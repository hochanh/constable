defmodule Constable.Repo do
  use Ecto.Repo,
    otp_app: :constable,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 30
  import Ecto.Query
  import Paginator

  def count(query) do
    one!(from record in query, select: count(record.id))
  end

  def cursor_paginate(query, opts \\ [], repo_opts \\ []) do
    Paginator.paginate(query, opts, __MODULE__, repo_opts)
  end
end
