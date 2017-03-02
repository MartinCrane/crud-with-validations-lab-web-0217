class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: { in: [true, false] }
  validate :release_year_test
  validates :artist_name, presence: true
  validate :song_per_year

  def release_year_test
    year_now = Time.new.year
    if released
      if !release_year.present?
          errors.add(:release_year, "album has been released. set year before or equal to present")
      elsif release_year > year_now
          errors.add(:release_year, "album has been released. set year before or equal to present")
      else
      end
    end
  end

  def song_per_year
    song = Song.find_by(title: title, artist_name: artist_name)
  
    if song != nil && song.release_year == release_year
      errors.add(:release_year, "artist has already released a song by that title this year")
    end
  end

end
