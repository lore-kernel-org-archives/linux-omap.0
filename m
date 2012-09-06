From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 00/10] ARM: OMAP: DMTIMER fixes and clean-up
Date: Thu, 6 Sep 2012 18:28:19 +0530
Message-ID: <50489DEB.9010709@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37908 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911Ab2IFM6d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Sep 2012 08:58:33 -0400
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>



On 9/6/2012 12:34 AM, Jon Hunter wrote:
> This series includes several fixes for the OMAP DMTIMER driver and a few
> clean-ups to simplify some of the code. This series is based upon 3.6-rc4.
> 
> Tested on OMAP5912 OSK, OMAP2420 H4, OMAP3430 Beagle and OMAP4430 Panda.
> Testing includes ...
> 1. Booting kernel on above boards
> 2. Set date and ensuring time of day is correct after 24 hours
> 3. Checking the timer counter is incrementing when configuring and starting
>    a timer
> 4. Checking the timer overflow interrupt when timer expires.
> 5. Using different clock sources to operate the timer with.
> 6. Running a loop test overnight that continually runs test #3 and #4 for
>    each available timer
> 

On the other hand I have validated this patch-series on both AM37xEVM
and BeagleBone platform. I used the test code which you shared with me
to validate it.

AM33XX Clock tree needs minor change here,

diff --git a/arch/arm/mach-omap2/clock33xx_data.c
b/arch/arm/mach-omap2/clock33xx_data.c
index a4006b2..daa36a5 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1070,6 +1070,8 @@ static struct omap_clk am33xx_clks[] = {
        CLK(NULL,       "gfx_fck_div_ck",       &gfx_fck_div_ck,
CK_AM33XX),
        CLK(NULL,       "sysclkout_pre_ck",     &sysclkout_pre_ck,
CK_AM33XX),
        CLK(NULL,       "clkout2_ck",           &clkout2_ck,    CK_AM33XX),
+       CLK(NULL,       "timer_32k_ck",         &clkdiv32k_ick, CK_AM33XX),
+       CLK(NULL,       "timer_sys_ck",         &sys_clkin_ck,  CK_AM33XX),
 };

 int __init am33xx_clk_init(void)


Thanks,
Vaibhav

> Jon Hunter (10):
>   ARM: OMAP3+: Implement timer workaround for errata i103 and i767
>   ARM: OMAP: Fix timer posted mode support
>   ARM: OMAP3: Correct HWMOD DMTIMER SYSC register declarations
>   ARM: OMAP2/3: Define HWMOD software reset status for DMTIMERs
>   ARM: OMAP2+: Don't use __omap_dm_timer_reset()
>   ARM: OMAP: Fix dmtimer reset for timer1
>   ARM: OMAP: Clean-up dmtimer reset code
>   ARM: OMAP: Clean-up timer posted mode support
>   ARM: OMAP: Add dmtimer interrupt disable function
>   ARM: OMAP: Remove unnecessary call to clk_get()
> 
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   15 ++-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   41 ++++----
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    4 +
>  arch/arm/mach-omap2/timer.c                        |   27 +++--
>  arch/arm/plat-omap/dmtimer.c                       |  109 +++++++++++++-------
>  arch/arm/plat-omap/include/plat/dmtimer.h          |   95 ++++++++++-------
>  6 files changed, 184 insertions(+), 107 deletions(-)
> 
