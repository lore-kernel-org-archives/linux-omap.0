From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
 cause data corruption
Date: Tue, 15 Feb 2011 12:44:17 +0530
Message-ID: <4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com><1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com><AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com><13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
 <AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com> <33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f1e28ab8462e049c4ce924
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46523 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501Ab1BOHOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 02:14:21 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so5651098wyb.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 23:14:19 -0800 (PST)
In-Reply-To: <33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Andrei Warkentin <andreiw@motorola.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, Catalin Marinas <catalin.marinas@arm.com>

--001485f1e28ab8462e049c4ce924
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Monday, February 14, 2011 10:39 AM
> To: Andrei Warkentin
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; tony@atomide.com;
> linux-arm-kernel@lists.infradead.org; Catalin Marinas
> Subject: RE: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> operation can cause data corruption
>

[....]

> > ...
> I understood that from first comment. But I am not in favor
> of polluting common ARM files with SOC specific #ifdeffery.
> We have gone over this when first errata support
> was added for PL310
>
> I have a better way to handle this scenario.
> Expect an updated patch for this.
>

Below is the updated version which should remove any
OMAP dependency on these errata's. Attached same.

----
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 14 Jan 2011 14:16:04 +0530
Subject: [v2 PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation
can cause data corruption

PL310 implements the Clean & Invalidate by Way L2 cache maintenance
operation (offset 0x7FC). This operation runs in background so that
PL310 can handle normal accesses while it is in progress. Under very
rare circumstances, due to this erratum, write data can be lost when
PL310 treats a cacheable write transaction during a Clean & Invalidate
by Way operation.

Workaround:
Disable Write-Back and Cache Linefill (Debug Control Register)
Clean & Invalidate by Way (0x7FC)
Re-enable Write-Back and Cache Linefill (Debug Control Register)

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig                   |   13 ++++++++++++-
 arch/arm/include/asm/outercache.h  |    1 +
 arch/arm/mach-omap2/Kconfig        |    3 +++
 arch/arm/mach-omap2/omap4-common.c |    7 +++++++
 arch/arm/mm/cache-l2x0.c           |   28 +++++++++++++++-------------
 5 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..ebadd95 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1140,7 +1140,7 @@ config ARM_ERRATA_742231

 config PL310_ERRATA_588369
 	bool "Clean & Invalidate maintenance operations do not invalidate
clean lines"
-	depends on CACHE_L2X0 && ARCH_OMAP4
+	depends on CACHE_L2X0 && CACHE_PL310
 	help
 	   The PL310 L2 cache controller implements three types of Clean &
 	   Invalidate maintenance operations: by Physical Address
@@ -1177,6 +1177,17 @@ config ARM_ERRATA_743622
 	  visible impact on the overall performance or power consumption
of the
 	  processor.

+config PL310_ERRATA_727915
+	bool "Background Clean & Invalidate by Way operation can cause
data corruption"
+	depends on CACHE_L2X0 && CACHE_PL310
+	help
+	  PL310 implements the Clean & Invalidate by Way L2 cache
maintenance
+	  operation (offset 0x7FC). This operation runs in background so
that
+	  PL310 can handle normal accesses while it is in progress. Under
very
+	  rare circumstances, due to this erratum, write data can be lost
when
+	  PL310 treats a cacheable write transaction during a Clean &
+	  Invalidate by Way operation Note that this errata uses Texas
+	  Instrument's secure monitor api to implement the work around.
 endmenu

 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/include/asm/outercache.h
b/arch/arm/include/asm/outercache.h
index fc19009..348d513 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -31,6 +31,7 @@ struct outer_cache_fns {
 #ifdef CONFIG_OUTER_CACHE_SYNC
 	void (*sync)(void);
 #endif
+	void (*set_debug)(unsigned long);
 };

 #ifdef CONFIG_OUTER_CACHE
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f285dd7..fd11ab4 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -45,7 +45,10 @@ config ARCH_OMAP4
 	select CPU_V7
 	select ARM_GIC
 	select LOCAL_TIMERS
+	select CACHE_L2X0
+	select CACHE_PL310
 	select PL310_ERRATA_588369
+	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
diff --git a/arch/arm/mach-omap2/omap4-common.c
b/arch/arm/mach-omap2/omap4-common.c
index 1926864..9ef8c29 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -52,6 +52,12 @@ static void omap4_l2x0_disable(void)
 	omap_smc1(0x102, 0x0);
 }

