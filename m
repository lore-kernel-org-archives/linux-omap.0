From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial stuff)
Date: Sun, 14 Oct 2012 20:30:33 +0200
Message-ID: <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk> <20121012162452.GD30339@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec5014c710b0f5f04cc091f6f
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45880 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab2JNSaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Oct 2012 14:30:55 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4510044vbb.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Oct 2012 11:30:54 -0700 (PDT)
In-Reply-To: <20121012162452.GD30339@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>

--bcaec5014c710b0f5f04cc091f6f
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Oct 12, 2012 at 6:24 PM, Tony Lindgren <tony@atomide.com> wrote:
>> Error setting wl12xx data: -38
..
> Ohad, can you please take a look?

Sure, -38 is -ENOSYS which is returned when the wl12xx driver isn't configured.

This isn't an error (it's a user decision, and it shouldn't elicit any
error) and the patch below (also attached) should make it go away on:

>From 374f145568585c8d6a8d5e4b8b5d3e6baedd2f39 Mon Sep 17 00:00:00 2001
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

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-davinci/board-da850-evm.c      |  7 ++++++-
 arch/arm/mach-omap2/board-4430sdp.c          | 13 ++++++++++--
 arch/arm/mach-omap2/board-omap3evm.c         | 11 +++++++++-
 arch/arm/mach-omap2/board-omap3pandora.c     |  9 ++++++++-
 arch/arm/mach-omap2/board-omap4panda.c       | 30 ++++++++++++++++++++++------
 arch/arm/mach-omap2/board-zoom-peripherals.c | 20 ++++++++++++++++---
 6 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c
b/arch/arm/mach-davinci/board-da850-evm.c
index 32ee3f8..1b19415 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1404,8 +1404,13 @@ static __init int da850_wl12xx_init(void)
 	da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);

 	ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
+	/* bail out silently in case wl12xx isn't configured */
+	if (ret == -ENOSYS)
+		goto free_wlan_irq;
+
+	/* bail out verbosely on any other error */
 	if (ret) {
-		pr_err("Could not set wl12xx data: %d\n", ret);
+		pr_err("error setting wl12xx data: %d\n", ret);
 		goto free_wlan_irq;
 	}

diff --git a/arch/arm/mach-omap2/board-4430sdp.c
b/arch/arm/mach-omap2/board-4430sdp.c
index 3669c12..d1dd81a 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -826,9 +826,18 @@ static void __init omap4_sdp4430_wifi_init(void)

 	omap4_sdp4430_wifi_mux_init();
 	omap4_sdp4430_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
+
 	ret = wl12xx_set_platform_data(&omap4_sdp4430_wlan_data);
-	if (ret)
-		pr_err("Error setting wl12xx data: %d\n", ret);
+	/* bail out silently in case wl12xx isn't configured */
+	if (ret == -ENOSYS)
+		return;
+
+	/* bail out verbosely on any other error */
+	if (ret) {
+		pr_err("error setting wl12xx data: %d\n", ret);
+		return;
+	}
+
 	ret = platform_device_register(&omap_vwlan_device);
 	if (ret)
 		pr_err("Error registering wl12xx device: %d\n", ret);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c
b/arch/arm/mach-omap2/board-omap3evm.c
index b9b776b..7f72e44 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -637,9 +637,18 @@ static void __init omap3_evm_wl12xx_init(void)

 	/* WL12xx WLAN Init */
 	omap3evm_wlan_data.irq = gpio_to_irq(OMAP3EVM_WLAN_IRQ_GPIO);
+
 	ret = wl12xx_set_platform_data(&omap3evm_wlan_data);
-	if (ret)
+	/* bail out silently in case wl12xx isn't configured */
+	if (ret == -ENOSYS)
+		return;
+
+	/* bail out verbosely on any other error */
+	if (ret) {
 		pr_err("error setting wl12xx data: %d\n", ret);
+		return;
+	}
+
 	ret = platform_device_register(&omap3evm_wlan_regulator);
 	if (ret)
 		pr_err("error registering wl12xx device: %d\n", ret);
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c
b/arch/arm/mach-omap2/board-omap3pandora.c
index 00a1f4a..bbc4001 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -549,8 +549,15 @@ static void __init pandora_wl1251_init(void)

 	pandora_wl1251_pdata.use_eeprom = true;
 	ret = wl12xx_set_platform_data(&pandora_wl1251_pdata);
