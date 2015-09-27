From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] iio:adc:palmas: add DT support
Date: Sun, 27 Sep 2015 16:37:15 +0100
Message-ID: <56080D2B.8030608@kernel.org>
References: <1437657169.3419965.331206849.51D66A2E@webmail.messagingengine.com>
 <cover.1443012491.git.hns@goldelico.com>
 <0A17C76F-3E8F-430E-BDED-506CC9C2E2AC@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0A17C76F-3E8F-430E-BDED-506CC9C2E2AC-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, notaz-in7WBhxDdJqvTmjiLVyRpw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 23/09/15 13:49, H. Nikolaus Schaller wrote:
> From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> 
> Code was found at:
> https://android.googlesource.com/kernel/tegra/+/a90856a6626d502d42c6e7abccbdf9d730b36270%5E%21/#F1
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> [Fixed minor typos + add channels list to documentation]
> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Various commments inline.  You've run into the region of previous arguments
over driver bindings...  Mark Rutland, one for you to comment on as I know
you love our bindings ;) and yes we haven't done anything about them in two
years or so since you last moaned about them to me :(

> ---
> .../devicetree/bindings/iio/adc/palmas-gpadc.txt   |  67 +++++++++++
> drivers/iio/adc/palmas_gpadc.c                     | 130 +++++++++++++++++----
> 2 files changed, 175 insertions(+), 22 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> new file mode 100644
> index 0000000..a5a33ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> @@ -0,0 +1,67 @@
> +* Palmas general purpose ADC IP block devicetree bindings
> +
> +Channels list:
> +	0 battery type
> +        1 battery temp NTC
tab vs space fun.
> +	2 GP
> +	3 temp (with ext. diode)
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
> +
> +Optional sub-nodes:
> +ti,channel0-current-microamp: Channel 0 current in uA.
> +	Valid values 0uA, 5uA, 15uA, 20uA.
> +ti,channel3-current-microamp: Channel 3 current in uA.
> +	Valid value 0uA, 10uA, 400uA, 800uA.
> +ti,enable-channel3-dual-current: Enable dual current on channel 3.
> +ti,enable-extended-delay: Enable extended delay.
> +
> +Optional sub-node:
> +The Palmas ADC node has optional subnode to define the iio mapping.
> +It is the name with "iio_map". This node has again subnode to define
> +the property of the channel. The sub subnode has following properties:
> +- ti,adc-channel-number: ADC channel number.
> +- ti,adc-consumer-device: Consumer device name.
> +- ti,adc-consumer-channel: ADC consumer channel name.
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
> +		ti,channel0-current-microamp = <5>;
> +		ti,channel3-current-microamp = <10>;
> +		iio_map {
> +			ch1 {
> +				ti,adc-channel-number = <1>;
> +				ti,adc-consumer-device = "generic-adc-thermal.0";
> +				ti,adc-consumer-channel ="battery-temp-channel";
> +			};
> +
> +			ch6 {
> +				ti,adc-channel-number = <6>;
> +				ti,adc-consumer-device = "palmas-battery";
> +				ti,adc-consumer-channel ="vbat_channel";
> +			};
See comments below.  There is an existing iio-consumer binding.
Various uses of it have caused complaints from the device tree guys in the
past.  I'd be interested to get their feedback on this use case.
> +		};
> +	};
> +	...
> +};
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 17abb28..bc4db43 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -20,6 +20,8 @@
> #include <linux/pm.h>
> #include <linux/mfd/palmas.h>
> #include <linux/completion.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> #include <linux/iio/iio.h>
> #include <linux/iio/machine.h>
> #include <linux/iio/driver.h>
> @@ -434,20 +436,97 @@ static const struct iio_chan_spec palmas_gpadc_iio_channel[] = {
> 	PALMAS_ADC_CHAN_IIO(IN15, IIO_VOLTAGE),
> };
> 
> +static int palmas_gpadc_get_adc_dt_data(struct platform_device *pdev,
> +	struct palmas_gpadc_platform_data **gpadc_pdata)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct palmas_gpadc_platform_data *gp_data;
> +	struct device_node *map_node;
> +	struct device_node *child;
> +	struct iio_map *palmas_iio_map;
> +	int ret;
> +	u32 pval;
> +	int nmap, nvalid_map;
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
> +	map_node = of_get_child_by_name(np, "iio_map");
> +	if (!map_node) {
> +		dev_warn(&pdev->dev, "IIO map table not found\n");
> +		goto done;
> +	}
> +
> +	nmap = of_get_child_count(map_node);
> +	if (!nmap)
> +		goto done;
> +
> +	nmap++;
> +	palmas_iio_map = devm_kzalloc(&pdev->dev,
> +				sizeof(*palmas_iio_map) * nmap, GFP_KERNEL);
> +	if (!palmas_iio_map)
> +		goto done;
> +
> +	nvalid_map = 0;
> +	for_each_child_of_node(map_node, child) {
> +		ret = of_property_read_u32(child, "ti,adc-channel-number",
> +					&pval);
> +		if (!ret && pval < ARRAY_SIZE(palmas_gpadc_iio_channel))
> +			palmas_iio_map[nvalid_map].adc_channel_label =
> +				palmas_gpadc_iio_channel[pval].datasheet_name;
> +		of_property_read_string(child, "ti,adc-consumer-device",
> +				&palmas_iio_map[nvalid_map].consumer_dev_name);
> +		of_property_read_string(child, "ti,adc-consumer-channel",
> +				&palmas_iio_map[nvalid_map].consumer_channel);
Hmm.  These aren't TI specific, and there are already IIO bindings
documented for consumers at Documentation/devicetree/bindings/iio/iio-bindings.txt.

They have caused some issues in the past due to binding to devices that are
linux specific convenience functions.  I fear that is sort of the case here
with your thermal binding, but we can see what response we get.

Mark Rutland is IIRC the most vocal on this :)

