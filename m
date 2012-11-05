From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Mon, 5 Nov 2012 17:59:36 +0100
Message-ID: <5097F078.50701@ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352108549-9341-2-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

+ Mark

On 11/05/2012 10:42 AM, AnilKumar Ch wrote:
> From: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
> 
> Set tps65217 PMIC status to OFF if power enable toggle is
> supported. Also adds platform data flag, which should be
> passed from board init data.
> 
> Signed-off-by: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
> [anilkumar-l0cyMroinI0@public.gmane.org: move the additions to tps65217 MFD driver]
> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
>  drivers/mfd/tps65217.c                             |   12 ++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
> index d316fb8..4f05d20 100644
> --- a/Documentation/devicetree/bindings/regulator/tps65217.txt
> +++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
> @@ -11,6 +11,9 @@ Required properties:
>    using the standard binding for regulators found at
>    Documentation/devicetree/bindings/regulator/regulator.txt.
>  
> +Optional properties:
> +- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.

That sounds like a generic functionality to me. Don't we have some more
generic way to handle that?

If not, that should probably not be a TI only attribute.

It looks like a GPIO like kind of interface at PMIC level.

Regards,
Benoit

> +
>    The valid names for regulators are:
>    tps65217: dcdc1, dcdc2, dcdc3, ldo1, ldo2, ldo3 and ldo4
>  
> @@ -20,6 +23,7 @@ Example:
>  
>  	tps: tps@24 {
>  		compatible = "ti,tps65217";
> +		ti,pmic-shutdown-controller;
>  
>  		regulators {
>  			dcdc1_reg: dcdc1 {
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 3fb32e6..c7f17d8 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -160,6 +160,7 @@ static int __devinit tps65217_probe(struct i2c_client *client,
>  	unsigned int version;
>  	unsigned int chip_id = ids->driver_data;
>  	const struct of_device_id *match;
> +	bool status_off = false;
>  	int ret;
>  
>  	if (client->dev.of_node) {
> @@ -170,6 +171,8 @@ static int __devinit tps65217_probe(struct i2c_client *client,
>  			return -EINVAL;
>  		}
>  		chip_id = (unsigned int)match->data;
> +		status_off = of_property_read_bool(client->dev.of_node,
> +					"ti,pmic-shutdown-controller");
>  	}
>  
>  	if (!chip_id) {
> @@ -207,6 +210,15 @@ static int __devinit tps65217_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	/* Set the PMIC to shutdown on PWR_EN toggle */
> +	if (status_off) {
> +		ret = tps65217_set_bits(tps, TPS65217_REG_STATUS,
> +				TPS65217_STATUS_OFF, TPS65217_STATUS_OFF,
> +				TPS65217_PROTECT_NONE);
> +		if (ret)
> +			dev_warn(tps->dev, "unable to set the status OFF\n");
> +	}
> +
>  	dev_info(tps->dev, "TPS65217 ID %#x version 1.%d\n",
>  			(version & TPS65217_CHIPID_CHIP_MASK) >> 4,
>  			version & TPS65217_CHIPID_REV_MASK);
> 
