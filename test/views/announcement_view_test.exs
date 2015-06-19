defmodule Constable.AnnouncementViewTest do
  use Constable.ViewCase, async: true

  test "show.json returns id, title, body, user and embedded comments" do
    user = Forge.user
    interest = Forge.interest
    announcement = Forge.announcement(user: user, interests: [interest])
    comment = Forge.comment(announcement: announcement, user: user)
    announcement = Map.put(announcement, :comments, [comment])

    rendered_announcement = render_one(announcement, "show.json")

    assert rendered_announcement == %{
      id: announcement.id,
      title: announcement.title,
      body: announcement.body,
      user: render_one(announcement.user, "show.json"),
      comments: render_many(announcement.comments, "show.json"),
      interests: [interest.name],
      inserted_at: announcement.inserted_at,
      updated_at: announcement.updated_at
    }
  end
end
