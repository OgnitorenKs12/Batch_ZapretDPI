#  Hazırlayan: Hüseyin UZUNYAYLA / OgnitorenKs
###  İletişim;
-   Discord: https://discord.gg/7hbzSGTYeZ
-   Mail: ognitorenks@gmail.com
-   Site: [https://ognitorenks.blospot.com](https://ognitorenks.blospot.com)

<details><summary><B> Versiyon 5.4 ► 16.08.2026 </B></summary>

    • Verileri parçalama yöntemi ödeme sistemlerinde soruna neden olduğu için fake paket yöntemi kullanıldı.

</details><details><summary><B> Versiyon 5.3 ► 06.06.2026 </B></summary>

    • ogni_host.exe uygulamasının Discord ve Roblox domainlerinin IP tespit işlemi hızlandırıldı.
	• İkinci seçenek olan local mod kaldırıldı. Belirli site yapılarında sorunlar çıkarıyordu.
	• Genel internete uygula seçeneği tek seçenek olarak bırakıldı.
	• Eski gereksiz kod bölümleri kaldırıldı.

</details><details><summary><B> Versiyon 5.2 ► 25.05.2026 </B></summary>

    • hosts içine yeni discord adresleri eklendi.
	
</details><details><summary><B> Versiyon 5.1 ► 25.05.2026 </B></summary>

    • Sahte paket gönderimi kaldırıldı. Ağda gereksiz yük yapıyordu. Bu olmadanda dpi atlatılıyor.
	• Bölgesel olarak çalışacak ikinci mod ekledim. Burada yalnızca Roblox ve Discord uygulamaları/siteleri etkilenir. Şişme sorununun önüne %99.9 oranında geçtim. Tavsiyem bu modu kullanın, kullanmak istediğiniz farklı siteler varsa domain adresini yasakli.txt dosyasına içine yazın, https falan olmasın düz yazın.
	• hosts içine eklenecek ip ve domainlerde sorun olmaması için ilk kurulumda otomatik olarak ip adresleri güncel haliyle alınır. Uygulamalarda ağırlaşma hissedilirse muhtemel bir ip yenilemesi olabilir bu durumda programı arayüzünden devre dışı bırak diyerek kapatıp yeniden kurun.
	
</details><details><summary><B> Versiyon 5.0 ► 25.05.2026 </B></summary>

    • GoodbyeDPI tarafında sorunlar çözülmeyince programın altyapısı olarak ZapretDPI kullanıldı.
	• host içine ekleme ve silme işlemlerini başarılı şekilde yapmak için "hosts-editor.exe" uygulaması hazırlandı.
	• ZapretDPI ile kusursuz parametre ayarı yapıldı.
	• Roblox ve Discord uygulamalarında sorun yaşanmaması için host içine kurulumda eklemeler yapılır.
	• Discord ve Roblox gibi uygulamalar sahte paket gönderimiyle şişip ağırlaşma sorunu ZapretDPI ile giderildi. Bu uygulamalar açılış sağlandıktan sonra gereksiz sahte paket gönderimini sonlandırır. Bunun ayarlaması "cutoff.txt" içine yapılan domain eklemeleri ile yapılmaktadır. Özel bir ekleme yapmak istiyorsanız buraya yapmanız gerekmektedir. 

</details><details><summary><B> Versiyon 4.0 ► 24.05.2026 </B></summary>

    • --reverse-frag komutu genel olarak şişme yaptığı için uzun vadede zararlı olacağından kaldırıldı. 
	• -e 2 parametrei 40 olarak düzenlendi. Daha büyük boyutlarda dosyayı bölecek ancak kısıtlamaları aşmaya devam edebilecek.
   
</details><details><summary><B> Versiyon 3.0 ► 24.05.2026 </B></summary>
    
	• GoodbyeDPI uygulamasına yapımcısı tarafından güncelleme verilmeyince kaynak kodlarını kullanarak yeni ve sorunları çözecek bir güncelleme hazırladım.
	• GoodbyeDPI varsayılan modunda QUIC/HTTP3 engelleme kapatıldı.
	    - Neden: Modern tarayıcılar ve uygulamalar QUIC kullanıyor. QUIC’in engellenmesi uygulamalarda gecikmeye sebep olabiliyor.
	• -f veya -e ile fragmentation kullanıldığında native fragmentation otomatik aktif hale getirildi.
	    - Neden: Eski window-size fragmentation yöntemi yerine daha hızlı ve uyumlu fragment gönderimi sağlamak için.
	• --exclude-hosts parametresi eklendi. Exclude.txt içindeki domainlerde fake TTL paketi göndermeyi atlar, ancak fragmentation uygulamaya devam eder.
	    - Neden: Bazı uygulama/CDN bağlantılarında fake TTL sorun çıkarırken, genel siteler için TTL yöntemi gerekli kalıyor. Bu ayrım domain bazlı yapılır.
	• Hosts dosyasına bazı eklemeler yapıldı. Roblox ve Discord'da sorun yaşanmaması için.

</details><details><summary><B> Versiyon 2.0 ► 07.05.2025 </B></summary>

    • --set-ttl 3 yönteminde birçok kullanıcı sorun yaşıyordu.
    • Çözüm olarak alternatif bir yöntem daha ekledim > --set-ttl 3 --dns-addr 77.88.8.8 --dns-port 1253 --dnsv6-addr 2a02:6b8::feed:0ff --dnsv6-port 1253
    
</details>