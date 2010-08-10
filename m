From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: CONFIG_CPU_IDLE broken for N900
Date: Tue, 10 Aug 2010 16:21:26 -0700
Message-ID: <87zkwu3vgp.fsf@deeprootsystems.com>
References: <1281442891.17541.26.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:65418 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0HJXV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 19:21:29 -0400
Received: by pxi10 with SMTP id 10so266813pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 16:21:29 -0700 (PDT)
In-Reply-To: <1281442891.17541.26.camel@chotu> (Ameya Palande's message of
	"Tue, 10 Aug 2010 15:21:31 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ameya Palande <ameya.palande@nokia.com> writes:

> When I enable CONFIG_CPU_IDLE and boot kernel, it hangs around the point
> when it switches to user space. I am able to reproduce this for 2.6.35
> on linux-omap and linux-2.6 trees.
>
> Has anyone else noticed the same thing for omap3 based boards?

I was able to reproduce on my n900 and found the problem.  I believe
this is the same problem that has been haunting the Overo folks in that
their console (on UART2 like n900) was not responding after suspend.

The patch below fixes the problem for me, and will post an official
version shortly.

Tested with l-o master (omap3_defconfig + CONFIG_CPU_IDLE=y) as well
with current PM branch.  PM branch (specifically pm-fixes sub-branch)
has been updated to include this fix.

Kevin


diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fb4994a..7b03426 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -480,7 +480,9 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (omap3_has_io_wakeup() && core_next_state < PWRDM_POWER_ON) {
+	if (omap3_has_io_wakeup() &&
+	    (per_next_state < PWRDM_POWER_ON ||
+	     core_next_state < PWRDM_POWER_ON)) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
-- 
1.7.2.1