-	if (ret < 0)
+	/* bail out silently in case wl12xx isn't configured */
+	if (ret == -ENOSYS)
+		goto fail_irq;
+
+	/* bail out verbosely on any other error */
+	if (ret) {
+		pr_err("error setting wl12xx data: %d\n", ret);
 		goto fail_irq;
+	}

 	return;

diff --git a/arch/arm/mach-omap2/board-omap4panda.c
b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..cc5cdd6 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -486,24 +486,42 @@ static void omap4_panda_init_rev(void)
 	}
 }

+static void __init omap4_panda_wlan_init(void)
+{
+	int ret;
+
+	omap_panda_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
+
+	ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
+
+	/* bail out silently in case wl12xx isn't configured */
+	if (ret == -ENOSYS)
+		return;
+
+	/* bail out verbosely on any other error */
+	if (ret) {
+		pr_err("error setting wl12xx data: %d\n", ret);
+		return;
+	}
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
index c166fe1..3506ed2 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -286,19 +286,33 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }

-void __init zoom_peripherals_init(void)
+static void __init zoom_wlan_init(void)
 {
 	int ret;

 	omap_zoom_wlan_data.irq = gpio_to_irq(OMAP_ZOOM_WLAN_IRQ_GPIO);
+
 	ret = wl12xx_set_platform_data(&omap_zoom_wlan_data);
+	/* bail out silently in case wl12xx isn't configured */
+	if (ret == -ENOSYS)
+		return;

-	if (ret)
+	/* bail out verbosely on any other error */
+	if (ret) {
 		pr_err("error setting wl12xx data: %d\n", ret);
+		return;
+	}

+	ret = platform_device_register(&omap_vwlan_device);
+	if (ret)
+		pr_err("error registering wl12xx's fixed regulator: %d\n", ret);
+}
+
+void __init zoom_peripherals_init(void)
+{
 	omap_hsmmc_init(mmc);
+	zoom_wlan_init();
 	omap_i2c_init();
-	platform_device_register(&omap_vwlan_device);
 	usb_musb_init(NULL);
 	enable_board_wakeup_source();
 	omap_serial_init();
-- 
1.7.10.rc3.1067.gb129051

--bcaec5014c710b0f5f04cc091f6f
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-don-t-print-any-error-when-wl12xx-isn-t-con.patch"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-don-t-print-any-error-when-wl12xx-isn-t-con.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h8ahnqc60

RnJvbSAzNzRmMTQ1NTY4NTg1YzhkNmE4ZDVlNGI4YjVkM2U2YmFlZGQyZjM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPaGFkIEJlbi1Db2hlbiA8b2hhZEB3aXplcnkuY29tPgpEYXRl
OiBTdW4sIDE0IE9jdCAyMDEyIDIwOjE2OjAxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQVJNOiBP
TUFQOiBkb24ndCBwcmludCBhbnkgZXJyb3Igd2hlbiB3bDEyeHggaXNuJ3QKIGNvbmZpZ3VyZWQK
ClN0b3AgaW50aW1pZGF0aW5nIHVzZXJzIHdpdGggc2Nhcnkgd2xhbiBlcnJvciBtZXNzYWdlcyBp
biBjYXNlIHdsMTJ4eApzdXBwb3J0IHdhc24ndCBldmVuIGJ1aWx0LgoKSW4gYWRkaXRpb24sIHdo
ZW4gd2wxMnh4X3NldF9wbGF0Zm9ybV9kYXRhKCkgZmFpbHMsIGRvbid0IGJvdGhlcgpyZWdpc3Rl
cmluZyB3bDEyeHgncyBmaXhlZCByZWd1bGF0b3IgZGV2aWNlIChvbiB0aGUgcmVsZXZhbnQKYm9h
cmRzKS4KCldoaWxlIHdlJ3JlIGF0IGl0LCBleHRyYWN0IHRoZSB3bGFuIGluaXQgY29kZSB0byBh
IGRlZGljYXRlZCBmdW5jdGlvbiB0bwptYWtlICh0aGUgcmVsZXZhbnQgYm9hcmRzJykgaW5pdCBj
b2RlIGxvb2sgYSBiaXQgbmljZXIuCgpSZXBvcnRlZC1ieTogUnVzc2VsbCBLaW5nIDxsaW51eEBh
cm0ubGludXgub3JnLnVrPgpTaWduZWQtb2ZmLWJ5OiBPaGFkIEJlbi1Db2hlbiA8b2hhZEB3aXpl
cnkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtZGF2aW5jaS9ib2FyZC1kYTg1MC1ldm0uYyAgICAg
IHwgIDcgKysrKysrLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC00NDMwc2RwLmMgICAgICAg
ICAgfCAxMyArKysrKysrKysrLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNldm0u
YyAgICAgICAgIHwgMTEgKysrKysrKysrLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFw
M3BhbmRvcmEuYyAgICAgfCAgOSArKysrKysrKy0KIGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQt
b21hcDRwYW5kYS5jICAgICAgIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQogYXJj
aC9hcm0vbWFjaC1vbWFwMi9ib2FyZC16b29tLXBlcmlwaGVyYWxzLmMgfCAyMCArKysrKysrKysr
KysrKysrLS0tCiA2IGZpbGVzIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9ib2FyZC1kYTg1MC1ldm0u
YyBiL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9ib2FyZC1kYTg1MC1ldm0uYwppbmRleCAzMmVlM2Y4
Li4xYjE5NDE1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLWRhdmluY2kvYm9hcmQtZGE4NTAt
ZXZtLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2JvYXJkLWRhODUwLWV2bS5jCkBAIC0x
NDA0LDggKzE0MDQsMTMgQEAgc3RhdGljIF9faW5pdCBpbnQgZGE4NTBfd2wxMnh4X2luaXQodm9p
ZCkKIAlkYTg1MF93bDEyeHhfd2xhbl9kYXRhLmlycSA9IGdwaW9fdG9faXJxKERBODUwX1dMQU5f
SVJRKTsKIAogCXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1fZGF0YSgmZGE4NTBfd2wxMnh4X3ds
YW5fZGF0YSk7CisJLyogYmFpbCBvdXQgc2lsZW50bHkgaW4gY2FzZSB3bDEyeHggaXNuJ3QgY29u
ZmlndXJlZCAqLworCWlmIChyZXQgPT0gLUVOT1NZUykKKwkJZ290byBmcmVlX3dsYW5faXJxOwor
CisJLyogYmFpbCBvdXQgdmVyYm9zZWx5IG9uIGFueSBvdGhlciBlcnJvciAqLwogCWlmIChyZXQp
IHsKLQkJcHJfZXJyKCJDb3VsZCBub3Qgc2V0IHdsMTJ4eCBkYXRhOiAlZFxuIiwgcmV0KTsKKwkJ
cHJfZXJyKCJlcnJvciBzZXR0aW5nIHdsMTJ4eCBkYXRhOiAlZFxuIiwgcmV0KTsKIAkJZ290byBm
cmVlX3dsYW5faXJxOwogCX0KIApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2Fy
ZC00NDMwc2RwLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTQ0MzBzZHAuYwppbmRleCAz
NjY5YzEyLi5kMWRkODFhIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTQ0
MzBzZHAuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTQ0MzBzZHAuYwpAQCAtODI2
LDkgKzgyNiwxOCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb21hcDRfc2RwNDQzMF93aWZpX2luaXQo
dm9pZCkKIAogCW9tYXA0X3NkcDQ0MzBfd2lmaV9tdXhfaW5pdCgpOwogCW9tYXA0X3NkcDQ0MzBf
d2xhbl9kYXRhLmlycSA9IGdwaW9fdG9faXJxKEdQSU9fV0lGSV9JUlEpOworCiAJcmV0ID0gd2wx
Mnh4X3NldF9wbGF0Zm9ybV9kYXRhKCZvbWFwNF9zZHA0NDMwX3dsYW5fZGF0YSk7Ci0JaWYgKHJl
dCkKLQkJcHJfZXJyKCJFcnJvciBzZXR0aW5nIHdsMTJ4eCBkYXRhOiAlZFxuIiwgcmV0KTsKKwkv
KiBiYWlsIG91dCBzaWxlbnRseSBpbiBjYXNlIHdsMTJ4eCBpc24ndCBjb25maWd1cmVkICovCisJ
aWYgKHJldCA9PSAtRU5PU1lTKQorCQlyZXR1cm47CisKKwkvKiBiYWlsIG91dCB2ZXJib3NlbHkg
b24gYW55IG90aGVyIGVycm9yICovCisJaWYgKHJldCkgeworCQlwcl9lcnIoImVycm9yIHNldHRp
bmcgd2wxMnh4IGRhdGE6ICVkXG4iLCByZXQpOworCQlyZXR1cm47CisJfQorCiAJcmV0ID0gcGxh
dGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZvbWFwX3Z3bGFuX2RldmljZSk7CiAJaWYgKHJldCkKIAkJ
cHJfZXJyKCJFcnJvciByZWdpc3RlcmluZyB3bDEyeHggZGV2aWNlOiAlZFxuIiwgcmV0KTsKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNldm0uYyBiL2FyY2gvYXJt
L21hY2gtb21hcDIvYm9hcmQtb21hcDNldm0uYwppbmRleCBiOWI3NzZiLi43ZjcyZTQ0IDEwMDY0
NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAzZXZtLmMKKysrIGIvYXJjaC9h
cm0vbWFjaC1vbWFwMi9ib2FyZC1vbWFwM2V2bS5jCkBAIC02MzcsOSArNjM3LDE4IEBAIHN0YXRp
YyB2b2lkIF9faW5pdCBvbWFwM19ldm1fd2wxMnh4X2luaXQodm9pZCkKIAogCS8qIFdMMTJ4eCBX
TEFOIEluaXQgKi8KIAlvbWFwM2V2bV93bGFuX2RhdGEuaXJxID0gZ3Bpb190b19pcnEoT01BUDNF
Vk1fV0xBTl9JUlFfR1BJTyk7CisKIAlyZXQgPSB3bDEyeHhfc2V0X3BsYXRmb3JtX2RhdGEoJm9t
YXAzZXZtX3dsYW5fZGF0YSk7Ci0JaWYgKHJldCkKKwkvKiBiYWlsIG91dCBzaWxlbnRseSBpbiBj
YXNlIHdsMTJ4eCBpc24ndCBjb25maWd1cmVkICovCisJaWYgKHJldCA9PSAtRU5PU1lTKQorCQly
ZXR1cm47CisKKwkvKiBiYWlsIG91dCB2ZXJib3NlbHkgb24gYW55IG90aGVyIGVycm9yICovCisJ
aWYgKHJldCkgewogCQlwcl9lcnIoImVycm9yIHNldHRpbmcgd2wxMnh4IGRhdGE6ICVkXG4iLCBy
ZXQpOworCQlyZXR1cm47CisJfQorCiAJcmV0ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZv
bWFwM2V2bV93bGFuX3JlZ3VsYXRvcik7CiAJaWYgKHJldCkKIAkJcHJfZXJyKCJlcnJvciByZWdp
c3RlcmluZyB3bDEyeHggZGV2aWNlOiAlZFxuIiwgcmV0KTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtb21hcDIvYm9hcmQtb21hcDNwYW5kb3JhLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLW9tYXAzcGFuZG9yYS5jCmluZGV4IDAwYTFmNGEuLmJiYzQwMDEgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDNwYW5kb3JhLmMKKysrIGIvYXJjaC9hcm0vbWFj
aC1vbWFwMi9ib2FyZC1vbWFwM3BhbmRvcmEuYwpAQCAtNTQ5LDggKzU0OSwxNSBAQCBzdGF0aWMg
dm9pZCBfX2luaXQgcGFuZG9yYV93bDEyNTFfaW5pdCh2b2lkKQogCiAJcGFuZG9yYV93bDEyNTFf
cGRhdGEudXNlX2VlcHJvbSA9IHRydWU7CiAJcmV0ID0gd2wxMnh4X3NldF9wbGF0Zm9ybV9kYXRh
KCZwYW5kb3JhX3dsMTI1MV9wZGF0YSk7Ci0JaWYgKHJldCA8IDApCisJLyogYmFpbCBvdXQgc2ls
ZW50bHkgaW4gY2FzZSB3bDEyeHggaXNuJ3QgY29uZmlndXJlZCAqLworCWlmIChyZXQgPT0gLUVO
T1NZUykKKwkJZ290byBmYWlsX2lycTsKKworCS8qIGJhaWwgb3V0IHZlcmJvc2VseSBvbiBhbnkg
b3RoZXIgZXJyb3IgKi8KKwlpZiAocmV0KSB7CisJCXByX2VycigiZXJyb3Igc2V0dGluZyB3bDEy
eHggZGF0YTogJWRcbiIsIHJldCk7CiAJCWdvdG8gZmFpbF9pcnE7CisJfQogCiAJcmV0dXJuOwog
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXA0cGFuZGEuYyBiL2Fy
Y2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDRwYW5kYS5jCmluZGV4IGJmY2QzOTcuLmNjNWNk
ZDYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDRwYW5kYS5jCisr
KyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDRwYW5kYS5jCkBAIC00ODYsMjQgKzQ4
Niw0MiBAQCBzdGF0aWMgdm9pZCBvbWFwNF9wYW5kYV9pbml0X3Jldih2b2lkKQogCX0KIH0KIAor
c3RhdGljIHZvaWQgX19pbml0IG9tYXA0X3BhbmRhX3dsYW5faW5pdCh2b2lkKQoreworCWludCBy
ZXQ7CisKKwlvbWFwX3BhbmRhX3dsYW5fZGF0YS5pcnEgPSBncGlvX3RvX2lycShHUElPX1dJRklf
SVJRKTsKKworCXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1fZGF0YSgmb21hcF9wYW5kYV93bGFu
X2RhdGEpOworCisJLyogYmFpbCBvdXQgc2lsZW50bHkgaW4gY2FzZSB3bDEyeHggaXNuJ3QgY29u
ZmlndXJlZCAqLworCWlmIChyZXQgPT0gLUVOT1NZUykKKwkJcmV0dXJuOworCisJLyogYmFpbCBv
dXQgdmVyYm9zZWx5IG9uIGFueSBvdGhlciBlcnJvciAqLworCWlmIChyZXQpIHsKKwkJcHJfZXJy
KCJlcnJvciBzZXR0aW5nIHdsMTJ4eCBkYXRhOiAlZFxuIiwgcmV0KTsKKwkJcmV0dXJuOworCX0K
KworCXJldCA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcigmb21hcF92d2xhbl9kZXZpY2UpOwor
CWlmIChyZXQpCisJCXByX2VycigiZXJyb3IgcmVnaXN0ZXJpbmcgd2wxMnh4J3MgZml4ZWQgcmVn
dWxhdG9yOiAlZFxuIiwgcmV0KTsKK30KKwogc3RhdGljIHZvaWQgX19pbml0IG9tYXA0X3BhbmRh
X2luaXQodm9pZCkKIHsKIAlpbnQgcGFja2FnZSA9IE9NQVBfUEFDS0FHRV9DQlM7Ci0JaW50IHJl
dDsKIAogCWlmIChvbWFwX3JldigpID09IE9NQVA0NDMwX1JFVl9FUzFfMCkKIAkJcGFja2FnZSA9
IE9NQVBfUEFDS0FHRV9DQkw7CiAJb21hcDRfbXV4X2luaXQoYm9hcmRfbXV4LCBOVUxMLCBwYWNr
YWdlKTsKIAotCW9tYXBfcGFuZGFfd2xhbl9kYXRhLmlycSA9IGdwaW9fdG9faXJxKEdQSU9fV0lG
SV9JUlEpOwotCXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1fZGF0YSgmb21hcF9wYW5kYV93bGFu
X2RhdGEpOwotCWlmIChyZXQpCi0JCXByX2VycigiZXJyb3Igc2V0dGluZyB3bDEyeHggZGF0YTog
JWRcbiIsIHJldCk7CisJb21hcDRfcGFuZGFfd2xhbl9pbml0KCk7CiAKIAlvbWFwNF9wYW5kYV9p
bml0X3JldigpOwogCW9tYXA0X3BhbmRhX2kyY19pbml0KCk7CiAJcGxhdGZvcm1fYWRkX2Rldmlj
ZXMocGFuZGFfZGV2aWNlcywgQVJSQVlfU0laRShwYW5kYV9kZXZpY2VzKSk7Ci0JcGxhdGZvcm1f
ZGV2aWNlX3JlZ2lzdGVyKCZvbWFwX3Z3bGFuX2RldmljZSk7CiAJb21hcF9zZXJpYWxfaW5pdCgp
OwogCW9tYXBfc2RyY19pbml0KE5VTEwsIE5VTEwpOwogCW9tYXA0X3R3bDYwMzBfaHNtbWNfaW5p
dChtbWMpOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC16b29tLXBlcmlw
aGVyYWxzLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLXpvb20tcGVyaXBoZXJhbHMuYwpp
bmRleCBjMTY2ZmUxLi4zNTA2ZWQyIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLXpvb20tcGVyaXBoZXJhbHMuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLXpv
b20tcGVyaXBoZXJhbHMuYwpAQCAtMjg2LDE5ICsyODYsMzMgQEAgc3RhdGljIHZvaWQgZW5hYmxl
X2JvYXJkX3dha2V1cF9zb3VyY2Uodm9pZCkKIAkJT01BUF9XQUtFVVBfRU4gfCBPTUFQX1BJTl9J
TlBVVF9QVUxMVVApOwogfQogCi12b2lkIF9faW5pdCB6b29tX3BlcmlwaGVyYWxzX2luaXQodm9p
ZCkKK3N0YXRpYyB2b2lkIF9faW5pdCB6b29tX3dsYW5faW5pdCh2b2lkKQogewogCWludCByZXQ7
CiAKIAlvbWFwX3pvb21fd2xhbl9kYXRhLmlycSA9IGdwaW9fdG9faXJxKE9NQVBfWk9PTV9XTEFO
X0lSUV9HUElPKTsKKwogCXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1fZGF0YSgmb21hcF96b29t
X3dsYW5fZGF0YSk7CisJLyogYmFpbCBvdXQgc2lsZW50bHkgaW4gY2FzZSB3bDEyeHggaXNuJ3Qg
Y29uZmlndXJlZCAqLworCWlmIChyZXQgPT0gLUVOT1NZUykKKwkJcmV0dXJuOwogCi0JaWYgKHJl
dCkKKwkvKiBiYWlsIG91dCB2ZXJib3NlbHkgb24gYW55IG90aGVyIGVycm9yICovCisJaWYgKHJl
dCkgewogCQlwcl9lcnIoImVycm9yIHNldHRpbmcgd2wxMnh4IGRhdGE6ICVkXG4iLCByZXQpOwor
CQlyZXR1cm47CisJfQogCisJcmV0ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZvbWFwX3Z3
bGFuX2RldmljZSk7CisJaWYgKHJldCkKKwkJcHJfZXJyKCJlcnJvciByZWdpc3RlcmluZyB3bDEy
eHgncyBmaXhlZCByZWd1bGF0b3I6ICVkXG4iLCByZXQpOworfQorCit2b2lkIF9faW5pdCB6b29t
X3BlcmlwaGVyYWxzX2luaXQodm9pZCkKK3sKIAlvbWFwX2hzbW1jX2luaXQobW1jKTsKKwl6b29t
X3dsYW5faW5pdCgpOwogCW9tYXBfaTJjX2luaXQoKTsKLQlwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0
ZXIoJm9tYXBfdndsYW5fZGV2aWNlKTsKIAl1c2JfbXVzYl9pbml0KE5VTEwpOwogCWVuYWJsZV9i
b2FyZF93YWtldXBfc291cmNlKCk7CiAJb21hcF9zZXJpYWxfaW5pdCgpOwotLSAKMS43LjEwLnJj
My4xMDY3LmdiMTI5MDUxCgo=
--bcaec5014c710b0f5f04cc091f6f--
