From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Date: Tue, 30 Jan 2018 00:20:31 +0100
Message-ID: <20180129232031.GA7695@lenoch>
References: <20180129230539.GA18280@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180129230539.GA18280@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tony@atomide.com, abcloriens@gmail.com, tiwai@suse.com, martijn@brixit.nl, Filip =?iso-8859-2?Q?Matijevi=E6?= <filip.matijevic.pz@gmail.com>, patrikbachan@gmail.com, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, serge@hallyn.com, devicetree@vger.kernel.org, pali.rohar@gmail.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, aaro.koskinen@iki.fi, linux-kernel@vger.kernel.org, broonie@kernel.org, clayton@craftyguy.net, sakari.ailus@linux.intel.com, sre@kernel.org, bhumirks@gmail.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
> 
> This adds device tree support to tlv320dac33.c.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> new file mode 100644
> index 0000000..6cbd311
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> @@ -0,0 +1,32 @@
> +Texas Instruments - tlv320dac33 Codec module
> +
> +The tlv320dac33 serial control bus communicates through I2C protocols.
> +
> +Required properties:
> +
> +- compatible - "ti,tlv320dac33"
> +- reg - I2C slave address
> +
> +Optional properties:
> +
> +- power-gpios - gpio pin to power the device, active high

While driver used gpio in platform data, isn't it more likely
regulator which powers device?

> +- interrupts       - The interrupt output from the device.
> +- interrupt-parent - The parent interrupt controller.
> +
> +- ti,keep-bclk 	- Keep the BCLK running in FIFO modes
> +- ti,burst-bclkdiv - BCLK divider value in burst mode
> +
> +Example:
> +
> +tlv320dac33: audio-codec@19 {
> +	compatible = "ti,tlv320dac33";
> +	reg = <0x19>;
> +
> +	interrupt-parent = <&gpio2>;
> +	interrupts = <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
> +	power-gpio = <&gpio2 28 0>; /* gpio_60 */
> +
> +	ti,keep-bclk;
> +	ti,burst-bclkdiv = <3>;
> +};
> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index 5b94a15..2a0fe06 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c
> @@ -30,6 +32,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/gpio.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/of_gpio.h>
>  #include <linux/slab.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
> @@ -105,7 +108,7 @@ struct tlv320dac33_priv {
>  	unsigned int nsample;		/* burst read amount from host */
>  	int mode1_latency;		/* latency caused by the i2c writes in
>  					 * us */
> -	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
> +	u32 burst_bclkdiv;		/* BCLK divider value in burst mode */
>  	unsigned int burst_rate;	/* Interface speed in Burst modes */
>  
>  	int keep_bclk;			/* Keep the BCLK continuously running
> @@ -1484,16 +1487,11 @@ static struct snd_soc_dai_driver dac33_dai = {
>  static int dac33_i2c_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
> -	struct tlv320dac33_platform_data *pdata;
> +	struct tlv320dac33_platform_data *pdata = client->dev.platform_data;
>  	struct tlv320dac33_priv *dac33;
> +	struct device_node *np = client->dev.of_node;
>  	int ret, i;
>  
> -	if (client->dev.platform_data == NULL) {
> -		dev_err(&client->dev, "Platform data not set\n");
> -		return -ENODEV;
> -	}
> -	pdata = client->dev.platform_data;
> -
>  	dac33 = devm_kzalloc(&client->dev, sizeof(struct tlv320dac33_priv),
>  			     GFP_KERNEL);
>  	if (dac33 == NULL)
> @@ -1505,10 +1503,26 @@ static int dac33_i2c_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, dac33);
>  
> -	dac33->power_gpio = pdata->power_gpio;
> -	dac33->burst_bclkdiv = pdata->burst_bclkdiv;
> -	dac33->keep_bclk = pdata->keep_bclk;
> -	dac33->mode1_latency = pdata->mode1_latency;
> +	if (pdata) {
> +		dac33->power_gpio = pdata->power_gpio;
> +		dac33->burst_bclkdiv = pdata->burst_bclkdiv;
> +		dac33->keep_bclk = pdata->keep_bclk;
> +		dac33->mode1_latency = pdata->mode1_latency;
> +	} else if (np) {
> +		ret = of_get_named_gpio(np, "power-gpios", 0);
> +		if (ret >= 0)
> +			dac33->power_gpio = ret;
> +		else
> +			dac33->power_gpio = -1;
> +
> +		if (of_property_read_bool(np, "ti,keep-bclk"))
> +			dac33->keep_bclk = true;
> +
> +		of_property_read_u32(np, "ti,burst-bclkdiv", &dac33->burst_bclkdiv);
> +	} else {
> +		dev_err(&client->dev, "Platform data not set\n");
> +		return -ENODEV;
> +	}
>  	if (!dac33->mode1_latency)
>  		dac33->mode1_latency = 10000; /* 10ms */
>  	dac33->irq = client->irq;
> @@ -1574,9 +1588,16 @@ static const struct i2c_device_id tlv320dac33_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, tlv320dac33_i2c_id);
>  
> +static const struct of_device_id tlv320dac33_of_match[] = {
> +	{ .compatible = "ti,tlv320dac33", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, tlv320dac33_of_match);
> +
>  static struct i2c_driver tlv320dac33_i2c_driver = {
>  	.driver = {
>  		.name = "tlv320dac33-codec",
> +		.of_match_table = of_match_ptr(tlv320dac33_of_match),
>  	},
>  	.probe		= dac33_i2c_probe,
>  	.remove		= dac33_i2c_remove,
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
