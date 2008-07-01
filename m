From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH 1/1] This patch adds backlight control for omap3evm
Date: Tue, 1 Jul 2008 17:52:49 +0530
Message-ID: <c656a4d20807010522u2742a089qad5ec3316d0db15a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_15208_7920594.1214914969467"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:45029 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbYGAMWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 08:22:51 -0400
Received: by yx-out-2324.google.com with SMTP id 8so54219yxm.1
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2008 05:22:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_15208_7920594.1214914969467
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

TWL4030 LEDdriver A(LEDA) is used here to control the LCD backlight

Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
---
 drivers/video/omap/lcd_omap3evm.c |   39 +++++++++++++++++++++++++++++++++---
 1 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/lcd_omap3evm.c
b/drivers/video/omap/lcd_omap3evm.c
index 5d2ed04..f5a1477 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -45,6 +45,12 @@
 #define ENABLE_VPLL2_DEDICATED	0x05
 #define ENABLE_VPLL2_DEV_GRP	0xE0

+#define TWL_LED_LEDEN		0x00
+#define TWL_PWMA_PWMAON		0x00
+#define TWL_PWMA_PWMAOFF	0x01
+
+static unsigned int bklight_level;
+
 static int omap3evm_panel_init(struct lcd_panel *panel,
 				struct omapfb_device *fbdev)
 {
@@ -60,10 +66,10 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
 	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
 	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);

-	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, 0);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, 1);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PWMB, 0x7F, 0);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PWMB, 0x7F, 1);
+	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+	bklight_level = 100;

 	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
 	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
@@ -94,6 +100,28 @@ static unsigned long
omap3evm_panel_get_caps(struct lcd_panel *panel)
 	return 0;
 }

