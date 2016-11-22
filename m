From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] Input: twl4030-vibra: remove legacy pdata support
Date: Tue, 22 Nov 2016 13:19:36 +0200
Message-ID: <d30d4cca-9fcf-befa-0389-1aafaef99ce8@ti.com>
References: <1479812398-1122-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1479812398-1122-1-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-input-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Belisko <marek@goldelico.com>, Baruch Siach <baruch@tkos.co.il>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org



On 11/22/2016 12:59 PM, Nicolae Rosia wrote:
> Remove dead code since all users are device tree enabled.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
> ---
>  drivers/input/misc/twl4030-vibra.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
> index caa5a62..5acc241 100644
> --- a/drivers/input/misc/twl4030-vibra.c
> +++ b/drivers/input/misc/twl4030-vibra.c
> @@ -177,12 +177,8 @@ static int __maybe_unused twl4030_vibra_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(twl4030_vibra_pm_ops,
>  			 twl4030_vibra_suspend, twl4030_vibra_resume);
>  
> -static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
> -			      struct device_node *node)
> +static bool twl4030_vibra_check_coexist(struct device_node *node)
>  {
> -	if (pdata && pdata->coexist)
> -		return true;
> -
>  	node = of_find_node_by_name(node, "codec");
>  	if (node) {
>  		of_node_put(node);
> @@ -194,13 +190,12 @@ static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
>  
>  static int twl4030_vibra_probe(struct platform_device *pdev)
>  {
> -	struct twl4030_vibra_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct device_node *twl4030_core_node = pdev->dev.parent->of_node;
>  	struct vibra_info *info;
>  	int ret;
>  
> -	if (!pdata && !twl4030_core_node) {
> -		dev_dbg(&pdev->dev, "platform_data not available\n");
> +	if (!twl4030_core_node) {
> +		dev_err(&pdev->dev, "no DT info\n\n");
>  		return -EINVAL;
>  	}
>  
> @@ -209,7 +204,7 @@ static int twl4030_vibra_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	info->dev = &pdev->dev;
> -	info->coexist = twl4030_vibra_check_coexist(pdata, twl4030_core_node);
> +	info->coexist = twl4030_vibra_check_coexist(twl4030_core_node);
>  	INIT_WORK(&info->play_work, vibra_play_work);
>  
>  	info->input_dev = devm_input_allocate_device(&pdev->dev);
> 

-- 
Péter
