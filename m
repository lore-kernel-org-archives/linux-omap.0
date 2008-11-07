From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: LCD: Use omap_rev check
Date: Fri, 7 Nov 2008 11:55:01 -0800
Message-ID: <20081107195501.GJ21736@atomide.com>
References: <A24693684029E5489D1D202277BE894413B3903C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62609 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYKGTzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 14:55:07 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894413B3903C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hyau@mvista.com" <hyau@mvista.com>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [081107 08:09]:
> From: Sergio Aguirre <saaguirre@ti.com>
> 
> OMAP: LCD: Use omap_rev check
> 
> This patch fixes correct detection of OMAP revision for
> LCD driver. This makes Tux look correct on my ES3 SDP board.

Thanks, pushing.

Tony


> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  drivers/video/omap/lcd_2430sdp.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-2.6/drivers/video/omap/lcd_2430sdp.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/video/omap/lcd_2430sdp.c
> +++ linux-omap-2.6/drivers/video/omap/lcd_2430sdp.c
> @@ -88,7 +88,7 @@ static int sdp2430_panel_enable(struct l
>                 grp_reg = TWL4030_VAUX3_DEV_GRP;
>                 grp_val = ENABLE_VAUX3_DEV_GRP;
> 
> -               if (system_rev > OMAP3430_REV_ES1_0) {
> +               if (omap_rev() > OMAP3430_REV_ES1_0) {
>                         t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
>                                         TWL4030_VPLL2_DEDICATED);
>                         t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
> @@ -116,7 +116,7 @@ static void sdp2430_panel_disable(struct
>  {
>         omap_set_gpio_dataout(enable_gpio, 0);
>         omap_set_gpio_dataout(backlight_gpio, 0);
> -       if (system_rev > OMAP3430_REV_ES1_0) {
> +       if (omap_rev() > OMAP3430_REV_ES1_0) {
>                 t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
>                 t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
>                 mdelay(4);
> 
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
