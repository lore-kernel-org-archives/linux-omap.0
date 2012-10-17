From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial stuff)
Date: Wed, 17 Oct 2012 11:10:08 +0200
Message-ID: <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com> <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
 <20121016181038.GC15569@atomide.com> <20121016182642.GF15569@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f923cc653139a04cc3da4e1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63011 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380Ab2JQJK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 05:10:29 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so11410809iea.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Oct 2012 02:10:29 -0700 (PDT)
In-Reply-To: <20121016182642.GF15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>

--e89a8f923cc653139a04cc3da4e1
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Oct 16, 2012 at 8:26 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hmm looking at it repeats the same code over again. Can you
> rather add some wl12xx_board_init() helper function to mach-omap2/devices.c
> to do it?

Nice, see below. Note that I can only compile test this now, which may
be ok because it's pretty trivial. But do let me know if you want me
to get it tested.

>From b940fb88a97494ad3a0a093279a5f176c0b29e44 Mon Sep 17 00:00:00 2001
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
 arch/arm/mach-davinci/board-da850-evm.c      |  8 ++------
 arch/arm/mach-omap2/board-4430sdp.c          |  7 ++++---
 arch/arm/mach-omap2/board-omap3evm.c         |  6 +++---
 arch/arm/mach-omap2/board-omap3pandora.c     |  9 +++------
 arch/arm/mach-omap2/board-omap4panda.c       | 20 ++++++++++++++------
 arch/arm/mach-omap2/board-zoom-peripherals.c | 15 ++++++++++-----
 arch/arm/mach-omap2/common-board-devices.h   |  2 ++
 arch/arm/mach-omap2/devices.c                | 26 ++++++++++++++++++++++++++
 8 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c
b/arch/arm/mach-davinci/board-da850-evm.c
index 32ee3f8..7243c22 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1401,13 +1401,9 @@ static __init int da850_wl12xx_init(void)
 		goto free_wlan_en;
 	}

-	da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
-
-	ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
-	if (ret) {
-		pr_err("Could not set wl12xx data: %d\n", ret);
+	ret = wl12xx_board_init(&da850_wl12xx_wlan_data, DA850_WLAN_IRQ);
+	if (ret)
 		goto free_wlan_irq;
-	}

 	return 0;

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
diff --git a/arch/arm/mach-omap2/common-board-devices.h
b/arch/arm/mach-omap2/common-board-devices.h
index a0b4a428..52e91424 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -7,9 +7,11 @@

 struct mtd_partition;
 struct ads7846_platform_data;
+struct wl12xx_platform_data;

 void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 		       struct ads7846_platform_data *board_pdata);
 void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts);
+int __init wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int gpio);

 #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c8c2117..9e86bb9 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/omap4-keypad.h>
