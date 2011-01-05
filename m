From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when !CONFIG_RUNTIME_PM
Date: Wed, 5 Jan 2011 19:23:07 +0530
Message-ID: <68789fa8ba11b9427aa6321da55c9a8b@mail.gmail.com>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0023547c8d738ed0f8049919b4d5
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:42095 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699Ab1AENxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 08:53:10 -0500
Received: by yib17 with SMTP id 17so4910714yib.7
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 05:53:09 -0800 (PST)
In-Reply-To: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--0023547c8d738ed0f8049919b4d5
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Wednesday, January 05, 2011 7:11 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; Santosh Shilimkar; Paul
> Walmsley
> Subject: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when
> !CONFIG_RUNTIME_PM
>
(Removing unnecessary changes which got committed by mistake)

>From c9c34f9bcff789bb2354c299e2c47aa74c8c07ed Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 5 Jan 2011 18:41:20 +0530
Subject: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when
!CONFIG_RUNTIME_PM

Commit ff2516fb 'wd_timer: disable on boot via hwmod postsetup mechanism'
introduced watchdog timer state state management using postsetup_state.
This was done to allow some board files to support watchdog coverage
throughout kernel initialization and it work as intended when RUNTIME_PM
is enabled.

With !CONFIG_RUNTIME_PM and no board is specifically requests watchdog
to remain enabled the omap_wdt_probe crashesh. This is because hwmod
in absense of runtime PM unable to turn watchdog clocks because it's
state is set to be disabled. For rest of the device, the state is
set as enabled in absense of RUNTIME_PM

