From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Thu, 8 May 2014 16:20:07 -0700
Message-ID: <20140508232006.GG2198@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16464 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683AbaEHXUM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 19:20:12 -0400
Content-Disposition: inline
In-Reply-To: <1398815562-24113-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com

* Tony Lindgren <tony@atomide.com> [140429 16:53]:
> Otherwise we can get often errors like the following and the
> display won't come on:
> 
> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
> the output with video overlays disabled
> 
> There are some earlier references to this issue:
> 
> http://www.spinics.net/lists/linux-omap/msg59511.html
> http://www.spinics.net/lists/linux-omap/msg59724.html
> 
> It seems that it's safe to set the lower values even for 3630.
> If we can confirm that 3630 works with the higher values
> reliably we can add further detection.

BTW, I'm also seeing this warning on 3730-evm it may be related:

[    3.523101] ------------[ cut here ]------------
[    3.528015] WARNING: CPU: 0 PID: 6 at drivers/video/fbdev/omap2/dss/dss.c:483 dss_set_fck_rate+0x6c/0x8c()
[    3.538360] clk rate mismatch: 108000000 != 115200000
[    3.543518] Modules linked in:
[    3.546966] CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G        W     3.15.0-rc3-00015-gaa296fa-dirty #391
[    3.557159] Workqueue: deferwq deferred_probe_work_func
[    3.562774] [<c0014cbc>] (unwind_backtrace) from [<c001191c>] (show_stack+0x10/0x14)
[    3.571014] [<c001191c>] (show_stack) from [<c05660b4>] (dump_stack+0x80/0x9c)
[    3.578704] [<c05660b4>] (dump_stack) from [<c003f558>] (warn_slowpath_common+0x68/0x8c)
[    3.587249] [<c003f558>] (warn_slowpath_common) from [<c003f610>] (warn_slowpath_fmt+0x30/0x40)
[    3.596496] [<c003f610>] (warn_slowpath_fmt) from [<c03129f0>] (dss_set_fck_rate+0x6c/0x8c)
[    3.605407] [<c03129f0>] (dss_set_fck_rate) from [<c0323728>] (dpi_display_enable+0x23c/0x2e4)
[    3.614562] [<c0323728>] (dpi_display_enable) from [<c03323a8>] (sharp_ls_enable+0x58/0xc4)
[    3.623474] [<c03323a8>] (sharp_ls_enable) from [<c0335ee0>] (omapfb_probe+0x548/0x848)
[    3.631988] [<c0335ee0>] (omapfb_probe) from [<c0378cfc>] (platform_drv_probe+0x18/0x48)
[    3.640594] [<c0378cfc>] (platform_drv_probe) from [<c0377938>] (driver_probe_device+0x110/0x22c)
[    3.650024] [<c0377938>] (driver_probe_device) from [<c0376038>] (bus_for_each_drv+0x44/0x8c)
[    3.659088] [<c0376038>] (bus_for_each_drv) from [<c03777f0>] (device_attach+0x74/0x8c)
[    3.667541] [<c03777f0>] (device_attach) from [<c0376ecc>] (bus_probe_device+0x88/0xb0)
[    3.676025] [<c0376ecc>] (bus_probe_device) from [<c03772d0>] (deferred_probe_work_func+0x64/0x94)
[    3.685546] [<c03772d0>] (deferred_probe_work_func) from [<c0057220>] (process_one_work+0x1b4/0x4bc)
[    3.695251] [<c0057220>] (process_one_work) from [<c0057908>] (worker_thread+0x11c/0x398)
[    3.704620] [<c0057908>] (worker_thread) from [<c005df10>] (kthread+0xc8/0xe4)
[    3.712280] [<c005df10>] (kthread) from [<c000e768>] (ret_from_fork+0x14/0x2c)
[    3.719909] ---[ end trace 1c9526c1a2975498 ]---

 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/video/fbdev/omap2/dss/dss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
> index d55266c..ad6561f 100644
> --- a/drivers/video/fbdev/omap2/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/dss/dss.c
> @@ -707,9 +707,10 @@ static const struct dss_features omap34xx_dss_feats __initconst = {
>  	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
>  };
>  
> +/* Supposedly 3630 can use div 32 mult 2, but that needs to be rechecked */
>  static const struct dss_features omap3630_dss_feats __initconst = {
> -	.fck_div_max		=	32,
> -	.dss_fck_multiplier	=	1,
> +	.fck_div_max		=	16,
> +	.dss_fck_multiplier	=	2,
>  	.parent_clk_name	=	"dpll4_ck",
>  	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
>  };
> -- 
> 1.8.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
