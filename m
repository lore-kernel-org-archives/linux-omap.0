From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH RFT 1/2] regulator: twl: Fix checking voltage range in
 twl6030smps_set_voltage()
Date: Mon, 16 Jul 2012 14:55:15 +0530
Message-ID: <5003DDFB.2090102@ti.com>
References: <1342244233.4207.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:58119 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288Ab2GPJZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 05:25:23 -0400
Received: by obbuo19 with SMTP id uo19so9714547obb.11
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 02:25:22 -0700 (PDT)
In-Reply-To: <1342244233.4207.1.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, LKML <linux-kernel@vger.kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>, loml <linux-omap@vger.kernel.org>

Copying Graeme and linux-omap list.

On Saturday 14 July 2012 11:07 AM, Axel Lin wrote:
> The voltage selection logic is supposed to find the samllest voltage falls
> within specified range. When using equation to calculate vsel, we need to
> ensure the requested min_uV meet the range of using the equation.
> Otherwise we may select a voltage that is out of specified range.
>
> For example, in the case vsel = 62 means select voltage of 2100000uV.
> What we want is to ensure the requested min_uV<= 2100000 rather than checking
> max_uV>= 2100000. And this also means in the case min_uV>  2100000, vsel = 62
> does not meet the request.
>
> Also calling twl6030smps_list_voltage() for all cases to ensure the selected
> voltage still in bounds.
>
> Signed-off-by: Axel Lin<axel.lin@gmail.com>
> ---
>   drivers/regulator/twl-regulator.c |   36 ++++++++++++++++--------------------
>   1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index 8f0bd56..03d0bea 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -760,32 +760,28 @@ twl6030smps_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
>   			unsigned int *selector)
>   {
>   	struct twlreg_info	*info = rdev_get_drvdata(rdev);
> -	int	vsel = 0;
> +	int vsel = 0, calc_uV;
>
>   	switch (info->flags) {
>   	case 0:
>   		if (min_uV == 0)
>   			vsel = 0;
>   		else if ((min_uV>= 600000)&&  (min_uV<= 1300000)) {
> -			int calc_uV;
>   			vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
>   			vsel++;
> -			calc_uV = twl6030smps_list_voltage(rdev, vsel);
> -			if (calc_uV>  max_uV)
> -				return -EINVAL;
>   		}
>   		/* Values 1..57 for vsel are linear and can be calculated
>   		 * values 58..62 are non linear.
>   		 */
> -		else if ((min_uV>  1900000)&&  (max_uV>= 2100000))
> +		else if ((min_uV>  1900000)&&  (min_uV<= 2100000))
>   			vsel = 62;
> -		else if ((min_uV>  1800000)&&  (max_uV>= 1900000))
> +		else if ((min_uV>  1800000)&&  (min_uV<= 1900000))
>   			vsel = 61;
> -		else if ((min_uV>  1500000)&&  (max_uV>= 1800000))
> +		else if ((min_uV>  1500000)&&  (min_uV<= 1800000))
>   			vsel = 60;
> -		else if ((min_uV>  1350000)&&  (max_uV>= 1500000))
> +		else if ((min_uV>  1350000)&&  (min_uV<= 1500000))
>   			vsel = 59;
> -		else if ((min_uV>  1300000)&&  (max_uV>= 1350000))
> +		else if ((min_uV>  1300000)&&  (min_uV<= 1350000))
>   			vsel = 58;
>   		else
>   			return -EINVAL;
> @@ -794,25 +790,21 @@ twl6030smps_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
>   		if (min_uV == 0)
>   			vsel = 0;
>   		else if ((min_uV>= 700000)&&  (min_uV<= 1420000)) {
> -			int calc_uV;
>   			vsel = DIV_ROUND_UP(min_uV - 700000, 12500);
>   			vsel++;
> -			calc_uV = twl6030smps_list_voltage(rdev, vsel);
> -			if (calc_uV>  max_uV)
> -				return -EINVAL;
>   		}
>   		/* Values 1..57 for vsel are linear and can be calculated
>   		 * values 58..62 are non linear.
>   		 */
> -		else if ((min_uV>  1900000)&&  (max_uV>= 2100000))
> +		else if ((min_uV>  1900000)&&  (min_uV<= 2100000))
>   			vsel = 62;
> -		else if ((min_uV>  1800000)&&  (max_uV>= 1900000))
> +		else if ((min_uV>  1800000)&&  (min_uV<= 1900000))
>   			vsel = 61;
> -		else if ((min_uV>  1350000)&&  (max_uV>= 1800000))
> +		else if ((min_uV>  1350000)&&  (min_uV<= 1800000))
>   			vsel = 60;
> -		else if ((min_uV>  1350000)&&  (max_uV>= 1500000))
> +		else if ((min_uV>  1350000)&&  (min_uV<= 1500000))
>   			vsel = 59;
> -		else if ((min_uV>  1300000)&&  (max_uV>= 1350000))
> +		else if ((min_uV>  1300000)&&  (min_uV<= 1350000))
>   			vsel = 58;
>   		else
>   			return -EINVAL;
> @@ -828,13 +820,17 @@ twl6030smps_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
>   	case SMPS_OFFSET_EN|SMPS_EXTENDED_EN:
>   		if (min_uV == 0) {
>   			vsel = 0;
> -		} else if ((min_uV>= 2161000)&&  (max_uV<= 4321000)) {
> +		} else if ((min_uV>= 2161000)&&  (min_uV<= 4321000)) {
>   			vsel = DIV_ROUND_UP(min_uV - 2161000, 38600);
>   			vsel++;
>   		}
>   		break;
>   	}
>
> +	calc_uV = twl6030smps_list_voltage(rdev, vsel);
> +	if (calc_uV>  max_uV)
> +		return -EINVAL;
> +
>   	*selector = vsel;
>
>   	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS,

