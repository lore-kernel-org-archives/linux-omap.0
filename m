From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 17:29:01 +0530
Message-ID: <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c152294df44049a098258
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:40662 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752871Ab1AQL7F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 06:59:05 -0500
Received: by mail-ey0-f171.google.com with SMTP id 5so2807488eyg.2
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 03:59:03 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>, rmk+kernel@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

--0015174c152294df44049a098258
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aaro Koskinen
> Sent: Monday, January 17, 2011 5:07 PM
> To: Tony Lindgren; rmk+kernel@arm.linux.org.uk
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Open issues after 2.6.38 merge window
>
> Hi,
>
> On Fri, 14 Jan 2011, Tony Lindgren wrote:
> > Before I update out master branch, let's try to summarize the
> > open issues after the merge window. Here's a list of issues
> > in omap-fixes-for-linus that I'm aware of:
> >
> > - NFS root oopses while mounting root
> >
> > - omap4430 es1.0 hangs if L2X0 cache is enabled
> >
> > - omap4 panda powers down after boot (watchdog?)
> >
> > - omap3 ldp board powers down after boot?
> >
> > Any other issues?
>
> Amstrad E3 fails during the boot. Bisection points to:
>
>  	commit 211baa7016894c02fc18693e21ca479cd08ac0c0
>  	Author: Russell King <rmk+kernel@arm.linux.org.uk>
>  	Date:   Tue Jan 11 16:23:04 2011 +0000
>
>  	    ARM: sched_clock: allow init_sched_clock() to be called
> early
>
> The board does not have sched_clock(), although HAVE_SCHED_CLOCK is
> defined for all OMAP.
>
I guess above is sorted out by the attached patch from Paul.

Regards,
Santosh


>From 8a2d92faa2c21fda24124e75da3ba47930e1eaf6 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 16 Jan 2011 21:08:13 +0530
Subject: [PATCH] OMAP: counter_32k: init clocksource as part of machine
timer init

