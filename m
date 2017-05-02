From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 2/3] ti-soc-thermal: Delete error messages for failed
 memory allocations in ti_bandgap_build()
Date: Tue, 2 May 2017 09:22:40 +0530
Message-ID: <f3fe19c4-f31b-6992-838a-d93947c8f780@ti.com>
References: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
 <65329026-ad0d-df20-1ff6-4befab001b3c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65329026-ad0d-df20-1ff6-4befab001b3c@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-omap@vger.kernel.org



On Wednesday 26 April 2017 09:07 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 26 Apr 2017 17:03:07 +0200
> 
> The script "checkpatch.pl" pointed information out like the following.
> 
> WARNING: Possible unnecessary 'out of memory' message
> 
> Thus remove such statements here.

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index f19cb7612a65..109fb0a5f19f 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1217,7 +1217,5 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
> -	if (!bgp) {
> -		dev_err(&pdev->dev, "Unable to allocate mem for driver ref\n");
> +	if (!bgp)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	of_id = of_match_device(of_ti_bandgap_match, &pdev->dev);
>  	if (of_id)
> @@ -1229,7 +1227,5 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
> -	if (!bgp->regval) {
> -		dev_err(&pdev->dev, "Unable to allocate mem for driver ref\n");
> +	if (!bgp->regval)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	i = 0;
>  	do {
> 
