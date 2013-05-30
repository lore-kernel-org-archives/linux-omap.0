From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 06/32] OMAPDSS: DPI: fix regulators for DT
Date: Thu, 30 May 2013 13:12:53 +0200
Message-ID: <20130530111253.GJ19468@game.jcrosoft.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
 <1369906493-27538-7-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:44015 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751113Ab3E3LeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 07:34:00 -0400
Received: from mail624.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id D4ADAFFADB5
	for <linux-omap@vger.kernel.org>; Thu, 30 May 2013 13:17:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1369906493-27538-7-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
> On some platforms DPI requires a regulator to be enabled to power up the
> output pins. This regulator is, for some reason, currently attached to
> the virtual omapdss device, instead of the DPI device. This does not
> work for DT, as the regulator mappings need to be described in the DT
> data, and the virtual omapdss device is not present there.
> 
> Fix the issue by acquiring the regulator in the DPI device. To retain
> compatibility with the current board files, the old method of getting
> the regulator is kept. The old method can be removed when the board
> files have been changed to pass the regulator to DPI.

as discuss with Arnd we should handle regular enable and disable at device
probe for every device as we do for pinctrl

Best Regards,
J.
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/dpi.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index ef8fca2..43f6b26 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -37,7 +37,10 @@
>  #include "dss_features.h"
>  
>  static struct {
> +	struct platform_device *pdev;
> +
>  	struct regulator *vdds_dsi_reg;
> +	bool vdds_dsi_from_core;
>  	struct platform_device *dsidev;
>  
>  	struct mutex lock;
> @@ -583,10 +586,15 @@ static int dpi_init_display(struct omap_dss_device *dssdev)
>  		struct regulator *vdds_dsi;
>  
>  		vdds_dsi = dss_get_vdds_dsi();
> -
>  		if (IS_ERR(vdds_dsi)) {
> -			DSSERR("can't get VDDS_DSI regulator\n");
> -			return PTR_ERR(vdds_dsi);
> +			vdds_dsi = regulator_get(&dpi.pdev->dev, "vdds_dsi");
> +			if (IS_ERR(vdds_dsi)) {
> +				DSSERR("can't get VDDS_DSI regulator\n");
> +				return PTR_ERR(vdds_dsi);
> +			}
> +			dpi.vdds_dsi_from_core = false;
> +		} else {
> +			dpi.vdds_dsi_from_core = true;
>  		}
>  
>  		dpi.vdds_dsi_reg = vdds_dsi;
> @@ -702,6 +710,8 @@ static int omap_dpi_probe(struct platform_device *pdev)
>  {
>  	int r;
>  
> +	dpi.pdev = pdev;
> +
>  	mutex_init(&dpi.lock);
>  
>  	dpi_init_output(pdev);
> @@ -725,6 +735,11 @@ static int __exit omap_dpi_remove(struct platform_device *pdev)
>  
>  	dpi_uninit_output(pdev);
>  
> +	if (dpi.vdds_dsi_reg != NULL && dpi.vdds_dsi_from_core == false) {
> +		regulator_put(dpi.vdds_dsi_reg);
> +		dpi.vdds_dsi_reg = NULL;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
