# encoding: UTF-8
# frozen_litteral_string: true

class MemoClass

CHOIX_ADD = {name:"Ajouter…", value: :add}
CHOIX_RENONCER = {name:"Renoncer", value: nil}

class << self

  def data
    @data ||= YAML.load_file(data_path).sort_by { |d| - d[:x] }
  end

  def save_data
    File.delete(data_path) if File.exist?(data_path)
    File.open(data_path,'wb'){|f|f.write data.to_yaml}
    if File.exist?(data_path)
      #
      # OK
      #
      # puts "Données sauvées.".vert
      return true
    else
      #
      # Problème d'enregistrement des données
      #
      puts "Bizarrement, les données n'ont pas pu être actualisées…".rouge
      return false
    end
  end

  ##
  # Méthode principale pour choisir un élément
  def choose
    idx = -1
    choix = [CHOIX_ADD] + data.collect do |ditem|
      idx += 1
      ditem.merge(value: idx)
    end + [CHOIX_RENONCER]

    # puts "Les choix : #{choix.inspect}"

    choix = Q.select("Choisir #{self.name} parmi :", filter: true) do |q|
      q.choices choix
      q.per_page choix.count
    end || return

    if choix == :add
      new_data
    else
      choisir_item(choix)
    end
  end

  def choisir_item(item_idx)
    # puts "-> choisir_item(#{item_idx})"
    # puts "Item choisi : #{data[item_idx].inspect}"
    # 
    # Incrémenter son utilisation
    #
    data[item_idx][:x] += 1
    #
    # Enregistrer les données
    #
    save_data
    #
    # Le mémoriser dans le presse-papier
    #
    clip(data[item_idx][:v])
  end

  def clip(value)
    `printf "#{value}" | pbcopy`
    puts "La valeur #{value.inspect} a été mis dans le presse-papier"
  end


  def new_data
    newvalue = Q.ask("Valeur à redonner :") || return
    newname  = Q.ask("Nom à donner à cette valeur (ne rien mettre si le nom et la valeur doivent être identiques) :") || return
    @data << {name: newname || newvalue, x: 0, v: newvalue}
    if save_data
      puts "La nouvelle valeur #{newname.inspect} de type #{self.name} a été mémorisée.".vert
    end
  end
end #/<< self
end #/MemoClass
