From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP3xxx: clockdomain: fix software supervised wakeup/sleep
Date: Mon, 30 Jul 2012 23:41:12 -0500
Message-ID: <501761E8.3030307@ti.com>
References: <alpine.DEB.2.00.1207261503290.14468@utopia.booyaka.com> <50122A75.2030108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36809 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891Ab2GaElN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 00:41:13 -0400
In-Reply-To: <50122A75.2030108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul, Rajendra,

On 07/27/2012 12:43 AM, Rajendra Nayak wrote:
> On Friday 27 July 2012 02:34 AM, Paul Walmsley wrote:
>>
>> Commit 4da71ae6 ("OMAP: clockdomain: Arch specific funcs for
>> clkdm_clk_enable/disable") called the OMAP2xxx-specific functions for
>> clockdomain wakeup and sleep.  This would probably have broken
>> software-supervised clockdomain wakeup and sleep on OMAP3.
> 
> Its strange this went unnoticed for so long. Thanks for this fix and
> sorry about introducing the bug in the first place.

Any chance that's because of the following code? I needed to
remove this to get the EMU clock domain to turn off on OMAP3
whilst testing PMU.

Cheers
Jon

commit a0307bd539ecef976793679a1c4ff0d47b22c4bd
Author: Jon Hunter <jon-hunter@ti.com>
Date:   Mon Jul 30 18:04:06 2012 -0500

    ARM: OMAP2/3: Allow HWMOD to disable clock domains
    
    Currently when HWMOD attempts to disable a clock domain on OMAP2/3 devices we
    will return from the function clkdm_hwmod_disable() without actually disabling
    the clock domain. Per the comment this is deliberate because initially HWMOD
    OMAP2/3 devices did not support clock domains. However, clock domains are now
    supported by HWMOD for these devices and so allow HWMOD to disable the clock
    domains.
    
    XXX - Tested on OMAP3430 beagle board, but needs more testing on OMAP2/3

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 011186f..8f7a941 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1075,10 +1075,6 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
  */
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
 {
-       /* The clkdm attribute does not exist yet prior OMAP4 */
-       if (cpu_is_omap24xx() || cpu_is_omap34xx())
-               return 0;
-
        /*
         * XXX Rewrite this code to maintain a list of enabled
         * downstream hwmods for debugging purposes?

