From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Wayoperationcan
 cause data corruption
Date: Mon, 7 Mar 2011 17:55:22 +0530
Message-ID: <491849bc08797fc8c4d0def52dd6308a@mail.gmail.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
	<1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
	<20110227120021.GA15314@n2100.arm.linux.org.uk>	<20110228101351.GA30781@n2100.arm.linux.org.uk><69dd173e3c7b4d02ef50ceaa19b2343a@mail.gmail.com>
 <000a01cbdcc0$3d0dfeb0$b729fc10$@deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175ca8ee102c3d049de3979f
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:57634 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752559Ab1CGMZd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 07:25:33 -0500
Received: by qyl38 with SMTP id 38so3802889qyl.15
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 04:25:30 -0800 (PST)
In-Reply-To: <000a01cbdcc0$3d0dfeb0$b729fc10$@deacon@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: tony@atomide.com, Catalin Marinas <Catalin.Marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--0015175ca8ee102c3d049de3979f
Content-Type: text/plain; charset=ISO-8859-1

Thanks Will for reporting it.

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-
> arm-kernel-bounces@lists.infradead.org] On Behalf Of Will Deacon
> Sent: Monday, March 07, 2011 5:38 PM
> To: 'Santosh Shilimkar'; Russell King - ARM Linux
> Cc: tony@atomide.com; Catalin Marinas; linux-omap@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 1/2] ARM: l2x0: Errata fix for flush by
> Wayoperationcan cause data corruption
>
> Hi Santosh,
>
> > > On Sun, Feb 27, 2011 at 12:00:21PM +0000, Russell King - ARM
> Linux
> > > wrote:
> > > > > +#else
> > > > > +/* Optimised out for non-errata case */
> > > > > +static inline void debug_writel(unsigned long val)
> > > > > +{
> > > > >  }
> > > >
> > > > #define l2x0_set_debug	NULL
> > > >
> > > > > +#endif
> > >
> > > I notice you got rid of the inline function.  Have you tried
> > > building this without the errata enabled?
> >
> > I accidently dropped the inline function while
> > incorporating the comment from you. :(
> >
> > Fixed it. Updated version # 6770/1
>
> This version of the patch (as it appears in -next) is broken:
>
>
> +#define debug_writel(val)	outer_cache.set_debug(val)
> +
> +static void l2x0_set_debug(unsigned long val)
> +{
> +	writel(val, l2x0_base + L2X0_DEBUG_CTRL);

This should have been "writel_relaxed()" to avoid the
cache sync.

>  }
>
> [...]
>
> @@ -119,9 +120,11 @@ static void l2x0_flush_all(void)
>
>  	/* clean all ways */
>  	spin_lock_irqsave(&l2x0_lock, flags);
> +	debug_writel(0x03);
>  	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
>  	cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
>  	cache_sync();
> +	debug_writel(0x00);
>  	spin_unlock_irqrestore(&l2x0_lock, flags);
>  }
>
>
> This deadlocks because the writel forces an outer cache sync, which
> then tries to acquire the spinlock which is held by the calling
> function.
>
> If you change l2x0_set_debug to use writel_relaxed then you can
> avoid the problem.
>
Ya understood. I couldn't test non-errata case because
direct right doesn't work because of security and henced missed
it.

Below is the updated version. Also attached.

Russell,
Do you want me to push this to patch system or you can
apply this one?


Regards,
Santosh
------
>From 9167fd4eff8adf1f8be772cdb734bfc0f2061354 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 28 Feb 2011 13:31:09 +0100
Subject: [PATCH] ARM: 6770/1: l2x0: Errata fix for flush by Way operation
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

This patch also removes any OMAP dependency on PL310 Errata's

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                  |   15 ++++++++++++---
 arch/arm/include/asm/outercache.h |    1 +
 arch/arm/mm/cache-l2x0.c          |   32 ++++++++++++++++++--------------
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 65ea7bb..ef41f7e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1135,7 +1135,7 @@ config ARM_ERRATA_742231

 config PL310_ERRATA_588369
 	bool "Clean & Invalidate maintenance operations do not invalidate
