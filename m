From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP5: Enable arch timer support
Date: Tue, 11 Sep 2012 14:59:38 +0530
Message-ID: <CAMQu2gzKDLBJmVdm0SUr0ec=LueT0mqBUYmHyGMsav5k=ggKQg@mail.gmail.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com>
 <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com>
 <504DE165.4000208@ti.com> <CAMQu2gxE8e9RBykLDyukZwV7dPKv3nG1vCynO1pijUBXBnyq8Q@mail.gmail.com>
 <504DE79B.3090302@ti.com> <CAMQu2gwT=XHcZtdKfYacGyt21Mo0of8MmSMNE+0PP9wemKSyxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf307cfcf8c26b9804c969b76c
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:55682 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756697Ab2IKJaA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 05:30:00 -0400
Received: by ggnl1 with SMTP id l1so357139ggn.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 02:29:58 -0700 (PDT)
In-Reply-To: <CAMQu2gwT=XHcZtdKfYacGyt21Mo0of8MmSMNE+0PP9wemKSyxw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orig, tony@atomide.com

--20cf307cfcf8c26b9804c969b76c
Content-Type: text/plain; charset=ISO-8859-1

Benoit,

On Mon, Sep 10, 2012 at 7:09 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Mon, Sep 10, 2012 at 6:44 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>>

[...]

>> >> Silly question: Don't we have one arch-timer per CPU?
>> >>
>> > It is per CPU just like A9 TWD
>>
>> Shouldn't we have two nodes then?
>>
> I need to check this but arch timer DT node should be same
> as the twd DT node. May be one node with reference to
> each CPU node should do but am not too sure about the DT
> nodes and how all that work.
>
Here is an updated patch based on our discussion. Thanks for comments.
Let me know if you are ok with this version.


>From 98f6a3b4b52ef7c76ed8b19bf9257c51ee5d7323 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 13 Aug 2012 14:39:03 +0530
Subject: [PATCH] ARM: OMAP5: Enable arch timer support

Enable Cortex A15 generic timer support for OMAP5 based SOCs.
The CPU local timers run on the free running real time counter clock.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   12 ++++++++++++
 arch/arm/mach-omap2/Kconfig  |    1 +
 arch/arm/mach-omap2/timer.c  |    7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 57e5270..7b986ed 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -33,9 +33,21 @@
 	cpus {
 		cpu@0 {
 			compatible = "arm,cortex-a15";
+			timer {
+				compatible = "arm,armv7-timer";
+				/* 14th PPI IRQ, active low level-sensitive */
+				interrupts = <1 14 0x308>;
+				clock-frequency = <6144000>;
+			};
 		};
 		cpu@1 {
 			compatible = "arm,cortex-a15";
+			timer {
+				compatible = "arm,armv7-timer";
+				/* 14th PPI IRQ, active low level-sensitive */
+				interrupts = <1 14 0x308>;
+				clock-frequency = <6144000>;
+			};
 		};
 	};

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2120f90..53fb77c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,6 +73,7 @@ config SOC_OMAP5
 	select ARM_GIC
 	select HAVE_SMP
 	select SOC_HAS_REALTIME_COUNTER
+	select ARM_ARCH_TIMER

 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 8f5b88b..46982d0 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -41,6 +41,7 @@
 #include <plat/dmtimer.h>
 #include <asm/smp_twd.h>
 #include <asm/sched_clock.h>
+#include <asm/arch_timer.h>
 #include "common.h"
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
@@ -481,9 +482,15 @@ OMAP_SYS_TIMER(4)
 #ifdef CONFIG_SOC_OMAP5
 static void __init omap5_timer_init(void)
 {
+	int err;
+
 	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
 	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
 	realtime_counter_init();
+
+	err = arch_timer_of_register();
+	if (err)
+		pr_err("%s: arch_timer_register failed %d\n", __func__, err);
 }
 OMAP_SYS_TIMER(5)
 #endif
-- 
1.7.9.5

--20cf307cfcf8c26b9804c969b76c
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP5-Enable-arch-timer-support.patch"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP5-Enable-arch-timer-support.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h6yssea10

