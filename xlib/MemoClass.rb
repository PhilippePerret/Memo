# encoding: UTF-8
# frozen_litteral_string: true

class MemoClass

  CHOIX_ADD = {name:"Ajouter…", value: :add}

class << self

  def data
    @data ||= YAML.load_file(data_path)
  end

  def save_data
    File.delete(data_path) if File.exist?(data_path)
    File.open(data_path,'wb'){|f|f.write data.to_yaml}
    if File.exist?(data_path)
      #
      # OK
      #
      # puts "Données sauvées.".vert
    else
      #
      # Problème d'enregistrement des données
      #
      puts "Bizarrement, les données n'ont pas pu être actualisées…".rouge
    end
  end

  def choose
    clear
    idx = -1
    choix = [CHOIX_ADD] + data.sort_by do |ditem|
      ditem[:x]
    end.collect do |ditem|
      idx += 1
      ditem.merge(value: idx)
    end
    choix = Q.select("Choisir #{self.name} parmi :") do |q|
      q.choices choix
      q.per_page choix.count
    end
    if choix == :add
      puts "Je dois apprendre à ajouter un item".jaune
    else
      choisir_item(choix)
    end
  end

  def choisir_item(item_idx)
    puts "Item choisi : #{data[item_idx].inspect}"
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
    clip(data[item_idx][:name])
  end

  def clip(value)
    `printf "#{value}" | pbcopy`
    puts "#{value.inspect} a été mis dans le presse-papier"
  end

end #/<< self
end #/MemoClass
