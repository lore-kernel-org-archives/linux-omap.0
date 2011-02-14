From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v4 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Mon, 14 Feb 2011 13:17:51 +0000
Message-ID: <20110214131750.GA2869@arm.com>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
 <87pqqy6tdj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46759 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab1BNNSA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 08:18:00 -0500
Received: by wwa36 with SMTP id 36so4856390wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 05:17:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87pqqy6tdj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Fri, Feb 11, 2011 at 03:31:20PM -0800, Kevin Hilman wrote:
> Hi Dave,
> 
> Dave Martin <dave.martin@linaro.org> writes:
> 
> > This set of patches, along with some other patches under
> > discussion on alkml, should enable omap3 and omap4 kernels to be
> > built with CONFIG_THUMB2_KERNEL.
> 
> OK, I tried some more testing with your 'dirty' branch merged with my PM
> branch.
> 
> Compiled in ARM mode, everything worked as expected on my 3530/omap3evm,
> including off-mode (in suspend and idle).  My 3630 (Zoom3) also can't do
> CORE off due to i583, but MPU, PER etc. all can hit off.
> 
> To rebuild in Thumb-2 mode, I disabled OMAP2 support and added Thumb-2
> mode:
> 
>    CONFIG_ARCH_OMAP2=n
>    CONFIG_THUMB2_KERNEL=y
> 
> then tested on 3530/omap3evm.  Testing suspend/resume to retention
> seemed to work fine.  However, enabling retention during idle[1] hung
> someplace (didn't debug further.)
> 
> I also tried off-mode, and suspend/resume to off didn't even work.
> 
> I didn't have time to debug this any further, so this is just to report
> raw test results.

Thanks, that's a useful step forward anyhow.

A possibility is that the Secure firmware can't cope with
interoperating with Thumb-2 code in the kernel, so that wakeup
entry points the SMC call sites may need to be ARM code.

If you get a moment, if would be interesting to see if this
patch makes a difference ... in the meantime, I'll see if
I can get my hands on an EVM from somewhere.

Cheers
---Dave

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index a204c78..ee1edb1 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -32,6 +32,14 @@
 #include "sdrc.h"
 #include "control.h"
 
+#undef ARM
+#undef THUMB
+#undef BSYM
+#define ARM(x...) x
+#define THUMB(x...)
+#define BSYM(x) (x)
+	.arm
+
 /*
  * Registers access definitions
  */
@@ -289,8 +297,20 @@ clean_l2:
 	 *  - should be faster and will change with kernel
 	 *  - 'might' have to copy address, load and jump to it
 	 */
+#ifdef CONFIG_THUMB2_KERNEL
+	/* kernel is non-interworking : must do this from Thumb */
+	adr	r1, . + 1
+	bx	r1
+	.thumb
+#endif
 	ldr	r1, kernel_flush
 	blx	r1
+#ifdef CONFIG_THUMB2_KERNEL
+	.align
+	bx	pc
+	nop
+	.arm
+#endif
 
 omap3_do_wfi:
 	ldr	r4, sdrc_power		@ read the SDRC_POWER register
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 829d235..64faab8 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -34,6 +34,14 @@
 #include "sdrc.h"
 #include "cm2xxx_3xxx.h"
 
+#undef ARM
+#undef THUMB
+#undef BSYM
+#define ARM(x...) x
+#define THUMB(x...)
+#define BSYM(x) (x)
+	.arm
+
 	.text
 
 /* r1 parameters */
-- 
1.7.1

