From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial stuff)
Date: Wed, 24 Oct 2012 13:15:06 +0200
Message-ID: <CAK=WgbZpQBVZiL2Gw_Sg_S0GZXPM0pxG2Nfbwqwk9gtnJyEe8Q@mail.gmail.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com> <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
 <20121016181038.GC15569@atomide.com> <20121016182642.GF15569@atomide.com>
 <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com>
 <507EA7DB.3070207@compulab.co.il> <CAK=Wgba_-k0kCHah6t6L4=qt838j30ZRVRbgAdJ1yzHDyA8frw@mail.gmail.com>
 <20121019170759.GK4730@atomide.com> <CAK=WgbbPmuOgssRRSinsV3rXg7TUa9fpOP-Zg+VatZgqgVYixw@mail.gmail.com>
 <20121024015418.GC5605@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae93410752ae1e604cccc348a
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54830 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab2JXLP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 07:15:28 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so432868iea.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Oct 2012 04:15:27 -0700 (PDT)
In-Reply-To: <20121024015418.GC5605@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>

--14dae93410752ae1e604cccc348a
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 24, 2012 at 3:54 AM, Tony Lindgren <tony@atomide.com> wrote:
> I don't think mach-davinci has wl12xx_board_init() available?
> Maybe leave this out or define also also somewhere for mach-davinci?

Yeah let's leave davinci out for now:

>From 665bcaa7ef0ed385cf1765f2d4503bf84aaf488a Mon Sep 17 00:00:00 2001
From: Ohad Ben-Cohen <ohad@wizery.com>
Date: Sun, 14 Oct 2012 20:16:01 +0200
Subject: [PATCH] ARM: OMAP: don't print any error when wl12xx isn't
 configured

Stop intimidating users with scary wlan error messages in case wl12xx
support wasn't even built.

In addition, when wl12xx_set_platform_data() fails, don't bother
registering wl12xx's fixed regulator device (on the relevant
boards).

While we're at it, extract the wlan init code to a dedicated function to
make (the relevant boards') init code look a bit nicer.

Compile tested only.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/board-4430sdp.c          |  7 +++---
 arch/arm/mach-omap2/board-omap3evm.c         |  6 ++---
 arch/arm/mach-omap2/board-omap3pandora.c     |  9 +++-----
 arch/arm/mach-omap2/board-omap4panda.c       | 20 ++++++++++++-----
 arch/arm/mach-omap2/board-zoom-peripherals.c | 15 ++++++++-----
 arch/arm/mach-omap2/common-board-devices.c   | 33 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/common-board-devices.h   |  2 ++
 7 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c
b/arch/arm/mach-omap2/board-4430sdp.c
index 3669c12..bc48679 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -825,10 +825,11 @@ static void __init omap4_sdp4430_wifi_init(void)
 	int ret;

 	omap4_sdp4430_wifi_mux_init();
-	omap4_sdp4430_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
-	ret = wl12xx_set_platform_data(&omap4_sdp4430_wlan_data);
+
+	ret = wl12xx_board_init(&omap4_sdp4430_wlan_data, GPIO_WIFI_IRQ);
 	if (ret)
-		pr_err("Error setting wl12xx data: %d\n", ret);
+		return;
+
 	ret = platform_device_register(&omap_vwlan_device);
 	if (ret)
 		pr_err("Error registering wl12xx device: %d\n", ret);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c
b/arch/arm/mach-omap2/board-omap3evm.c
index b9b776b..8e3a075 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -636,10 +636,10 @@ static void __init omap3_evm_wl12xx_init(void)
 	int ret;

 	/* WL12xx WLAN Init */
-	omap3evm_wlan_data.irq = gpio_to_irq(OMAP3EVM_WLAN_IRQ_GPIO);
-	ret = wl12xx_set_platform_data(&omap3evm_wlan_data);
+	ret = wl12xx_board_init(&omap3evm_wlan_data, OMAP3EVM_WLAN_IRQ_GPIO);
 	if (ret)
-		pr_err("error setting wl12xx data: %d\n", ret);
+		return;
+
 	ret = platform_device_register(&omap3evm_wlan_regulator);
 	if (ret)
 		pr_err("error registering wl12xx device: %d\n", ret);
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c
b/arch/arm/mach-omap2/board-omap3pandora.c
index 00a1f4a..bfdc7aa 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -543,13 +543,10 @@ static void __init pandora_wl1251_init(void)
 	if (ret < 0)
 		goto fail;

-	pandora_wl1251_pdata.irq = gpio_to_irq(PANDORA_WIFI_IRQ_GPIO);
-	if (pandora_wl1251_pdata.irq < 0)
-		goto fail_irq;
-
 	pandora_wl1251_pdata.use_eeprom = true;
-	ret = wl12xx_set_platform_data(&pandora_wl1251_pdata);
-	if (ret < 0)
+
+	ret = wl12xx_board_init(&pandora_wl1251_pdata, PANDORA_WIFI_IRQ_GPIO);
+	if (ret)
 		goto fail_irq;

 	return;
diff --git a/arch/arm/mach-omap2/board-omap4panda.c
b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..f203cd9 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -486,24 +486,32 @@ static void omap4_panda_init_rev(void)
 	}
 }