+static void omap4_l2x0_set_debug(unsigned long val)
+{
+	/* Program PL310 L2 Cache controller debug register */
+	omap_smc1(0x100, val);
+}
+
 static int __init omap_l2_cache_init(void)
 {
 	u32 aux_ctrl = 0;
@@ -99,6 +105,7 @@ static int __init omap_l2_cache_init(void)
 	 * specific one
 	*/
 	outer_cache.disable = omap4_l2x0_disable;
+	outer_cache.set_debug = omap4_l2x0_set_debug;

 	return 0;
 }
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 170c9bb..a8caee4 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -67,18 +67,22 @@ static inline void l2x0_inv_line(unsigned long addr)
 	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
 }

-#ifdef CONFIG_PL310_ERRATA_588369
+#if defined(CONFIG_PL310_ERRATA_588369) ||
defined(CONFIG_PL310_ERRATA_727915)
 static void debug_writel(unsigned long val)
 {
-	extern void omap_smc1(u32 fn, u32 arg);
-
-	/*
-	 * Texas Instrument secure monitor api to modify the
-	 * PL310 Debug Control Register.
-	 */
-	omap_smc1(0x100, val);
+	if (outer_cache.set_debug)
+		outer_cache.set_debug(val);
+	else
+		writel(val, l2x0_base + L2X0_DEBUG_CTRL);
+}
+#else
+/* Optimised out for non-errata case */
+static inline void debug_writel(unsigned long val)
+{
 }
+#endif

+#ifdef CONFIG_PL310_ERRATA_588369
 static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
@@ -91,11 +95,6 @@ static inline void l2x0_flush_line(unsigned long addr)
 }
 #else

-/* Optimised out for non-errata case */
-static inline void debug_writel(unsigned long val)
-{
-}
-
 static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
@@ -119,9 +118,11 @@ static void l2x0_flush_all(void)

 	/* clean all ways */
 	spin_lock_irqsave(&l2x0_lock, flags);
+	debug_writel(0x03);
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
 	cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
 	cache_sync();
+	debug_writel(0x00);
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }

@@ -329,6 +330,7 @@ void __init l2x0_init(void __iomem *base, __u32
aux_val, __u32 aux_mask)
 	outer_cache.flush_all = l2x0_flush_all;
 	outer_cache.inv_all = l2x0_inv_all;
 	outer_cache.disable = l2x0_disable;
+	outer_cache.set_debug = NULL;

 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x,
Cache size: %d B\n",
-- 
1.6.0.4

--001485f1e28ab8462e049c4ce924
Content-Type: application/octet-stream;
	name="0003-ARM-l2x0-Errata-fix-for-flush-by-Way-operation-can.patch"
Content-Disposition: attachment;
	filename="0003-ARM-l2x0-Errata-fix-for-flush-by-Way-operation-can.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 25153e06c26ccd48_0.1

