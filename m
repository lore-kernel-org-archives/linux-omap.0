From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH RFT 2/2] regulator: twl: Convert twlsmps_ops to get_voltage_sel
 and map_voltage
Date: Mon, 16 Jul 2012 14:55:44 +0530
Message-ID: <5003DE18.7010107@ti.com>
References: <1342244233.4207.1.camel@phoenix> <1342244483.4207.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56304 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497Ab2GPJZv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 05:25:51 -0400
Received: by obbun3 with SMTP id un3so11535471obb.13
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 02:25:50 -0700 (PDT)
In-Reply-To: <1342244483.4207.4.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, Graeme Gregory <gg@slimlogic.co.uk>, loml <linux-omap@vger.kernel.org>

Copying Graeme and linux-omap list.

On Saturday 14 July 2012 11:11 AM, Axel Lin wrote:
> Signed-off-by: Axel Lin<axel.lin@gmail.com>
> ---
>   drivers/regulator/twl-regulator.c |   24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index 03d0bea..8dae1e3 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -755,12 +755,11 @@ static int twl6030smps_list_voltage(struct regulator_dev *rdev, unsigned index)
>   	return voltage;
>   }
>
> -static int
> -twl6030smps_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
> -			unsigned int *selector)
> +static int twl6030smps_map_voltage(struct regulator_dev *rdev, int min_uV,
> +				   int max_uV)
>   {
> -	struct twlreg_info	*info = rdev_get_drvdata(rdev);
> -	int vsel = 0, calc_uV;
> +	struct twlreg_info *info = rdev_get_drvdata(rdev);
> +	int vsel = 0;
>
>   	switch (info->flags) {
>   	case 0:
> @@ -827,14 +826,16 @@ twl6030smps_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
>   		break;
>   	}
>
> -	calc_uV = twl6030smps_list_voltage(rdev, vsel);
> -	if (calc_uV>  max_uV)
> -		return -EINVAL;
> +	return vsel;
> +}
>
> -	*selector = vsel;
> +static int twl6030smps_set_voltage_sel(struct regulator_dev *rdev,
> +				       unsigned int selector)
> +{
> +	struct twlreg_info *info = rdev_get_drvdata(rdev);
>
>   	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS,
> -							vsel);
> +			    selector);
>   }
>
>   static int twl6030smps_get_voltage_sel(struct regulator_dev *rdev)
> @@ -846,8 +847,9 @@ static int twl6030smps_get_voltage_sel(struct regulator_dev *rdev)
>
>   static struct regulator_ops twlsmps_ops = {
>   	.list_voltage		= twl6030smps_list_voltage,
> +	.map_voltage		= twl6030smps_map_voltage,
>
> -	.set_voltage		= twl6030smps_set_voltage,
> +	.set_voltage_sel	= twl6030smps_set_voltage_sel,
>   	.get_voltage_sel	= twl6030smps_get_voltage_sel,
>
>   	.enable			= twl6030reg_enable,