+static void __init omap4_panda_wlan_init(void)
+{
+	int ret;
+
+	ret = wl12xx_board_init(&omap_panda_wlan_data, GPIO_WIFI_IRQ);
+	if (ret)
+		return;
+
+	ret = platform_device_register(&omap_vwlan_device);
+	if (ret)
+		pr_err("error registering wl12xx's fixed regulator: %d\n", ret);
+}
+
 static void __init omap4_panda_init(void)
 {
 	int package = OMAP_PACKAGE_CBS;
-	int ret;

 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		package = OMAP_PACKAGE_CBL;
 	omap4_mux_init(board_mux, NULL, package);

-	omap_panda_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
-	ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
-	if (ret)
-		pr_err("error setting wl12xx data: %d\n", ret);
+	omap4_panda_wlan_init();

 	omap4_panda_init_rev();
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
-	platform_device_register(&omap_vwlan_device);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	omap4_twl6030_hsmmc_init(mmc);
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
b/arch/arm/mach-omap2/board-zoom-peripherals.c
index c166fe1..c81a2c7 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -286,19 +286,24 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }

-void __init zoom_peripherals_init(void)
+static void __init zoom_wlan_init(void)
 {
 	int ret;

-	omap_zoom_wlan_data.irq = gpio_to_irq(OMAP_ZOOM_WLAN_IRQ_GPIO);
-	ret = wl12xx_set_platform_data(&omap_zoom_wlan_data);
+	ret = wl12xx_board_init(&omap_zoom_wlan_data, OMAP_ZOOM_WLAN_IRQ_GPIO);
+	if (ret)
+		return;

+	ret = platform_device_register(&omap_vwlan_device);
 	if (ret)
-		pr_err("error setting wl12xx data: %d\n", ret);
+		pr_err("error registering wl12xx's fixed regulator: %d\n", ret);
+}

+void __init zoom_peripherals_init(void)
+{
 	omap_hsmmc_init(mmc);
+	zoom_wlan_init();
 	omap_i2c_init();
-	platform_device_register(&omap_vwlan_device);
 	usb_musb_init(NULL);
 	enable_board_wakeup_source();
 	omap_serial_init();
diff --git a/arch/arm/mach-omap2/common-board-devices.c
b/arch/arm/mach-omap2/common-board-devices.c
index 48daac2..02351e9 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/wl12xx.h>

 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
@@ -141,3 +142,35 @@ void __init omap_nand_flash_init(int options,
struct mtd_partition *parts,
 {
 }
 #endif
+
+#ifdef CONFIG_WL12XX_PLATFORM_DATA
+int __init wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int gpio)
+{
+	int ret;
+
+	wlan_data->irq = gpio_to_irq(gpio);
+	if (wlan_data->irq < 0) {
+		ret = wlan_data->irq;
+		pr_err("wl12xx: gpio_to_irq(%d) failed: %d\n", gpio, ret);
+		return ret;
+	}
+
+	ret = wl12xx_set_platform_data(wlan_data);
+	/* bail out silently in case wl12xx isn't configured */
+	if (ret == -ENOSYS)
+		return ret;
+
+	/* bail out verbosely on any other error */
+	if (ret) {
+		pr_err("error setting wl12xx data: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+#else /* !CONFIG_WL12XX_PLATFORM_DATA */
+int __init wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int gpio)
+{
+	return 0;
+}
+#endif
diff --git a/arch/arm/mach-omap2/common-board-devices.h
b/arch/arm/mach-omap2/common-board-devices.h
index a0b4a428..0e7398f 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -7,9 +7,11 @@

 struct mtd_partition;
 struct ads7846_platform_data;
+struct wl12xx_platform_data;

 void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 		       struct ads7846_platform_data *board_pdata);
 void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts);
+int wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int gpio);

 #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
