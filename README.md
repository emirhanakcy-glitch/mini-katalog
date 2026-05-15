# Mini Katalog Uygulaması 🛍️

TNC GROUP Staj Programı - Flutter Mobil Uygulama Projesi

**Geliştirici:** Emirhan Akçay

---

## Proje Hakkında

Flutter ile geliştirilmiş bir mobil ürün katalog uygulamasıdır. Kullanıcılar ürünleri listeleyebilir, detaylarını görüntüleyebilir ve sepete ekleyebilir.

## Özellikler

- 🏠 Ana sayfa — GridView ile ürün listeleme
- 🔍 Ürün arama ve filtreleme
- 📄 Ürün detay sayfası
- 🛒 Sepet yönetimi (ekleme & silme)
- 📱 Sayfa geçişleri (Navigator)
- 🎨 Material Design 3 tema

## Kullanılan Teknolojiler

- **Flutter** 3.x
- **Dart** 3.x
- **Material Design 3**
- Simüle edilmiş ürün verisi (JSON model yapısı)

## Proje Yapısı

```
lib/
├── main.dart
├── models/
│   └── product.dart
├── pages/
│   ├── home_page.dart
│   ├── detail_page.dart
│   └── cart_page.dart
└── widgets/
    └── product_card.dart
```

## Çalıştırma Adımları

```bash
# Flutter SDK kurulumu gereklidir
flutter --version

# Bağımlılıkları yükle
flutter pub get

# Uygulamayı çalıştır
flutter run
```

## Ekran Görüntüleri

| Ana Sayfa | Ürün Detayı | Sepet |
|-----------|-------------|-------|
| Ürün grid listesi | Detay ve sepete ekle | Sepet yönetimi |
