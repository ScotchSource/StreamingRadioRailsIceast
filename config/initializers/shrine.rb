require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

s3_options = {
    access_key_id:      ENV['S3_KEY'],
    secret_access_key:  ENV['S3_SECRET'],
    region:             ENV['S3_REGION'],
    bucket:             ENV['S3_BUCKET']
}

Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("tmp/uploads"),
    store: Shrine::Storage::S3.new(upload_options: {acl: "public-read"}, prefix: "store",
                                   **s3_options),
}

Shrine.plugin :activerecord
Shrine.plugin :add_metadata