clean lines"
-	depends on CACHE_L2X0 && ARCH_OMAP4
+	depends on CACHE_L2X0
 	help
 	   The PL310 L2 cache controller implements three types of Clean &
 	   Invalidate maintenance operations: by Physical Address
@@ -1144,8 +1144,7 @@ config PL310_ERRATA_588369
 	   clean operation followed immediately by an invalidate
operation,
 	   both performing to the same memory location. This functionality
 	   is not correctly implemented in PL310 as clean lines are not
-	   invalidated as a result of these operations. Note that this
errata
-	   uses Texas Instrument's secure monitor api.
+	   invalidated as a result of these operations.

 config ARM_ERRATA_720789
 	bool "ARM errata: TLBIASIDIS and TLBIMVAIS operations can
broadcast a faulty ASID"
@@ -1172,6 +1171,16 @@ config ARM_ERRATA_743622
 	  visible impact on the overall performance or power consumption
of the
 	  processor.

+config PL310_ERRATA_727915
+	bool "Background Clean & Invalidate by Way operation can cause
data corruption"
+	depends on CACHE_L2X0
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
+	  Invalidate by Way operation.
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
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 170c9bb..0986cce 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -67,18 +67,24 @@ static inline void l2x0_inv_line(unsigned long addr)
 	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
 }

-#ifdef CONFIG_PL310_ERRATA_588369
-static void debug_writel(unsigned long val)
-{
-	extern void omap_smc1(u32 fn, u32 arg);
+#if defined(CONFIG_PL310_ERRATA_588369) ||
defined(CONFIG_PL310_ERRATA_727915)

-	/*
-	 * Texas Instrument secure monitor api to modify the
-	 * PL310 Debug Control Register.
-	 */
-	omap_smc1(0x100, val);
+#define debug_writel(val)	outer_cache.set_debug(val)
+
+static void l2x0_set_debug(unsigned long val)
+{
+	writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
 }
+#else
+/* Optimised out for non-errata case */
+static inline void debug_writel(unsigned long val)
+{
+}
+
+#define l2x0_set_debug	NULL
+#endif

+#ifdef CONFIG_PL310_ERRATA_588369
 static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
@@ -91,11 +97,6 @@ static inline void l2x0_flush_line(unsigned long addr)
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
@@ -119,9 +120,11 @@ static void l2x0_flush_all(void)

 	/* clean all ways */
 	spin_lock_irqsave(&l2x0_lock, flags);
+	debug_writel(0x03);
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
 	cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
 	cache_sync();
+	debug_writel(0x00);
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }

@@ -329,6 +332,7 @@ void __init l2x0_init(void __iomem *base, __u32
aux_val, __u32 aux_mask)
 	outer_cache.flush_all = l2x0_flush_all;
 	outer_cache.inv_all = l2x0_inv_all;
 	outer_cache.disable = l2x0_disable;
+	outer_cache.set_debug = l2x0_set_debug;

 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x,
Cache size: %d B\n",
-- 
1.6.0.4

--0015175ca8ee102c3d049de3979f
Content-Type: application/octet-stream;
	name="0001-ARM-6770-1-l2x0-Errata-fix-for-flush-by-Way-opera.patch"
Content-Disposition: attachment;
	filename="0001-ARM-6770-1-l2x0-Errata-fix-for-flush-by-Way-opera.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: c262237f5f4c68d6_0.1

