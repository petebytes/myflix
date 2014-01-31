require 'spec_helper'

describe QueueItem do
  it {should belong_to :user}
  it {should belong_to :video}
  it {should validate_numericality_of(:position).only_integer}

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: "Elf")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq("Elf")
    end
  end

  describe "#rating" do
    it "returns the rating for the review when review is present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, video: video, user: user, rating: 4)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(4)
    end
    it "returns nil when the review is not present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to be_nil
    end
  end

  describe "#rating=" do
    it "changes the rating of the review if the review is present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end

    it "clears the rating of the review if the review is present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end
    it "creates a review with the rating if a review is not present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.rating = 3
      expect(Review.first.rating).to eq(3)
    end
  end

  describe "#category_name" do
    it "returns the category name of the video" do
      category = Fabricate(:category, name: "Horror")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("Horror")
    end
  end

  describe "#category" do
    it "returns the category of the video" do
      category = Fabricate(:category, name: "Horror")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
    end
  end
end
