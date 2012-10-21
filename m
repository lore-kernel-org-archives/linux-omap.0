From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial stuff)
Date: Sun, 21 Oct 2012 16:54:25 +0200
Message-ID: <CAK=WgbbPmuOgssRRSinsV3rXg7TUa9fpOP-Zg+VatZgqgVYixw@mail.gmail.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com> <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
 <20121016181038.GC15569@atomide.com> <20121016182642.GF15569@atomide.com>
 <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com>
 <507EA7DB.3070207@compulab.co.il> <CAK=Wgba_-k0kCHah6t6L4=qt838j30ZRVRbgAdJ1yzHDyA8frw@mail.gmail.com>
 <20121019170759.GK4730@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f503458ec5fd404cc92ea82
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60858 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab2JUOyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Oct 2012 10:54:46 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2579080iea.19
        for <linux-omap@vger.kernel.org>; Sun, 21 Oct 2012 07:54:45 -0700 (PDT)
In-Reply-To: <20121019170759.GK4730@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>

--e89a8f503458ec5fd404cc92ea82
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Oct 19, 2012 at 7:07 PM, Tony Lindgren <tony@atomide.com> wrote:
...
> We could optimize away a minimal amount of code for many configurations
> with the ifdef? :)

Sure, here goes (compile tested only):

>From 6b82365da2c04986e647d06c285197efece7cb34 Mon Sep 17 00:00:00 2001
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
 arch/arm/mach-davinci/board-da850-evm.c      |  8 ++-----
 arch/arm/mach-omap2/board-4430sdp.c          |  7 +++---
 arch/arm/mach-omap2/board-omap3evm.c         |  6 ++---
 arch/arm/mach-omap2/board-omap3pandora.c     |  9 +++-----
 arch/arm/mach-omap2/board-omap4panda.c       | 20 ++++++++++++-----
 arch/arm/mach-omap2/board-zoom-peripherals.c | 15 ++++++++-----
 arch/arm/mach-omap2/common-board-devices.c   | 33 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/common-board-devices.h   |  2 ++
 8 files changed, 71 insertions(+), 29 deletions(-)

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

--e89a8f503458ec5fd404cc92ea82
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-don-t-print-any-error-when-wl12xx-isn-t-con.patch"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-don-t-print-any-error-when-wl12xx-isn-t-con.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h8ka0vvb0