RnJvbSA0MDYzYTM4ODFlNjcxOTc0NDNjZjQ0N2JlYWRhMGU1MjY1MDcxODI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBGcmksIDE0IEphbiAyMDExIDE0OjE2OjA0ICswNTMwClN1YmplY3Q6IFt2
MiBQQVRDSCAzLzVdIEFSTTogbDJ4MDogRXJyYXRhIGZpeCBmb3IgZmx1c2ggYnkgV2F5IG9wZXJh
dGlvbiBjYW4gY2F1c2UgZGF0YSBjb3JydXB0aW9uCgpQTDMxMCBpbXBsZW1lbnRzIHRoZSBDbGVh
biAmIEludmFsaWRhdGUgYnkgV2F5IEwyIGNhY2hlIG1haW50ZW5hbmNlCm9wZXJhdGlvbiAob2Zm
c2V0IDB4N0ZDKS4gVGhpcyBvcGVyYXRpb24gcnVucyBpbiBiYWNrZ3JvdW5kIHNvIHRoYXQKUEwz
MTAgY2FuIGhhbmRsZSBub3JtYWwgYWNjZXNzZXMgd2hpbGUgaXQgaXMgaW4gcHJvZ3Jlc3MuIFVu
ZGVyIHZlcnkKcmFyZSBjaXJjdW1zdGFuY2VzLCBkdWUgdG8gdGhpcyBlcnJhdHVtLCB3cml0ZSBk
YXRhIGNhbiBiZSBsb3N0IHdoZW4KUEwzMTAgdHJlYXRzIGEgY2FjaGVhYmxlIHdyaXRlIHRyYW5z
YWN0aW9uIGR1cmluZyBhIENsZWFuICYgSW52YWxpZGF0ZQpieSBXYXkgb3BlcmF0aW9uLgoKV29y
a2Fyb3VuZDoKRGlzYWJsZSBXcml0ZS1CYWNrIGFuZCBDYWNoZSBMaW5lZmlsbCAoRGVidWcgQ29u
dHJvbCBSZWdpc3RlcikKQ2xlYW4gJiBJbnZhbGlkYXRlIGJ5IFdheSAoMHg3RkMpClJlLWVuYWJs
ZSBXcml0ZS1CYWNrIGFuZCBDYWNoZSBMaW5lZmlsbCAoRGVidWcgQ29udHJvbCBSZWdpc3RlcikK
ClNpZ25lZC1vZmYtYnk6IFNhbnRvc2ggU2hpbGlta2FyIDxzYW50b3NoLnNoaWxpbWthckB0aS5j
b20+CkNjOiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPgotLS0KIGFy
Y2gvYXJtL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgIDEzICsrKysrKysrKysrKy0KIGFy
Y2gvYXJtL2luY2x1ZGUvYXNtL291dGVyY2FjaGUuaCAgfCAgICAxICsKIGFyY2gvYXJtL21hY2gt
b21hcDIvS2NvbmZpZyAgICAgICAgfCAgICAzICsrKwogYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFw
NC1jb21tb24uYyB8ICAgIDcgKysrKysrKwogYXJjaC9hcm0vbW0vY2FjaGUtbDJ4MC5jICAgICAg
ICAgICB8ICAgMjggKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQogNSBmaWxlcyBjaGFuZ2Vk
LCAzOCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9LY29uZmlnIGIvYXJjaC9hcm0vS2NvbmZpZwppbmRleCA1Y2ZmMTY1Li5lYmFkZDk1IDEwMDY0
NAotLS0gYS9hcmNoL2FybS9LY29uZmlnCisrKyBiL2FyY2gvYXJtL0tjb25maWcKQEAgLTExNDAs
NyArMTE0MCw3IEBAIGNvbmZpZyBBUk1fRVJSQVRBXzc0MjIzMQogCiBjb25maWcgUEwzMTBfRVJS
QVRBXzU4ODM2OQogCWJvb2wgIkNsZWFuICYgSW52YWxpZGF0ZSBtYWludGVuYW5jZSBvcGVyYXRp
b25zIGRvIG5vdCBpbnZhbGlkYXRlIGNsZWFuIGxpbmVzIgotCWRlcGVuZHMgb24gQ0FDSEVfTDJY
MCAmJiBBUkNIX09NQVA0CisJZGVwZW5kcyBvbiBDQUNIRV9MMlgwICYmIENBQ0hFX1BMMzEwCiAJ
aGVscAogCSAgIFRoZSBQTDMxMCBMMiBjYWNoZSBjb250cm9sbGVyIGltcGxlbWVudHMgdGhyZWUg
dHlwZXMgb2YgQ2xlYW4gJgogCSAgIEludmFsaWRhdGUgbWFpbnRlbmFuY2Ugb3BlcmF0aW9uczog
YnkgUGh5c2ljYWwgQWRkcmVzcwpAQCAtMTE3Nyw2ICsxMTc3LDE3IEBAIGNvbmZpZyBBUk1fRVJS
QVRBXzc0MzYyMgogCSAgdmlzaWJsZSBpbXBhY3Qgb24gdGhlIG92ZXJhbGwgcGVyZm9ybWFuY2Ug
b3IgcG93ZXIgY29uc3VtcHRpb24gb2YgdGhlCiAJICBwcm9jZXNzb3IuCiAKK2NvbmZpZyBQTDMx
MF9FUlJBVEFfNzI3OTE1CisJYm9vbCAiQmFja2dyb3VuZCBDbGVhbiAmIEludmFsaWRhdGUgYnkg
V2F5IG9wZXJhdGlvbiBjYW4gY2F1c2UgZGF0YSBjb3JydXB0aW9uIgorCWRlcGVuZHMgb24gQ0FD
SEVfTDJYMCAmJiBDQUNIRV9QTDMxMAorCWhlbHAKKwkgIFBMMzEwIGltcGxlbWVudHMgdGhlIENs
ZWFuICYgSW52YWxpZGF0ZSBieSBXYXkgTDIgY2FjaGUgbWFpbnRlbmFuY2UKKwkgIG9wZXJhdGlv
biAob2Zmc2V0IDB4N0ZDKS4gVGhpcyBvcGVyYXRpb24gcnVucyBpbiBiYWNrZ3JvdW5kIHNvIHRo
YXQKKwkgIFBMMzEwIGNhbiBoYW5kbGUgbm9ybWFsIGFjY2Vzc2VzIHdoaWxlIGl0IGlzIGluIHBy
b2dyZXNzLiBVbmRlciB2ZXJ5CisJICByYXJlIGNpcmN1bXN0YW5jZXMsIGR1ZSB0byB0aGlzIGVy
cmF0dW0sIHdyaXRlIGRhdGEgY2FuIGJlIGxvc3Qgd2hlbgorCSAgUEwzMTAgdHJlYXRzIGEgY2Fj
aGVhYmxlIHdyaXRlIHRyYW5zYWN0aW9uIGR1cmluZyBhIENsZWFuICYKKwkgIEludmFsaWRhdGUg
YnkgV2F5IG9wZXJhdGlvbiBOb3RlIHRoYXQgdGhpcyBlcnJhdGEgdXNlcyBUZXhhcworCSAgSW5z
dHJ1bWVudCdzIHNlY3VyZSBtb25pdG9yIGFwaSB0byBpbXBsZW1lbnQgdGhlIHdvcmsgYXJvdW5k
LgogZW5kbWVudQogCiBzb3VyY2UgImFyY2gvYXJtL2NvbW1vbi9LY29uZmlnIgpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vb3V0ZXJjYWNoZS5oIGIvYXJjaC9hcm0vaW5jbHVkZS9h
c20vb3V0ZXJjYWNoZS5oCmluZGV4IGZjMTkwMDkuLjM0OGQ1MTMgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL2luY2x1ZGUvYXNtL291dGVyY2FjaGUuaAorKysgYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9v
dXRlcmNhY2hlLmgKQEAgLTMxLDYgKzMxLDcgQEAgc3RydWN0IG91dGVyX2NhY2hlX2ZucyB7CiAj
aWZkZWYgQ09ORklHX09VVEVSX0NBQ0hFX1NZTkMKIAl2b2lkICgqc3luYykodm9pZCk7CiAjZW5k
aWYKKwl2b2lkICgqc2V0X2RlYnVnKSh1bnNpZ25lZCBsb25nKTsKIH07CiAKICNpZmRlZiBDT05G
SUdfT1VURVJfQ0FDSEUKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvS2NvbmZpZyBi
L2FyY2gvYXJtL21hY2gtb21hcDIvS2NvbmZpZwppbmRleCBmMjg1ZGQ3Li5mZDExYWI0IDEwMDY0
NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL0tjb25maWcKKysrIGIvYXJjaC9hcm0vbWFjaC1v
bWFwMi9LY29uZmlnCkBAIC00NSw3ICs0NSwxMCBAQCBjb25maWcgQVJDSF9PTUFQNAogCXNlbGVj
dCBDUFVfVjcKIAlzZWxlY3QgQVJNX0dJQwogCXNlbGVjdCBMT0NBTF9USU1FUlMKKwlzZWxlY3Qg
Q0FDSEVfTDJYMAorCXNlbGVjdCBDQUNIRV9QTDMxMAogCXNlbGVjdCBQTDMxMF9FUlJBVEFfNTg4
MzY5CisJc2VsZWN0IFBMMzEwX0VSUkFUQV83Mjc5MTUKIAlzZWxlY3QgQVJNX0VSUkFUQV83MjA3
ODkKIAlzZWxlY3QgQVJDSF9IQVNfT1BQCiAJc2VsZWN0IFBNX09QUCBpZiBQTQpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwNC1jb21tb24uYyBiL2FyY2gvYXJtL21hY2gtb21h
cDIvb21hcDQtY29tbW9uLmMKaW5kZXggMTkyNjg2NC4uOWVmOGMyOSAxMDA2NDQKLS0tIGEvYXJj
aC9hcm0vbWFjaC1vbWFwMi9vbWFwNC1jb21tb24uYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAy
L29tYXA0LWNvbW1vbi5jCkBAIC01Miw2ICs1MiwxMiBAQCBzdGF0aWMgdm9pZCBvbWFwNF9sMngw
X2Rpc2FibGUodm9pZCkKIAlvbWFwX3NtYzEoMHgxMDIsIDB4MCk7CiB9CiAKK3N0YXRpYyB2b2lk
IG9tYXA0X2wyeDBfc2V0X2RlYnVnKHVuc2lnbmVkIGxvbmcgdmFsKQoreworCS8qIFByb2dyYW0g
UEwzMTAgTDIgQ2FjaGUgY29udHJvbGxlciBkZWJ1ZyByZWdpc3RlciAqLworCW9tYXBfc21jMSgw
eDEwMCwgdmFsKTsKK30KKwogc3RhdGljIGludCBfX2luaXQgb21hcF9sMl9jYWNoZV9pbml0KHZv
aWQpCiB7CiAJdTMyIGF1eF9jdHJsID0gMDsKQEAgLTk5LDYgKzEwNSw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IG9tYXBfbDJfY2FjaGVfaW5pdCh2b2lkKQogCSAqIHNwZWNpZmljIG9uZQogCSovCiAJ
b3V0ZXJfY2FjaGUuZGlzYWJsZSA9IG9tYXA0X2wyeDBfZGlzYWJsZTsKKwlvdXRlcl9jYWNoZS5z
ZXRfZGVidWcgPSBvbWFwNF9sMngwX3NldF9kZWJ1ZzsKIAogCXJldHVybiAwOwogfQpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbW0vY2FjaGUtbDJ4MC5jIGIvYXJjaC9hcm0vbW0vY2FjaGUtbDJ4MC5j
CmluZGV4IDE3MGM5YmIuLmE4Y2FlZTQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21tL2NhY2hlLWwy
eDAuYworKysgYi9hcmNoL2FybS9tbS9jYWNoZS1sMngwLmMKQEAgLTY3LDE4ICs2NywyMiBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgbDJ4MF9pbnZfbGluZSh1bnNpZ25lZCBsb25nIGFkZHIpCiAJd3Jp
dGVsX3JlbGF4ZWQoYWRkciwgYmFzZSArIEwyWDBfSU5WX0xJTkVfUEEpOwogfQogCi0jaWZkZWYg
Q09ORklHX1BMMzEwX0VSUkFUQV81ODgzNjkKKyNpZiBkZWZpbmVkKENPTkZJR19QTDMxMF9FUlJB
VEFfNTg4MzY5KSB8fCBkZWZpbmVkKENPTkZJR19QTDMxMF9FUlJBVEFfNzI3OTE1KQogc3RhdGlj
IHZvaWQgZGVidWdfd3JpdGVsKHVuc2lnbmVkIGxvbmcgdmFsKQogewotCWV4dGVybiB2b2lkIG9t
YXBfc21jMSh1MzIgZm4sIHUzMiBhcmcpOwotCi0JLyoKLQkgKiBUZXhhcyBJbnN0cnVtZW50IHNl
Y3VyZSBtb25pdG9yIGFwaSB0byBtb2RpZnkgdGhlCi0JICogUEwzMTAgRGVidWcgQ29udHJvbCBS
ZWdpc3Rlci4KLQkgKi8KLQlvbWFwX3NtYzEoMHgxMDAsIHZhbCk7CisJaWYgKG91dGVyX2NhY2hl
LnNldF9kZWJ1ZykKKwkJb3V0ZXJfY2FjaGUuc2V0X2RlYnVnKHZhbCk7CisJZWxzZQorCQl3cml0
ZWwodmFsLCBsMngwX2Jhc2UgKyBMMlgwX0RFQlVHX0NUUkwpOworfQorI2Vsc2UKKy8qIE9wdGlt
aXNlZCBvdXQgZm9yIG5vbi1lcnJhdGEgY2FzZSAqLworc3RhdGljIGlubGluZSB2b2lkIGRlYnVn
X3dyaXRlbCh1bnNpZ25lZCBsb25nIHZhbCkKK3sKIH0KKyNlbmRpZgogCisjaWZkZWYgQ09ORklH
X1BMMzEwX0VSUkFUQV81ODgzNjkKIHN0YXRpYyBpbmxpbmUgdm9pZCBsMngwX2ZsdXNoX2xpbmUo
dW5zaWduZWQgbG9uZyBhZGRyKQogewogCXZvaWQgX19pb21lbSAqYmFzZSA9IGwyeDBfYmFzZTsK
QEAgLTkxLDExICs5NSw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMngwX2ZsdXNoX2xpbmUodW5z
aWduZWQgbG9uZyBhZGRyKQogfQogI2Vsc2UKIAotLyogT3B0aW1pc2VkIG91dCBmb3Igbm9uLWVy
cmF0YSBjYXNlICovCi1zdGF0aWMgaW5saW5lIHZvaWQgZGVidWdfd3JpdGVsKHVuc2lnbmVkIGxv
bmcgdmFsKQotewotfQotCiBzdGF0aWMgaW5saW5lIHZvaWQgbDJ4MF9mbHVzaF9saW5lKHVuc2ln
bmVkIGxvbmcgYWRkcikKIHsKIAl2b2lkIF9faW9tZW0gKmJhc2UgPSBsMngwX2Jhc2U7CkBAIC0x
MTksOSArMTE4LDExIEBAIHN0YXRpYyB2b2lkIGwyeDBfZmx1c2hfYWxsKHZvaWQpCiAKIAkvKiBj
bGVhbiBhbGwgd2F5cyAqLwogCXNwaW5fbG9ja19pcnFzYXZlKCZsMngwX2xvY2ssIGZsYWdzKTsK
KwlkZWJ1Z193cml0ZWwoMHgwMyk7CiAJd3JpdGVsX3JlbGF4ZWQobDJ4MF93YXlfbWFzaywgbDJ4
MF9iYXNlICsgTDJYMF9DTEVBTl9JTlZfV0FZKTsKIAljYWNoZV93YWl0X3dheShsMngwX2Jhc2Ug
KyBMMlgwX0NMRUFOX0lOVl9XQVksIGwyeDBfd2F5X21hc2spOwogCWNhY2hlX3N5bmMoKTsKKwlk
ZWJ1Z193cml0ZWwoMHgwMCk7CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbDJ4MF9sb2NrLCBm
bGFncyk7CiB9CiAKQEAgLTMyOSw2ICszMzAsNyBAQCB2b2lkIF9faW5pdCBsMngwX2luaXQodm9p
ZCBfX2lvbWVtICpiYXNlLCBfX3UzMiBhdXhfdmFsLCBfX3UzMiBhdXhfbWFzaykKIAlvdXRlcl9j
YWNoZS5mbHVzaF9hbGwgPSBsMngwX2ZsdXNoX2FsbDsKIAlvdXRlcl9jYWNoZS5pbnZfYWxsID0g
bDJ4MF9pbnZfYWxsOwogCW91dGVyX2NhY2hlLmRpc2FibGUgPSBsMngwX2Rpc2FibGU7CisJb3V0
ZXJfY2FjaGUuc2V0X2RlYnVnID0gTlVMTDsKIAogCXByaW50ayhLRVJOX0lORk8gIiVzIGNhY2hl
IGNvbnRyb2xsZXIgZW5hYmxlZFxuIiwgdHlwZSk7CiAJcHJpbnRrKEtFUk5fSU5GTyAibDJ4MDog
JWQgd2F5cywgQ0FDSEVfSUQgMHglMDh4LCBBVVhfQ1RSTCAweCUwOHgsIENhY2hlIHNpemU6ICVk
IEJcbiIsCi0tIAoxLjYuMC40Cgo=
--001485f1e28ab8462e049c4ce924--
