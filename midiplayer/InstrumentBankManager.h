#pragma once

#include <cstdint>
#include <string>
#include <string_view>
#include <vector>

class InstrumentBankManager
{
public:
    enum class Type : uint32_t
    {
        Opal,
        Primesynth,
        TinySoundFont,
        VSTi
    };

    enum class Location : uint32_t
    {
        Memory,
        File
    };

    InstrumentBankManager() { SetDefaults(); };

    void SetDefaults();

    auto GetType() { return type; }

    auto GetLocation() { return location; }

    void SetPath(const std::string_view &path);

    auto GetPath() { return fileName.c_str(); }

    void SetData(const uint8_t *data, size_t size, Type type = Type::Opal);

    auto GetData() { return data.data(); }

    auto GetDataSize() { return data.size(); }

private:
    static const uint8_t defaultBank[];
    static const size_t defaultBankSize = 212069;

    Type type;
    Location location;
    std::string fileName;
    std::vector<uint8_t> data;

    static bool HasFileExtension(const std::string_view &name, const std::string_view &extension);
};
