From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V3] ARM: GIC: Convert GIC library to use the IO relaxed
 operations
Date: Wed, 04 May 2011 16:32:42 +0530
Message-ID: <4DC13252.2080308@ti.com>
References: <1304058131-8375-1-git-send-email-santosh.shilimkar@ti.com> <1304417481.19196.60.camel@e102109-lin.cambridge.arm.com> <4DBFD59D.50008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060305080108070501010303"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56478 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab1EDLCw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 07:02:52 -0400
Received: by gyg8 with SMTP id 8so450497gyg.24
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 04:02:51 -0700 (PDT)
In-Reply-To: <4DBFD59D.50008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305080108070501010303
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/2011 3:44 PM, Santosh Shilimkar wrote:
> On 5/3/2011 3:41 PM, Catalin Marinas wrote:

[...]

>>
>> Otherwise the patch looks fine (I'll add my ack after you fix the above).
>>
> Thanks. Will add above comment, drop the readl and repost with your ack.
>
> Same will push it the patch system
>
Below is the updated version. I didn't push this to patch system because
it is generated on top of Will's GIC series.

Will,
Can you queue this patch part of your series please?

Regards
Santosh

 From 1506abc77b36eb10ae0e3f8711e6ad1b87ca363d Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 28 Mar 2011 19:27:46 +0530
Subject: [PATCH] ARM: GIC: Convert GIC library to use the IO relaxed 
operations

The GIC register accesses today make use of readl()/writel()
which prove to be very expensive when used along with mandatory
barriers. This mandatory barriers also introduces an un-necessary
and expensive l2x0_sync() operation. On Cortex-A9 MP cores, GIC
IO accesses from CPU are direct and doesn't go through L2X0 write
buffer.

A DSB before writel_relaxed() in gic_raise_softirq() is added to be
compliant with the Barrier Litmus document - the mailbox scenario.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
  arch/arm/common/gic.c |   54 
+++++++++++++++++++++++++++---------------------
  1 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index e9c2ff8..4ddd0a6 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -89,7 +89,7 @@ static void gic_mask_irq(struct irq_data *d)
  	u32 mask = 1 << (d->irq % 32);

  	spin_lock(&irq_controller_lock);
-	writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 
32) * 4);
+	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + 
(gic_irq(d) / 32) * 4);
  	if (gic_arch_extn.irq_mask)
  		gic_arch_extn.irq_mask(d);
  	spin_unlock(&irq_controller_lock);
@@ -102,7 +102,7 @@ static void gic_unmask_irq(struct irq_data *d)
  	spin_lock(&irq_controller_lock);
  	if (gic_arch_extn.irq_unmask)
  		gic_arch_extn.irq_unmask(d);
-	writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 
32) * 4);
+	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + 
(gic_irq(d) / 32) * 4);
  	spin_unlock(&irq_controller_lock);
  }

@@ -114,7 +114,7 @@ static void gic_eoi_irq(struct irq_data *d)
  		spin_unlock(&irq_controller_lock);
  	}

-	writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
  }

  static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -140,7 +140,7 @@ static int gic_set_type(struct irq_data *d, unsigned 
int type)
  	if (gic_arch_extn.irq_set_type)
  		gic_arch_extn.irq_set_type(d, type);

-	val = readl(base + GIC_DIST_CONFIG + confoff);
+	val = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
  	if (type == IRQ_TYPE_LEVEL_HIGH)
  		val &= ~confmask;
  	else if (type == IRQ_TYPE_EDGE_RISING)
@@ -150,15 +150,15 @@ static int gic_set_type(struct irq_data *d, 
unsigned int type)
  	 * As recommended by the spec, disable the interrupt before changing
  	 * the configuration
  	 */
-	if (readl(base + GIC_DIST_ENABLE_SET + enableoff) & enablemask) {
-		writel(enablemask, base + GIC_DIST_ENABLE_CLEAR + enableoff);
+	if (readl_relaxed(base + GIC_DIST_ENABLE_SET + enableoff) & enablemask) {
+		writel_relaxed(enablemask, base + GIC_DIST_ENABLE_CLEAR + enableoff);
  		enabled = true;
  	}

-	writel(val, base + GIC_DIST_CONFIG + confoff);
+	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);

  	if (enabled)
