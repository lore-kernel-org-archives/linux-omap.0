From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Wed, 14 Nov 2012 14:21:59 -0800
Message-ID: <20121114222159.GB6801@atomide.com>
References: <20121114185335.GU6801@atomide.com>
 <50A3EBCD.3040801@ti.com>
 <20121114202244.GE3332@n2100.arm.linux.org.uk>
 <20121114203221.GA6801@atomide.com>
 <50A413D4.7000405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54413 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423429Ab2KNWWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 17:22:08 -0500
Content-Disposition: inline
In-Reply-To: <50A413D4.7000405@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rob Herring <robherring2@gmail.com> [121114 13:59]:
> On 11/14/2012 02:32 PM, Tony Lindgren wrote:
> > 
> > Checking for the bit already set should work in this case, I'll post
> > a patch for that shortly.
> 
> Can you actually read the state of the diagnostic register in non-secure
> mode? If you can on the A9, is the same true on A8 or others?

Looks like it can be read on at least TI omap 4430 which is A9.
But it reads as zero, so the below patch is what I came up with.

No idea if assuming that zero value for the diagnostic register
is safe.. What's the default value of the diagnostic register supposed
to be?
 
> Multi-platform kernels present a new problem in that we basically need
> to enable all errata work-arounds. I've been meaning to look thru the
> errata work-arounds to figure out which ones can be selected for
> multi-platform kernels without side effects on unaffected parts (i.e.
> set a chicken bit based on core revision). For any in runtime paths, we
> may need to do runtime patching if they have performance impact.

Yeah that's how I ran into it as multiplatform enabled omap booted
on other omaps but not on omap4.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 13 Nov 2012 16:57:42 -0800
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 for secure mode

Looks like enabling CONFIG_ARM_ERRATA_751472 causes TI omap4 blaze
to not boot when enabled. The ARM core on it is an earlier r1p2.

This seems to be caused by the write to the diagnostic register
that shortly after causes an exception as writing to the diagnostic
register on systems with secure mode is not allowed.

Also it seems that reading the diagnostic register results zero
so we may not be able to check if bit #11 is already set.

Let's assume that if the diagnostic register is zero, we don't
want to touch it as it seems to hint secure mode at least on
TI omaps. If it's non-zero, check if bit #11 is set and only
attempt to set it if not set.

--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -238,9 +238,13 @@ __v7_setup:
 #if defined(CONFIG_ARM_ERRATA_751472) && defined(CONFIG_SMP)
 	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0
 	ALT_UP_B(1f)
-	mrclt	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orrlt	r10, r10, #1 << 11		@ set bit #11
-	mcrlt	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	bge	1f				@ not needed for r3p0 and later
+	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	teq	r10, #0				@ zero for secure mode?
+	beq	1f				@ bail out for secure mode
+	tst	r10, #1 << 11			@ bit #11 already set?
+	orreq	r10, r10, #1 << 11		@ set bit #11 if not set
+	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 1:
 #endif
 
