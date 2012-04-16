From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/3] ARM: OMAP2+: dmtimer: cleanup related to devm API
 and clk usage
Date: Mon, 16 Apr 2012 14:53:20 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9EE723@DBDE01.ent.ti.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47323 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab2DPOx2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 10:53:28 -0400
In-Reply-To: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Mon, Apr 16, 2012 at 17:55:22, DebBarma, Tarun Kanti wrote:
> The devm API usage in probe() simplifies error handling operation.
> Since iclk is not used in the driver it is removed from wherever
> not needed. The fclk naming is made uniform as per OMAP4 platform,
> viz. "timer1_fck", "timer2_fck", ... in all relevant places which
> include hwmod database. With this change there is no more need to
> construct clock names using sprintf() to be used in clk_get()
> during initialization. Instead we can use oh->main_clk directly.
> 
Correct me if I am wrong here, I believe there is no relation between 
naming of clock and sprintf; with the existing code you can still use
oh>main_clk, isn't it?

Below code alone should work right, so that driver code is becomes 
independent of clock name.

-	sprintf(name, "gpt%d_fck", gptimer_id);
-	timer->fclk = clk_get(NULL, name);
+	timer->fclk = clk_get(NULL, oh->main_clk);


Thanks,
Vaibhav

> Reference:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Commit: e816b57a337ea3b755de72bec38c10c864f23015 (Linux 3.4-rc3)
> 
> Series is available here for reference:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev dmtimer_cleanup_for_3.5
> 
> Tested on following platforms:
> OMAP4430SDP, OMAP3430SDP, OMAP2430SDP.
> Could not test on OMAP2420 due to unavailability of board.
> 
> Tarun Kanti DebBarma (3):
>   ARM: OMAP: dmtimer: Use devm_ API and do some cleanup in probe()
>   ARM: OMAP2+: dmtimer: cleanup iclk usage
>   ARM: OMAP2+: dmtimer: cleanup fclk usage
> 
>  arch/arm/mach-omap2/clock2420_data.c       |   72 ++++++++++++++--------------
>  arch/arm/mach-omap2/clock2430_data.c       |   72 ++++++++++++++--------------
>  arch/arm/mach-omap2/clock3xxx_data.c       |   72 ++++++++++++++--------------
>  arch/arm/mach-omap2/clock44xx_data.c       |   33 ++++--------
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   24 +++++-----
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   24 +++++-----
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   24 +++++-----
>  arch/arm/mach-omap2/timer.c                |   10 +----
>  arch/arm/plat-omap/dmtimer.c               |   51 +++++++------------
>  arch/arm/plat-omap/include/plat/dmtimer.h  |    2 +-
>  10 files changed, 176 insertions(+), 208 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

