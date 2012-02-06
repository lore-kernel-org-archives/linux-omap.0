From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: OMAP34xx
Date: Mon, 6 Feb 2012 12:37:31 +0200
Message-ID: <CAK=WgbZorAreBdwLKndAxmm7H3Q=2pyy2=N93Mb3jiyW0qNroA@mail.gmail.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205172528.GA17029@n2100.arm.linux.org.uk> <20120205174700.GU20333@atomide.com>
 <20120205180812.GH17309@n2100.arm.linux.org.uk> <20120205183316.GL1426@atomide.com>
 <20120205184139.GI17309@n2100.arm.linux.org.uk> <20120205185939.GN1426@atomide.com>
 <20120205201146.GK17309@n2100.arm.linux.org.uk> <20120205205157.GO1426@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f2343a318bd7204b84941d9
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:35894 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751979Ab2BFKhw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 05:37:52 -0500
Received: by obcva7 with SMTP id va7so6626703obc.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Feb 2012 02:37:51 -0800 (PST)
In-Reply-To: <20120205205157.GO1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

--e89a8f2343a318bd7204b84941d9
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Feb 5, 2012 at 10:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hmm I see. Ohad, care to take a look this one?

All worthy comments, and indeed there's no point in registering the
fixed regulator device in case wl12xx_set_platform_data() fails.

I cooked up something (using wl12xx_set_platform_data()'s -ENOSYS to
avoid ifdef'ing the code) - see below (and attached).

Russell, Tony, please tell me if you want me to cook something similar
for all the other platforms, or would rather use your existing
patch(es).

Thanks,
Ohad.

>From 6bc46ed359c8399a53a9e02bbf8f47b2831dfe0e Mon Sep 17 00:00:00 2001
From: Ohad Ben-Cohen <ohad@wizery.com>
Date: Mon, 6 Feb 2012 11:53:17 +0200
Subject: [PATCH] ARM: OMAP4: panda: clean up/fix wlan init path

1. Stop intimidating users with scary wlan error messages in case wl12xx
   support wasn't even built.
2. When a wlan init error does happen, provide users with helpful
   information regarding the nature of the failure.
3. Don't bother registering wl12xx's fixed regulator device in case
   wl12xx_set_platform_data() failed.

While we're at it, extract the wlan init code to a dedicated function to
make omap4_panda_init() look a bit nicer.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c
b/arch/arm/mach-omap2/board-omap4panda.c
index 30ad40d..c801e7e 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -475,6 +475,27 @@ void omap4_panda_display_init(void)
 		omap_hdmi_init(0);
 }

