From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 06/32] OMAPDSS: DPI: fix regulators for DT
Date: Fri, 7 Jun 2013 11:26:15 +0530
Message-ID: <51B175FF.90804@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-7-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41202 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab3FGF53 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 01:57:29 -0400
In-Reply-To: <1369906493-27538-7-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Thursday 30 May 2013 03:04 PM, Tomi Valkeinen wrote:
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
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dpi.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index ef8fca2..43f6b26 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -37,7 +37,10 @@
>   #include "dss_features.h"
>
>   static struct {
> +	struct platform_device *pdev;

We don't really need to add a new member here for getting the output's 
device pointer. It's already there in dpi.output.dev.

Archit

> +
>   	struct regulator *vdds_dsi_reg;
> +	bool vdds_dsi_from_core;
>   	struct platform_device *dsidev;
>
>   	struct mutex lock;
> @@ -583,10 +586,15 @@ static int dpi_init_display(struct omap_dss_device *dssdev)
>   		struct regulator *vdds_dsi;
>
>   		vdds_dsi = dss_get_vdds_dsi();
> -
>   		if (IS_ERR(vdds_dsi)) {
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
>   		}
>
>   		dpi.vdds_dsi_reg = vdds_dsi;
> @@ -702,6 +710,8 @@ static int omap_dpi_probe(struct platform_device *pdev)
>   {
>   	int r;
>
> +	dpi.pdev = pdev;
> +
>   	mutex_init(&dpi.lock);
>
>   	dpi_init_output(pdev);
> @@ -725,6 +735,11 @@ static int __exit omap_dpi_remove(struct platform_device *pdev)
>
>   	dpi_uninit_output(pdev);
>
> +	if (dpi.vdds_dsi_reg != NULL && dpi.vdds_dsi_from_core == false) {
> +		regulator_put(dpi.vdds_dsi_reg);
> +		dpi.vdds_dsi_reg = NULL;
> +	}
> +
>   	return 0;
>   }
>
>

