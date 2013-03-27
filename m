From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 05/26] OMAPDSS: DPI: fix regulators
Date: Wed, 27 Mar 2013 15:27:08 +0530
Message-ID: <5152C274.4070901@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com> <1364304836-18134-6-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51542 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab3C0J5z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 05:57:55 -0400
In-Reply-To: <1364304836-18134-6-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 26 March 2013 07:03 PM, Tomi Valkeinen wrote:
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
>   drivers/video/omap2/dss/dpi.c |   21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index ad67a9c..08342d1 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -37,7 +37,10 @@
>   #include "dss_features.h"
>
>   static struct {
> +	struct platform_device *pdev;

We can use dpi.output.pdev, we don't really need to have another pdev 
pointer. Same for SDI in the next patch.

Archit

> +
>   	struct regulator *vdds_dsi_reg;
> +	bool vdds_dsi_from_core;
>   	struct platform_device *dsidev;
>
>   	struct mutex lock;
> @@ -583,10 +586,15 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
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
> @@ -698,6 +706,8 @@ static void __exit dpi_uninit_output(struct platform_device *pdev)
>
>   static int __init omap_dpi_probe(struct platform_device *pdev)
>   {
> +	dpi.pdev = pdev;
> +
>   	mutex_init(&dpi.lock);
>
>   	dpi_init_output(pdev);
> @@ -714,6 +724,11 @@ static int __exit omap_dpi_remove(struct platform_device *pdev)
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

