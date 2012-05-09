From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM address space.
Date: Wed, 9 May 2012 14:20:28 +0530
Message-ID: <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508124116.GE17798@arm.com> <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
 <20120508215554.GA18980@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:32982 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755263Ab2EIIuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 04:50:51 -0400
Received: by qaeb19 with SMTP id b19so1626702qae.18
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 01:50:49 -0700 (PDT)
In-Reply-To: <20120508215554.GA18980@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Wed, May 9, 2012 at 3:25 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, May 08, 2012 at 07:31:57PM +0530, Shilimkar, Santosh wrote:
>> Ok. Assuming you mean " it's _not_ cleaner to have two domains where
>> manager overrides XN attributes" Note that DRAM can be in the middle of
>> 4GB address space, so we need to take care of bottom and top address
>> space.
>>
>> Update patch end of the email. Is that fine with you ?
>
> This is certainly not cleaner because this will break non-ARMv7.

The only change done common code is  clearing 'XN' bit for DRAM
region in page table entries. The other change of setting the DACR
register is done in ARMv7 specific code.

So it should work as long as XN bit supported or that
bit position is not used. I checked ARMv6(OMAP2) and that seems
to be fine.

Can you please help me to understand which ARM version will
be broken because of this change and how ? I only have access
to ARMv6 and ARMv7 specs.

The updated patch looks like below after fixing last comments from
Catalin.

Regards
Santosh

>From a52613d1adc38651bf0fb824700efeb2fa02f1a2 Mon Sep 17 00:00:00 2001
From: R Sricharan <r.sricharan@ti.com>
Date: Mon, 7 May 2012 15:11:58 +0530
Subject: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM address
 space.

ARM decompressor code setups entire 4GB address space pages.
Out of the 4GB, about 256MB are setup with normal memory attributes
for needed DRAM and the rest of the address space as Strongly ordered.

But since all the sections are mapped in DOMAIN0(Manager), processor
like Cortex-A15, can speculatively prefetch from non-DRAM read sensitive
areas even in the presence of XN(Non-executable). This is because XN
attribute is ignored when domain is Manager.

This can lead to accesses to non-accessible address regions leading
to various interconnect violations. The issue is observed on OMAP5.

This patch tries to fix the issue by ensuring that all regions
are marked as a client domain so that XN attribute is effective.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/boot/compressed/head.S |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index dc7e8ce..0faadf8 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -578,10 +578,11 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
 		mov	r9, r0, lsr #18
 		mov	r9, r9, lsl #18		@ start of RAM
 		add	r10, r9, #0x10000000	@ a reasonable RAM size
-		mov	r1, #0x12
+		mov	r1, #0x12		@ Default executable section
 		orr	r1, r1, #3 << 10
 		add	r2, r3, #16384
 1:		cmp	r1, r9			@ if virt > start of RAM
+		bichs	r1, r1, #0x10		@ clear XN for DRAM
 #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
 		orrhs	r1, r1, #0x08		@ set cacheable
 #else
@@ -589,6 +590,7 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
 #endif
 		cmp	r1, r10			@ if virt > end of RAM
 		bichs	r1, r1, #0x0c		@ clear cacheable, bufferable
+		orrhs	r1, r1, #0x10		@ Mark XN for non DRAM
 		str	r1, [r0], #4		@ 1:1 mapping
 		add	r1, r1, #1048576
 		teq	r0, r2
@@ -599,7 +601,7 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
  * so there is no map overlap problem for up to 1 MB compressed kernel.
  * If the execution is in RAM then we would only be duplicating the above.
  */
-		mov	r1, #0x1e
+		mov	r1, #0x0e		@ Clear XN
 		orr	r1, r1, #3 << 10
 		mov	r2, pc
 		mov	r2, r2, lsr #20
@@ -658,6 +660,9 @@ __armv7_mmu_cache_on:
 		movne	r1, #-1
 		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
 		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
+		bic	r1, r1, #0x03		@ Clear domain0 bits
+		orr	r1, r1, #0x01		@ Set domain0 as client
+		mcr	p15, 0, r1, c3, c0, 0
 #endif
 		mcr	p15, 0, r0, c7, c5, 4	@ ISB
 		mcr	p15, 0, r0, c1, c0, 0	@ load control register
-- 
1.7.5.4
