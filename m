From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH] OMAP2EVM: add LCD panel support
Date: Thu, 3 Jul 2008 20:24:22 +0530
Message-ID: <c656a4d20807030754ta845d4dx7bfd54fb66634a0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9905_30252636.1215096862732"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:37516 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYGCOyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 10:54:23 -0400
Received: by wf-out-1314.google.com with SMTP id 27so817731wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 03 Jul 2008 07:54:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_9905_30252636.1215096862732
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

omap2evm LCD supports VGA and QVGA resolution, by default its in VGA mode.

Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap2evm.c |   15 +++-
 drivers/video/omap/Makefile          |    1 +
 drivers/video/omap/lcd_omap2evm.c    |  195 ++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 drivers/video/omap/lcd_omap2evm.c

diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index bcdf4a6..db1c4cb 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -62,6 +62,15 @@ static inline void __init omap2evm_init_smc911x(void)

 }

+static struct platform_device omap2_evm_lcd_device = {
+	.name		= "omap2evm_lcd",
+	.id		= -1,
+};
+
+static struct omap_lcd_config omap2_evm_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
 static void __init omap2_evm_init_irq(void)
 {
 	omap2_init_common_hw();
@@ -75,7 +84,8 @@ static struct omap_uart_config omap2_evm_uart_config
__initdata = {
 };

 static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
-	{OMAP_TAG_UART, &omap2_evm_uart_config},
+	{ OMAP_TAG_UART,	&omap2_evm_uart_config },
+	{ OMAP_TAG_LCD,		&omap2_evm_lcd_config },
 };

 static int __init omap2_evm_i2c_init(void)
@@ -90,7 +100,8 @@ static int __init omap2_evm_i2c_init(void)
 }

 static struct platform_device *omap2_evm_devices[] __initdata = {
-    &omap2evm_smc911x_device,
+	&omap2_evm_lcd_device,
+	&omap2evm_smc911x_device,
 };

 static void __init omap2_evm_init(void)
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index a72a2d9..e234d5f 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -30,6 +30,7 @@ objs-y$(CONFIG_MACH_SX1) += lcd_sx1.o

 objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
 objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
+objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
 objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_3430sdp.o
 objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