Linus's master branch, currently at commit
1b59be2a6cdcb5a12e18d8315c07c94a624de48f ("Merge branch 'slab/urgent'
of git://git.kernel.org/pub/scm/linux/kernel/git/penberg/slab-2.6"),
crashes during boot on OMAP4430 ES2.0 Panda:

[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual
address 00000000
[    0.000000] pgd = c0004000
[    0.000000] [00000000] *pgd=00000000
[    0.000000] Internal error: Oops: 80000005 [#1] SMP
[    0.000000] last sysfs file:
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Tainted: G        W    (2.6.37-07734-g2467802 #7)
[    0.000000] PC is at 0x0
[    0.000000] LR is at sched_clock_poll+0x2c/0x3c
[    0.000000] pc : [<00000000>]    lr : [<c0060b74>]    psr: 600001d3
[    0.000000] sp : c058bfd0  ip : c058a000  fp : 00000000
[    0.000000] r10: 00000000  r9 : 411fc092  r8 : 800330c8
[    0.000000] r7 : c05a08e0  r6 : c0034c48  r5 : c05ffc40  r4 : c0034c4c
[    0.000000] r3 : c05ffe6c  r2 : c05a0bc0  r1 : c059f098  r0 : 00000000
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment kernel
[    0.000000] Control: 10c53c7f  Table: 8000404a  DAC: 00000017

This is due to the recent ARM init_sched_clock() changes and the late
initialization of the counter_32k clock source:

   http://marc.info/?l=linux-omap&m=129513468605208&w=2

Fix by initializing the counter_32k clocksource during the machine timer
initialization.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/time.c               |    7 +++++++
 arch/arm/mach-omap2/timer-gp.c           |   10 ++++++++--
 arch/arm/plat-omap/counter_32k.c         |    3 +--
 arch/arm/plat-omap/include/plat/common.h |    1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index ed7a61f..6ec65e5 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -244,6 +244,13 @@ static void __init omap_timer_init(void)

 	omap_init_mpu_timer(rate);
 	omap_init_clocksource(rate);
+	/*
+	 * XXX Since this file seems to deal mostly with the MPU timer,
+	 * this doesn't seem like the correct place for the sync timer
+	 * clocksource init.
+	 */
+	if (!cpu_is_omap7xx() && !cpu_is_omap15xx())
+		omap_init_clocksource_32k();
 }

 struct sys_timer omap_timer = {
diff --git a/arch/arm/mach-omap2/timer-gp.c
b/arch/arm/mach-omap2/timer-gp.c
index 4e48e78..57d53e0 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -42,6 +42,8 @@

 #include "timer-gp.h"

+#include <plat/common.h>
+
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12

@@ -176,10 +178,14 @@ static void __init omap2_gp_clockevent_init(void)
 /*
  * When 32k-timer is enabled, don't use GPTimer for clocksource
  * instead, just leave default clocksource which uses the 32k
- * sync counter.  See clocksource setup in see plat-omap/common.c.
+ * sync counter.  See clocksource setup in plat-omap/timer-32k.c
  */

-static inline void __init omap2_gp_clocksource_init(void) {}
+static void __init omap2_gp_clocksource_init(void)
+{
+	omap_init_clocksource_32k();
+}
+
 #else
 /*
  * clocksource
diff --git a/arch/arm/plat-omap/counter_32k.c
b/arch/arm/plat-omap/counter_32k.c
index ea46440..0367998 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -160,7 +160,7 @@ void read_persistent_clock(struct timespec *ts)
 	*ts = *tsp;
 }

-static int __init omap_init_clocksource_32k(void)
+int __init omap_init_clocksource_32k(void)
 {
 	static char err[] __initdata = KERN_ERR
 			"%s: can't register clocksource!\n";
@@ -195,7 +195,6 @@ static int __init omap_init_clocksource_32k(void)
 	}
 	return 0;
 }
-arch_initcall(omap_init_clocksource_32k);

 #endif	/* !(defined(CONFIG_ARCH_OMAP730) ||
defined(CONFIG_ARCH_OMAP15XX)) */

diff --git a/arch/arm/plat-omap/include/plat/common.h
b/arch/arm/plat-omap/include/plat/common.h
index 6b8088e..84c707f 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -35,6 +35,7 @@ struct sys_timer;

 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
+extern int __init omap_init_clocksource_32k(void);

 extern void omap_reserve(void);

-- 
1.6.0.4

--0015174c152294df44049a098258
Content-Type: application/octet-stream;
	name="0001-OMAP-counter_32k-init-clocksource-as-part-of-machi.patch"
Content-Disposition: attachment;
	filename="0001-OMAP-counter_32k-init-clocksource-as-part-of-machi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: d88648f219e9872b_0.1

RnJvbSA4YTJkOTJmYWEyYzIxZmRhMjQxMjRlNzVkYTNiYTQ3OTMwZTFlYWY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIFdhbG1zbGV5IDxwYXVsQHB3c2FuLmNvbT4KRGF0ZTog
U3VuLCAxNiBKYW4gMjAxMSAyMTowODoxMyArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIE9NQVA6IGNv
dW50ZXJfMzJrOiBpbml0IGNsb2Nrc291cmNlIGFzIHBhcnQgb2YgbWFjaGluZSB0aW1lciBpbml0
CgpMaW51cydzIG1hc3RlciBicmFuY2gsIGN1cnJlbnRseSBhdCBjb21taXQKMWI1OWJlMmE2Y2Rj
YjVhMTJlMThkODMxNWMwN2M5NGE2MjRkZTQ4ZiAoIk1lcmdlIGJyYW5jaCAnc2xhYi91cmdlbnQn
Cm9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wZW5iZXJn
L3NsYWItMi42IiksCmNyYXNoZXMgZHVyaW5nIGJvb3Qgb24gT01BUDQ0MzAgRVMyLjAgUGFuZGE6
CgpbICAgIDAuMDAwMDAwXSBPTUFQIGNsb2NrZXZlbnQgc291cmNlOiBHUFRJTUVSMSBhdCAzMjc2
OCBIegpbICAgIDAuMDAwMDAwXSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwClsgICAgMC4wMDAwMDBdIHBn
ZCA9IGMwMDA0MDAwClsgICAgMC4wMDAwMDBdIFswMDAwMDAwMF0gKnBnZD0wMDAwMDAwMApbICAg
IDAuMDAwMDAwXSBJbnRlcm5hbCBlcnJvcjogT29wczogODAwMDAwMDUgWyMxXSBTTVAKWyAgICAw
LjAwMDAwMF0gbGFzdCBzeXNmcyBmaWxlOgpbICAgIDAuMDAwMDAwXSBNb2R1bGVzIGxpbmtlZCBp
bjoKWyAgICAwLjAwMDAwMF0gQ1BVOiAwICAgIFRhaW50ZWQ6IEcgICAgICAgIFcgICAgKDIuNi4z
Ny0wNzczNC1nMjQ2NzgwMiAjNykKWyAgICAwLjAwMDAwMF0gUEMgaXMgYXQgMHgwClsgICAgMC4w
MDAwMDBdIExSIGlzIGF0IHNjaGVkX2Nsb2NrX3BvbGwrMHgyYy8weDNjClsgICAgMC4wMDAwMDBd
IHBjIDogWzwwMDAwMDAwMD5dICAgIGxyIDogWzxjMDA2MGI3ND5dICAgIHBzcjogNjAwMDAxZDMK
WyAgICAwLjAwMDAwMF0gc3AgOiBjMDU4YmZkMCAgaXAgOiBjMDU4YTAwMCAgZnAgOiAwMDAwMDAw
MApbICAgIDAuMDAwMDAwXSByMTA6IDAwMDAwMDAwICByOSA6IDQxMWZjMDkyICByOCA6IDgwMDMz
MGM4ClsgICAgMC4wMDAwMDBdIHI3IDogYzA1YTA4ZTAgIHI2IDogYzAwMzRjNDggIHI1IDogYzA1
ZmZjNDAgIHI0IDogYzAwMzRjNGMKWyAgICAwLjAwMDAwMF0gcjMgOiBjMDVmZmU2YyAgcjIgOiBj
MDVhMGJjMCAgcjEgOiBjMDU5ZjA5OCAgcjAgOiAwMDAwMDAwMApbICAgIDAuMDAwMDAwXSBGbGFn
czogblpDdiAgSVJRcyBvZmYgIEZJUXMgb2ZmICBNb2RlIFNWQ18zMiAgSVNBIEFSTSAgU2VnbWVu
dCBrZXJuZWwKWyAgICAwLjAwMDAwMF0gQ29udHJvbDogMTBjNTNjN2YgIFRhYmxlOiA4MDAwNDA0
YSAgREFDOiAwMDAwMDAxNwoKVGhpcyBpcyBkdWUgdG8gdGhlIHJlY2VudCBBUk0gaW5pdF9zY2hl
ZF9jbG9jaygpIGNoYW5nZXMgYW5kIHRoZSBsYXRlCmluaXRpYWxpemF0aW9uIG9mIHRoZSBjb3Vu
dGVyXzMyayBjbG9jayBzb3VyY2U6CgogICBodHRwOi8vbWFyYy5pbmZvLz9sPWxpbnV4LW9tYXAm
bT0xMjk1MTM0Njg2MDUyMDgmdz0yCgpGaXggYnkgaW5pdGlhbGl6aW5nIHRoZSBjb3VudGVyXzMy
ayBjbG9ja3NvdXJjZSBkdXJpbmcgdGhlIG1hY2hpbmUgdGltZXIKaW5pdGlhbGl6YXRpb24uCgpS
ZXBvcnRlZC1ieTogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybS5saW51eC5vcmcudWs+ClNp
Z25lZC1vZmYtYnk6IFBhdWwgV2FsbXNsZXkgPHBhdWxAcHdzYW4uY29tPgotLS0KIGFyY2gvYXJt
L21hY2gtb21hcDEvdGltZS5jICAgICAgICAgICAgICAgfCAgICA3ICsrKysrKysKIGFyY2gvYXJt
L21hY2gtb21hcDIvdGltZXItZ3AuYyAgICAgICAgICAgfCAgIDEwICsrKysrKysrLS0KIGFyY2gv
YXJtL3BsYXQtb21hcC9jb3VudGVyXzMyay5jICAgICAgICAgfCAgICAzICstLQogYXJjaC9hcm0v
cGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9jb21tb24uaCB8ICAgIDEgKwogNCBmaWxlcyBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtb21hcDEvdGltZS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMS90aW1lLmMKaW5kZXggZWQ3
YTYxZi4uNmVjNjVlNSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMS90aW1lLmMKKysr
IGIvYXJjaC9hcm0vbWFjaC1vbWFwMS90aW1lLmMKQEAgLTI0NCw2ICsyNDQsMTMgQEAgc3RhdGlj
IHZvaWQgX19pbml0IG9tYXBfdGltZXJfaW5pdCh2b2lkKQogCiAJb21hcF9pbml0X21wdV90aW1l
cihyYXRlKTsKIAlvbWFwX2luaXRfY2xvY2tzb3VyY2UocmF0ZSk7CisJLyoKKwkgKiBYWFggU2lu
Y2UgdGhpcyBmaWxlIHNlZW1zIHRvIGRlYWwgbW9zdGx5IHdpdGggdGhlIE1QVSB0aW1lciwKKwkg
KiB0aGlzIGRvZXNuJ3Qgc2VlbSBsaWtlIHRoZSBjb3JyZWN0IHBsYWNlIGZvciB0aGUgc3luYyB0
aW1lcgorCSAqIGNsb2Nrc291cmNlIGluaXQuCisJICovCisJaWYgKCFjcHVfaXNfb21hcDd4eCgp
ICYmICFjcHVfaXNfb21hcDE1eHgoKSkKKwkJb21hcF9pbml0X2Nsb2Nrc291cmNlXzMyaygpOwog
fQogCiBzdHJ1Y3Qgc3lzX3RpbWVyIG9tYXBfdGltZXIgPSB7CmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLW9tYXAyL3RpbWVyLWdwLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLWdwLmMK
aW5kZXggNGU0OGU3OC4uNTdkNTNlMCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi90
aW1lci1ncC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvdGltZXItZ3AuYwpAQCAtNDIsNiAr
NDIsOCBAQAogCiAjaW5jbHVkZSAidGltZXItZ3AuaCIKIAorI2luY2x1ZGUgPHBsYXQvY29tbW9u
Lmg+CisKIC8qIE1BWF9HUFRJTUVSX0lEOiBudW1iZXIgb2YgR1BUSU1FUnMgb24gdGhlIGNoaXAg
Ki8KICNkZWZpbmUgTUFYX0dQVElNRVJfSUQJCTEyCiAKQEAgLTE3NiwxMCArMTc4LDE0IEBAIHN0
YXRpYyB2b2lkIF9faW5pdCBvbWFwMl9ncF9jbG9ja2V2ZW50X2luaXQodm9pZCkKIC8qIAogICog
V2hlbiAzMmstdGltZXIgaXMgZW5hYmxlZCwgZG9uJ3QgdXNlIEdQVGltZXIgZm9yIGNsb2Nrc291
cmNlCiAgKiBpbnN0ZWFkLCBqdXN0IGxlYXZlIGRlZmF1bHQgY2xvY2tzb3VyY2Ugd2hpY2ggdXNl
cyB0aGUgMzJrCi0gKiBzeW5jIGNvdW50ZXIuICBTZWUgY2xvY2tzb3VyY2Ugc2V0dXAgaW4gc2Vl
IHBsYXQtb21hcC9jb21tb24uYy4gCisgKiBzeW5jIGNvdW50ZXIuICBTZWUgY2xvY2tzb3VyY2Ug
c2V0dXAgaW4gcGxhdC1vbWFwL3RpbWVyLTMyay5jCiAgKi8KIAotc3RhdGljIGlubGluZSB2b2lk
IF9faW5pdCBvbWFwMl9ncF9jbG9ja3NvdXJjZV9pbml0KHZvaWQpIHt9CitzdGF0aWMgdm9pZCBf
X2luaXQgb21hcDJfZ3BfY2xvY2tzb3VyY2VfaW5pdCh2b2lkKQoreworCW9tYXBfaW5pdF9jbG9j
a3NvdXJjZV8zMmsoKTsKK30KKwogI2Vsc2UKIC8qCiAgKiBjbG9ja3NvdXJjZQpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vcGxhdC1vbWFwL2NvdW50ZXJfMzJrLmMgYi9hcmNoL2FybS9wbGF0LW9tYXAv
Y291bnRlcl8zMmsuYwppbmRleCBlYTQ2NDQwLi4wMzY3OTk4IDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9wbGF0LW9tYXAvY291bnRlcl8zMmsuYworKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvY291bnRl
cl8zMmsuYwpAQCAtMTYwLDcgKzE2MCw3IEBAIHZvaWQgcmVhZF9wZXJzaXN0ZW50X2Nsb2NrKHN0
cnVjdCB0aW1lc3BlYyAqdHMpCiAJKnRzID0gKnRzcDsKIH0KIAotc3RhdGljIGludCBfX2luaXQg
b21hcF9pbml0X2Nsb2Nrc291cmNlXzMyayh2b2lkKQoraW50IF9faW5pdCBvbWFwX2luaXRfY2xv
Y2tzb3VyY2VfMzJrKHZvaWQpCiB7CiAJc3RhdGljIGNoYXIgZXJyW10gX19pbml0ZGF0YSA9IEtF
Uk5fRVJSCiAJCQkiJXM6IGNhbid0IHJlZ2lzdGVyIGNsb2Nrc291cmNlIVxuIjsKQEAgLTE5NSw3
ICsxOTUsNiBAQCBzdGF0aWMgaW50IF9faW5pdCBvbWFwX2luaXRfY2xvY2tzb3VyY2VfMzJrKHZv
aWQpCiAJfQogCXJldHVybiAwOwogfQotYXJjaF9pbml0Y2FsbChvbWFwX2luaXRfY2xvY2tzb3Vy
Y2VfMzJrKTsKIAogI2VuZGlmCS8qICEoZGVmaW5lZChDT05GSUdfQVJDSF9PTUFQNzMwKSB8fCBk
ZWZpbmVkKENPTkZJR19BUkNIX09NQVAxNVhYKSkgKi8KIApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
cGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9jb21tb24uaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNs
dWRlL3BsYXQvY29tbW9uLmgKaW5kZXggNmI4MDg4ZS4uODRjNzA3ZiAxMDA2NDQKLS0tIGEvYXJj
aC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9jb21tb24uaAorKysgYi9hcmNoL2FybS9wbGF0
LW9tYXAvaW5jbHVkZS9wbGF0L2NvbW1vbi5oCkBAIC0zNSw2ICszNSw3IEBAIHN0cnVjdCBzeXNf
dGltZXI7CiAKIGV4dGVybiB2b2lkIG9tYXBfbWFwX2NvbW1vbl9pbyh2b2lkKTsKIGV4dGVybiBz
dHJ1Y3Qgc3lzX3RpbWVyIG9tYXBfdGltZXI7CitleHRlcm4gaW50IF9faW5pdCBvbWFwX2luaXRf
Y2xvY2tzb3VyY2VfMzJrKHZvaWQpOwogCiBleHRlcm4gdm9pZCBvbWFwX3Jlc2VydmUodm9pZCk7
CiAKLS0gCjEuNi4wLjQKCg==
--0015174c152294df44049a098258--