The current plan for iio-hwmon which caused all the controversy is to look
at moving the decision to create the mapping entirely into userspace
via configfs and hence make it a clear policy decision rather than claiming
that changing user interface is a hardware mapping.

> +		dev_dbg(&pdev->dev,
> +			"Channel %s consumer dev %s and consumer channel %s\n",
> +				palmas_iio_map[nvalid_map].adc_channel_label,
> +				palmas_iio_map[nvalid_map].consumer_dev_name,
> +				palmas_iio_map[nvalid_map].consumer_channel);
> +		nvalid_map++;
> +	}
> +	palmas_iio_map[nvalid_map].adc_channel_label = NULL;
> +	palmas_iio_map[nvalid_map].consumer_dev_name = NULL;
> +	palmas_iio_map[nvalid_map].consumer_channel = NULL;
> +
> +	gp_data->iio_maps = palmas_iio_map;
> +
> +done:
> +	*gpadc_pdata = gp_data;
blank line here.
> +	return 0;
> +}
> +
> static int palmas_gpadc_probe(struct platform_device *pdev)
> {
> 	struct palmas_gpadc *adc;
> 	struct palmas_platform_data *pdata;
> -	struct palmas_gpadc_platform_data *adc_pdata;
> +	struct palmas_gpadc_platform_data *gpadc_pdata = NULL;
This rename should not be here. It adds a lot of churn to the patch
and makes it harder to review.  Fix it in the previous patch.

> 	struct iio_dev *iodev;
> 	int ret, i;
> 
> 	pdata = dev_get_platdata(pdev->dev.parent);
> -	if (!pdata || !pdata->gpadc_pdata) {
> -		dev_err(&pdev->dev, "No platform data\n");
> -		return -ENODEV;
> +	if (pdata && pdata->gpadc_pdata)
> +		gpadc_pdata = pdata->gpadc_pdata;
> +
> +	if (!gpadc_pdata && pdev->dev.of_node) {
> +		ret = palmas_gpadc_get_adc_dt_data(pdev, &gpadc_pdata);
> +		if (ret < 0)
> +			return ret;
> 	}
> -	adc_pdata = pdata->gpadc_pdata;
> +	if (!gpadc_pdata)
> +		return -EINVAL;
> 
> 	iodev = iio_device_alloc(sizeof(*adc));
> 	if (!iodev) {
> @@ -455,8 +534,8 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
> 		return -ENOMEM;
> 	}
> 
> -	if (adc_pdata->iio_maps) {
> -		ret = iio_map_array_register(iodev, adc_pdata->iio_maps);
> +	if (gpadc_pdata->iio_maps) {
> +		ret = iio_map_array_register(iodev, gpadc_pdata->iio_maps);
> 		if (ret < 0) {
> 			dev_err(&pdev->dev, "iio_map_array_register failed\n");
> 			goto out;
> @@ -470,7 +549,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
> 	init_completion(&adc->conv_completion);
> 	dev_set_drvdata(&pdev->dev, iodev);
> 
> -	adc->auto_conversion_period = adc_pdata->auto_conversion_period_ms;
> +	adc->auto_conversion_period = gpadc_pdata->auto_conversion_period_ms;
> 	adc->irq = palmas_irq_get_virq(adc->palmas, PALMAS_GPADC_EOC_SW_IRQ);
> 	ret = request_threaded_irq(adc->irq, NULL,
> 		palmas_gpadc_irq,
> @@ -482,8 +561,8 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
> 		goto out_unregister_map;
> 	}
> 
> -	if (adc_pdata->adc_wakeup1_data) {
> -		memcpy(&adc->wakeup1_data, adc_pdata->adc_wakeup1_data,
> +	if (gpadc_pdata->adc_wakeup1_data) {
> +		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
> 			sizeof(adc->wakeup1_data));
> 		adc->wakeup1_enable = true;
> 		adc->irq_auto_0 =  platform_get_irq(pdev, 1);
> @@ -498,8 +577,8 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
> 		}
> 	}
> 
> -	if (adc_pdata->adc_wakeup2_data) {
> -		memcpy(&adc->wakeup2_data, adc_pdata->adc_wakeup2_data,
> +	if (gpadc_pdata->adc_wakeup2_data) {
> +		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
> 				sizeof(adc->wakeup2_data));
> 		adc->wakeup2_enable = true;
> 		adc->irq_auto_1 =  platform_get_irq(pdev, 2);
> @@ -514,25 +593,25 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
> 		}
> 	}
> 
> -	if (adc_pdata->ch0_current == 0)
> +	if (gpadc_pdata->ch0_current == 0)
> 		adc->ch0_current = PALMAS_ADC_CH0_CURRENT_SRC_0;
> -	else if (adc_pdata->ch0_current <= 5)
> +	else if (gpadc_pdata->ch0_current <= 5)
> 		adc->ch0_current = PALMAS_ADC_CH0_CURRENT_SRC_5;
> -	else if (adc_pdata->ch0_current <= 15)
> +	else if (gpadc_pdata->ch0_current <= 15)
> 		adc->ch0_current = PALMAS_ADC_CH0_CURRENT_SRC_15;
> 	else
> 		adc->ch0_current = PALMAS_ADC_CH0_CURRENT_SRC_20;
> 
> -	if (adc_pdata->ch3_current == 0)
> +	if (gpadc_pdata->ch3_current == 0)
> 		adc->ch3_current = PALMAS_ADC_CH3_CURRENT_SRC_0;
> -	else if (adc_pdata->ch3_current <= 10)
> +	else if (gpadc_pdata->ch3_current <= 10)
> 		adc->ch3_current = PALMAS_ADC_CH3_CURRENT_SRC_10;
> -	else if (adc_pdata->ch3_current <= 400)
> +	else if (gpadc_pdata->ch3_current <= 400)
> 		adc->ch3_current = PALMAS_ADC_CH3_CURRENT_SRC_400;
> 	else
> 		adc->ch3_current = PALMAS_ADC_CH3_CURRENT_SRC_800;
> 
> -	adc->extended_delay = adc_pdata->extended_delay;
> +	adc->extended_delay = gpadc_pdata->extended_delay;
> 
> 	iodev->name = MOD_NAME;
> 	iodev->dev.parent = &pdev->dev;
> @@ -559,15 +638,15 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
> 	return 0;
> 
> out_irq_auto1_free:
> -	if (adc_pdata->adc_wakeup2_data)
> +	if (gpadc_pdata->adc_wakeup2_data)
> 		free_irq(adc->irq_auto_1, adc);
> out_irq_auto0_free:
> -	if (adc_pdata->adc_wakeup1_data)
> +	if (gpadc_pdata->adc_wakeup1_data)
> 		free_irq(adc->irq_auto_0, adc);
> out_irq_free:
> 	free_irq(adc->irq, adc);
> out_unregister_map:
> -	if (adc_pdata->iio_maps)
> +	if (gpadc_pdata->iio_maps)
> 		iio_map_array_unregister(iodev);
> out:
> 	iio_device_free(iodev);
> @@ -769,6 +848,12 @@ static const struct dev_pm_ops palmas_pm_ops = {
> 				palmas_gpadc_resume)
> };
> 
> +static const struct of_device_id of_palmas_gpadc_match_tbl[] = {
> +	{ .compatible = "ti,palmas-gpadc", },
> +	{ /* end */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_palmas_gpadc_match_tbl);
> +
> static struct platform_driver palmas_gpadc_driver = {
> 	.probe = palmas_gpadc_probe,
> 	.remove = palmas_gpadc_remove,
> @@ -776,6 +861,7 @@ static struct platform_driver palmas_gpadc_driver = {
> 		.name = MOD_NAME,
> 		.owner = THIS_MODULE,
> 		.pm = &palmas_pm_ops,
> +		.of_match_table = of_palmas_gpadc_match_tbl,
> 	},
> };
> 