diff --git a/drivers/video/omap/lcd_omap2evm.c
b/drivers/video/omap/lcd_omap2evm.c
new file mode 100644
index 0000000..d834640
--- /dev/null
+++ b/drivers/video/omap/lcd_omap2evm.c
@@ -0,0 +1,195 @@
+/*
+ * LCD panel support for the MISTRAL OMAP2EVM board
+ *
+ * Author: Arun C <arunedarath@mistralsolutions.com>
+ *
+ * Derived from drivers/video/omap/lcd_omap3evm.c
+ * Derived from drivers/video/omap/lcd-apollon.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
+
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_PANEL_ENABLE_GPIO	154
+#define LCD_PANEL_LR		128
+#define LCD_PANEL_UD		129
+#define LCD_PANEL_INI		152
+#define LCD_PANEL_QVGA		148
+#define LCD_PANEL_RESB		153
+
+#define LCD_XRES		480
+#define LCD_YRES		640
+#define LCD_PIXCLOCK		20000 /* in kHz */
+
+#define TWL_LED_LEDEN		0x00
+#define TWL_PWMA_PWMAON		0x00
+#define TWL_PWMA_PWMAOFF	0x01
+
+static unsigned int bklight_level;
+
+static int omap2evm_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	omap_request_gpio(LCD_PANEL_ENABLE_GPIO);
+	omap_request_gpio(LCD_PANEL_LR);
+	omap_request_gpio(LCD_PANEL_UD);
+	omap_request_gpio(LCD_PANEL_INI);
+	omap_request_gpio(LCD_PANEL_QVGA);
+	omap_request_gpio(LCD_PANEL_RESB);
+
+	omap_set_gpio_direction(LCD_PANEL_ENABLE_GPIO, 0);
+	omap_set_gpio_direction(LCD_PANEL_LR, 0);
+	omap_set_gpio_direction(LCD_PANEL_UD, 0);
+	omap_set_gpio_direction(LCD_PANEL_INI, 0);
+	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
+	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
+
+	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
+	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
+	omap_set_gpio_dataout(LCD_PANEL_QVGA, 0);
+	omap_set_gpio_dataout(LCD_PANEL_LR, 1);
+	omap_set_gpio_dataout(LCD_PANEL_UD, 1);
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+	bklight_level = 100;
+
+	return 0;
+}
+
+static void omap2evm_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int omap2evm_panel_enable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
+	return 0;
+}
+
+static void omap2evm_panel_disable(struct lcd_panel *panel)
+{
+	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
+}
+
+static unsigned long omap2evm_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static int omap2evm_bklight_setlevel(struct lcd_panel *panel,
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
+static unsigned int omap2evm_bklight_getlevel(struct lcd_panel *panel)
+{
+	return bklight_level;
+}
+
+static unsigned int omap2evm_bklight_getmaxlevel(struct lcd_panel *panel)
+{
+	return 100;
+}
+
+struct lcd_panel omap2evm_panel = {
+	.name		= "omap2evm",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC,
+
+	.bpp		= 16,
+	.data_lines	= 18,
+	.x_res		= LCD_XRES,
+	.y_res		= LCD_YRES,
+	.hsw		= 3,
+	.hfp		= 0,
+	.hbp		= 28,
+	.vsw		= 2,
+	.vfp		= 1,
+	.vbp		= 0,
+
+	.pixel_clock	= LCD_PIXCLOCK,
+
+	.init		= omap2evm_panel_init,
+	.cleanup	= omap2evm_panel_cleanup,
+	.enable		= omap2evm_panel_enable,
+	.disable	= omap2evm_panel_disable,
+	.get_caps	= omap2evm_panel_get_caps,
+	.set_bklight_level      = omap2evm_bklight_setlevel,
+	.get_bklight_level      = omap2evm_bklight_getlevel,
+	.get_bklight_max        = omap2evm_bklight_getmaxlevel,
+};
+
+static int omap2evm_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&omap2evm_panel);
+	return 0;
+}
+
+static int omap2evm_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap2evm_panel_suspend(struct platform_device *pdev,
+				   pm_message_t mesg)
+{
+	return 0;
+}
+
+static int omap2evm_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver omap2evm_panel_driver = {
+	.probe		= omap2evm_panel_probe,
+	.remove		= omap2evm_panel_remove,
+	.suspend	= omap2evm_panel_suspend,
+	.resume		= omap2evm_panel_resume,
+	.driver		= {
+		.name	= "omap2evm_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap2evm_panel_drv_init(void)
+{
+	return platform_driver_register(&omap2evm_panel_driver);
+}
+
+static void __exit omap2evm_panel_drv_exit(void)
+{
+	platform_driver_unregister(&omap2evm_panel_driver);
+}
+
+module_init(omap2evm_panel_drv_init);
+module_exit(omap2evm_panel_drv_exit);
-- 
1.5.6

------=_Part_9905_30252636.1215096862732
Content-Type: text/x-patch;
 name=0001-This-patch-adds-LCD-support-for-omap2evm.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fi7h66du0
Content-Disposition: attachment;
 filename=0001-This-patch-adds-LCD-support-for-omap2evm.patch

RnJvbSBmMjU3M2IzYzViMTRjNTFkMDc3MTA0ZDUyNzUyZjU4ZDYwNTYxYTg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEMgPGFydW5lZGFyYXRoQG1pc3RyYWxzb2x1dGlvbnMu
Y29tPgpEYXRlOiBUaHUsIDMgSnVsIDIwMDggMTk6NDg6NTggKzA1MzAKU3ViamVjdDogW1BBVENI
XSBPTUFQMkVWTTogYWRkIExDRCBwYW5lbCBzdXBwb3J0CgpvbWFwMmV2bSBMQ0Qgc3VwcG9ydHMg
VkdBIGFuZCBRVkdBIHJlc29sdXRpb24sIGJ5IGRlZmF1bHQgaXRzIGluIFZHQSBtb2RlLgoKU2ln
bmVkLW9mZi1ieTogQXJ1biBDIDxhcnVuZWRhcmF0aEBtaXN0cmFsc29sdXRpb25zLmNvbT4KLS0t
CiBhcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAyZXZtLmMgfCAgIDE1ICsrKy0KIGRyaXZl
cnMvdmlkZW8vb21hcC9NYWtlZmlsZSAgICAgICAgICB8ICAgIDEgKwogZHJpdmVycy92aWRlby9v
bWFwL2xjZF9vbWFwMmV2bS5jICAgIHwgIDE5NSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDIwOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmlkZW8vb21hcC9sY2Rfb21hcDJldm0uYwoK
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDJldm0uYyBiL2FyY2gv
YXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDJldm0uYwppbmRleCBiY2RmNGE2Li5kYjFjNGNiIDEw
MDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAyZXZtLmMKKysrIGIvYXJj
aC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwMmV2bS5jCkBAIC02Miw2ICs2MiwxNSBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgX19pbml0IG9tYXAyZXZtX2luaXRfc21jOTExeCh2b2lkKQogCiB9CiAK
K3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIG9tYXAyX2V2bV9sY2RfZGV2aWNlID0gewor
CS5uYW1lCQk9ICJvbWFwMmV2bV9sY2QiLAorCS5pZAkJPSAtMSwKK307CisKK3N0YXRpYyBzdHJ1
Y3Qgb21hcF9sY2RfY29uZmlnIG9tYXAyX2V2bV9sY2RfY29uZmlnIF9faW5pdGRhdGEgPSB7CisJ
LmN0cmxfbmFtZQk9ICJpbnRlcm5hbCIsCit9OworCiBzdGF0aWMgdm9pZCBfX2luaXQgb21hcDJf
ZXZtX2luaXRfaXJxKHZvaWQpCiB7CiAJb21hcDJfaW5pdF9jb21tb25faHcoKTsKQEAgLTc1LDcg
Kzg0LDggQEAgc3RhdGljIHN0cnVjdCBvbWFwX3VhcnRfY29uZmlnIG9tYXAyX2V2bV91YXJ0X2Nv
bmZpZyBfX2luaXRkYXRhID0gewogfTsKIAogc3RhdGljIHN0cnVjdCBvbWFwX2JvYXJkX2NvbmZp
Z19rZXJuZWwgb21hcDJfZXZtX2NvbmZpZ1tdIF9faW5pdGRhdGEgPSB7Ci0Je09NQVBfVEFHX1VB
UlQsICZvbWFwMl9ldm1fdWFydF9jb25maWd9LAorCXsgT01BUF9UQUdfVUFSVCwJJm9tYXAyX2V2
bV91YXJ0X2NvbmZpZyB9LAorCXsgT01BUF9UQUdfTENELAkJJm9tYXAyX2V2bV9sY2RfY29uZmln
IH0sCiB9OwogCiBzdGF0aWMgaW50IF9faW5pdCBvbWFwMl9ldm1faTJjX2luaXQodm9pZCkKQEAg
LTkwLDcgKzEwMCw4IEBAIHN0YXRpYyBpbnQgX19pbml0IG9tYXAyX2V2bV9pMmNfaW5pdCh2b2lk
KQogfQogCiBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqb21hcDJfZXZtX2RldmljZXNb
XSBfX2luaXRkYXRhID0gewotICAgICZvbWFwMmV2bV9zbWM5MTF4X2RldmljZSwKKwkmb21hcDJf
ZXZtX2xjZF9kZXZpY2UsCisJJm9tYXAyZXZtX3NtYzkxMXhfZGV2aWNlLAogfTsKIAogc3RhdGlj
IHZvaWQgX19pbml0IG9tYXAyX2V2bV9pbml0KHZvaWQpCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
ZGVvL29tYXAvTWFrZWZpbGUgYi9kcml2ZXJzL3ZpZGVvL29tYXAvTWFrZWZpbGUKaW5kZXggYTcy
YTJkOS4uZTIzNGQ1ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9vbWFwL01ha2VmaWxlCisr
KyBiL2RyaXZlcnMvdmlkZW8vb21hcC9NYWtlZmlsZQpAQCAtMzAsNiArMzAsNyBAQCBvYmpzLXkk
KENPTkZJR19NQUNIX1NYMSkgKz0gbGNkX3N4MS5vCiAKIG9ianMteSQoQ09ORklHX01BQ0hfT01B
UF9BUE9MTE9OKSArPSBsY2RfYXBvbGxvbi5vCiBvYmpzLXkkKENPTkZJR19NQUNIX09NQVBfMjQz
MFNEUCkgKz0gbGNkXzI0MzBzZHAubworb2Jqcy15JChDT05GSUdfTUFDSF9PTUFQMkVWTSkgKz0g
bGNkX29tYXAyZXZtLm8KIG9ianMteSQoQ09ORklHX01BQ0hfT01BUF8zNDMwU0RQKSArPSBsY2Rf
MzQzMHNkcC5vCiBvYmpzLXkkKENPTkZJR19NQUNIX09NQVAzRVZNKSArPSBsY2Rfb21hcDNldm0u
bwogb2Jqcy15JChDT05GSUdfTUFDSF9PTUFQM19CRUFHTEUpICs9IGxjZF9vbWFwM2JlYWdsZS5v
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL29tYXAvbGNkX29tYXAyZXZtLmMgYi9kcml2ZXJz
L3ZpZGVvL29tYXAvbGNkX29tYXAyZXZtLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMC4uZDgzNDY0MAotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvdmlkZW8vb21hcC9sY2Rf
b21hcDJldm0uYwpAQCAtMCwwICsxLDE5NSBAQAorLyoKKyAqIExDRCBwYW5lbCBzdXBwb3J0IGZv
ciB0aGUgTUlTVFJBTCBPTUFQMkVWTSBib2FyZAorICoKKyAqIEF1dGhvcjogQXJ1biBDIDxhcnVu
ZWRhcmF0aEBtaXN0cmFsc29sdXRpb25zLmNvbT4KKyAqCisgKiBEZXJpdmVkIGZyb20gZHJpdmVy
cy92aWRlby9vbWFwL2xjZF9vbWFwM2V2bS5jCisgKiBEZXJpdmVkIGZyb20gZHJpdmVycy92aWRl
by9vbWFwL2xjZC1hcG9sbG9uLmMKKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2Fy
ZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeSBpdAorICogdW5kZXIgdGhl
IHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkg
dGhlCisgKiBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhl
IExpY2Vuc2UsIG9yIChhdCB5b3VyCisgKiBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoK
KyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwg
YmUgdXNlZnVsLCBidXQKKyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhl
IGltcGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBB
IFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VCisgKiBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEg
Y29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcKKyAqIHdpdGggdGhp
cyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24s
IEluYy4sCisgKiA1OSBUZW1wbGUgUGxhY2UgLSBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgIDAyMTEx
LTEzMDcsIFVTQS4KKyAqLworCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvaTJjL3R3bDQwMzAuaD4K
KworI2luY2x1ZGUgPGFzbS9hcmNoL2dwaW8uaD4KKyNpbmNsdWRlIDxhc20vYXJjaC9tdXguaD4K
KyNpbmNsdWRlIDxhc20vYXJjaC9vbWFwZmIuaD4KKyNpbmNsdWRlIDxhc20vbWFjaC10eXBlcy5o
PgorCisjZGVmaW5lIExDRF9QQU5FTF9FTkFCTEVfR1BJTwkxNTQKKyNkZWZpbmUgTENEX1BBTkVM
X0xSCQkxMjgKKyNkZWZpbmUgTENEX1BBTkVMX1VECQkxMjkKKyNkZWZpbmUgTENEX1BBTkVMX0lO
SQkJMTUyCisjZGVmaW5lIExDRF9QQU5FTF9RVkdBCQkxNDgKKyNkZWZpbmUgTENEX1BBTkVMX1JF
U0IJCTE1MworCisjZGVmaW5lIExDRF9YUkVTCQk0ODAKKyNkZWZpbmUgTENEX1lSRVMJCTY0MAor
I2RlZmluZSBMQ0RfUElYQ0xPQ0sJCTIwMDAwIC8qIGluIGtIeiAqLworCisjZGVmaW5lIFRXTF9M
RURfTEVERU4JCTB4MDAKKyNkZWZpbmUgVFdMX1BXTUFfUFdNQU9OCQkweDAwCisjZGVmaW5lIFRX
TF9QV01BX1BXTUFPRkYJMHgwMQorCitzdGF0aWMgdW5zaWduZWQgaW50IGJrbGlnaHRfbGV2ZWw7
CisKK3N0YXRpYyBpbnQgb21hcDJldm1fcGFuZWxfaW5pdChzdHJ1Y3QgbGNkX3BhbmVsICpwYW5l
bCwKKwkJCQlzdHJ1Y3Qgb21hcGZiX2RldmljZSAqZmJkZXYpCit7CisJb21hcF9yZXF1ZXN0X2dw
aW8oTENEX1BBTkVMX0VOQUJMRV9HUElPKTsKKwlvbWFwX3JlcXVlc3RfZ3BpbyhMQ0RfUEFORUxf
TFIpOworCW9tYXBfcmVxdWVzdF9ncGlvKExDRF9QQU5FTF9VRCk7CisJb21hcF9yZXF1ZXN0X2dw
aW8oTENEX1BBTkVMX0lOSSk7CisJb21hcF9yZXF1ZXN0X2dwaW8oTENEX1BBTkVMX1FWR0EpOwor
CW9tYXBfcmVxdWVzdF9ncGlvKExDRF9QQU5FTF9SRVNCKTsKKworCW9tYXBfc2V0X2dwaW9fZGly
ZWN0aW9uKExDRF9QQU5FTF9FTkFCTEVfR1BJTywgMCk7CisJb21hcF9zZXRfZ3Bpb19kaXJlY3Rp
b24oTENEX1BBTkVMX0xSLCAwKTsKKwlvbWFwX3NldF9ncGlvX2RpcmVjdGlvbihMQ0RfUEFORUxf
VUQsIDApOworCW9tYXBfc2V0X2dwaW9fZGlyZWN0aW9uKExDRF9QQU5FTF9JTkksIDApOworCW9t
YXBfc2V0X2dwaW9fZGlyZWN0aW9uKExDRF9QQU5FTF9RVkdBLCAwKTsKKwlvbWFwX3NldF9ncGlv
X2RpcmVjdGlvbihMQ0RfUEFORUxfUkVTQiwgMCk7CisKKwlvbWFwX3NldF9ncGlvX2RhdGFvdXQo
TENEX1BBTkVMX1JFU0IsIDEpOworCW9tYXBfc2V0X2dwaW9fZGF0YW91dChMQ0RfUEFORUxfSU5J
LCAxKTsKKwlvbWFwX3NldF9ncGlvX2RhdGFvdXQoTENEX1BBTkVMX1FWR0EsIDApOworCW9tYXBf
c2V0X2dwaW9fZGF0YW91dChMQ0RfUEFORUxfTFIsIDEpOworCW9tYXBfc2V0X2dwaW9fZGF0YW91
dChMQ0RfUEFORUxfVUQsIDEpOworCisJdHdsNDAzMF9pMmNfd3JpdGVfdTgoVFdMNDAzMF9NT0RV
TEVfTEVELCAweDExLCBUV0xfTEVEX0xFREVOKTsKKwl0d2w0MDMwX2kyY193cml0ZV91OChUV0w0
MDMwX01PRFVMRV9QV01BLCAweDAxLCBUV0xfUFdNQV9QV01BT04pOworCXR3bDQwMzBfaTJjX3dy
aXRlX3U4KFRXTDQwMzBfTU9EVUxFX1BXTUEsIDB4MDIsIFRXTF9QV01BX1BXTUFPRkYpOworCWJr
bGlnaHRfbGV2ZWwgPSAxMDA7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgb21hcDJl
dm1fcGFuZWxfY2xlYW51cChzdHJ1Y3QgbGNkX3BhbmVsICpwYW5lbCkKK3sKK30KKworc3RhdGlj
IGludCBvbWFwMmV2bV9wYW5lbF9lbmFibGUoc3RydWN0IGxjZF9wYW5lbCAqcGFuZWwpCit7CisJ
b21hcF9zZXRfZ3Bpb19kYXRhb3V0KExDRF9QQU5FTF9FTkFCTEVfR1BJTywgMCk7CisJcmV0dXJu
IDA7Cit9CisKK3N0YXRpYyB2b2lkIG9tYXAyZXZtX3BhbmVsX2Rpc2FibGUoc3RydWN0IGxjZF9w
YW5lbCAqcGFuZWwpCit7CisJb21hcF9zZXRfZ3Bpb19kYXRhb3V0KExDRF9QQU5FTF9FTkFCTEVf
R1BJTywgMSk7Cit9CisKK3N0YXRpYyB1bnNpZ25lZCBsb25nIG9tYXAyZXZtX3BhbmVsX2dldF9j
YXBzKHN0cnVjdCBsY2RfcGFuZWwgKnBhbmVsKQoreworCXJldHVybiAwOworfQorCitzdGF0aWMg
aW50IG9tYXAyZXZtX2JrbGlnaHRfc2V0bGV2ZWwoc3RydWN0IGxjZF9wYW5lbCAqcGFuZWwsCisJ
CQkJCQl1bnNpZ25lZCBpbnQgbGV2ZWwpCit7CisJdTggYzsKKwlpZiAoKGxldmVsID49IDApICYm
IChsZXZlbCA8PSAxMDApKSB7CisJCWMgPSAoMTI1ICogKDEwMCAtIGxldmVsKSkgLyAxMDAgKyAy
OworCQl0d2w0MDMwX2kyY193cml0ZV91OChUV0w0MDMwX01PRFVMRV9QV01BLCBjLCBUV0xfUFdN
QV9QV01BT0ZGKTsKKwkJYmtsaWdodF9sZXZlbCA9IGxldmVsOworCX0KKwlyZXR1cm4gMDsKK30K
Kworc3RhdGljIHVuc2lnbmVkIGludCBvbWFwMmV2bV9ia2xpZ2h0X2dldGxldmVsKHN0cnVjdCBs
Y2RfcGFuZWwgKnBhbmVsKQoreworCXJldHVybiBia2xpZ2h0X2xldmVsOworfQorCitzdGF0aWMg
dW5zaWduZWQgaW50IG9tYXAyZXZtX2JrbGlnaHRfZ2V0bWF4bGV2ZWwoc3RydWN0IGxjZF9wYW5l
bCAqcGFuZWwpCit7CisJcmV0dXJuIDEwMDsKK30KKworc3RydWN0IGxjZF9wYW5lbCBvbWFwMmV2
bV9wYW5lbCA9IHsKKwkubmFtZQkJPSAib21hcDJldm0iLAorCS5jb25maWcJCT0gT01BUF9MQ0RD
X1BBTkVMX1RGVCB8IE9NQVBfTENEQ19JTlZfVlNZTkMgfAorCQkJICBPTUFQX0xDRENfSU5WX0hT
WU5DLAorCisJLmJwcAkJPSAxNiwKKwkuZGF0YV9saW5lcwk9IDE4LAorCS54X3JlcwkJPSBMQ0Rf
WFJFUywKKwkueV9yZXMJCT0gTENEX1lSRVMsCisJLmhzdwkJPSAzLAorCS5oZnAJCT0gMCwKKwku
aGJwCQk9IDI4LAorCS52c3cJCT0gMiwKKwkudmZwCQk9IDEsCisJLnZicAkJPSAwLAorCisJLnBp
eGVsX2Nsb2NrCT0gTENEX1BJWENMT0NLLAorCisJLmluaXQJCT0gb21hcDJldm1fcGFuZWxfaW5p
dCwKKwkuY2xlYW51cAk9IG9tYXAyZXZtX3BhbmVsX2NsZWFudXAsCisJLmVuYWJsZQkJPSBvbWFw
MmV2bV9wYW5lbF9lbmFibGUsCisJLmRpc2FibGUJPSBvbWFwMmV2bV9wYW5lbF9kaXNhYmxlLAor
CS5nZXRfY2Fwcwk9IG9tYXAyZXZtX3BhbmVsX2dldF9jYXBzLAorCS5zZXRfYmtsaWdodF9sZXZl
bCAgICAgID0gb21hcDJldm1fYmtsaWdodF9zZXRsZXZlbCwKKwkuZ2V0X2JrbGlnaHRfbGV2ZWwg
ICAgICA9IG9tYXAyZXZtX2JrbGlnaHRfZ2V0bGV2ZWwsCisJLmdldF9ia2xpZ2h0X21heCAgICAg
ICAgPSBvbWFwMmV2bV9ia2xpZ2h0X2dldG1heGxldmVsLAorfTsKKworc3RhdGljIGludCBvbWFw
MmV2bV9wYW5lbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoreworCW9tYXBm
Yl9yZWdpc3Rlcl9wYW5lbCgmb21hcDJldm1fcGFuZWwpOworCXJldHVybiAwOworfQorCitzdGF0
aWMgaW50IG9tYXAyZXZtX3BhbmVsX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQoreworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IG9tYXAyZXZtX3BhbmVsX3N1c3BlbmQo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwKKwkJCQkgICBwbV9tZXNzYWdlX3QgbWVzZykK
K3sKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBvbWFwMmV2bV9wYW5lbF9yZXN1bWUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlyZXR1cm4gMDsKK30KKworc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBvbWFwMmV2bV9wYW5lbF9kcml2ZXIgPSB7CisJLnByb2JlCQk9IG9tYXAy
ZXZtX3BhbmVsX3Byb2JlLAorCS5yZW1vdmUJCT0gb21hcDJldm1fcGFuZWxfcmVtb3ZlLAorCS5z
dXNwZW5kCT0gb21hcDJldm1fcGFuZWxfc3VzcGVuZCwKKwkucmVzdW1lCQk9IG9tYXAyZXZtX3Bh
bmVsX3Jlc3VtZSwKKwkuZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSAib21hcDJldm1fbGNkIiwKKwkJ
Lm93bmVyCT0gVEhJU19NT0RVTEUsCisJfSwKK307CisKK3N0YXRpYyBpbnQgX19pbml0IG9tYXAy
ZXZtX3BhbmVsX2Rydl9pbml0KHZvaWQpCit7CisJcmV0dXJuIHBsYXRmb3JtX2RyaXZlcl9yZWdp
c3Rlcigmb21hcDJldm1fcGFuZWxfZHJpdmVyKTsKK30KKworc3RhdGljIHZvaWQgX19leGl0IG9t
YXAyZXZtX3BhbmVsX2Rydl9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0
ZXIoJm9tYXAyZXZtX3BhbmVsX2RyaXZlcik7Cit9CisKK21vZHVsZV9pbml0KG9tYXAyZXZtX3Bh
bmVsX2Rydl9pbml0KTsKK21vZHVsZV9leGl0KG9tYXAyZXZtX3BhbmVsX2Rydl9leGl0KTsKLS0g
CjEuNS42Cgo=
------=_Part_9905_30252636.1215096862732--
