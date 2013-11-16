From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is
 not found
Date: Sat, 16 Nov 2013 06:18:53 -0800
Message-ID: <20131116141853.GF10317@atomide.com>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
 <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17851 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab3KPOS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 09:18:58 -0500
Content-Disposition: inline
In-Reply-To: <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131116 05:25]:
> On Device Tree boot the VDDS_DSI regulator is not linked to
> the DPI device so omapfb driver probing fails with:
> 
> [    3.186035] OMAPFB: omapfb_probe
> [    3.190704] omapdss DPI error: can't get VDDS_DSI regulator
> [    3.196594] omapfb omapfb: failed to connect default display
> [    3.202667] omapfb omapfb: failed to init overlay connections
> [    3.208892] OMAPFB: free_resources
> [    3.212493] OMAPFB: free all fbmem
> [    3.216735] omapfb omapfb: failed to setup omapfb
> 
> As a workaround try to use the VPLL2 regulator from twl4030 in
> dpi_init_regulator() if getting the VDDS_DSI regulator fails.

Probably makes sens to fix this in the dpi.c, but this can also be set
in the .dts file. I just set up the following in the omap3-ldp.dts file:

&vaux1 {
	/* Needed for ads7846 */
	regulator-name = "vcc";
};

&vpll2 {
	/* Needed for DSS */
	regulator-name = "vdds_dsi";
};

Regards,

Tony

 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/video/omap2/dss/dpi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index bd48cde..e328f0b 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -550,6 +550,11 @@ static int dpi_init_regulator(void)
>  		return 0;
>  
>  	vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "vdds_dsi");
> +
> +        /* DT HACK: try VPLL2 to make omapdss work for OMAP3 IGEPv2 */
> +        if (IS_ERR(vdds_dsi))
> +                vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "VPLL2");
> +
>  	if (IS_ERR(vdds_dsi)) {
>  		DSSERR("can't get VDDS_DSI regulator\n");
>  		return PTR_ERR(vdds_dsi);
> -- 
> 1.8.4.2
> 
