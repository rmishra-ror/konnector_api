User.create!(
  [
    {
      id: 1,
      name: "John",
      email: "john@gmail.com",
      campaigns_list: [
        { campaign_name: "cam1", campaign_id: "id1" },
        { campaign_name: "cam2", campaign_id: "id2" }
      ]
    },
    {
      id: 2,
      name: "Jane",
      email: "jane@gmail.com",
      campaigns_list: [
        { campaign_name: "cam1", campaign_id: "id1" },
        { campaign_name: "cam3", campaign_id: "id3" }
      ]
    }
  ]
)
