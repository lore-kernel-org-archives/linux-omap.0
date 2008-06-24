From: "Arun KS" <getarunks@gmail.com>
Subject: [ PATCH 2/3 ] net:smc911x Modify driver to also work with omap24xx
Date: Tue, 24 Jun 2008 17:44:33 +0530
Message-ID: <dfeb90390806240514w62490fb9kdc1c189f3fd946f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4870_21581219.1214309673453"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:7016 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbYFXMOf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 08:14:35 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1310928tic.23
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 05:14:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_4870_21581219.1214309673453
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

net:smc911x Modify driver to also work with omap24xx

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 drivers/net/Kconfig   |    2 +-
 drivers/net/smc911x.h |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 61ecee7..17d0a9c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -955,7 +955,7 @@ config SMC911X
    tristate "SMSC LAN911[5678] support"
    select CRC32
    select MII
-   depends on ARCH_PXA || SH_MAGIC_PANEL_R2 || ARCH_OMAP34XX
+   depends on ARCH_PXA || SH_MAGIC_PANEL_R2 || ARCH_OMAP34XX || ARCH_OMAP24XX
    help
      This is a driver for SMSC's LAN911x series of Ethernet chipsets
      including the new LAN9115, LAN9116, LAN9117, and LAN9118.
diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
index dad93a8..0f406a0 100644
--- a/drivers/net/smc911x.h
+++ b/drivers/net/smc911x.h
@@ -47,6 +47,11 @@
   #define SMC_USE_32BIT        1
   #define SMC_IRQ_SENSE        IRQF_TRIGGER_LOW
   #define SMC_MEM_RESERVED 1
+#elif defined(CONFIG_ARCH_OMAP24XX)
+  #define SMC_USE_16BIT        0
+  #define SMC_USE_32BIT        1
+  #define SMC_IRQ_SENSE        IRQF_TRIGGER_LOW
+  #define SMC_MEM_RESERVED 1
 #endif


--
1.5.3.4

------=_Part_4870_21581219.1214309673453
Content-Type: text/x-patch;
 name=0002-net-smc911x-Modify-driver-to-also-work-with-omap24xx.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhugwl140
Content-Disposition: attachment;
 filename=0002-net-smc911x-Modify-driver-to-also-work-with-omap24xx.patch

RnJvbSA4YjQ1YmZkNDBhY2E3ZDVmODkxOTVmOTVkNjY4YmFlNzhlMmRiYmE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IFR1ZSwgMjQgSnVuIDIwMDggMTc6MzM6MDggKzA1MzAKU3ViamVjdDogW1BBVENIXSBu
ZXQ6c21jOTExeCBNb2RpZnkgZHJpdmVyIHRvIGFsc28gd29yayB3aXRoIG9tYXAyNHh4CgpuZXQ6
c21jOTExeCBNb2RpZnkgZHJpdmVyIHRvIGFsc28gd29yayB3aXRoIG9tYXAyNHh4CgpTaWduZWQt
b2ZmLWJ5OiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+Ci0tLQogZHJpdmVy
cy9uZXQvS2NvbmZpZyAgIHwgICAgMiArLQogZHJpdmVycy9uZXQvc21jOTExeC5oIHwgICAgNSAr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvS2NvbmZpZyBiL2RyaXZlcnMvbmV0L0tjb25maWcKaW5k
ZXggNjFlY2VlNy4uMTdkMGE5YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvS2NvbmZpZworKysg
Yi9kcml2ZXJzL25ldC9LY29uZmlnCkBAIC05NTUsNyArOTU1LDcgQEAgY29uZmlnIFNNQzkxMVgK
IAl0cmlzdGF0ZSAiU01TQyBMQU45MTFbNTY3OF0gc3VwcG9ydCIKIAlzZWxlY3QgQ1JDMzIKIAlz
ZWxlY3QgTUlJCi0JZGVwZW5kcyBvbiBBUkNIX1BYQSB8fCBTSF9NQUdJQ19QQU5FTF9SMiB8fCBB
UkNIX09NQVAzNFhYCisJZGVwZW5kcyBvbiBBUkNIX1BYQSB8fCBTSF9NQUdJQ19QQU5FTF9SMiB8
fCBBUkNIX09NQVAzNFhYIHx8IEFSQ0hfT01BUDI0WFgKIAloZWxwCiAJICBUaGlzIGlzIGEgZHJp
dmVyIGZvciBTTVNDJ3MgTEFOOTExeCBzZXJpZXMgb2YgRXRoZXJuZXQgY2hpcHNldHMKIAkgIGlu
Y2x1ZGluZyB0aGUgbmV3IExBTjkxMTUsIExBTjkxMTYsIExBTjkxMTcsIGFuZCBMQU45MTE4Lgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvc21jOTExeC5oIGIvZHJpdmVycy9uZXQvc21jOTExeC5o
CmluZGV4IGRhZDkzYTguLjBmNDA2YTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3NtYzkxMXgu
aAorKysgYi9kcml2ZXJzL25ldC9zbWM5MTF4LmgKQEAgLTQ3LDYgKzQ3LDExIEBACiAgICNkZWZp
bmUgU01DX1VTRV8zMkJJVAkJMQogICAjZGVmaW5lIFNNQ19JUlFfU0VOU0UJCUlSUUZfVFJJR0dF
Ul9MT1cKICAgI2RlZmluZSBTTUNfTUVNX1JFU0VSVkVECTEKKyNlbGlmIGRlZmluZWQoQ09ORklH
X0FSQ0hfT01BUDI0WFgpCisgICNkZWZpbmUgU01DX1VTRV8xNkJJVAkJMAorICAjZGVmaW5lIFNN
Q19VU0VfMzJCSVQJCTEKKyAgI2RlZmluZSBTTUNfSVJRX1NFTlNFCQlJUlFGX1RSSUdHRVJfTE9X
CisgICNkZWZpbmUgU01DX01FTV9SRVNFUlZFRAkxCiAjZW5kaWYKIAogCi0tIAoxLjUuMy40Cgo=

------=_Part_4870_21581219.1214309673453--