RnJvbSA2YjgyMzY1ZGEyYzA0OTg2ZTY0N2QwNmMyODUxOTdlZmVjZTdjYjM0IE1vbiBTZXAgMTcg
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
Ym9hcmQtZGE4NTAtZXZtLmMgICAgICB8ICA4ICsrLS0tLS0KIGFyY2gvYXJtL21hY2gtb21hcDIv
Ym9hcmQtNDQzMHNkcC5jICAgICAgICAgIHwgIDcgKysrLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAy
L2JvYXJkLW9tYXAzZXZtLmMgICAgICAgICB8ICA2ICsrLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAy
L2JvYXJkLW9tYXAzcGFuZG9yYS5jICAgICB8ICA5ICsrKy0tLS0tCiBhcmNoL2FybS9tYWNoLW9t
YXAyL2JvYXJkLW9tYXA0cGFuZGEuYyAgICAgICB8IDIwICsrKysrKysrKysrKy0tLS0tCiBhcmNo
L2FybS9tYWNoLW9tYXAyL2JvYXJkLXpvb20tcGVyaXBoZXJhbHMuYyB8IDE1ICsrKysrKysrLS0t
LS0KIGFyY2gvYXJtL21hY2gtb21hcDIvY29tbW9uLWJvYXJkLWRldmljZXMuYyAgIHwgMzMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogYXJjaC9hcm0vbWFjaC1vbWFwMi9jb21tb24tYm9h
cmQtZGV2aWNlcy5oICAgfCAgMiArKwogOCBmaWxlcyBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCsp
LCAyOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWRhdmluY2kvYm9h
cmQtZGE4NTAtZXZtLmMgYi9hcmNoL2FybS9tYWNoLWRhdmluY2kvYm9hcmQtZGE4NTAtZXZtLmMK
aW5kZXggMzJlZTNmOC4uNzI0M2MyMiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNp
L2JvYXJkLWRhODUwLWV2bS5jCisrKyBiL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9ib2FyZC1kYTg1
MC1ldm0uYwpAQCAtMTQwMSwxMyArMTQwMSw5IEBAIHN0YXRpYyBfX2luaXQgaW50IGRhODUwX3ds
MTJ4eF9pbml0KHZvaWQpCiAJCWdvdG8gZnJlZV93bGFuX2VuOwogCX0KIAotCWRhODUwX3dsMTJ4
eF93bGFuX2RhdGEuaXJxID0gZ3Bpb190b19pcnEoREE4NTBfV0xBTl9JUlEpOwotCi0JcmV0ID0g
d2wxMnh4X3NldF9wbGF0Zm9ybV9kYXRhKCZkYTg1MF93bDEyeHhfd2xhbl9kYXRhKTsKLQlpZiAo
cmV0KSB7Ci0JCXByX2VycigiQ291bGQgbm90IHNldCB3bDEyeHggZGF0YTogJWRcbiIsIHJldCk7
CisJcmV0ID0gd2wxMnh4X2JvYXJkX2luaXQoJmRhODUwX3dsMTJ4eF93bGFuX2RhdGEsIERBODUw
X1dMQU5fSVJRKTsKKwlpZiAocmV0KQogCQlnb3RvIGZyZWVfd2xhbl9pcnE7Ci0JfQogCiAJcmV0
dXJuIDA7CiAKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtNDQzMHNkcC5j
IGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC00NDMwc2RwLmMKaW5kZXggMzY2OWMxMi4uYmM0
ODY3OSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC00NDMwc2RwLmMKKysr
IGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC00NDMwc2RwLmMKQEAgLTgyNSwxMCArODI1LDEx
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFwNF9zZHA0NDMwX3dpZmlfaW5pdCh2b2lkKQogCWlu
dCByZXQ7CiAKIAlvbWFwNF9zZHA0NDMwX3dpZmlfbXV4X2luaXQoKTsKLQlvbWFwNF9zZHA0NDMw
X3dsYW5fZGF0YS5pcnEgPSBncGlvX3RvX2lycShHUElPX1dJRklfSVJRKTsKLQlyZXQgPSB3bDEy
eHhfc2V0X3BsYXRmb3JtX2RhdGEoJm9tYXA0X3NkcDQ0MzBfd2xhbl9kYXRhKTsKKworCXJldCA9
IHdsMTJ4eF9ib2FyZF9pbml0KCZvbWFwNF9zZHA0NDMwX3dsYW5fZGF0YSwgR1BJT19XSUZJX0lS
USk7CiAJaWYgKHJldCkKLQkJcHJfZXJyKCJFcnJvciBzZXR0aW5nIHdsMTJ4eCBkYXRhOiAlZFxu
IiwgcmV0KTsKKwkJcmV0dXJuOworCiAJcmV0ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZv
bWFwX3Z3bGFuX2RldmljZSk7CiAJaWYgKHJldCkKIAkJcHJfZXJyKCJFcnJvciByZWdpc3Rlcmlu
ZyB3bDEyeHggZGV2aWNlOiAlZFxuIiwgcmV0KTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gt
b21hcDIvYm9hcmQtb21hcDNldm0uYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNl
dm0uYwppbmRleCBiOWI3NzZiLi44ZTNhMDc1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9t
YXAyL2JvYXJkLW9tYXAzZXZtLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFw
M2V2bS5jCkBAIC02MzYsMTAgKzYzNiwxMCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb21hcDNfZXZt
X3dsMTJ4eF9pbml0KHZvaWQpCiAJaW50IHJldDsKIAogCS8qIFdMMTJ4eCBXTEFOIEluaXQgKi8K
LQlvbWFwM2V2bV93bGFuX2RhdGEuaXJxID0gZ3Bpb190b19pcnEoT01BUDNFVk1fV0xBTl9JUlFf
R1BJTyk7Ci0JcmV0ID0gd2wxMnh4X3NldF9wbGF0Zm9ybV9kYXRhKCZvbWFwM2V2bV93bGFuX2Rh
dGEpOworCXJldCA9IHdsMTJ4eF9ib2FyZF9pbml0KCZvbWFwM2V2bV93bGFuX2RhdGEsIE9NQVAz
RVZNX1dMQU5fSVJRX0dQSU8pOwogCWlmIChyZXQpCi0JCXByX2VycigiZXJyb3Igc2V0dGluZyB3
bDEyeHggZGF0YTogJWRcbiIsIHJldCk7CisJCXJldHVybjsKKwogCXJldCA9IHBsYXRmb3JtX2Rl
dmljZV9yZWdpc3Rlcigmb21hcDNldm1fd2xhbl9yZWd1bGF0b3IpOwogCWlmIChyZXQpCiAJCXBy
X2VycigiZXJyb3IgcmVnaXN0ZXJpbmcgd2wxMnh4IGRldmljZTogJWRcbiIsIHJldCk7CmRpZmYg
LS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzcGFuZG9yYS5jIGIvYXJjaC9h
cm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwM3BhbmRvcmEuYwppbmRleCAwMGExZjRhLi5iZmRjN2Fh
IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzcGFuZG9yYS5jCisr
KyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNwYW5kb3JhLmMKQEAgLTU0MywxMyAr
NTQzLDEwIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBwYW5kb3JhX3dsMTI1MV9pbml0KHZvaWQpCiAJ
aWYgKHJldCA8IDApCiAJCWdvdG8gZmFpbDsKIAotCXBhbmRvcmFfd2wxMjUxX3BkYXRhLmlycSA9
IGdwaW9fdG9faXJxKFBBTkRPUkFfV0lGSV9JUlFfR1BJTyk7Ci0JaWYgKHBhbmRvcmFfd2wxMjUx
X3BkYXRhLmlycSA8IDApCi0JCWdvdG8gZmFpbF9pcnE7Ci0KIAlwYW5kb3JhX3dsMTI1MV9wZGF0
YS51c2VfZWVwcm9tID0gdHJ1ZTsKLQlyZXQgPSB3bDEyeHhfc2V0X3BsYXRmb3JtX2RhdGEoJnBh
bmRvcmFfd2wxMjUxX3BkYXRhKTsKLQlpZiAocmV0IDwgMCkKKworCXJldCA9IHdsMTJ4eF9ib2Fy
ZF9pbml0KCZwYW5kb3JhX3dsMTI1MV9wZGF0YSwgUEFORE9SQV9XSUZJX0lSUV9HUElPKTsKKwlp
ZiAocmV0KQogCQlnb3RvIGZhaWxfaXJxOwogCiAJcmV0dXJuOwpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwNHBhbmRhLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLW9tYXA0cGFuZGEuYwppbmRleCBiZmNkMzk3Li5mMjAzY2Q5IDEwMDY0NAotLS0gYS9hcmNo
L2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXA0cGFuZGEuYworKysgYi9hcmNoL2FybS9tYWNoLW9t
YXAyL2JvYXJkLW9tYXA0cGFuZGEuYwpAQCAtNDg2LDI0ICs0ODYsMzIgQEAgc3RhdGljIHZvaWQg
b21hcDRfcGFuZGFfaW5pdF9yZXYodm9pZCkKIAl9CiB9CiAKK3N0YXRpYyB2b2lkIF9faW5pdCBv
bWFwNF9wYW5kYV93bGFuX2luaXQodm9pZCkKK3sKKwlpbnQgcmV0OworCisJcmV0ID0gd2wxMnh4
X2JvYXJkX2luaXQoJm9tYXBfcGFuZGFfd2xhbl9kYXRhLCBHUElPX1dJRklfSVJRKTsKKwlpZiAo
cmV0KQorCQlyZXR1cm47CisKKwlyZXQgPSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXIoJm9tYXBf
dndsYW5fZGV2aWNlKTsKKwlpZiAocmV0KQorCQlwcl9lcnIoImVycm9yIHJlZ2lzdGVyaW5nIHds
MTJ4eCdzIGZpeGVkIHJlZ3VsYXRvcjogJWRcbiIsIHJldCk7Cit9CisKIHN0YXRpYyB2b2lkIF9f
aW5pdCBvbWFwNF9wYW5kYV9pbml0KHZvaWQpCiB7CiAJaW50IHBhY2thZ2UgPSBPTUFQX1BBQ0tB
R0VfQ0JTOwotCWludCByZXQ7CiAKIAlpZiAob21hcF9yZXYoKSA9PSBPTUFQNDQzMF9SRVZfRVMx
XzApCiAJCXBhY2thZ2UgPSBPTUFQX1BBQ0tBR0VfQ0JMOwogCW9tYXA0X211eF9pbml0KGJvYXJk
X211eCwgTlVMTCwgcGFja2FnZSk7CiAKLQlvbWFwX3BhbmRhX3dsYW5fZGF0YS5pcnEgPSBncGlv
X3RvX2lycShHUElPX1dJRklfSVJRKTsKLQlyZXQgPSB3bDEyeHhfc2V0X3BsYXRmb3JtX2RhdGEo
Jm9tYXBfcGFuZGFfd2xhbl9kYXRhKTsKLQlpZiAocmV0KQotCQlwcl9lcnIoImVycm9yIHNldHRp
bmcgd2wxMnh4IGRhdGE6ICVkXG4iLCByZXQpOworCW9tYXA0X3BhbmRhX3dsYW5faW5pdCgpOwog
CiAJb21hcDRfcGFuZGFfaW5pdF9yZXYoKTsKIAlvbWFwNF9wYW5kYV9pMmNfaW5pdCgpOwogCXBs
YXRmb3JtX2FkZF9kZXZpY2VzKHBhbmRhX2RldmljZXMsIEFSUkFZX1NJWkUocGFuZGFfZGV2aWNl
cykpOwotCXBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcigmb21hcF92d2xhbl9kZXZpY2UpOwogCW9t
YXBfc2VyaWFsX2luaXQoKTsKIAlvbWFwX3NkcmNfaW5pdChOVUxMLCBOVUxMKTsKIAlvbWFwNF90
d2w2MDMwX2hzbW1jX2luaXQobW1jKTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIv
Ym9hcmQtem9vbS1wZXJpcGhlcmFscy5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC16b29t
LXBlcmlwaGVyYWxzLmMKaW5kZXggYzE2NmZlMS4uYzgxYTJjNyAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vbWFjaC1vbWFwMi9ib2FyZC16b29tLXBlcmlwaGVyYWxzLmMKKysrIGIvYXJjaC9hcm0vbWFj
aC1vbWFwMi9ib2FyZC16b29tLXBlcmlwaGVyYWxzLmMKQEAgLTI4NiwxOSArMjg2LDI0IEBAIHN0
YXRpYyB2b2lkIGVuYWJsZV9ib2FyZF93YWtldXBfc291cmNlKHZvaWQpCiAJCU9NQVBfV0FLRVVQ
X0VOIHwgT01BUF9QSU5fSU5QVVRfUFVMTFVQKTsKIH0KIAotdm9pZCBfX2luaXQgem9vbV9wZXJp
cGhlcmFsc19pbml0KHZvaWQpCitzdGF0aWMgdm9pZCBfX2luaXQgem9vbV93bGFuX2luaXQodm9p
ZCkKIHsKIAlpbnQgcmV0OwogCi0Jb21hcF96b29tX3dsYW5fZGF0YS5pcnEgPSBncGlvX3RvX2ly
cShPTUFQX1pPT01fV0xBTl9JUlFfR1BJTyk7Ci0JcmV0ID0gd2wxMnh4X3NldF9wbGF0Zm9ybV9k
YXRhKCZvbWFwX3pvb21fd2xhbl9kYXRhKTsKKwlyZXQgPSB3bDEyeHhfYm9hcmRfaW5pdCgmb21h
cF96b29tX3dsYW5fZGF0YSwgT01BUF9aT09NX1dMQU5fSVJRX0dQSU8pOworCWlmIChyZXQpCisJ
CXJldHVybjsKIAorCXJldCA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcigmb21hcF92d2xhbl9k
ZXZpY2UpOwogCWlmIChyZXQpCi0JCXByX2VycigiZXJyb3Igc2V0dGluZyB3bDEyeHggZGF0YTog
JWRcbiIsIHJldCk7CisJCXByX2VycigiZXJyb3IgcmVnaXN0ZXJpbmcgd2wxMnh4J3MgZml4ZWQg
cmVndWxhdG9yOiAlZFxuIiwgcmV0KTsKK30KIAordm9pZCBfX2luaXQgem9vbV9wZXJpcGhlcmFs
c19pbml0KHZvaWQpCit7CiAJb21hcF9oc21tY19pbml0KG1tYyk7CisJem9vbV93bGFuX2luaXQo
KTsKIAlvbWFwX2kyY19pbml0KCk7Ci0JcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZvbWFwX3Z3
bGFuX2RldmljZSk7CiAJdXNiX211c2JfaW5pdChOVUxMKTsKIAllbmFibGVfYm9hcmRfd2FrZXVw
X3NvdXJjZSgpOwogCW9tYXBfc2VyaWFsX2luaXQoKTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvY29tbW9uLWJvYXJkLWRldmljZXMuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvY29t
bW9uLWJvYXJkLWRldmljZXMuYwppbmRleCA0OGRhYWMyLi4wMjM1MWU5IDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLW9tYXAyL2NvbW1vbi1ib2FyZC1kZXZpY2VzLmMKKysrIGIvYXJjaC9hcm0v
bWFjaC1vbWFwMi9jb21tb24tYm9hcmQtZGV2aWNlcy5jCkBAIC0yMyw2ICsyMyw3IEBACiAjaW5j
bHVkZSA8bGludXgvZ3Bpby5oPgogI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4KICNpbmNsdWRl
IDxsaW51eC9zcGkvYWRzNzg0Ni5oPgorI2luY2x1ZGUgPGxpbnV4L3dsMTJ4eC5oPgogCiAjaW5j
bHVkZSA8bGludXgvcGxhdGZvcm1fZGF0YS9zcGktb21hcDItbWNzcGkuaD4KICNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kYXRhL210ZC1uYW5kLW9tYXAyLmg+CkBAIC0xNDEsMyArMTQyLDM1IEBA
IHZvaWQgX19pbml0IG9tYXBfbmFuZF9mbGFzaF9pbml0KGludCBvcHRpb25zLCBzdHJ1Y3QgbXRk
X3BhcnRpdGlvbiAqcGFydHMsCiB7CiB9CiAjZW5kaWYKKworI2lmZGVmIENPTkZJR19XTDEyWFhf
UExBVEZPUk1fREFUQQoraW50IF9faW5pdCB3bDEyeHhfYm9hcmRfaW5pdChzdHJ1Y3Qgd2wxMnh4
X3BsYXRmb3JtX2RhdGEgKndsYW5fZGF0YSwgaW50IGdwaW8pCit7CisJaW50IHJldDsKKworCXds
YW5fZGF0YS0+aXJxID0gZ3Bpb190b19pcnEoZ3Bpbyk7CisJaWYgKHdsYW5fZGF0YS0+aXJxIDwg
MCkgeworCQlyZXQgPSB3bGFuX2RhdGEtPmlycTsKKwkJcHJfZXJyKCJ3bDEyeHg6IGdwaW9fdG9f
aXJxKCVkKSBmYWlsZWQ6ICVkXG4iLCBncGlvLCByZXQpOworCQlyZXR1cm4gcmV0OworCX0KKwor
CXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1fZGF0YSh3bGFuX2RhdGEpOworCS8qIGJhaWwgb3V0
IHNpbGVudGx5IGluIGNhc2Ugd2wxMnh4IGlzbid0IGNvbmZpZ3VyZWQgKi8KKwlpZiAocmV0ID09
IC1FTk9TWVMpCisJCXJldHVybiByZXQ7CisKKwkvKiBiYWlsIG91dCB2ZXJib3NlbHkgb24gYW55
IG90aGVyIGVycm9yICovCisJaWYgKHJldCkgeworCQlwcl9lcnIoImVycm9yIHNldHRpbmcgd2wx
Mnh4IGRhdGE6ICVkXG4iLCByZXQpOworCQlyZXR1cm4gcmV0OworCX0KKworCXJldHVybiAwOwor
fQorI2Vsc2UgLyogIUNPTkZJR19XTDEyWFhfUExBVEZPUk1fREFUQSAqLworaW50IF9faW5pdCB3
bDEyeHhfYm9hcmRfaW5pdChzdHJ1Y3Qgd2wxMnh4X3BsYXRmb3JtX2RhdGEgKndsYW5fZGF0YSwg
aW50IGdwaW8pCit7CisJcmV0dXJuIDA7Cit9CisjZW5kaWYKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtb21hcDIvY29tbW9uLWJvYXJkLWRldmljZXMuaCBiL2FyY2gvYXJtL21hY2gtb21hcDIv
Y29tbW9uLWJvYXJkLWRldmljZXMuaAppbmRleCBhMGI0YTQyOC4uMGU3Mzk4ZiAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9jb21tb24tYm9hcmQtZGV2aWNlcy5oCisrKyBiL2FyY2gv
YXJtL21hY2gtb21hcDIvY29tbW9uLWJvYXJkLWRldmljZXMuaApAQCAtNyw5ICs3LDExIEBACiAK
IHN0cnVjdCBtdGRfcGFydGl0aW9uOwogc3RydWN0IGFkczc4NDZfcGxhdGZvcm1fZGF0YTsKK3N0
cnVjdCB3bDEyeHhfcGxhdGZvcm1fZGF0YTsKIAogdm9pZCBvbWFwX2Fkczc4NDZfaW5pdChpbnQg
YnVzX251bSwgaW50IGdwaW9fcGVuZG93biwgaW50IGdwaW9fZGVib3VuY2UsCiAJCSAgICAgICBz
dHJ1Y3QgYWRzNzg0Nl9wbGF0Zm9ybV9kYXRhICpib2FyZF9wZGF0YSk7CiB2b2lkIG9tYXBfbmFu
ZF9mbGFzaF9pbml0KGludCBvcHRzLCBzdHJ1Y3QgbXRkX3BhcnRpdGlvbiAqcGFydHMsIGludCBu
X3BhcnRzKTsKK2ludCB3bDEyeHhfYm9hcmRfaW5pdChzdHJ1Y3Qgd2wxMnh4X3BsYXRmb3JtX2Rh
dGEgKndsYW5fZGF0YSwgaW50IGdwaW8pOwogCiAjZW5kaWYgLyogX19PTUFQX0NPTU1PTl9CT0FS
RF9ERVZJQ0VTX18gKi8KLS0gCjEuNy4xMC5yYzMuMTA2Ny5nYjEyOTA1MQoK
--e89a8f503458ec5fd404cc92ea82--