+#include <linux/wl12xx.h>

 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -38,6 +39,31 @@
 #define L3_MODULES_MAX_LEN 12
 #define L3_MODULES 3

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
+
 static int __init omap3_l3_init(void)
 {
 	struct omap_hwmod *oh;
-- 
1.7.10.rc3.1067.gb129051

--e89a8f923cc653139a04cc3da4e1
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-don-t-print-any-error-when-wl12xx-isn-t-con.patch"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-don-t-print-any-error-when-wl12xx-isn-t-con.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h8e7ycvb0

RnJvbSBiOTQwZmI4OGE5NzQ5NGFkM2EwYTA5MzI3OWE1ZjE3NmMwYjI5ZTQ0IE1vbiBTZXAgMTcg
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
ZCBCZW4tQ29oZW4gPG9oYWRAd2l6ZXJ5LmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLWRhdmluY2kv
Ym9hcmQtZGE4NTAtZXZtLmMgICAgICB8ICA4ICsrLS0tLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAy
L2JvYXJkLTQ0MzBzZHAuYyAgICAgICAgICB8ICA3ICsrKystLS0KIGFyY2gvYXJtL21hY2gtb21h
cDIvYm9hcmQtb21hcDNldm0uYyAgICAgICAgIHwgIDYgKysrLS0tCiBhcmNoL2FybS9tYWNoLW9t
YXAyL2JvYXJkLW9tYXAzcGFuZG9yYS5jICAgICB8ICA5ICsrKy0tLS0tLQogYXJjaC9hcm0vbWFj
aC1vbWFwMi9ib2FyZC1vbWFwNHBhbmRhLmMgICAgICAgfCAyMCArKysrKysrKysrKysrKy0tLS0t
LQogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC16b29tLXBlcmlwaGVyYWxzLmMgfCAxNSArKysr
KysrKysrLS0tLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvY29tbW9uLWJvYXJkLWRldmljZXMuaCAg
IHwgIDIgKysKIGFyY2gvYXJtL21hY2gtb21hcDIvZGV2aWNlcy5jICAgICAgICAgICAgICAgIHwg
MjYgKysrKysrKysrKysrKysrKysrKysrKysrKysKIDggZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0
aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1kYXZp
bmNpL2JvYXJkLWRhODUwLWV2bS5jIGIvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2JvYXJkLWRhODUw
LWV2bS5jCmluZGV4IDMyZWUzZjguLjcyNDNjMjIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gt
ZGF2aW5jaS9ib2FyZC1kYTg1MC1ldm0uYworKysgYi9hcmNoL2FybS9tYWNoLWRhdmluY2kvYm9h
cmQtZGE4NTAtZXZtLmMKQEAgLTE0MDEsMTMgKzE0MDEsOSBAQCBzdGF0aWMgX19pbml0IGludCBk
YTg1MF93bDEyeHhfaW5pdCh2b2lkKQogCQlnb3RvIGZyZWVfd2xhbl9lbjsKIAl9CiAKLQlkYTg1
MF93bDEyeHhfd2xhbl9kYXRhLmlycSA9IGdwaW9fdG9faXJxKERBODUwX1dMQU5fSVJRKTsKLQot
CXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1fZGF0YSgmZGE4NTBfd2wxMnh4X3dsYW5fZGF0YSk7
Ci0JaWYgKHJldCkgewotCQlwcl9lcnIoIkNvdWxkIG5vdCBzZXQgd2wxMnh4IGRhdGE6ICVkXG4i
LCByZXQpOworCXJldCA9IHdsMTJ4eF9ib2FyZF9pbml0KCZkYTg1MF93bDEyeHhfd2xhbl9kYXRh
LCBEQTg1MF9XTEFOX0lSUSk7CisJaWYgKHJldCkKIAkJZ290byBmcmVlX3dsYW5faXJxOwotCX0K
IAogCXJldHVybiAwOwogCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTQ0
MzBzZHAuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtNDQzMHNkcC5jCmluZGV4IDM2Njlj
MTIuLmJjNDg2NzkgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtNDQzMHNk
cC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtNDQzMHNkcC5jCkBAIC04MjUsMTAg
KzgyNSwxMSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb21hcDRfc2RwNDQzMF93aWZpX2luaXQodm9p
ZCkKIAlpbnQgcmV0OwogCiAJb21hcDRfc2RwNDQzMF93aWZpX211eF9pbml0KCk7Ci0Jb21hcDRf
c2RwNDQzMF93bGFuX2RhdGEuaXJxID0gZ3Bpb190b19pcnEoR1BJT19XSUZJX0lSUSk7Ci0JcmV0
ID0gd2wxMnh4X3NldF9wbGF0Zm9ybV9kYXRhKCZvbWFwNF9zZHA0NDMwX3dsYW5fZGF0YSk7CisK
KwlyZXQgPSB3bDEyeHhfYm9hcmRfaW5pdCgmb21hcDRfc2RwNDQzMF93bGFuX2RhdGEsIEdQSU9f
V0lGSV9JUlEpOwogCWlmIChyZXQpCi0JCXByX2VycigiRXJyb3Igc2V0dGluZyB3bDEyeHggZGF0
YTogJWRcbiIsIHJldCk7CisJCXJldHVybjsKKwogCXJldCA9IHBsYXRmb3JtX2RldmljZV9yZWdp
c3Rlcigmb21hcF92d2xhbl9kZXZpY2UpOwogCWlmIChyZXQpCiAJCXByX2VycigiRXJyb3IgcmVn
aXN0ZXJpbmcgd2wxMnh4IGRldmljZTogJWRcbiIsIHJldCk7CmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzZXZtLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJk
LW9tYXAzZXZtLmMKaW5kZXggYjliNzc2Yi4uOGUzYTA3NSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9ib2FyZC1vbWFwM2V2bS5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9h
cmQtb21hcDNldm0uYwpAQCAtNjM2LDEwICs2MzYsMTAgQEAgc3RhdGljIHZvaWQgX19pbml0IG9t
YXAzX2V2bV93bDEyeHhfaW5pdCh2b2lkKQogCWludCByZXQ7CiAKIAkvKiBXTDEyeHggV0xBTiBJ
bml0ICovCi0Jb21hcDNldm1fd2xhbl9kYXRhLmlycSA9IGdwaW9fdG9faXJxKE9NQVAzRVZNX1dM
QU5fSVJRX0dQSU8pOwotCXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1fZGF0YSgmb21hcDNldm1f
d2xhbl9kYXRhKTsKKwlyZXQgPSB3bDEyeHhfYm9hcmRfaW5pdCgmb21hcDNldm1fd2xhbl9kYXRh
LCBPTUFQM0VWTV9XTEFOX0lSUV9HUElPKTsKIAlpZiAocmV0KQotCQlwcl9lcnIoImVycm9yIHNl
dHRpbmcgd2wxMnh4IGRhdGE6ICVkXG4iLCByZXQpOworCQlyZXR1cm47CisKIAlyZXQgPSBwbGF0
Zm9ybV9kZXZpY2VfcmVnaXN0ZXIoJm9tYXAzZXZtX3dsYW5fcmVndWxhdG9yKTsKIAlpZiAocmV0
KQogCQlwcl9lcnIoImVycm9yIHJlZ2lzdGVyaW5nIHdsMTJ4eCBkZXZpY2U6ICVkXG4iLCByZXQp
OwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwM3BhbmRvcmEuYyBi
L2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNwYW5kb3JhLmMKaW5kZXggMDBhMWY0YS4u
YmZkYzdhYSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwM3BhbmRv
cmEuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzcGFuZG9yYS5jCkBAIC01
NDMsMTMgKzU0MywxMCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgcGFuZG9yYV93bDEyNTFfaW5pdCh2
b2lkKQogCWlmIChyZXQgPCAwKQogCQlnb3RvIGZhaWw7CiAKLQlwYW5kb3JhX3dsMTI1MV9wZGF0
YS5pcnEgPSBncGlvX3RvX2lycShQQU5ET1JBX1dJRklfSVJRX0dQSU8pOwotCWlmIChwYW5kb3Jh
X3dsMTI1MV9wZGF0YS5pcnEgPCAwKQotCQlnb3RvIGZhaWxfaXJxOwotCiAJcGFuZG9yYV93bDEy
NTFfcGRhdGEudXNlX2VlcHJvbSA9IHRydWU7Ci0JcmV0ID0gd2wxMnh4X3NldF9wbGF0Zm9ybV9k
YXRhKCZwYW5kb3JhX3dsMTI1MV9wZGF0YSk7Ci0JaWYgKHJldCA8IDApCisKKwlyZXQgPSB3bDEy
eHhfYm9hcmRfaW5pdCgmcGFuZG9yYV93bDEyNTFfcGRhdGEsIFBBTkRPUkFfV0lGSV9JUlFfR1BJ
Tyk7CisJaWYgKHJldCkKIAkJZ290byBmYWlsX2lycTsKIAogCXJldHVybjsKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDRwYW5kYS5jIGIvYXJjaC9hcm0vbWFjaC1v
bWFwMi9ib2FyZC1vbWFwNHBhbmRhLmMKaW5kZXggYmZjZDM5Ny4uZjIwM2NkOSAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwNHBhbmRhLmMKKysrIGIvYXJjaC9hcm0v
bWFjaC1vbWFwMi9ib2FyZC1vbWFwNHBhbmRhLmMKQEAgLTQ4NiwyNCArNDg2LDMyIEBAIHN0YXRp
YyB2b2lkIG9tYXA0X3BhbmRhX2luaXRfcmV2KHZvaWQpCiAJfQogfQogCitzdGF0aWMgdm9pZCBf
X2luaXQgb21hcDRfcGFuZGFfd2xhbl9pbml0KHZvaWQpCit7CisJaW50IHJldDsKKworCXJldCA9
IHdsMTJ4eF9ib2FyZF9pbml0KCZvbWFwX3BhbmRhX3dsYW5fZGF0YSwgR1BJT19XSUZJX0lSUSk7
CisJaWYgKHJldCkKKwkJcmV0dXJuOworCisJcmV0ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVy
KCZvbWFwX3Z3bGFuX2RldmljZSk7CisJaWYgKHJldCkKKwkJcHJfZXJyKCJlcnJvciByZWdpc3Rl
cmluZyB3bDEyeHgncyBmaXhlZCByZWd1bGF0b3I6ICVkXG4iLCByZXQpOworfQorCiBzdGF0aWMg
dm9pZCBfX2luaXQgb21hcDRfcGFuZGFfaW5pdCh2b2lkKQogewogCWludCBwYWNrYWdlID0gT01B
UF9QQUNLQUdFX0NCUzsKLQlpbnQgcmV0OwogCiAJaWYgKG9tYXBfcmV2KCkgPT0gT01BUDQ0MzBf
UkVWX0VTMV8wKQogCQlwYWNrYWdlID0gT01BUF9QQUNLQUdFX0NCTDsKIAlvbWFwNF9tdXhfaW5p
dChib2FyZF9tdXgsIE5VTEwsIHBhY2thZ2UpOwogCi0Jb21hcF9wYW5kYV93bGFuX2RhdGEuaXJx
ID0gZ3Bpb190b19pcnEoR1BJT19XSUZJX0lSUSk7Ci0JcmV0ID0gd2wxMnh4X3NldF9wbGF0Zm9y
bV9kYXRhKCZvbWFwX3BhbmRhX3dsYW5fZGF0YSk7Ci0JaWYgKHJldCkKLQkJcHJfZXJyKCJlcnJv
ciBzZXR0aW5nIHdsMTJ4eCBkYXRhOiAlZFxuIiwgcmV0KTsKKwlvbWFwNF9wYW5kYV93bGFuX2lu
aXQoKTsKIAogCW9tYXA0X3BhbmRhX2luaXRfcmV2KCk7CiAJb21hcDRfcGFuZGFfaTJjX2luaXQo
KTsKIAlwbGF0Zm9ybV9hZGRfZGV2aWNlcyhwYW5kYV9kZXZpY2VzLCBBUlJBWV9TSVpFKHBhbmRh
X2RldmljZXMpKTsKLQlwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXIoJm9tYXBfdndsYW5fZGV2aWNl
KTsKIAlvbWFwX3NlcmlhbF9pbml0KCk7CiAJb21hcF9zZHJjX2luaXQoTlVMTCwgTlVMTCk7CiAJ
b21hcDRfdHdsNjAzMF9oc21tY19pbml0KG1tYyk7CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNo
LW9tYXAyL2JvYXJkLXpvb20tcGVyaXBoZXJhbHMuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9h
cmQtem9vbS1wZXJpcGhlcmFscy5jCmluZGV4IGMxNjZmZTEuLmM4MWEyYzcgMTAwNjQ0Ci0tLSBh
L2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtem9vbS1wZXJpcGhlcmFscy5jCisrKyBiL2FyY2gv
YXJtL21hY2gtb21hcDIvYm9hcmQtem9vbS1wZXJpcGhlcmFscy5jCkBAIC0yODYsMTkgKzI4Niwy
NCBAQCBzdGF0aWMgdm9pZCBlbmFibGVfYm9hcmRfd2FrZXVwX3NvdXJjZSh2b2lkKQogCQlPTUFQ
X1dBS0VVUF9FTiB8IE9NQVBfUElOX0lOUFVUX1BVTExVUCk7CiB9CiAKLXZvaWQgX19pbml0IHpv
b21fcGVyaXBoZXJhbHNfaW5pdCh2b2lkKQorc3RhdGljIHZvaWQgX19pbml0IHpvb21fd2xhbl9p
bml0KHZvaWQpCiB7CiAJaW50IHJldDsKIAotCW9tYXBfem9vbV93bGFuX2RhdGEuaXJxID0gZ3Bp
b190b19pcnEoT01BUF9aT09NX1dMQU5fSVJRX0dQSU8pOwotCXJldCA9IHdsMTJ4eF9zZXRfcGxh
dGZvcm1fZGF0YSgmb21hcF96b29tX3dsYW5fZGF0YSk7CisJcmV0ID0gd2wxMnh4X2JvYXJkX2lu
aXQoJm9tYXBfem9vbV93bGFuX2RhdGEsIE9NQVBfWk9PTV9XTEFOX0lSUV9HUElPKTsKKwlpZiAo
cmV0KQorCQlyZXR1cm47CiAKKwlyZXQgPSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXIoJm9tYXBf
dndsYW5fZGV2aWNlKTsKIAlpZiAocmV0KQotCQlwcl9lcnIoImVycm9yIHNldHRpbmcgd2wxMnh4
IGRhdGE6ICVkXG4iLCByZXQpOworCQlwcl9lcnIoImVycm9yIHJlZ2lzdGVyaW5nIHdsMTJ4eCdz
IGZpeGVkIHJlZ3VsYXRvcjogJWRcbiIsIHJldCk7Cit9CiAKK3ZvaWQgX19pbml0IHpvb21fcGVy
aXBoZXJhbHNfaW5pdCh2b2lkKQorewogCW9tYXBfaHNtbWNfaW5pdChtbWMpOworCXpvb21fd2xh
bl9pbml0KCk7CiAJb21hcF9pMmNfaW5pdCgpOwotCXBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcigm
b21hcF92d2xhbl9kZXZpY2UpOwogCXVzYl9tdXNiX2luaXQoTlVMTCk7CiAJZW5hYmxlX2JvYXJk
X3dha2V1cF9zb3VyY2UoKTsKIAlvbWFwX3NlcmlhbF9pbml0KCk7CmRpZmYgLS1naXQgYS9hcmNo
L2FybS9tYWNoLW9tYXAyL2NvbW1vbi1ib2FyZC1kZXZpY2VzLmggYi9hcmNoL2FybS9tYWNoLW9t
YXAyL2NvbW1vbi1ib2FyZC1kZXZpY2VzLmgKaW5kZXggYTBiNGE0MjguLjUyZTkxNDI0IDEwMDY0
NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2NvbW1vbi1ib2FyZC1kZXZpY2VzLmgKKysrIGIv
YXJjaC9hcm0vbWFjaC1vbWFwMi9jb21tb24tYm9hcmQtZGV2aWNlcy5oCkBAIC03LDkgKzcsMTEg
QEAKIAogc3RydWN0IG10ZF9wYXJ0aXRpb247CiBzdHJ1Y3QgYWRzNzg0Nl9wbGF0Zm9ybV9kYXRh
Oworc3RydWN0IHdsMTJ4eF9wbGF0Zm9ybV9kYXRhOwogCiB2b2lkIG9tYXBfYWRzNzg0Nl9pbml0
KGludCBidXNfbnVtLCBpbnQgZ3Bpb19wZW5kb3duLCBpbnQgZ3Bpb19kZWJvdW5jZSwKIAkJICAg
ICAgIHN0cnVjdCBhZHM3ODQ2X3BsYXRmb3JtX2RhdGEgKmJvYXJkX3BkYXRhKTsKIHZvaWQgb21h
cF9uYW5kX2ZsYXNoX2luaXQoaW50IG9wdHMsIHN0cnVjdCBtdGRfcGFydGl0aW9uICpwYXJ0cywg
aW50IG5fcGFydHMpOworaW50IF9faW5pdCB3bDEyeHhfYm9hcmRfaW5pdChzdHJ1Y3Qgd2wxMnh4
X3BsYXRmb3JtX2RhdGEgKndsYW5fZGF0YSwgaW50IGdwaW8pOwogCiAjZW5kaWYgLyogX19PTUFQ
X0NPTU1PTl9CT0FSRF9ERVZJQ0VTX18gKi8KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21h
cDIvZGV2aWNlcy5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9kZXZpY2VzLmMKaW5kZXggYzhjMjEx
Ny4uOWU4NmJiOSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9kZXZpY2VzLmMKKysr
IGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9kZXZpY2VzLmMKQEAgLTE5LDYgKzE5LDcgQEAKICNpbmNs
dWRlIDxsaW51eC9vZi5oPgogI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvbWFjaGluZS5oPgogI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RhdGEvb21hcDQta2V5cGFkLmg+CisjaW5jbHVkZSA8bGlu
dXgvd2wxMnh4Lmg+CiAKICNpbmNsdWRlIDxhc20vbWFjaC10eXBlcy5oPgogI2luY2x1ZGUgPGFz
bS9tYWNoL21hcC5oPgpAQCAtMzgsNiArMzksMzEgQEAKICNkZWZpbmUgTDNfTU9EVUxFU19NQVhf
TEVOIDEyCiAjZGVmaW5lIEwzX01PRFVMRVMgMwogCitpbnQgX19pbml0IHdsMTJ4eF9ib2FyZF9p
bml0KHN0cnVjdCB3bDEyeHhfcGxhdGZvcm1fZGF0YSAqd2xhbl9kYXRhLCBpbnQgZ3BpbykKK3sK
KwlpbnQgcmV0OworCisJd2xhbl9kYXRhLT5pcnEgPSBncGlvX3RvX2lycShncGlvKTsKKwlpZiAo
d2xhbl9kYXRhLT5pcnEgPCAwKSB7CisJCXJldCA9IHdsYW5fZGF0YS0+aXJxOworCQlwcl9lcnIo
IndsMTJ4eDogZ3Bpb190b19pcnEoJWQpIGZhaWxlZDogJWRcbiIsIGdwaW8sIHJldCk7CisJCXJl
dHVybiByZXQ7CisJfQorCisJcmV0ID0gd2wxMnh4X3NldF9wbGF0Zm9ybV9kYXRhKHdsYW5fZGF0
YSk7CisJLyogYmFpbCBvdXQgc2lsZW50bHkgaW4gY2FzZSB3bDEyeHggaXNuJ3QgY29uZmlndXJl
ZCAqLworCWlmIChyZXQgPT0gLUVOT1NZUykKKwkJcmV0dXJuIHJldDsKKworCS8qIGJhaWwgb3V0
IHZlcmJvc2VseSBvbiBhbnkgb3RoZXIgZXJyb3IgKi8KKwlpZiAocmV0KSB7CisJCXByX2Vycigi
ZXJyb3Igc2V0dGluZyB3bDEyeHggZGF0YTogJWRcbiIsIHJldCk7CisJCXJldHVybiByZXQ7CisJ
fQorCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgX19pbml0IG9tYXAzX2wzX2luaXQodm9p
ZCkKIHsKIAlzdHJ1Y3Qgb21hcF9od21vZCAqb2g7Ci0tIAoxLjcuMTAucmMzLjEwNjcuZ2IxMjkw
NTEKCg==
--e89a8f923cc653139a04cc3da4e1--
