From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] iio:adc:palmas: add DT support
Date: Sun, 25 Oct 2015 12:04:52 +0000
Message-ID: <562CC564.7090402@kernel.org>
References: <cover.1445000017.git.hns@goldelico.com>
 <79429ca1a6d0465b6b19ede16d90de23e4363431.1445000017.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <79429ca1a6d0465b6b19ede16d90de23e4363431.1445000017.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 16/10/15 13:53, H. Nikolaus Schaller wrote:
> From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> 
> Code was found at:
> https://android.googlesource.com/kernel/tegra/+/a90856a6626d502d42c6e7abccbdf9d730b36270%5E%21/#F1
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [Fixed minor typos + add channels list to documentation]
I am happy with your responses to Lars and that kind of covers what Mark raised as well.

One typo correction applied.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/palmas-gpadc.txt   | 48 ++++++++++++++++++++
>  drivers/iio/adc/palmas_gpadc.c                     | 52 +++++++++++++++++++---
>  2 files changed, 95 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> new file mode 100644
> index 0000000..a6de996
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> @@ -0,0 +1,48 @@
> +* Palmas general purpose ADC IP block devicetree bindings
> +
> +Channels list:
> +	0 battery type
> +	1 battery temp NTC (optional current source)
> +	2 GP
> +	3 temp (with ext. diode, optional current source)
> +	4 GP
> +	5 GP
> +	6 VBAT_SENSE
> +	7 VCC_SENSE
> +	8 Backup Battery voltage
> +	9 external charger (VCHG)
> +	10 VBUS
> +	11 DC-DC current probe (how does this work?)
> +	12 internal die temp
> +	13 internal die temp
> +	14 USB ID pin voltage
> +	15 test network
> +
> +Required properties:
> +- compatible : Must be "ti,palmas-gpadc".
> +- #io-channel-cells: Should be set to <1>.
> +
> +Optional sub-nodes:
> +ti,channel0-current-microamp: Channel 0 current in uA.
> +	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
> +ti,channel3-current-microamp: Channel 3 current in uA.
> +	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.
Values

> +ti,enable-extended-delay: Enable extended delay.
> +
> +Example:
> +
> +pmic {
> +	compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> +	...
> +	gpadc {
> +		compatible = "ti,palmas-gpadc";
> +		interrupts = <18 0
> +			      16 0
> +			      17 0>;
> +		#io-channel-cells = <1>;
> +		ti,channel0-current-microamp = <5>;
> +		ti,channel3-current-microamp = <10>;
> +		};
> +	};
> +	...
> +};
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 71763c5..f42eb8a 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -21,6 +21,8 @@
>  #include <linux/pm.h>
>  #include <linux/mfd/palmas.h>
>  #include <linux/completion.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/machine.h>
>  #include <linux/iio/driver.h>
> @@ -460,6 +462,34 @@ static const struct iio_chan_spec palmas_gpadc_iio_channel[] = {
>  	PALMAS_ADC_CHAN_IIO(IN15, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
>  };
>  
> +static int palmas_gpadc_get_adc_dt_data(struct platform_device *pdev,
> +	struct palmas_gpadc_platform_data **gpadc_pdata)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct palmas_gpadc_platform_data *gp_data;
> +	int ret;
> +	u32 pval;
> +
> +	gp_data = devm_kzalloc(&pdev->dev, sizeof(*gp_data), GFP_KERNEL);
> +	if (!gp_data)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32(np, "ti,channel0-current-microamp", &pval);
> +	if (!ret)
> +		gp_data->ch0_current = pval;
> +
> +	ret = of_property_read_u32(np, "ti,channel3-current-microamp", &pval);
> +	if (!ret)
> +		gp_data->ch3_current = pval;
> +
> +	gp_data->extended_delay = of_property_read_bool(np,
> +					"ti,enable-extended-delay");
> +
> +	*gpadc_pdata = gp_data;
> +
> +	return 0;
> +}
> +
>  static int palmas_gpadc_probe(struct platform_device *pdev)
>  {
>  	struct palmas_gpadc *adc;
> @@ -469,12 +499,17 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  	int ret, i;
>  
>  	pdata = dev_get_platdata(pdev->dev.parent);
> -	if (!pdata || !pdata->gpadc_pdata) {
> -		dev_err(&pdev->dev, "No platform data\n");
> -		return -ENODEV;
> -	}
>  
> -	gpadc_pdata = pdata->gpadc_pdata;
> +	if (pdata && pdata->gpadc_pdata)
> +		gpadc_pdata = pdata->gpadc_pdata;
> +
> +	if (!gpadc_pdata && pdev->dev.of_node) {
> +		ret = palmas_gpadc_get_adc_dt_data(pdev, &gpadc_pdata);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (!gpadc_pdata)
> +		return -EINVAL;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
>  	if (!indio_dev) {
> @@ -790,12 +825,19 @@ static const struct dev_pm_ops palmas_pm_ops = {
>  				palmas_gpadc_resume)
>  };
>  
> +static const struct of_device_id of_palmas_gpadc_match_tbl[] = {
> +	{ .compatible = "ti,palmas-gpadc", },
> +	{ /* end */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_palmas_gpadc_match_tbl);
> +
>  static struct platform_driver palmas_gpadc_driver = {
>  	.probe = palmas_gpadc_probe,
>  	.remove = palmas_gpadc_remove,
>  	.driver = {
>  		.name = MOD_NAME,
>  		.pm = &palmas_pm_ops,
> +		.of_match_table = of_palmas_gpadc_match_tbl,
>  	},
>  };
>  
> 