+static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
+						unsigned int level)
+{
+	u8 c;
+	if ((level >= 0) && (level <= 100)) {
+		c = (125 * (100 - level)) / 100 + 2;
+		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
+		bklight_level = level;
+	}
+	return 0;
+}
+
+static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)
+{
+	return bklight_level;
+}
+
+static unsigned int omap3evm_bklight_getmaxlevel(struct lcd_panel *panel)
+{
+	return 100;
+}
+
 struct lcd_panel omap3evm_panel = {
 	.name		= "omap3evm",
 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
@@ -117,6 +145,9 @@ struct lcd_panel omap3evm_panel = {
 	.enable		= omap3evm_panel_enable,
 	.disable	= omap3evm_panel_disable,
 	.get_caps	= omap3evm_panel_get_caps,
+	.set_bklight_level      = omap3evm_bklight_setlevel,
+	.get_bklight_level      = omap3evm_bklight_getlevel,
+	.get_bklight_max        = omap3evm_bklight_getmaxlevel,
 };

 static int omap3evm_panel_probe(struct platform_device *pdev)
-- 
1.5.5.3

------=_Part_15208_7920594.1214914969467
Content-Type: text/x-patch;
 name=0001-This-patch-adds-backlight-control-for-omap3evm.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fi4gxadm0
Content-Disposition: attachment;
 filename=0001-This-patch-adds-backlight-control-for-omap3evm.patch

RnJvbSA5MmExMDk0YzY1ZTkwYWUwZjBmZTViOTcwZjczM2Q1ODRkMmY3MjAxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEMgPGFydW5lZGFyYXRoQG1pc3RyYWxzb2x1dGlvbnMu
Y29tPgpEYXRlOiBUdWUsIDEgSnVsIDIwMDggMTY6NTQ6NTUgKzA1MzAKU3ViamVjdDogW1BBVENI
XSBUaGlzIHBhdGNoIGFkZHMgYmFja2xpZ2h0IGNvbnRyb2wgZm9yIG9tYXAzZXZtCgpUV0w0MDMw
IExFRGRyaXZlciBBKExFREEpIGlzIHVzZWQgaGVyZSB0byBjb250cm9sIHRoZSBMQ0QgYmFja2xp
Z2h0CgpTaWduZWQtb2ZmLWJ5OiBBcnVuIEMgPGFydW5lZGFyYXRoQG1pc3RyYWxzb2x1dGlvbnMu
Y29tPgotLS0KIGRyaXZlcnMvdmlkZW8vb21hcC9sY2Rfb21hcDNldm0uYyB8ICAgMzkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDM1IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9vbWFw
L2xjZF9vbWFwM2V2bS5jIGIvZHJpdmVycy92aWRlby9vbWFwL2xjZF9vbWFwM2V2bS5jCmluZGV4
IDVkMmVkMDQuLmY1YTE0NzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vb21hcC9sY2Rfb21h
cDNldm0uYworKysgYi9kcml2ZXJzL3ZpZGVvL29tYXAvbGNkX29tYXAzZXZtLmMKQEAgLTQ1LDYg
KzQ1LDEyIEBACiAjZGVmaW5lIEVOQUJMRV9WUExMMl9ERURJQ0FURUQJMHgwNQogI2RlZmluZSBF
TkFCTEVfVlBMTDJfREVWX0dSUAkweEUwCiAKKyNkZWZpbmUgVFdMX0xFRF9MRURFTgkJMHgwMAor
I2RlZmluZSBUV0xfUFdNQV9QV01BT04JCTB4MDAKKyNkZWZpbmUgVFdMX1BXTUFfUFdNQU9GRgkw
eDAxCisKK3N0YXRpYyB1bnNpZ25lZCBpbnQgYmtsaWdodF9sZXZlbDsKKwogc3RhdGljIGludCBv
bWFwM2V2bV9wYW5lbF9pbml0KHN0cnVjdCBsY2RfcGFuZWwgKnBhbmVsLAogCQkJCXN0cnVjdCBv
bWFwZmJfZGV2aWNlICpmYmRldikKIHsKQEAgLTYwLDEwICs2NiwxMCBAQCBzdGF0aWMgaW50IG9t
YXAzZXZtX3BhbmVsX2luaXQoc3RydWN0IGxjZF9wYW5lbCAqcGFuZWwsCiAJb21hcF9zZXRfZ3Bp
b19kaXJlY3Rpb24oTENEX1BBTkVMX1JFU0IsIDApOwogCW9tYXBfc2V0X2dwaW9fZGlyZWN0aW9u
KExDRF9QQU5FTF9RVkdBLCAwKTsKIAotCXR3bDQwMzBfaTJjX3dyaXRlX3U4KFRXTDQwMzBfTU9E
VUxFX1BXTUEsIDB4N0YsIDApOwotCXR3bDQwMzBfaTJjX3dyaXRlX3U4KFRXTDQwMzBfTU9EVUxF
X1BXTUEsIDB4N0YsIDEpOwotCXR3bDQwMzBfaTJjX3dyaXRlX3U4KFRXTDQwMzBfTU9EVUxFX1BX
TUIsIDB4N0YsIDApOwotCXR3bDQwMzBfaTJjX3dyaXRlX3U4KFRXTDQwMzBfTU9EVUxFX1BXTUIs
IDB4N0YsIDEpOworCXR3bDQwMzBfaTJjX3dyaXRlX3U4KFRXTDQwMzBfTU9EVUxFX0xFRCwgMHgx
MSwgVFdMX0xFRF9MRURFTik7CisJdHdsNDAzMF9pMmNfd3JpdGVfdTgoVFdMNDAzMF9NT0RVTEVf
UFdNQSwgMHgwMSwgVFdMX1BXTUFfUFdNQU9OKTsKKwl0d2w0MDMwX2kyY193cml0ZV91OChUV0w0
MDMwX01PRFVMRV9QV01BLCAweDAyLCBUV0xfUFdNQV9QV01BT0ZGKTsKKwlia2xpZ2h0X2xldmVs
ID0gMTAwOwogCiAJb21hcF9zZXRfZ3Bpb19kYXRhb3V0KExDRF9QQU5FTF9SRVNCLCAxKTsKIAlv
bWFwX3NldF9ncGlvX2RhdGFvdXQoTENEX1BBTkVMX0lOSSwgMSk7CkBAIC05NCw2ICsxMDAsMjgg
QEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgb21hcDNldm1fcGFuZWxfZ2V0X2NhcHMoc3RydWN0IGxj
ZF9wYW5lbCAqcGFuZWwpCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyBpbnQgb21hcDNldm1fYmts
aWdodF9zZXRsZXZlbChzdHJ1Y3QgbGNkX3BhbmVsICpwYW5lbCwKKwkJCQkJCXVuc2lnbmVkIGlu
dCBsZXZlbCkKK3sKKwl1OCBjOworCWlmICgobGV2ZWwgPj0gMCkgJiYgKGxldmVsIDw9IDEwMCkp
IHsKKwkJYyA9ICgxMjUgKiAoMTAwIC0gbGV2ZWwpKSAvIDEwMCArIDI7CisJCXR3bDQwMzBfaTJj
X3dyaXRlX3U4KFRXTDQwMzBfTU9EVUxFX1BXTUEsIGMsIFRXTF9QV01BX1BXTUFPRkYpOworCQli
a2xpZ2h0X2xldmVsID0gbGV2ZWw7CisJfQorCXJldHVybiAwOworfQorCitzdGF0aWMgdW5zaWdu
ZWQgaW50IG9tYXAzZXZtX2JrbGlnaHRfZ2V0bGV2ZWwoc3RydWN0IGxjZF9wYW5lbCAqcGFuZWwp
Cit7CisJcmV0dXJuIGJrbGlnaHRfbGV2ZWw7Cit9CisKK3N0YXRpYyB1bnNpZ25lZCBpbnQgb21h
cDNldm1fYmtsaWdodF9nZXRtYXhsZXZlbChzdHJ1Y3QgbGNkX3BhbmVsICpwYW5lbCkKK3sKKwly
ZXR1cm4gMTAwOworfQorCiBzdHJ1Y3QgbGNkX3BhbmVsIG9tYXAzZXZtX3BhbmVsID0gewogCS5u
YW1lCQk9ICJvbWFwM2V2bSIsCiAJLmNvbmZpZwkJPSBPTUFQX0xDRENfUEFORUxfVEZUIHwgT01B
UF9MQ0RDX0lOVl9WU1lOQyB8CkBAIC0xMTcsNiArMTQ1LDkgQEAgc3RydWN0IGxjZF9wYW5lbCBv
bWFwM2V2bV9wYW5lbCA9IHsKIAkuZW5hYmxlCQk9IG9tYXAzZXZtX3BhbmVsX2VuYWJsZSwKIAku
ZGlzYWJsZQk9IG9tYXAzZXZtX3BhbmVsX2Rpc2FibGUsCiAJLmdldF9jYXBzCT0gb21hcDNldm1f
cGFuZWxfZ2V0X2NhcHMsCisJLnNldF9ia2xpZ2h0X2xldmVsICAgICAgPSBvbWFwM2V2bV9ia2xp
Z2h0X3NldGxldmVsLAorCS5nZXRfYmtsaWdodF9sZXZlbCAgICAgID0gb21hcDNldm1fYmtsaWdo
dF9nZXRsZXZlbCwKKwkuZ2V0X2JrbGlnaHRfbWF4ICAgICAgICA9IG9tYXAzZXZtX2JrbGlnaHRf
Z2V0bWF4bGV2ZWwsCiB9OwogCiBzdGF0aWMgaW50IG9tYXAzZXZtX3BhbmVsX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCi0tIAoxLjUuNS4zCgo=
------=_Part_15208_7920594.1214914969467--