[    1.372558] Unhandled fault: imprecise external abort (0x1406) at
0xad733eeb
[    1.379913] Internal error: : 1406 [#1] SMP
[    1.384277] last sysfs file:
[    1.387359] Modules linked in:
[    1.390563] CPU: 0    Tainted: G        W
(2.6.37-rc7-00265-g4298a4c-dirty #23)
[    1.398468] PC is at omap_wdt_disable+0x2c/0x3c
[    1.403198] LR is at omap_wdt_probe+0x124/0x1e0
[    1.407928] pc : [<c02f5bf4>]    lr : [<c03be10c>]    psr: 60000013
[    1.407958] sp : df833f00  ip : 00000000  fp : 00000000
[    1.419921] r10: c0ac57ac  r9 : df959e00  r8 : 00000000
[    1.425384] r7 : df959e08  r6 : df8000c0  r5 : df95bebc  r4 : df87dde0
[    1.432189] r3 : fc314000  r2 : 00005555  r1 : fc314034  r0 : df87dde0

This patch make the default watchdog state to be enabled in case of
!CONFIG_RUNTIME_PM. This fixes the crash

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
Paul, I am not too sure if it breaks your _shutdown idea of watchdog
timer.
Patch generated against 'omap-for-linus' branch and boot tested on OMAP4
with and without CONFIG_OMAP_WATCHDOG.

 arch/arm/mach-omap2/io.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e66687b..b879a16 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -378,7 +378,11 @@ void __init omap2_init_common_infrastructure(void)
 	 * XXX ideally we could detect whether the MPU WDT was currently
 	 * enabled here and make this conditional
 	 */
+#ifdef CONFIG_PM_RUNTIME
 	postsetup_state = _HWMOD_STATE_DISABLED;
+#else
+	postsetup_state = _HWMOD_STATE_ENABLED;
+#endif
 	omap_hwmod_for_each_by_class("wd_timer",
 				     _set_hwmod_postsetup_state,
 				     &postsetup_state);
-- 
1.6.0.4

--0023547c8d738ed0f8049919b4d5
Content-Type: application/octet-stream;
	name="0001-omap-wd_timer-Fix-crash-frm-wdt_probe-when-CONFIG.patch"
Content-Disposition: attachment;
	filename="0001-omap-wd_timer-Fix-crash-frm-wdt_probe-when-CONFIG.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: e21da8a46d45c72a_0.1

RnJvbSBjOWMzNGY5YmNmZjc4OWJiMjM1NGMyOTllMmM0N2FhNzRjOGMwN2VkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBXZWQsIDUgSmFuIDIwMTEgMTg6NDE6MjAgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBvbWFwOiB3ZF90aW1lcjogRml4IGNyYXNoIGZybSB3ZHRfcHJvYmUgd2hlbiAhQ09ORklH
X1JVTlRJTUVfUE0KCkNvbW1pdCBmZjI1MTZmYiAnd2RfdGltZXI6IGRpc2FibGUgb24gYm9vdCB2
aWEgaHdtb2QgcG9zdHNldHVwIG1lY2hhbmlzbScKaW50cm9kdWNlZCB3YXRjaGRvZyB0aW1lciBz
dGF0ZSBzdGF0ZSBtYW5hZ2VtZW50IHVzaW5nIHBvc3RzZXR1cF9zdGF0ZS4KVGhpcyB3YXMgZG9u
ZSB0byBhbGxvdyBzb21lIGJvYXJkIGZpbGVzIHRvIHN1cHBvcnQgd2F0Y2hkb2cgY292ZXJhZ2UK
dGhyb3VnaG91dCBrZXJuZWwgaW5pdGlhbGl6YXRpb24gYW5kIGl0IHdvcmsgYXMgaW50ZW5kZWQg
d2hlbiBSVU5USU1FX1BNCmlzIGVuYWJsZWQuCgpXaXRoICFDT05GSUdfUlVOVElNRV9QTSBhbmQg
bm8gYm9hcmQgaXMgc3BlY2lmaWNhbGx5IHJlcXVlc3RzIHdhdGNoZG9nCnRvIHJlbWFpbiBlbmFi
bGVkIHRoZSBvbWFwX3dkdF9wcm9iZSBjcmFzaGVzaC4gVGhpcyBpcyBiZWNhdXNlIGh3bW9kCmlu
IGFic2Vuc2Ugb2YgcnVudGltZSBQTSB1bmFibGUgdG8gdHVybiB3YXRjaGRvZyBjbG9ja3MgYmVj
YXVzZSBpdCdzCnN0YXRlIGlzIHNldCB0byBiZSBkaXNhYmxlZC4gRm9yIHJlc3Qgb2YgdGhlIGRl
dmljZSwgdGhlIHN0YXRlIGlzCnNldCBhcyBlbmFibGVkIGluIGFic2Vuc2Ugb2YgUlVOVElNRV9Q
TQoKWyAgICAxLjM3MjU1OF0gVW5oYW5kbGVkIGZhdWx0OiBpbXByZWNpc2UgZXh0ZXJuYWwgYWJv
cnQgKDB4MTQwNikgYXQgMHhhZDczM2VlYgpbICAgIDEuMzc5OTEzXSBJbnRlcm5hbCBlcnJvcjog
OiAxNDA2IFsjMV0gU01QClsgICAgMS4zODQyNzddIGxhc3Qgc3lzZnMgZmlsZToKWyAgICAxLjM4
NzM1OV0gTW9kdWxlcyBsaW5rZWQgaW46ClsgICAgMS4zOTA1NjNdIENQVTogMCAgICBUYWludGVk
OiBHICAgICAgICBXICAgICgyLjYuMzctcmM3LTAwMjY1LWc0Mjk4YTRjLWRpcnR5ICMyMykKWyAg
ICAxLjM5ODQ2OF0gUEMgaXMgYXQgb21hcF93ZHRfZGlzYWJsZSsweDJjLzB4M2MKWyAgICAxLjQw
MzE5OF0gTFIgaXMgYXQgb21hcF93ZHRfcHJvYmUrMHgxMjQvMHgxZTAKWyAgICAxLjQwNzkyOF0g
cGMgOiBbPGMwMmY1YmY0Pl0gICAgbHIgOiBbPGMwM2JlMTBjPl0gICAgcHNyOiA2MDAwMDAxMwpb
ICAgIDEuNDA3OTU4XSBzcCA6IGRmODMzZjAwICBpcCA6IDAwMDAwMDAwICBmcCA6IDAwMDAwMDAw
ClsgICAgMS40MTk5MjFdIHIxMDogYzBhYzU3YWMgIHI5IDogZGY5NTllMDAgIHI4IDogMDAwMDAw
MDAKWyAgICAxLjQyNTM4NF0gcjcgOiBkZjk1OWUwOCAgcjYgOiBkZjgwMDBjMCAgcjUgOiBkZjk1
YmViYyAgcjQgOiBkZjg3ZGRlMApbICAgIDEuNDMyMTg5XSByMyA6IGZjMzE0MDAwICByMiA6IDAw
MDA1NTU1ICByMSA6IGZjMzE0MDM0ICByMCA6IGRmODdkZGUwCgpUaGlzIHBhdGNoIG1ha2UgdGhl
IGRlZmF1bHQgd2F0Y2hkb2cgc3RhdGUgdG8gYmUgZW5hYmxlZCBpbiBjYXNlIG9mCiFDT05GSUdf
UlVOVElNRV9QTS4gVGhpcyBmaXhlcyB0aGUgY3Jhc2gKClNpZ25lZC1vZmYtYnk6IFNhbnRvc2gg
U2hpbGlta2FyIDxzYW50b3NoLnNoaWxpbWthckB0aS5jb20+CkNjOiBQYXVsIFdhbG1zbGV5IDxw
YXVsQHB3c2FuLmNvbT4KLS0tClBhdWwsIEkgYW0gbm90IHRvbyBzdXJlIGlmIGl0IGJyZWFrcyB5
b3VyIF9zaHV0ZG93biBpZGVhIG9mIHdhdGNoZG9nCnRpbWVyLgpQYXRjaCBnZW5lcmF0ZWQgYWdh
aW5zdCAnb21hcC1mb3ItbGludXMnIGJyYW5jaCBhbmQgYm9vdCB0ZXN0ZWQgb24gT01BUDQKd2l0
aCBhbmQgd2l0aG91dCBDT05GSUdfT01BUF9XQVRDSERPRy4KCiBhcmNoL2FybS9tYWNoLW9tYXAy
L2lvLmMgfCAgICA0ICsrKysKIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvaW8uYyBiL2FyY2gv
YXJtL21hY2gtb21hcDIvaW8uYwppbmRleCBlNjY2ODdiLi5iODc5YTE2IDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLW9tYXAyL2lvLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9pby5jCkBA
IC0zNzgsNyArMzc4LDExIEBAIHZvaWQgX19pbml0IG9tYXAyX2luaXRfY29tbW9uX2luZnJhc3Ry
dWN0dXJlKHZvaWQpCiAJICogWFhYIGlkZWFsbHkgd2UgY291bGQgZGV0ZWN0IHdoZXRoZXIgdGhl
IE1QVSBXRFQgd2FzIGN1cnJlbnRseQogCSAqIGVuYWJsZWQgaGVyZSBhbmQgbWFrZSB0aGlzIGNv
bmRpdGlvbmFsCiAJICovCisjaWZkZWYgQ09ORklHX1BNX1JVTlRJTUUKIAlwb3N0c2V0dXBfc3Rh
dGUgPSBfSFdNT0RfU1RBVEVfRElTQUJMRUQ7CisjZWxzZQorCXBvc3RzZXR1cF9zdGF0ZSA9IF9I
V01PRF9TVEFURV9FTkFCTEVEOworI2VuZGlmCiAJb21hcF9od21vZF9mb3JfZWFjaF9ieV9jbGFz
cygid2RfdGltZXIiLAogCQkJCSAgICAgX3NldF9od21vZF9wb3N0c2V0dXBfc3RhdGUsCiAJCQkJ
ICAgICAmcG9zdHNldHVwX3N0YXRlKTsKLS0gCjEuNi4wLjQKCg==
--0023547c8d738ed0f8049919b4d5--