RnJvbSA5OGY2YTNiNGI1MmVmN2M3NmVkOGIxOWJmOTI1N2M1MWVlNWQ3MzIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBNb24sIDEzIEF1ZyAyMDEyIDE0OjM5OjAzICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gQVJNOiBPTUFQNTogRW5hYmxlIGFyY2ggdGltZXIgc3VwcG9ydAoKRW5hYmxlIENvcnRl
eCBBMTUgZ2VuZXJpYyB0aW1lciBzdXBwb3J0IGZvciBPTUFQNSBiYXNlZCBTT0NzLgpUaGUgQ1BV
IGxvY2FsIHRpbWVycyBydW4gb24gdGhlIGZyZWUgcnVubmluZyByZWFsIHRpbWUgY291bnRlciBj
bG9jay4KClNpZ25lZC1vZmYtYnk6IFNhbnRvc2ggU2hpbGlta2FyIDxzYW50b3NoLnNoaWxpbWth
ckB0aS5jb20+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvb21hcDUuZHRzaSB8ICAgMTIgKysrKysr
KysrKysrCiBhcmNoL2FybS9tYWNoLW9tYXAyL0tjb25maWcgIHwgICAgMSArCiBhcmNoL2FybS9t
YWNoLW9tYXAyL3RpbWVyLmMgIHwgICAgNyArKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDIwIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9vbWFwNS5kdHNpIGIv
YXJjaC9hcm0vYm9vdC9kdHMvb21hcDUuZHRzaQppbmRleCA1N2U1MjcwLi43Yjk4NmVkIDEwMDY0
NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9vbWFwNS5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL29tYXA1LmR0c2kKQEAgLTMzLDkgKzMzLDIxIEBACiAJY3B1cyB7CiAJCWNwdUAwIHsKIAkJ
CWNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hMTUiOworCQkJdGltZXIgeworCQkJCWNvbXBhdGli
bGUgPSAiYXJtLGFybXY3LXRpbWVyIjsKKwkJCQkvKiAxNHRoIFBQSSBJUlEsIGFjdGl2ZSBsb3cg
bGV2ZWwtc2Vuc2l0aXZlICovCisJCQkJaW50ZXJydXB0cyA9IDwxIDE0IDB4MzA4PjsKKwkJCQlj
bG9jay1mcmVxdWVuY3kgPSA8NjE0NDAwMD47CisJCQl9OwogCQl9OwogCQljcHVAMSB7CiAJCQlj
b21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTE1IjsKKwkJCXRpbWVyIHsKKwkJCQljb21wYXRpYmxl
ID0gImFybSxhcm12Ny10aW1lciI7CisJCQkJLyogMTR0aCBQUEkgSVJRLCBhY3RpdmUgbG93IGxl
dmVsLXNlbnNpdGl2ZSAqLworCQkJCWludGVycnVwdHMgPSA8MSAxNCAweDMwOD47CisJCQkJY2xv
Y2stZnJlcXVlbmN5ID0gPDYxNDQwMDA+OworCQkJfTsKIAkJfTsKIAl9OwogCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9tYWNoLW9tYXAyL0tjb25maWcgYi9hcmNoL2FybS9tYWNoLW9tYXAyL0tjb25m
aWcKaW5kZXggMjEyMGY5MC4uNTNmYjc3YyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9LY29uZmlnCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvS2NvbmZpZwpAQCAtNzMsNiArNzMs
NyBAQCBjb25maWcgU09DX09NQVA1CiAJc2VsZWN0IEFSTV9HSUMKIAlzZWxlY3QgSEFWRV9TTVAK
IAlzZWxlY3QgU09DX0hBU19SRUFMVElNRV9DT1VOVEVSCisJc2VsZWN0IEFSTV9BUkNIX1RJTUVS
CiAKIGNvbW1lbnQgIk9NQVAgQ29yZSBUeXBlIgogCWRlcGVuZHMgb24gQVJDSF9PTUFQMgpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi90aW1lci5jIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi90aW1lci5jCmluZGV4IDhmNWI4OGIuLjQ2OTgyZDAgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvdGltZXIuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLmMKQEAgLTQx
LDYgKzQxLDcgQEAKICNpbmNsdWRlIDxwbGF0L2RtdGltZXIuaD4KICNpbmNsdWRlIDxhc20vc21w
X3R3ZC5oPgogI2luY2x1ZGUgPGFzbS9zY2hlZF9jbG9jay5oPgorI2luY2x1ZGUgPGFzbS9hcmNo
X3RpbWVyLmg+CiAjaW5jbHVkZSAiY29tbW9uLmgiCiAjaW5jbHVkZSA8cGxhdC9vbWFwX2h3bW9k
Lmg+CiAjaW5jbHVkZSA8cGxhdC9vbWFwX2RldmljZS5oPgpAQCAtNDgxLDkgKzQ4MiwxNSBAQCBP
TUFQX1NZU19USU1FUig0KQogI2lmZGVmIENPTkZJR19TT0NfT01BUDUKIHN0YXRpYyB2b2lkIF9f
aW5pdCBvbWFwNV90aW1lcl9pbml0KHZvaWQpCiB7CisJaW50IGVycjsKKwogCW9tYXAyX2dwX2Ns
b2NrZXZlbnRfaW5pdCgxLCBPTUFQNF9DTEtFVl9TT1VSQ0UpOwogCW9tYXAyX2Nsb2Nrc291cmNl
X2luaXQoMiwgT01BUDRfTVBVX1NPVVJDRSk7CiAJcmVhbHRpbWVfY291bnRlcl9pbml0KCk7CisK
KwllcnIgPSBhcmNoX3RpbWVyX29mX3JlZ2lzdGVyKCk7CisJaWYgKGVycikKKwkJcHJfZXJyKCIl
czogYXJjaF90aW1lcl9yZWdpc3RlciBmYWlsZWQgJWRcbiIsIF9fZnVuY19fLCBlcnIpOwogfQog
T01BUF9TWVNfVElNRVIoNSkKICNlbmRpZgotLSAKMS43LjkuNQoK
--20cf307cfcf8c26b9804c969b76c--
