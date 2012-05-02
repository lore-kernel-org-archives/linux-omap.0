From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH-V6 0/3] ARM: OMAP: Make OMAP clocksource source selection
 runtime
Date: Wed, 2 May 2012 14:56:18 -0500
Message-ID: <4FA19162.5040102@ti.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45410 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab2EBT4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 15:56:23 -0400
In-Reply-To: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Vaibhav,

On 05/02/2012 08:56 AM, Vaibhav Hiremath wrote:
> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)
> 
> This patch series cleans up the existing 32k-sync timer implementation,
> movind SoC init code to respective files (mach-omap1/timer32k.c and
> mach-omap2/timer.c) and uses kernel parameter to override the default
> clocksource of "counter_32k", also in order to support some OMAP based
> derivative SoCs like AM33XX which doesn't have 32K sync-timer hardware IP,
> adds hwmod lookup for omap2+ devices, and if lookup fails then
> fall back to gp-timer.
> 
> if(use_gptimer_clksrc == true)
> 	gptimer clocksource init;
> else if (counter_32 init == false)
> 	/* Fallback to gptimer */
> 	gptimer clocksource init(;
> 
> With this, we should be able to support multi-omap boot
> including devices with/without 32k-sync timer.
> 
> This patch-series has been boot tested on AM37xEVM platform, it
> would be helpful if somebody help me to validate it on OMAP1/2
> platforms.
> 
> The patches are also available at (based on linux-omap/master) -
> https://github.com/hvaibhav/am335x-linux   32ksync-timer-cleanup

I was testing on OMAP4 and I found that the gptimer was always being set by default. I noticed that currently the HWMOD for counter_32k on OMAP4 is commented and hence was not being found. Please can you include the following with your series?

Cheers
Jon

>From 2a213a6d5f5894bc1c5262f2724508eaef21c7a5 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Wed, 2 May 2012 14:45:03 -0500
Subject: [PATCH] ARM: OMAP4: Enable counter_32k HWMOD for OMAP4 devices

HWMOD is being used to determine if the 32k sync timer is present in order
to use the timer as the clocksource for the kernel. Enable the counter_32k
HWMOD for OMAP4 devices so that the 32k sync timer will be used by default.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6abc757..f0455d0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5561,7 +5561,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_bandgap_hwmod,
 
 	/* counter class */
-/*	&omap44xx_counter_32k_hwmod, */
+	&omap44xx_counter_32k_hwmod,
 
 	/* dma class */
 	&omap44xx_dma_system_hwmod,
-- 
1.7.5.4