-		writel(enablemask, base + GIC_DIST_ENABLE_SET + enableoff);
+		writel_relaxed(enablemask, base + GIC_DIST_ENABLE_SET + enableoff);

  	spin_unlock(&irq_controller_lock);

@@ -190,8 +190,8 @@ static int gic_set_affinity(struct irq_data *d, 
const struct cpumask *mask_val,

  	spin_lock(&irq_controller_lock);
  	d->node = cpu;
-	val = readl(reg) & ~mask;
-	writel(val | bit, reg);
+	val = readl_relaxed(reg) & ~mask;
+	writel_relaxed(val | bit, reg);
  	spin_unlock(&irq_controller_lock);

  	return 0;
@@ -223,7 +223,7 @@ static void gic_handle_cascade_irq(unsigned int irq, 
struct irq_desc *desc)
  	chained_irq_enter(chip, desc);

  	spin_lock(&irq_controller_lock);
-	status = readl(chip_data->cpu_base + GIC_CPU_INTACK);
+	status = readl_relaxed(chip_data->cpu_base + GIC_CPU_INTACK);
  	spin_unlock(&irq_controller_lock);

  	gic_irq = (status & 0x3ff);
@@ -272,13 +272,13 @@ static void __init gic_dist_init(struct 
gic_chip_data *gic,
  	cpumask |= cpumask << 8;
  	cpumask |= cpumask << 16;

-	writel(0, base + GIC_DIST_CTRL);
+	writel_relaxed(0, base + GIC_DIST_CTRL);

  	/*
  	 * Find out how many interrupts are supported.
  	 * The GIC only supports up to 1020 interrupt sources.
  	 */
-	gic_irqs = readl(base + GIC_DIST_CTR) & 0x1f;
+	gic_irqs = readl_relaxed(base + GIC_DIST_CTR) & 0x1f;
  	gic_irqs = (gic_irqs + 1) * 32;
  	if (gic_irqs > 1020)
  		gic_irqs = 1020;
@@ -287,26 +287,26 @@ static void __init gic_dist_init(struct 
gic_chip_data *gic,
  	 * Set all global interrupts to be level triggered, active low.
  	 */
  	for (i = 32; i < gic_irqs; i += 16)
-		writel(0, base + GIC_DIST_CONFIG + i * 4 / 16);
+		writel_relaxed(0, base + GIC_DIST_CONFIG + i * 4 / 16);

  	/*
  	 * Set all global interrupts to this CPU only.
  	 */
  	for (i = 32; i < gic_irqs; i += 4)
-		writel(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
+		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);

  	/*
  	 * Set priority on all global interrupts.
  	 */
  	for (i = 32; i < gic_irqs; i += 4)
-		writel(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);
+		writel_relaxed(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);

  	/*
  	 * Disable all interrupts.  Leave the PPI and SGIs alone
  	 * as these enables are banked registers.
  	 */
  	for (i = 32; i < gic_irqs; i += 32)
-		writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
+		writel_relaxed(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);

  	/*
  	 * Limit number of interrupts registered to the platform maximum
@@ -324,7 +324,7 @@ static void __init gic_dist_init(struct 
gic_chip_data *gic,
  		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
  	}

-	writel(1, base + GIC_DIST_CTRL);
+	writel_relaxed(1, base + GIC_DIST_CTRL);
  }

  static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
@@ -337,17 +337,17 @@ static void __cpuinit gic_cpu_init(struct 
gic_chip_data *gic)
  	 * Deal with the banked PPI and SGI interrupts - disable all
  	 * PPI interrupts, ensure all SGI interrupts are enabled.
  	 */
-	writel(0xffff0000, dist_base + GIC_DIST_ENABLE_CLEAR);
-	writel(0x0000ffff, dist_base + GIC_DIST_ENABLE_SET);
+	writel_relaxed(0xffff0000, dist_base + GIC_DIST_ENABLE_CLEAR);
+	writel_relaxed(0x0000ffff, dist_base + GIC_DIST_ENABLE_SET);

  	/*
  	 * Set priority on PPI and SGI interrupts
  	 */
  	for (i = 0; i < 32; i += 4)
-		writel(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
+		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);

-	writel(0xf0, base + GIC_CPU_PRIMASK);
-	writel(1, base + GIC_CPU_CTRL);
+	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
+	writel_relaxed(1, base + GIC_CPU_CTRL);
  }

  void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
@@ -391,7 +391,13 @@ void gic_raise_softirq(const struct cpumask *mask, 
unsigned int irq)
  {
  	unsigned long map = *cpus_addr(*mask);

+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before issuing the IPI.
+	 */
+	dsb();
+
  	/* this always happens on GIC0 */
-	writel(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
+	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
  }
  #endif
-- 
1.6.0.4




--------------060305080108070501010303
Content-Type: text/plain;
 name="0001-ARM-GIC-Convert-GIC-library-to-use-the-IO-relaxed.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-ARM-GIC-Convert-GIC-library-to-use-the-IO-relaxed.patch"

RnJvbSAxNTA2YWJjNzdiMzZlYjEwYWUwZTNmODcxMWU2YWQxYjg3Y2EzNjNkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGls
aW1rYXJAdGkuY29tPgpEYXRlOiBNb24sIDI4IE1hciAyMDExIDE5OjI3OjQ2ICswNTMwClN1
YmplY3Q6IFtQQVRDSF0gQVJNOiBHSUM6IENvbnZlcnQgR0lDIGxpYnJhcnkgdG8gdXNlIHRo
ZSBJTyByZWxheGVkIG9wZXJhdGlvbnMKClRoZSBHSUMgcmVnaXN0ZXIgYWNjZXNzZXMgdG9k
YXkgbWFrZSB1c2Ugb2YgcmVhZGwoKS93cml0ZWwoKQp3aGljaCBwcm92ZSB0byBiZSB2ZXJ5
IGV4cGVuc2l2ZSB3aGVuIHVzZWQgYWxvbmcgd2l0aCBtYW5kYXRvcnkKYmFycmllcnMuIFRo
aXMgbWFuZGF0b3J5IGJhcnJpZXJzIGFsc28gaW50cm9kdWNlcyBhbiB1bi1uZWNlc3NhcnkK
YW5kIGV4cGVuc2l2ZSBsMngwX3N5bmMoKSBvcGVyYXRpb24uIE9uIENvcnRleC1BOSBNUCBj
b3JlcywgR0lDCklPIGFjY2Vzc2VzIGZyb20gQ1BVIGFyZSBkaXJlY3QgYW5kIGRvZXNuJ3Qg
Z28gdGhyb3VnaCBMMlgwIHdyaXRlCmJ1ZmZlci4KCkEgRFNCIGJlZm9yZSB3cml0ZWxfcmVs
YXhlZCgpIGluIGdpY19yYWlzZV9zb2Z0aXJxKCkgaXMgYWRkZWQgdG8gYmUKY29tcGxpYW50
IHdpdGggdGhlIEJhcnJpZXIgTGl0bXVzIGRvY3VtZW50IC0gdGhlIG1haWxib3ggc2NlbmFy
aW8uCgpTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1r
YXJAdGkuY29tPgpBY2tlZC1ieTogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNA
YXJtLmNvbT4KQ2M6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPgotLS0KIGFy
Y2gvYXJtL2NvbW1vbi9naWMuYyB8ICAgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMo
KyksIDI0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbW1vbi9naWMu
YyBiL2FyY2gvYXJtL2NvbW1vbi9naWMuYwppbmRleCBlOWMyZmY4Li40ZGRkMGE2IDEwMDY0
NAotLS0gYS9hcmNoL2FybS9jb21tb24vZ2ljLmMKKysrIGIvYXJjaC9hcm0vY29tbW9uL2dp
Yy5jCkBAIC04OSw3ICs4OSw3IEBAIHN0YXRpYyB2b2lkIGdpY19tYXNrX2lycShzdHJ1Y3Qg
aXJxX2RhdGEgKmQpCiAJdTMyIG1hc2sgPSAxIDw8IChkLT5pcnEgJSAzMik7CiAKIAlzcGlu
X2xvY2soJmlycV9jb250cm9sbGVyX2xvY2spOwotCXdyaXRlbChtYXNrLCBnaWNfZGlzdF9i
YXNlKGQpICsgR0lDX0RJU1RfRU5BQkxFX0NMRUFSICsgKGdpY19pcnEoZCkgLyAzMikgKiA0
KTsKKwl3cml0ZWxfcmVsYXhlZChtYXNrLCBnaWNfZGlzdF9iYXNlKGQpICsgR0lDX0RJU1Rf
RU5BQkxFX0NMRUFSICsgKGdpY19pcnEoZCkgLyAzMikgKiA0KTsKIAlpZiAoZ2ljX2FyY2hf
ZXh0bi5pcnFfbWFzaykKIAkJZ2ljX2FyY2hfZXh0bi5pcnFfbWFzayhkKTsKIAlzcGluX3Vu
bG9jaygmaXJxX2NvbnRyb2xsZXJfbG9jayk7CkBAIC0xMDIsNyArMTAyLDcgQEAgc3RhdGlj
IHZvaWQgZ2ljX3VubWFza19pcnEoc3RydWN0IGlycV9kYXRhICpkKQogCXNwaW5fbG9jaygm
aXJxX2NvbnRyb2xsZXJfbG9jayk7CiAJaWYgKGdpY19hcmNoX2V4dG4uaXJxX3VubWFzaykK
IAkJZ2ljX2FyY2hfZXh0bi5pcnFfdW5tYXNrKGQpOwotCXdyaXRlbChtYXNrLCBnaWNfZGlz
dF9iYXNlKGQpICsgR0lDX0RJU1RfRU5BQkxFX1NFVCArIChnaWNfaXJxKGQpIC8gMzIpICog
NCk7CisJd3JpdGVsX3JlbGF4ZWQobWFzaywgZ2ljX2Rpc3RfYmFzZShkKSArIEdJQ19ESVNU
X0VOQUJMRV9TRVQgKyAoZ2ljX2lycShkKSAvIDMyKSAqIDQpOwogCXNwaW5fdW5sb2NrKCZp
cnFfY29udHJvbGxlcl9sb2NrKTsKIH0KIApAQCAtMTE0LDcgKzExNCw3IEBAIHN0YXRpYyB2
b2lkIGdpY19lb2lfaXJxKHN0cnVjdCBpcnFfZGF0YSAqZCkKIAkJc3Bpbl91bmxvY2soJmly
cV9jb250cm9sbGVyX2xvY2spOwogCX0KIAotCXdyaXRlbChnaWNfaXJxKGQpLCBnaWNfY3B1
X2Jhc2UoZCkgKyBHSUNfQ1BVX0VPSSk7CisJd3JpdGVsX3JlbGF4ZWQoZ2ljX2lycShkKSwg
Z2ljX2NwdV9iYXNlKGQpICsgR0lDX0NQVV9FT0kpOwogfQogCiBzdGF0aWMgaW50IGdpY19z
ZXRfdHlwZShzdHJ1Y3QgaXJxX2RhdGEgKmQsIHVuc2lnbmVkIGludCB0eXBlKQpAQCAtMTQw
LDcgKzE0MCw3IEBAIHN0YXRpYyBpbnQgZ2ljX3NldF90eXBlKHN0cnVjdCBpcnFfZGF0YSAq
ZCwgdW5zaWduZWQgaW50IHR5cGUpCiAJaWYgKGdpY19hcmNoX2V4dG4uaXJxX3NldF90eXBl
KQogCQlnaWNfYXJjaF9leHRuLmlycV9zZXRfdHlwZShkLCB0eXBlKTsKIAotCXZhbCA9IHJl
YWRsKGJhc2UgKyBHSUNfRElTVF9DT05GSUcgKyBjb25mb2ZmKTsKKwl2YWwgPSByZWFkbF9y
ZWxheGVkKGJhc2UgKyBHSUNfRElTVF9DT05GSUcgKyBjb25mb2ZmKTsKIAlpZiAodHlwZSA9
PSBJUlFfVFlQRV9MRVZFTF9ISUdIKQogCQl2YWwgJj0gfmNvbmZtYXNrOwogCWVsc2UgaWYg
KHR5cGUgPT0gSVJRX1RZUEVfRURHRV9SSVNJTkcpCkBAIC0xNTAsMTUgKzE1MCwxNSBAQCBz
dGF0aWMgaW50IGdpY19zZXRfdHlwZShzdHJ1Y3QgaXJxX2RhdGEgKmQsIHVuc2lnbmVkIGlu
dCB0eXBlKQogCSAqIEFzIHJlY29tbWVuZGVkIGJ5IHRoZSBzcGVjLCBkaXNhYmxlIHRoZSBp
bnRlcnJ1cHQgYmVmb3JlIGNoYW5naW5nCiAJICogdGhlIGNvbmZpZ3VyYXRpb24KIAkgKi8K
LQlpZiAocmVhZGwoYmFzZSArIEdJQ19ESVNUX0VOQUJMRV9TRVQgKyBlbmFibGVvZmYpICYg
ZW5hYmxlbWFzaykgewotCQl3cml0ZWwoZW5hYmxlbWFzaywgYmFzZSArIEdJQ19ESVNUX0VO
QUJMRV9DTEVBUiArIGVuYWJsZW9mZik7CisJaWYgKHJlYWRsX3JlbGF4ZWQoYmFzZSArIEdJ
Q19ESVNUX0VOQUJMRV9TRVQgKyBlbmFibGVvZmYpICYgZW5hYmxlbWFzaykgeworCQl3cml0
ZWxfcmVsYXhlZChlbmFibGVtYXNrLCBiYXNlICsgR0lDX0RJU1RfRU5BQkxFX0NMRUFSICsg
ZW5hYmxlb2ZmKTsKIAkJZW5hYmxlZCA9IHRydWU7CiAJfQogCi0Jd3JpdGVsKHZhbCwgYmFz
ZSArIEdJQ19ESVNUX0NPTkZJRyArIGNvbmZvZmYpOworCXdyaXRlbF9yZWxheGVkKHZhbCwg
YmFzZSArIEdJQ19ESVNUX0NPTkZJRyArIGNvbmZvZmYpOwogCiAJaWYgKGVuYWJsZWQpCi0J
CXdyaXRlbChlbmFibGVtYXNrLCBiYXNlICsgR0lDX0RJU1RfRU5BQkxFX1NFVCArIGVuYWJs
ZW9mZik7CisJCXdyaXRlbF9yZWxheGVkKGVuYWJsZW1hc2ssIGJhc2UgKyBHSUNfRElTVF9F
TkFCTEVfU0VUICsgZW5hYmxlb2ZmKTsKIAogCXNwaW5fdW5sb2NrKCZpcnFfY29udHJvbGxl
cl9sb2NrKTsKIApAQCAtMTkwLDggKzE5MCw4IEBAIHN0YXRpYyBpbnQgZ2ljX3NldF9hZmZp
bml0eShzdHJ1Y3QgaXJxX2RhdGEgKmQsIGNvbnN0IHN0cnVjdCBjcHVtYXNrICptYXNrX3Zh
bCwKIAogCXNwaW5fbG9jaygmaXJxX2NvbnRyb2xsZXJfbG9jayk7CiAJZC0+bm9kZSA9IGNw
dTsKLQl2YWwgPSByZWFkbChyZWcpICYgfm1hc2s7Ci0Jd3JpdGVsKHZhbCB8IGJpdCwgcmVn
KTsKKwl2YWwgPSByZWFkbF9yZWxheGVkKHJlZykgJiB+bWFzazsKKwl3cml0ZWxfcmVsYXhl
ZCh2YWwgfCBiaXQsIHJlZyk7CiAJc3Bpbl91bmxvY2soJmlycV9jb250cm9sbGVyX2xvY2sp
OwogCiAJcmV0dXJuIDA7CkBAIC0yMjMsNyArMjIzLDcgQEAgc3RhdGljIHZvaWQgZ2ljX2hh
bmRsZV9jYXNjYWRlX2lycSh1bnNpZ25lZCBpbnQgaXJxLCBzdHJ1Y3QgaXJxX2Rlc2MgKmRl
c2MpCiAJY2hhaW5lZF9pcnFfZW50ZXIoY2hpcCwgZGVzYyk7CiAKIAlzcGluX2xvY2soJmly
cV9jb250cm9sbGVyX2xvY2spOwotCXN0YXR1cyA9IHJlYWRsKGNoaXBfZGF0YS0+Y3B1X2Jh
c2UgKyBHSUNfQ1BVX0lOVEFDSyk7CisJc3RhdHVzID0gcmVhZGxfcmVsYXhlZChjaGlwX2Rh
dGEtPmNwdV9iYXNlICsgR0lDX0NQVV9JTlRBQ0spOwogCXNwaW5fdW5sb2NrKCZpcnFfY29u
dHJvbGxlcl9sb2NrKTsKIAogCWdpY19pcnEgPSAoc3RhdHVzICYgMHgzZmYpOwpAQCAtMjcy
LDEzICsyNzIsMTMgQEAgc3RhdGljIHZvaWQgX19pbml0IGdpY19kaXN0X2luaXQoc3RydWN0
IGdpY19jaGlwX2RhdGEgKmdpYywKIAljcHVtYXNrIHw9IGNwdW1hc2sgPDwgODsKIAljcHVt
YXNrIHw9IGNwdW1hc2sgPDwgMTY7CiAKLQl3cml0ZWwoMCwgYmFzZSArIEdJQ19ESVNUX0NU
UkwpOworCXdyaXRlbF9yZWxheGVkKDAsIGJhc2UgKyBHSUNfRElTVF9DVFJMKTsKIAogCS8q
CiAJICogRmluZCBvdXQgaG93IG1hbnkgaW50ZXJydXB0cyBhcmUgc3VwcG9ydGVkLgogCSAq
IFRoZSBHSUMgb25seSBzdXBwb3J0cyB1cCB0byAxMDIwIGludGVycnVwdCBzb3VyY2VzLgog
CSAqLwotCWdpY19pcnFzID0gcmVhZGwoYmFzZSArIEdJQ19ESVNUX0NUUikgJiAweDFmOwor
CWdpY19pcnFzID0gcmVhZGxfcmVsYXhlZChiYXNlICsgR0lDX0RJU1RfQ1RSKSAmIDB4MWY7
CiAJZ2ljX2lycXMgPSAoZ2ljX2lycXMgKyAxKSAqIDMyOwogCWlmIChnaWNfaXJxcyA+IDEw
MjApCiAJCWdpY19pcnFzID0gMTAyMDsKQEAgLTI4NywyNiArMjg3LDI2IEBAIHN0YXRpYyB2
b2lkIF9faW5pdCBnaWNfZGlzdF9pbml0KHN0cnVjdCBnaWNfY2hpcF9kYXRhICpnaWMsCiAJ
ICogU2V0IGFsbCBnbG9iYWwgaW50ZXJydXB0cyB0byBiZSBsZXZlbCB0cmlnZ2VyZWQsIGFj
dGl2ZSBsb3cuCiAJICovCiAJZm9yIChpID0gMzI7IGkgPCBnaWNfaXJxczsgaSArPSAxNikK
LQkJd3JpdGVsKDAsIGJhc2UgKyBHSUNfRElTVF9DT05GSUcgKyBpICogNCAvIDE2KTsKKwkJ
d3JpdGVsX3JlbGF4ZWQoMCwgYmFzZSArIEdJQ19ESVNUX0NPTkZJRyArIGkgKiA0IC8gMTYp
OwogCiAJLyoKIAkgKiBTZXQgYWxsIGdsb2JhbCBpbnRlcnJ1cHRzIHRvIHRoaXMgQ1BVIG9u
bHkuCiAJICovCiAJZm9yIChpID0gMzI7IGkgPCBnaWNfaXJxczsgaSArPSA0KQotCQl3cml0
ZWwoY3B1bWFzaywgYmFzZSArIEdJQ19ESVNUX1RBUkdFVCArIGkgKiA0IC8gNCk7CisJCXdy
aXRlbF9yZWxheGVkKGNwdW1hc2ssIGJhc2UgKyBHSUNfRElTVF9UQVJHRVQgKyBpICogNCAv
IDQpOwogCiAJLyoKIAkgKiBTZXQgcHJpb3JpdHkgb24gYWxsIGdsb2JhbCBpbnRlcnJ1cHRz
LgogCSAqLwogCWZvciAoaSA9IDMyOyBpIDwgZ2ljX2lycXM7IGkgKz0gNCkKLQkJd3JpdGVs
KDB4YTBhMGEwYTAsIGJhc2UgKyBHSUNfRElTVF9QUkkgKyBpICogNCAvIDQpOworCQl3cml0
ZWxfcmVsYXhlZCgweGEwYTBhMGEwLCBiYXNlICsgR0lDX0RJU1RfUFJJICsgaSAqIDQgLyA0
KTsKIAogCS8qCiAJICogRGlzYWJsZSBhbGwgaW50ZXJydXB0cy4gIExlYXZlIHRoZSBQUEkg
YW5kIFNHSXMgYWxvbmUKIAkgKiBhcyB0aGVzZSBlbmFibGVzIGFyZSBiYW5rZWQgcmVnaXN0
ZXJzLgogCSAqLwogCWZvciAoaSA9IDMyOyBpIDwgZ2ljX2lycXM7IGkgKz0gMzIpCi0JCXdy
aXRlbCgweGZmZmZmZmZmLCBiYXNlICsgR0lDX0RJU1RfRU5BQkxFX0NMRUFSICsgaSAqIDQg
LyAzMik7CisJCXdyaXRlbF9yZWxheGVkKDB4ZmZmZmZmZmYsIGJhc2UgKyBHSUNfRElTVF9F
TkFCTEVfQ0xFQVIgKyBpICogNCAvIDMyKTsKIAogCS8qCiAJICogTGltaXQgbnVtYmVyIG9m
IGludGVycnVwdHMgcmVnaXN0ZXJlZCB0byB0aGUgcGxhdGZvcm0gbWF4aW11bQpAQCAtMzI0
LDcgKzMyNCw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBnaWNfZGlzdF9pbml0KHN0cnVjdCBn
aWNfY2hpcF9kYXRhICpnaWMsCiAJCXNldF9pcnFfZmxhZ3MoaSwgSVJRRl9WQUxJRCB8IElS
UUZfUFJPQkUpOwogCX0KIAotCXdyaXRlbCgxLCBiYXNlICsgR0lDX0RJU1RfQ1RSTCk7CisJ
d3JpdGVsX3JlbGF4ZWQoMSwgYmFzZSArIEdJQ19ESVNUX0NUUkwpOwogfQogCiBzdGF0aWMg
dm9pZCBfX2NwdWluaXQgZ2ljX2NwdV9pbml0KHN0cnVjdCBnaWNfY2hpcF9kYXRhICpnaWMp
CkBAIC0zMzcsMTcgKzMzNywxNyBAQCBzdGF0aWMgdm9pZCBfX2NwdWluaXQgZ2ljX2NwdV9p
bml0KHN0cnVjdCBnaWNfY2hpcF9kYXRhICpnaWMpCiAJICogRGVhbCB3aXRoIHRoZSBiYW5r
ZWQgUFBJIGFuZCBTR0kgaW50ZXJydXB0cyAtIGRpc2FibGUgYWxsCiAJICogUFBJIGludGVy
cnVwdHMsIGVuc3VyZSBhbGwgU0dJIGludGVycnVwdHMgYXJlIGVuYWJsZWQuCiAJICovCi0J
d3JpdGVsKDB4ZmZmZjAwMDAsIGRpc3RfYmFzZSArIEdJQ19ESVNUX0VOQUJMRV9DTEVBUik7
Ci0Jd3JpdGVsKDB4MDAwMGZmZmYsIGRpc3RfYmFzZSArIEdJQ19ESVNUX0VOQUJMRV9TRVQp
OworCXdyaXRlbF9yZWxheGVkKDB4ZmZmZjAwMDAsIGRpc3RfYmFzZSArIEdJQ19ESVNUX0VO
QUJMRV9DTEVBUik7CisJd3JpdGVsX3JlbGF4ZWQoMHgwMDAwZmZmZiwgZGlzdF9iYXNlICsg
R0lDX0RJU1RfRU5BQkxFX1NFVCk7CiAKIAkvKgogCSAqIFNldCBwcmlvcml0eSBvbiBQUEkg
YW5kIFNHSSBpbnRlcnJ1cHRzCiAJICovCiAJZm9yIChpID0gMDsgaSA8IDMyOyBpICs9IDQp
Ci0JCXdyaXRlbCgweGEwYTBhMGEwLCBkaXN0X2Jhc2UgKyBHSUNfRElTVF9QUkkgKyBpICog
NCAvIDQpOworCQl3cml0ZWxfcmVsYXhlZCgweGEwYTBhMGEwLCBkaXN0X2Jhc2UgKyBHSUNf
RElTVF9QUkkgKyBpICogNCAvIDQpOwogCi0Jd3JpdGVsKDB4ZjAsIGJhc2UgKyBHSUNfQ1BV
X1BSSU1BU0spOwotCXdyaXRlbCgxLCBiYXNlICsgR0lDX0NQVV9DVFJMKTsKKwl3cml0ZWxf
cmVsYXhlZCgweGYwLCBiYXNlICsgR0lDX0NQVV9QUklNQVNLKTsKKwl3cml0ZWxfcmVsYXhl
ZCgxLCBiYXNlICsgR0lDX0NQVV9DVFJMKTsKIH0KIAogdm9pZCBfX2luaXQgZ2ljX2luaXQo
dW5zaWduZWQgaW50IGdpY19uciwgdW5zaWduZWQgaW50IGlycV9zdGFydCwKQEAgLTM5MSw3
ICszOTEsMTMgQEAgdm9pZCBnaWNfcmFpc2Vfc29mdGlycShjb25zdCBzdHJ1Y3QgY3B1bWFz
ayAqbWFzaywgdW5zaWduZWQgaW50IGlycSkKIHsKIAl1bnNpZ25lZCBsb25nIG1hcCA9ICpj
cHVzX2FkZHIoKm1hc2spOwogCisJLyoKKwkgKiBFbnN1cmUgdGhhdCBzdG9yZXMgdG8gTm9y
bWFsIG1lbW9yeSBhcmUgdmlzaWJsZSB0byB0aGUKKwkgKiBvdGhlciBDUFVzIGJlZm9yZSBp
c3N1aW5nIHRoZSBJUEkuCisJICovCisJZHNiKCk7CisKIAkvKiB0aGlzIGFsd2F5cyBoYXBw
ZW5zIG9uIEdJQzAgKi8KLQl3cml0ZWwobWFwIDw8IDE2IHwgaXJxLCBnaWNfZGF0YVswXS5k
aXN0X2Jhc2UgKyBHSUNfRElTVF9TT0ZUSU5UKTsKKwl3cml0ZWxfcmVsYXhlZChtYXAgPDwg
MTYgfCBpcnEsIGdpY19kYXRhWzBdLmRpc3RfYmFzZSArIEdJQ19ESVNUX1NPRlRJTlQpOwog
fQogI2VuZGlmCi0tIAoxLjYuMC40Cgo=
--------------060305080108070501010303--