RnJvbSA5MTY3ZmQ0ZWZmOGFkZjFmOGJlNzcyY2RiNzM0YmZjMGYyMDYxMzU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBNb24sIDI4IEZlYiAyMDExIDEzOjMxOjA5ICswMTAwClN1YmplY3Q6IFtQ
QVRDSF0gQVJNOiA2NzcwLzE6IGwyeDA6IEVycmF0YSBmaXggZm9yIGZsdXNoIGJ5IFdheSBvcGVy
YXRpb24gY2FuIGNhdXNlIGRhdGEgY29ycnVwdGlvbgoKUEwzMTAgaW1wbGVtZW50cyB0aGUgQ2xl
YW4gJiBJbnZhbGlkYXRlIGJ5IFdheSBMMiBjYWNoZSBtYWludGVuYW5jZQpvcGVyYXRpb24gKG9m
ZnNldCAweDdGQykuIFRoaXMgb3BlcmF0aW9uIHJ1bnMgaW4gYmFja2dyb3VuZCBzbyB0aGF0ClBM
MzEwIGNhbiBoYW5kbGUgbm9ybWFsIGFjY2Vzc2VzIHdoaWxlIGl0IGlzIGluIHByb2dyZXNzLiBV
bmRlciB2ZXJ5CnJhcmUgY2lyY3Vtc3RhbmNlcywgZHVlIHRvIHRoaXMgZXJyYXR1bSwgd3JpdGUg
ZGF0YSBjYW4gYmUgbG9zdCB3aGVuClBMMzEwIHRyZWF0cyBhIGNhY2hlYWJsZSB3cml0ZSB0cmFu
c2FjdGlvbiBkdXJpbmcgYSBDbGVhbiAmIEludmFsaWRhdGUKYnkgV2F5IG9wZXJhdGlvbi4KCldv
cmthcm91bmQ6CkRpc2FibGUgV3JpdGUtQmFjayBhbmQgQ2FjaGUgTGluZWZpbGwgKERlYnVnIENv
bnRyb2wgUmVnaXN0ZXIpCkNsZWFuICYgSW52YWxpZGF0ZSBieSBXYXkgKDB4N0ZDKQpSZS1lbmFi
bGUgV3JpdGUtQmFjayBhbmQgQ2FjaGUgTGluZWZpbGwgKERlYnVnIENvbnRyb2wgUmVnaXN0ZXIp
CgpUaGlzIHBhdGNoIGFsc28gcmVtb3ZlcyBhbnkgT01BUCBkZXBlbmRlbmN5IG9uIFBMMzEwIEVy
cmF0YSdzCgpTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1r
YXJAdGkuY29tPgpBY2tlZC1ieTogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJt
LmNvbT4KU2lnbmVkLW9mZi1ieTogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybS5saW51eC5v
cmcudWs+Ci0tLQogYXJjaC9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAxNSArKysr
KysrKysrKystLS0KIGFyY2gvYXJtL2luY2x1ZGUvYXNtL291dGVyY2FjaGUuaCB8ICAgIDEgKwog
YXJjaC9hcm0vbW0vY2FjaGUtbDJ4MC5jICAgICAgICAgIHwgICAzMiArKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxNyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9LY29uZmlnIGIvYXJjaC9hcm0vS2Nv
bmZpZwppbmRleCA2NWVhN2JiLi5lZjQxZjdlIDEwMDY0NAotLS0gYS9hcmNoL2FybS9LY29uZmln
CisrKyBiL2FyY2gvYXJtL0tjb25maWcKQEAgLTExMzUsNyArMTEzNSw3IEBAIGNvbmZpZyBBUk1f
RVJSQVRBXzc0MjIzMQogCiBjb25maWcgUEwzMTBfRVJSQVRBXzU4ODM2OQogCWJvb2wgIkNsZWFu
ICYgSW52YWxpZGF0ZSBtYWludGVuYW5jZSBvcGVyYXRpb25zIGRvIG5vdCBpbnZhbGlkYXRlIGNs
ZWFuIGxpbmVzIgotCWRlcGVuZHMgb24gQ0FDSEVfTDJYMCAmJiBBUkNIX09NQVA0CisJZGVwZW5k
cyBvbiBDQUNIRV9MMlgwCiAJaGVscAogCSAgIFRoZSBQTDMxMCBMMiBjYWNoZSBjb250cm9sbGVy
IGltcGxlbWVudHMgdGhyZWUgdHlwZXMgb2YgQ2xlYW4gJgogCSAgIEludmFsaWRhdGUgbWFpbnRl
bmFuY2Ugb3BlcmF0aW9uczogYnkgUGh5c2ljYWwgQWRkcmVzcwpAQCAtMTE0NCw4ICsxMTQ0LDcg
QEAgY29uZmlnIFBMMzEwX0VSUkFUQV81ODgzNjkKIAkgICBjbGVhbiBvcGVyYXRpb24gZm9sbG93
ZWQgaW1tZWRpYXRlbHkgYnkgYW4gaW52YWxpZGF0ZSBvcGVyYXRpb24sCiAJICAgYm90aCBwZXJm
b3JtaW5nIHRvIHRoZSBzYW1lIG1lbW9yeSBsb2NhdGlvbi4gVGhpcyBmdW5jdGlvbmFsaXR5CiAJ
ICAgaXMgbm90IGNvcnJlY3RseSBpbXBsZW1lbnRlZCBpbiBQTDMxMCBhcyBjbGVhbiBsaW5lcyBh
cmUgbm90Ci0JICAgaW52YWxpZGF0ZWQgYXMgYSByZXN1bHQgb2YgdGhlc2Ugb3BlcmF0aW9ucy4g
Tm90ZSB0aGF0IHRoaXMgZXJyYXRhCi0JICAgdXNlcyBUZXhhcyBJbnN0cnVtZW50J3Mgc2VjdXJl
IG1vbml0b3IgYXBpLgorCSAgIGludmFsaWRhdGVkIGFzIGEgcmVzdWx0IG9mIHRoZXNlIG9wZXJh
dGlvbnMuCiAKIGNvbmZpZyBBUk1fRVJSQVRBXzcyMDc4OQogCWJvb2wgIkFSTSBlcnJhdGE6IFRM
QklBU0lESVMgYW5kIFRMQklNVkFJUyBvcGVyYXRpb25zIGNhbiBicm9hZGNhc3QgYSBmYXVsdHkg
QVNJRCIKQEAgLTExNzIsNiArMTE3MSwxNiBAQCBjb25maWcgQVJNX0VSUkFUQV83NDM2MjIKIAkg
IHZpc2libGUgaW1wYWN0IG9uIHRoZSBvdmVyYWxsIHBlcmZvcm1hbmNlIG9yIHBvd2VyIGNvbnN1
bXB0aW9uIG9mIHRoZQogCSAgcHJvY2Vzc29yLgogCitjb25maWcgUEwzMTBfRVJSQVRBXzcyNzkx
NQorCWJvb2wgIkJhY2tncm91bmQgQ2xlYW4gJiBJbnZhbGlkYXRlIGJ5IFdheSBvcGVyYXRpb24g
Y2FuIGNhdXNlIGRhdGEgY29ycnVwdGlvbiIKKwlkZXBlbmRzIG9uIENBQ0hFX0wyWDAKKwloZWxw
CisJICBQTDMxMCBpbXBsZW1lbnRzIHRoZSBDbGVhbiAmIEludmFsaWRhdGUgYnkgV2F5IEwyIGNh
Y2hlIG1haW50ZW5hbmNlCisJICBvcGVyYXRpb24gKG9mZnNldCAweDdGQykuIFRoaXMgb3BlcmF0
aW9uIHJ1bnMgaW4gYmFja2dyb3VuZCBzbyB0aGF0CisJICBQTDMxMCBjYW4gaGFuZGxlIG5vcm1h
bCBhY2Nlc3NlcyB3aGlsZSBpdCBpcyBpbiBwcm9ncmVzcy4gVW5kZXIgdmVyeQorCSAgcmFyZSBj
aXJjdW1zdGFuY2VzLCBkdWUgdG8gdGhpcyBlcnJhdHVtLCB3cml0ZSBkYXRhIGNhbiBiZSBsb3N0
IHdoZW4KKwkgIFBMMzEwIHRyZWF0cyBhIGNhY2hlYWJsZSB3cml0ZSB0cmFuc2FjdGlvbiBkdXJp
bmcgYSBDbGVhbiAmCisJICBJbnZhbGlkYXRlIGJ5IFdheSBvcGVyYXRpb24uCiBlbmRtZW51CiAK
IHNvdXJjZSAiYXJjaC9hcm0vY29tbW9uL0tjb25maWciCmRpZmYgLS1naXQgYS9hcmNoL2FybS9p
bmNsdWRlL2FzbS9vdXRlcmNhY2hlLmggYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9vdXRlcmNhY2hl
LmgKaW5kZXggZmMxOTAwOS4uMzQ4ZDUxMyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vaW5jbHVkZS9h
c20vb3V0ZXJjYWNoZS5oCisrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL291dGVyY2FjaGUuaApA
QCAtMzEsNiArMzEsNyBAQCBzdHJ1Y3Qgb3V0ZXJfY2FjaGVfZm5zIHsKICNpZmRlZiBDT05GSUdf
T1VURVJfQ0FDSEVfU1lOQwogCXZvaWQgKCpzeW5jKSh2b2lkKTsKICNlbmRpZgorCXZvaWQgKCpz
ZXRfZGVidWcpKHVuc2lnbmVkIGxvbmcpOwogfTsKIAogI2lmZGVmIENPTkZJR19PVVRFUl9DQUNI
RQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbW0vY2FjaGUtbDJ4MC5jIGIvYXJjaC9hcm0vbW0vY2Fj
aGUtbDJ4MC5jCmluZGV4IDE3MGM5YmIuLjA5ODZjY2UgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21t
L2NhY2hlLWwyeDAuYworKysgYi9hcmNoL2FybS9tbS9jYWNoZS1sMngwLmMKQEAgLTY3LDE4ICs2
NywyNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbDJ4MF9pbnZfbGluZSh1bnNpZ25lZCBsb25nIGFk
ZHIpCiAJd3JpdGVsX3JlbGF4ZWQoYWRkciwgYmFzZSArIEwyWDBfSU5WX0xJTkVfUEEpOwogfQog
Ci0jaWZkZWYgQ09ORklHX1BMMzEwX0VSUkFUQV81ODgzNjkKLXN0YXRpYyB2b2lkIGRlYnVnX3dy
aXRlbCh1bnNpZ25lZCBsb25nIHZhbCkKLXsKLQlleHRlcm4gdm9pZCBvbWFwX3NtYzEodTMyIGZu
LCB1MzIgYXJnKTsKKyNpZiBkZWZpbmVkKENPTkZJR19QTDMxMF9FUlJBVEFfNTg4MzY5KSB8fCBk
ZWZpbmVkKENPTkZJR19QTDMxMF9FUlJBVEFfNzI3OTE1KQogCi0JLyoKLQkgKiBUZXhhcyBJbnN0
cnVtZW50IHNlY3VyZSBtb25pdG9yIGFwaSB0byBtb2RpZnkgdGhlCi0JICogUEwzMTAgRGVidWcg
Q29udHJvbCBSZWdpc3Rlci4KLQkgKi8KLQlvbWFwX3NtYzEoMHgxMDAsIHZhbCk7CisjZGVmaW5l
IGRlYnVnX3dyaXRlbCh2YWwpCW91dGVyX2NhY2hlLnNldF9kZWJ1Zyh2YWwpCisKK3N0YXRpYyB2
b2lkIGwyeDBfc2V0X2RlYnVnKHVuc2lnbmVkIGxvbmcgdmFsKQoreworCXdyaXRlbF9yZWxheGVk
KHZhbCwgbDJ4MF9iYXNlICsgTDJYMF9ERUJVR19DVFJMKTsKIH0KKyNlbHNlCisvKiBPcHRpbWlz
ZWQgb3V0IGZvciBub24tZXJyYXRhIGNhc2UgKi8KK3N0YXRpYyBpbmxpbmUgdm9pZCBkZWJ1Z193
cml0ZWwodW5zaWduZWQgbG9uZyB2YWwpCit7Cit9CisKKyNkZWZpbmUgbDJ4MF9zZXRfZGVidWcJ
TlVMTAorI2VuZGlmCiAKKyNpZmRlZiBDT05GSUdfUEwzMTBfRVJSQVRBXzU4ODM2OQogc3RhdGlj
IGlubGluZSB2b2lkIGwyeDBfZmx1c2hfbGluZSh1bnNpZ25lZCBsb25nIGFkZHIpCiB7CiAJdm9p
ZCBfX2lvbWVtICpiYXNlID0gbDJ4MF9iYXNlOwpAQCAtOTEsMTEgKzk3LDYgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGwyeDBfZmx1c2hfbGluZSh1bnNpZ25lZCBsb25nIGFkZHIpCiB9CiAjZWxzZQog
Ci0vKiBPcHRpbWlzZWQgb3V0IGZvciBub24tZXJyYXRhIGNhc2UgKi8KLXN0YXRpYyBpbmxpbmUg
dm9pZCBkZWJ1Z193cml0ZWwodW5zaWduZWQgbG9uZyB2YWwpCi17Ci19Ci0KIHN0YXRpYyBpbmxp
bmUgdm9pZCBsMngwX2ZsdXNoX2xpbmUodW5zaWduZWQgbG9uZyBhZGRyKQogewogCXZvaWQgX19p
b21lbSAqYmFzZSA9IGwyeDBfYmFzZTsKQEAgLTExOSw5ICsxMjAsMTEgQEAgc3RhdGljIHZvaWQg
bDJ4MF9mbHVzaF9hbGwodm9pZCkKIAogCS8qIGNsZWFuIGFsbCB3YXlzICovCiAJc3Bpbl9sb2Nr
X2lycXNhdmUoJmwyeDBfbG9jaywgZmxhZ3MpOworCWRlYnVnX3dyaXRlbCgweDAzKTsKIAl3cml0
ZWxfcmVsYXhlZChsMngwX3dheV9tYXNrLCBsMngwX2Jhc2UgKyBMMlgwX0NMRUFOX0lOVl9XQVkp
OwogCWNhY2hlX3dhaXRfd2F5KGwyeDBfYmFzZSArIEwyWDBfQ0xFQU5fSU5WX1dBWSwgbDJ4MF93
YXlfbWFzayk7CiAJY2FjaGVfc3luYygpOworCWRlYnVnX3dyaXRlbCgweDAwKTsKIAlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZsMngwX2xvY2ssIGZsYWdzKTsKIH0KIApAQCAtMzI5LDYgKzMzMiw3
IEBAIHZvaWQgX19pbml0IGwyeDBfaW5pdCh2b2lkIF9faW9tZW0gKmJhc2UsIF9fdTMyIGF1eF92
YWwsIF9fdTMyIGF1eF9tYXNrKQogCW91dGVyX2NhY2hlLmZsdXNoX2FsbCA9IGwyeDBfZmx1c2hf
YWxsOwogCW91dGVyX2NhY2hlLmludl9hbGwgPSBsMngwX2ludl9hbGw7CiAJb3V0ZXJfY2FjaGUu
ZGlzYWJsZSA9IGwyeDBfZGlzYWJsZTsKKwlvdXRlcl9jYWNoZS5zZXRfZGVidWcgPSBsMngwX3Nl
dF9kZWJ1ZzsKIAogCXByaW50ayhLRVJOX0lORk8gIiVzIGNhY2hlIGNvbnRyb2xsZXIgZW5hYmxl
ZFxuIiwgdHlwZSk7CiAJcHJpbnRrKEtFUk5fSU5GTyAibDJ4MDogJWQgd2F5cywgQ0FDSEVfSUQg
MHglMDh4LCBBVVhfQ1RSTCAweCUwOHgsIENhY2hlIHNpemU6ICVkIEJcbiIsCi0tIAoxLjYuMC40
Cgo=
--0015175ca8ee102c3d049de3979f--