+static void __init omap4_panda_wlan_init(void)
+{
+	int ret;
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
@@ -483,12 +504,9 @@ static void __init omap4_panda_init(void)
 		package = OMAP_PACKAGE_CBL;
 	omap4_mux_init(board_mux, NULL, package);

-	if (wl12xx_set_platform_data(&omap_panda_wlan_data))
-		pr_err("error setting wl12xx data\n");
-
+	omap4_panda_wlan_init();
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
-	platform_device_register(&omap_vwlan_device);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	omap4_twl6030_hsmmc_init(mmc);
-- 
1.7.5.4

--e89a8f2343a318bd7204b84941d9
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ARM-OMAP4-panda-clean-up-fix-wlan-init-path.patch"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP4-panda-clean-up-fix-wlan-init-path.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gybccsgd0

RnJvbSA2YmM0NmVkMzU5YzgzOTlhNTNhOWUwMmJiZjhmNDdiMjgzMWRmZTBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPaGFkIEJlbi1Db2hlbiA8b2hhZEB3aXplcnkuY29tPgpEYXRl
OiBNb24sIDYgRmViIDIwMTIgMTE6NTM6MTcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBBUk06IE9N
QVA0OiBwYW5kYTogY2xlYW4gdXAvZml4IHdsYW4gaW5pdCBwYXRoCgoxLiBTdG9wIGludGltaWRh
dGluZyB1c2VycyB3aXRoIHNjYXJ5IHdsYW4gZXJyb3IgbWVzc2FnZXMgaW4gY2FzZSB3bDEyeHgK
ICAgc3VwcG9ydCB3YXNuJ3QgZXZlbiBidWlsdC4KMi4gV2hlbiBhIHdsYW4gaW5pdCBlcnJvciBk
b2VzIGhhcHBlbiwgcHJvdmlkZSB1c2VycyB3aXRoIGhlbHBmdWwKICAgaW5mb3JtYXRpb24gcmVn
YXJkaW5nIHRoZSBuYXR1cmUgb2YgdGhlIGZhaWx1cmUuCjMuIERvbid0IGJvdGhlciByZWdpc3Rl
cmluZyB3bDEyeHgncyBmaXhlZCByZWd1bGF0b3IgZGV2aWNlIGluIGNhc2UKICAgd2wxMnh4X3Nl
dF9wbGF0Zm9ybV9kYXRhKCkgZmFpbGVkLgoKV2hpbGUgd2UncmUgYXQgaXQsIGV4dHJhY3QgdGhl
IHdsYW4gaW5pdCBjb2RlIHRvIGEgZGVkaWNhdGVkIGZ1bmN0aW9uIHRvCm1ha2Ugb21hcDRfcGFu
ZGFfaW5pdCgpIGxvb2sgYSBiaXQgbmljZXIuCgpSZXBvcnRlZC1ieTogUnVzc2VsbCBLaW5nIDxs
aW51eEBhcm0ubGludXgub3JnLnVrPgpTaWduZWQtb2ZmLWJ5OiBPaGFkIEJlbi1Db2hlbiA8b2hh
ZEB3aXplcnkuY29tPgpDYzogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4KLS0tCiBh
cmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXA0cGFuZGEuYyB8ICAgMjYgKysrKysrKysrKysr
KysrKysrKysrKy0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXA0cGFu
ZGEuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDRwYW5kYS5jCmluZGV4IDMwYWQ0
MGQuLmM4MDFlN2UgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDRw
YW5kYS5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDRwYW5kYS5jCkBAIC00
NzUsNiArNDc1LDI3IEBAIHZvaWQgb21hcDRfcGFuZGFfZGlzcGxheV9pbml0KHZvaWQpCiAJCW9t
YXBfaGRtaV9pbml0KDApOwogfQogCitzdGF0aWMgdm9pZCBfX2luaXQgb21hcDRfcGFuZGFfd2xh
bl9pbml0KHZvaWQpCit7CisJaW50IHJldDsKKworCXJldCA9IHdsMTJ4eF9zZXRfcGxhdGZvcm1f
ZGF0YSgmb21hcF9wYW5kYV93bGFuX2RhdGEpOworCisJLyogYmFpbCBvdXQgc2lsZW50bHkgaW4g
Y2FzZSB3bDEyeHggaXNuJ3QgY29uZmlndXJlZCAqLworCWlmIChyZXQgPT0gLUVOT1NZUykKKwkJ
cmV0dXJuOworCisJLyogYmFpbCBvdXQgdmVyYm9zZWx5IG9uIGFueSBvdGhlciBlcnJvciAqLwor
CWlmIChyZXQpIHsKKwkJcHJfZXJyKCJlcnJvciBzZXR0aW5nIHdsMTJ4eCBkYXRhOiAlZFxuIiwg
cmV0KTsKKwkJcmV0dXJuOworCX0KKworCXJldCA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcigm
b21hcF92d2xhbl9kZXZpY2UpOworCWlmIChyZXQpCisJCXByX2VycigiZXJyb3IgcmVnaXN0ZXJp
bmcgd2wxMnh4J3MgZml4ZWQgcmVndWxhdG9yOiAlZFxuIiwgcmV0KTsKK30KKwogc3RhdGljIHZv
aWQgX19pbml0IG9tYXA0X3BhbmRhX2luaXQodm9pZCkKIHsKIAlpbnQgcGFja2FnZSA9IE9NQVBf
UEFDS0FHRV9DQlM7CkBAIC00ODMsMTIgKzUwNCw5IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFw
NF9wYW5kYV9pbml0KHZvaWQpCiAJCXBhY2thZ2UgPSBPTUFQX1BBQ0tBR0VfQ0JMOwogCW9tYXA0
X211eF9pbml0KGJvYXJkX211eCwgTlVMTCwgcGFja2FnZSk7CiAKLQlpZiAod2wxMnh4X3NldF9w
bGF0Zm9ybV9kYXRhKCZvbWFwX3BhbmRhX3dsYW5fZGF0YSkpCi0JCXByX2VycigiZXJyb3Igc2V0
dGluZyB3bDEyeHggZGF0YVxuIik7Ci0KKwlvbWFwNF9wYW5kYV93bGFuX2luaXQoKTsKIAlvbWFw
NF9wYW5kYV9pMmNfaW5pdCgpOwogCXBsYXRmb3JtX2FkZF9kZXZpY2VzKHBhbmRhX2RldmljZXMs
IEFSUkFZX1NJWkUocGFuZGFfZGV2aWNlcykpOwotCXBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcigm
b21hcF92d2xhbl9kZXZpY2UpOwogCW9tYXBfc2VyaWFsX2luaXQoKTsKIAlvbWFwX3NkcmNfaW5p
dChOVUxMLCBOVUxMKTsKIAlvbWFwNF90d2w2MDMwX2hzbW1jX2luaXQobW1jKTsKLS0gCjEuNy41
LjQKCg==
--e89a8f2343a318bd7204b84941d9--