-- 
1.7.10.rc3.1067.gb129051

--14dae93410752ae1e604cccc348a
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-don-t-print-any-error-when-wl12xx-isn-t-con.patch"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-don-t-print-any-error-when-wl12xx-isn-t-con.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h8ocj4wv0

RnJvbSA2NjViY2FhN2VmMGVkMzg1Y2YxNzY1ZjJkNDUwM2JmODRhYWY0ODhhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPaGFkIEJlbi1Db2hlbiA8b2hhZEB3aXplcnkuY29tPgpEYXRl
OiBTdW4sIDE0IE9jdCAyMDEyIDIwOjE2OjAxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQVJNOiBP
TUFQOiBkb24ndCBwcmludCBhbnkgZXJyb3Igd2hlbiB3bDEyeHggaXNuJ3QKIGNvbmZpZ3VyZWQK
ClN0b3AgaW50aW1pZGF0aW5nIHVzZXJzIHdpdGggc2Nhcnkgd2xhbiBlcnJvciBtZXNzYWdlcyBp
biBjYXNlIHdsMTJ4eApzdXBwb3J0IHdhc24ndCBldmVuIGJ1aWx0LgoKSW4gYWRkaXRpb24sIHdo
ZW4gd2wxMnh4X3NldF9wbGF0Zm9ybV9kYXRhKCkgZmFpbHMsIGRvbid0IGJvdGhlcgpyZWdpc3Rl
cmluZyB3bDEyeHgncyBmaXhlZCByZWd1bGF0b3IgZGV2aWNlIChvbiB0aGUgcmVsZXZhbnQKYm9h
cmRzKS4KCldoaWxlIHdlJ3JlIGF0IGl0LCBleHRyYWN0IHRoZSB3bGFuIGluaXQgY29kZSB0byBh
IGRlZGljYXRlZCBmdW5jdGlvbiB0bwptYWtlICh0aGUgcmVsZXZhbnQgYm9hcmRzJykgaW5pdCBj
b2RlIGxvb2sgYSBiaXQgbmljZXIuCgpDb21waWxlIHRlc3RlZCBvbmx5LgoKUmVwb3J0ZWQtYnk6
IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtLmxpbnV4Lm9yZy51az4KU2lnbmVkLW9mZi1ieTogT2hh
ZCBCZW4tQ29oZW4gPG9oYWRAd2l6ZXJ5LmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLTQ0MzBzZHAuYyAgICAgICAgICB8ICA3ICsrKy0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9i
b2FyZC1vbWFwM2V2bS5jICAgICAgICAgfCAgNiArKy0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9i
b2FyZC1vbWFwM3BhbmRvcmEuYyAgICAgfCAgOSArKystLS0tLQogYXJjaC9hcm0vbWFjaC1vbWFw
Mi9ib2FyZC1vbWFwNHBhbmRhLmMgICAgICAgfCAyMCArKysrKysrKysrKystLS0tLQogYXJjaC9h
cm0vbWFjaC1vbWFwMi9ib2FyZC16b29tLXBlcmlwaGVyYWxzLmMgfCAxNSArKysrKysrKy0tLS0t
CiBhcmNoL2FybS9tYWNoLW9tYXAyL2NvbW1vbi1ib2FyZC1kZXZpY2VzLmMgICB8IDMzICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtL21hY2gtb21hcDIvY29tbW9uLWJvYXJk
LWRldmljZXMuaCAgIHwgIDIgKysKIDcgZmlsZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwg
MjMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC00
NDMwc2RwLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTQ0MzBzZHAuYwppbmRleCAzNjY5
YzEyLi5iYzQ4Njc5IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTQ0MzBz
ZHAuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTQ0MzBzZHAuYwpAQCAtODI1LDEw
ICs4MjUsMTEgQEAgc3RhdGljIHZvaWQgX19pbml0IG9tYXA0X3NkcDQ0MzBfd2lmaV9pbml0KHZv
aWQpCiAJaW50IHJldDsKIAogCW9tYXA0X3NkcDQ0MzBfd2lmaV9tdXhfaW5pdCgpOwotCW9tYXA0
X3NkcDQ0MzBfd2xhbl9kYXRhLmlycSA9IGdwaW9fdG9faXJxKEdQSU9fV0lGSV9JUlEpOwotCXJl
dCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1fZGF0YSgmb21hcDRfc2RwNDQzMF93bGFuX2RhdGEpOwor
CisJcmV0ID0gd2wxMnh4X2JvYXJkX2luaXQoJm9tYXA0X3NkcDQ0MzBfd2xhbl9kYXRhLCBHUElP
X1dJRklfSVJRKTsKIAlpZiAocmV0KQotCQlwcl9lcnIoIkVycm9yIHNldHRpbmcgd2wxMnh4IGRh
dGE6ICVkXG4iLCByZXQpOworCQlyZXR1cm47CisKIAlyZXQgPSBwbGF0Zm9ybV9kZXZpY2VfcmVn
aXN0ZXIoJm9tYXBfdndsYW5fZGV2aWNlKTsKIAlpZiAocmV0KQogCQlwcl9lcnIoIkVycm9yIHJl
Z2lzdGVyaW5nIHdsMTJ4eCBkZXZpY2U6ICVkXG4iLCByZXQpOwpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwM2V2bS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2Fy
ZC1vbWFwM2V2bS5jCmluZGV4IGI5Yjc3NmIuLjhlM2EwNzUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJt
L21hY2gtb21hcDIvYm9hcmQtb21hcDNldm0uYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLW9tYXAzZXZtLmMKQEAgLTYzNiwxMCArNjM2LDEwIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBv
bWFwM19ldm1fd2wxMnh4X2luaXQodm9pZCkKIAlpbnQgcmV0OwogCiAJLyogV0wxMnh4IFdMQU4g
SW5pdCAqLwotCW9tYXAzZXZtX3dsYW5fZGF0YS5pcnEgPSBncGlvX3RvX2lycShPTUFQM0VWTV9X
TEFOX0lSUV9HUElPKTsKLQlyZXQgPSB3bDEyeHhfc2V0X3BsYXRmb3JtX2RhdGEoJm9tYXAzZXZt
X3dsYW5fZGF0YSk7CisJcmV0ID0gd2wxMnh4X2JvYXJkX2luaXQoJm9tYXAzZXZtX3dsYW5fZGF0
YSwgT01BUDNFVk1fV0xBTl9JUlFfR1BJTyk7CiAJaWYgKHJldCkKLQkJcHJfZXJyKCJlcnJvciBz
ZXR0aW5nIHdsMTJ4eCBkYXRhOiAlZFxuIiwgcmV0KTsKKwkJcmV0dXJuOworCiAJcmV0ID0gcGxh
dGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZvbWFwM2V2bV93bGFuX3JlZ3VsYXRvcik7CiAJaWYgKHJl
dCkKIAkJcHJfZXJyKCJlcnJvciByZWdpc3RlcmluZyB3bDEyeHggZGV2aWNlOiAlZFxuIiwgcmV0
KTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNwYW5kb3JhLmMg
Yi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzcGFuZG9yYS5jCmluZGV4IDAwYTFmNGEu
LmJmZGM3YWEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNwYW5k
b3JhLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwM3BhbmRvcmEuYwpAQCAt
NTQzLDEzICs1NDMsMTAgQEAgc3RhdGljIHZvaWQgX19pbml0IHBhbmRvcmFfd2wxMjUxX2luaXQo
dm9pZCkKIAlpZiAocmV0IDwgMCkKIAkJZ290byBmYWlsOwogCi0JcGFuZG9yYV93bDEyNTFfcGRh
dGEuaXJxID0gZ3Bpb190b19pcnEoUEFORE9SQV9XSUZJX0lSUV9HUElPKTsKLQlpZiAocGFuZG9y
YV93bDEyNTFfcGRhdGEuaXJxIDwgMCkKLQkJZ290byBmYWlsX2lycTsKLQogCXBhbmRvcmFfd2wx
MjUxX3BkYXRhLnVzZV9lZXByb20gPSB0cnVlOwotCXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1f
ZGF0YSgmcGFuZG9yYV93bDEyNTFfcGRhdGEpOwotCWlmIChyZXQgPCAwKQorCisJcmV0ID0gd2wx
Mnh4X2JvYXJkX2luaXQoJnBhbmRvcmFfd2wxMjUxX3BkYXRhLCBQQU5ET1JBX1dJRklfSVJRX0dQ
SU8pOworCWlmIChyZXQpCiAJCWdvdG8gZmFpbF9pcnE7CiAKIAlyZXR1cm47CmRpZmYgLS1naXQg
YS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXA0cGFuZGEuYyBiL2FyY2gvYXJtL21hY2gt
b21hcDIvYm9hcmQtb21hcDRwYW5kYS5jCmluZGV4IGJmY2QzOTcuLmYyMDNjZDkgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDRwYW5kYS5jCisrKyBiL2FyY2gvYXJt
L21hY2gtb21hcDIvYm9hcmQtb21hcDRwYW5kYS5jCkBAIC00ODYsMjQgKzQ4NiwzMiBAQCBzdGF0
aWMgdm9pZCBvbWFwNF9wYW5kYV9pbml0X3Jldih2b2lkKQogCX0KIH0KIAorc3RhdGljIHZvaWQg
X19pbml0IG9tYXA0X3BhbmRhX3dsYW5faW5pdCh2b2lkKQoreworCWludCByZXQ7CisKKwlyZXQg
PSB3bDEyeHhfYm9hcmRfaW5pdCgmb21hcF9wYW5kYV93bGFuX2RhdGEsIEdQSU9fV0lGSV9JUlEp
OworCWlmIChyZXQpCisJCXJldHVybjsKKworCXJldCA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rl
cigmb21hcF92d2xhbl9kZXZpY2UpOworCWlmIChyZXQpCisJCXByX2VycigiZXJyb3IgcmVnaXN0
ZXJpbmcgd2wxMnh4J3MgZml4ZWQgcmVndWxhdG9yOiAlZFxuIiwgcmV0KTsKK30KKwogc3RhdGlj
IHZvaWQgX19pbml0IG9tYXA0X3BhbmRhX2luaXQodm9pZCkKIHsKIAlpbnQgcGFja2FnZSA9IE9N
QVBfUEFDS0FHRV9DQlM7Ci0JaW50IHJldDsKIAogCWlmIChvbWFwX3JldigpID09IE9NQVA0NDMw
X1JFVl9FUzFfMCkKIAkJcGFja2FnZSA9IE9NQVBfUEFDS0FHRV9DQkw7CiAJb21hcDRfbXV4X2lu
aXQoYm9hcmRfbXV4LCBOVUxMLCBwYWNrYWdlKTsKIAotCW9tYXBfcGFuZGFfd2xhbl9kYXRhLmly
cSA9IGdwaW9fdG9faXJxKEdQSU9fV0lGSV9JUlEpOwotCXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZv
cm1fZGF0YSgmb21hcF9wYW5kYV93bGFuX2RhdGEpOwotCWlmIChyZXQpCi0JCXByX2VycigiZXJy
b3Igc2V0dGluZyB3bDEyeHggZGF0YTogJWRcbiIsIHJldCk7CisJb21hcDRfcGFuZGFfd2xhbl9p
bml0KCk7CiAKIAlvbWFwNF9wYW5kYV9pbml0X3JldigpOwogCW9tYXA0X3BhbmRhX2kyY19pbml0
KCk7CiAJcGxhdGZvcm1fYWRkX2RldmljZXMocGFuZGFfZGV2aWNlcywgQVJSQVlfU0laRShwYW5k
YV9kZXZpY2VzKSk7Ci0JcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZvbWFwX3Z3bGFuX2Rldmlj
ZSk7CiAJb21hcF9zZXJpYWxfaW5pdCgpOwogCW9tYXBfc2RyY19pbml0KE5VTEwsIE5VTEwpOwog
CW9tYXA0X3R3bDYwMzBfaHNtbWNfaW5pdChtbWMpOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFj
aC1vbWFwMi9ib2FyZC16b29tLXBlcmlwaGVyYWxzLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLXpvb20tcGVyaXBoZXJhbHMuYwppbmRleCBjMTY2ZmUxLi5jODFhMmM3IDEwMDY0NAotLS0g
YS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLXpvb20tcGVyaXBoZXJhbHMuYworKysgYi9hcmNo
L2FybS9tYWNoLW9tYXAyL2JvYXJkLXpvb20tcGVyaXBoZXJhbHMuYwpAQCAtMjg2LDE5ICsyODYs
MjQgQEAgc3RhdGljIHZvaWQgZW5hYmxlX2JvYXJkX3dha2V1cF9zb3VyY2Uodm9pZCkKIAkJT01B
UF9XQUtFVVBfRU4gfCBPTUFQX1BJTl9JTlBVVF9QVUxMVVApOwogfQogCi12b2lkIF9faW5pdCB6
b29tX3BlcmlwaGVyYWxzX2luaXQodm9pZCkKK3N0YXRpYyB2b2lkIF9faW5pdCB6b29tX3dsYW5f
aW5pdCh2b2lkKQogewogCWludCByZXQ7CiAKLQlvbWFwX3pvb21fd2xhbl9kYXRhLmlycSA9IGdw
aW9fdG9faXJxKE9NQVBfWk9PTV9XTEFOX0lSUV9HUElPKTsKLQlyZXQgPSB3bDEyeHhfc2V0X3Bs
YXRmb3JtX2RhdGEoJm9tYXBfem9vbV93bGFuX2RhdGEpOworCXJldCA9IHdsMTJ4eF9ib2FyZF9p
bml0KCZvbWFwX3pvb21fd2xhbl9kYXRhLCBPTUFQX1pPT01fV0xBTl9JUlFfR1BJTyk7CisJaWYg
KHJldCkKKwkJcmV0dXJuOwogCisJcmV0ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZvbWFw
X3Z3bGFuX2RldmljZSk7CiAJaWYgKHJldCkKLQkJcHJfZXJyKCJlcnJvciBzZXR0aW5nIHdsMTJ4
eCBkYXRhOiAlZFxuIiwgcmV0KTsKKwkJcHJfZXJyKCJlcnJvciByZWdpc3RlcmluZyB3bDEyeHgn
cyBmaXhlZCByZWd1bGF0b3I6ICVkXG4iLCByZXQpOworfQogCit2b2lkIF9faW5pdCB6b29tX3Bl
cmlwaGVyYWxzX2luaXQodm9pZCkKK3sKIAlvbWFwX2hzbW1jX2luaXQobW1jKTsKKwl6b29tX3ds
YW5faW5pdCgpOwogCW9tYXBfaTJjX2luaXQoKTsKLQlwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXIo
Jm9tYXBfdndsYW5fZGV2aWNlKTsKIAl1c2JfbXVzYl9pbml0KE5VTEwpOwogCWVuYWJsZV9ib2Fy
ZF93YWtldXBfc291cmNlKCk7CiAJb21hcF9zZXJpYWxfaW5pdCgpOwpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vbWFjaC1vbWFwMi9jb21tb24tYm9hcmQtZGV2aWNlcy5jIGIvYXJjaC9hcm0vbWFjaC1v
bWFwMi9jb21tb24tYm9hcmQtZGV2aWNlcy5jCmluZGV4IDQ4ZGFhYzIuLjAyMzUxZTkgMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvY29tbW9uLWJvYXJkLWRldmljZXMuYworKysgYi9h
cmNoL2FybS9tYWNoLW9tYXAyL2NvbW1vbi1ib2FyZC1kZXZpY2VzLmMKQEAgLTIzLDYgKzIzLDcg
QEAKICNpbmNsdWRlIDxsaW51eC9ncGlvLmg+CiAjaW5jbHVkZSA8bGludXgvc3BpL3NwaS5oPgog
I2luY2x1ZGUgPGxpbnV4L3NwaS9hZHM3ODQ2Lmg+CisjaW5jbHVkZSA8bGludXgvd2wxMnh4Lmg+
CiAKICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kYXRhL3NwaS1vbWFwMi1tY3NwaS5oPgogI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RhdGEvbXRkLW5hbmQtb21hcDIuaD4KQEAgLTE0MSwzICsx
NDIsMzUgQEAgdm9pZCBfX2luaXQgb21hcF9uYW5kX2ZsYXNoX2luaXQoaW50IG9wdGlvbnMsIHN0
cnVjdCBtdGRfcGFydGl0aW9uICpwYXJ0cywKIHsKIH0KICNlbmRpZgorCisjaWZkZWYgQ09ORklH
X1dMMTJYWF9QTEFURk9STV9EQVRBCitpbnQgX19pbml0IHdsMTJ4eF9ib2FyZF9pbml0KHN0cnVj
dCB3bDEyeHhfcGxhdGZvcm1fZGF0YSAqd2xhbl9kYXRhLCBpbnQgZ3BpbykKK3sKKwlpbnQgcmV0
OworCisJd2xhbl9kYXRhLT5pcnEgPSBncGlvX3RvX2lycShncGlvKTsKKwlpZiAod2xhbl9kYXRh
LT5pcnEgPCAwKSB7CisJCXJldCA9IHdsYW5fZGF0YS0+aXJxOworCQlwcl9lcnIoIndsMTJ4eDog
Z3Bpb190b19pcnEoJWQpIGZhaWxlZDogJWRcbiIsIGdwaW8sIHJldCk7CisJCXJldHVybiByZXQ7
CisJfQorCisJcmV0ID0gd2wxMnh4X3NldF9wbGF0Zm9ybV9kYXRhKHdsYW5fZGF0YSk7CisJLyog
YmFpbCBvdXQgc2lsZW50bHkgaW4gY2FzZSB3bDEyeHggaXNuJ3QgY29uZmlndXJlZCAqLworCWlm
IChyZXQgPT0gLUVOT1NZUykKKwkJcmV0dXJuIHJldDsKKworCS8qIGJhaWwgb3V0IHZlcmJvc2Vs
eSBvbiBhbnkgb3RoZXIgZXJyb3IgKi8KKwlpZiAocmV0KSB7CisJCXByX2VycigiZXJyb3Igc2V0
dGluZyB3bDEyeHggZGF0YTogJWRcbiIsIHJldCk7CisJCXJldHVybiByZXQ7CisJfQorCisJcmV0
dXJuIDA7Cit9CisjZWxzZSAvKiAhQ09ORklHX1dMMTJYWF9QTEFURk9STV9EQVRBICovCitpbnQg
X19pbml0IHdsMTJ4eF9ib2FyZF9pbml0KHN0cnVjdCB3bDEyeHhfcGxhdGZvcm1fZGF0YSAqd2xh
bl9kYXRhLCBpbnQgZ3BpbykKK3sKKwlyZXR1cm4gMDsKK30KKyNlbmRpZgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vbWFjaC1vbWFwMi9jb21tb24tYm9hcmQtZGV2aWNlcy5oIGIvYXJjaC9hcm0vbWFj
aC1vbWFwMi9jb21tb24tYm9hcmQtZGV2aWNlcy5oCmluZGV4IGEwYjRhNDI4Li4wZTczOThmIDEw
MDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2NvbW1vbi1ib2FyZC1kZXZpY2VzLmgKKysr
IGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9jb21tb24tYm9hcmQtZGV2aWNlcy5oCkBAIC03LDkgKzcs
MTEgQEAKIAogc3RydWN0IG10ZF9wYXJ0aXRpb247CiBzdHJ1Y3QgYWRzNzg0Nl9wbGF0Zm9ybV9k
YXRhOworc3RydWN0IHdsMTJ4eF9wbGF0Zm9ybV9kYXRhOwogCiB2b2lkIG9tYXBfYWRzNzg0Nl9p
bml0KGludCBidXNfbnVtLCBpbnQgZ3Bpb19wZW5kb3duLCBpbnQgZ3Bpb19kZWJvdW5jZSwKIAkJ
ICAgICAgIHN0cnVjdCBhZHM3ODQ2X3BsYXRmb3JtX2RhdGEgKmJvYXJkX3BkYXRhKTsKIHZvaWQg
b21hcF9uYW5kX2ZsYXNoX2luaXQoaW50IG9wdHMsIHN0cnVjdCBtdGRfcGFydGl0aW9uICpwYXJ0
cywgaW50IG5fcGFydHMpOworaW50IHdsMTJ4eF9ib2FyZF9pbml0KHN0cnVjdCB3bDEyeHhfcGxh
dGZvcm1fZGF0YSAqd2xhbl9kYXRhLCBpbnQgZ3Bpbyk7CiAKICNlbmRpZiAvKiBfX09NQVBfQ09N
TU9OX0JPQVJEX0RFVklDRVNfXyAqLwotLSAKMS43LjEwLnJjMy4xMDY3LmdiMTI5MDUxCgo=
--14dae93410752ae1e604cccc348a--
