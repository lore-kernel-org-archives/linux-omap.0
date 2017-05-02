From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 1/3] ti-soc-thermal: Use devm_kcalloc() in
 ti_bandgap_build()
Date: Tue, 2 May 2017 09:25:56 +0530
Message-ID: <baec64c7-2cae-dfd8-2f5e-790b2141efc9@ti.com>
References: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
 <071d2e92-0bcc-5ccc-ad28-b05a72538d6b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <071d2e92-0bcc-5ccc-ad28-b05a72538d6b@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 26 April 2017 09:04 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 26 Apr 2017 16:45:25 +0200
> 
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "devm_kcalloc".

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index ba9c302454fb..f19cb7612a65 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1224,8 +1224,8 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
>  		bgp->conf = of_id->data;
>  
>  	/* register shadow for context save and restore */
> -	bgp->regval = devm_kzalloc(&pdev->dev, sizeof(*bgp->regval) *
> -				   bgp->conf->sensor_count, GFP_KERNEL);
> +	bgp->regval = devm_kcalloc(&pdev->dev, bgp->conf->sensor_count,
> +				   sizeof(*bgp->regval), GFP_KERNEL);
>  	if (!bgp->regval) {
>  		dev_err(&pdev->dev, "Unable to allocate mem for driver ref\n");
>  		return ERR_PTR(-ENOMEM);
> 
