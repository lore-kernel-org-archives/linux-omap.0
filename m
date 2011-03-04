From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of individual
 hwmods
Date: Fri, 4 Mar 2011 17:39:27 +0100
Message-ID: <4D7115BF.7000009@ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <4D651998.3040002@ti.com> <alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com> <4D6B845A.9000900@ti.com> <20110302175422.GY20560@atomide.com> <4D6F7723.5040001@ti.com> <4D70FC5B.9040701@ti.com> <20110304161933.GV20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46918 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759739Ab1CDQje (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 11:39:34 -0500
In-Reply-To: <20110304161933.GV20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On 3/4/2011 5:19 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110304 06:49]:
>>
>> Tony,
>> Do you plan to re-merge this branch or should I just send a revert
>> on top of it?
> 
> Please just provide a patch.
> 
> Regards,
> 
> Tony

I posted it with the one from Rajendra to fix the regression with Santosh's series, but I do need Santosh to rebase and re-test the second one.

Meanwhile, here is the revert.

Benoit

---
>From aa22c44486c12c388eb96e9fe9b1476267856006 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 4 Mar 2011 16:01:43 +0100
Subject: [PATCH 1/2] Revert "OMAP4: hwmod data: Prevent timer1 to be reset and idle during init"

The following commit: 38698be:
OMAP2+: clockevent: set up GPTIMER clockevent hwmod right before timer init

Fixed properly the issue with early init for the timer1

So reverts commit 3b03b58dab847883e6b9a431558c7d8e43fa94c6 that is now
generated a warning at boot time.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7dbcdf7..7b72316 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4005,7 +4005,6 @@ static struct omap_hwmod_ocp_if *omap44xx_timer1_slaves[] = {
 static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_timer1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
 	.main_clk	= "timer1_fck",
-- 
1.7.0.4

