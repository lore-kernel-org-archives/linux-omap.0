From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 04/11] MFD: twl4030-audio: Add DT support
Date: Wed, 8 Aug 2012 13:50:53 +0200
Message-ID: <5022529D.3090406@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On 08/08/2012 11:41 AM, Peter Ujfalusi wrote:
> Support for loading the twl4030 audio module via devicetree.
> Sub devices for codec and vibra will be created as mfd devices once the
> core MFD driver is loaded when the kernel is booted with a DT blob.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/mfd/twl4030-audio.txt      |   51 +++++++++++++++
>  drivers/mfd/twl4030-audio.c                        |   65 +++++++++++++++++---
>  2 files changed, 108 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/twl4030-audio.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/twl4030-audio.txt b/Documentation/devicetree/bindings/mfd/twl4030-audio.txt
> new file mode 100644
> index 0000000..bc45025
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/twl4030-audio.txt
> @@ -0,0 +1,51 @@
> +Texas Instruments TWL family (twl4030) audio module
> +
> +The audio module inside the TWL family consist of an audio codec and a vibra
> +driver.
> +
> +Required properties:
> +- compatible : must be "ti,twl4030-audio"
> +- ti,audio_mclk: Master clock frequency used on the board. Supported
> +	         frequencies: 19200000, 26000000 and 38400000

Since you care about the frequency only you can use the generic
attribute: clock-frequency (in your example, I2C is using it).


That being said, since we do have the clock binding now, maybe we should
create a clock provider at board level for the sys_clk and thus you will
just have to create a phandle to it in your audio description.

In theory OMAP and other components will thus have to use that sys_clock
reference as well.

Regards,
Benoit


> +
> +Optional properties, nodes:
> +
> +Audio functionality:
> +- codec { }: Need to be present if the audio functionality is used. Within this
> +	     section the following options can be used:
> +- ti,digimic_delay: Delay need after enabling the digimic to reduce artifacts
> +		    from the start of the recorded sample (in ms)
> +-ti,ramp_delay_value: HS ramp delay configuration to reduce pop noise
> +-ti,hs_extmute: Use external mute for HS pop reduction
> +-ti,hs_extmute_gpio: Use external GPIO to control the external mute
> +-ti,hs_extmute_disable_level: The desired level of the GPIO line when the
> +			      external mute is disabled. valuse: 0 or 1
> +-ti,offset_cncl_path: Offset cancellation path selection, refer to TRM for the
> +		      valid values.
> +
> +Vibra functionality
> +- ti,enable-vibra: Need to be set to <1> if the vibra functionality is used. if
> +		   missing or it is 0, the vibra functionality is disabled.
> +
> +Example:
> +&i2c1 {
> +	clock-frequency = <2600000>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +
> +		twl_audio: audio {
> +			compatible = "ti,twl4030-audio";
> +			ti,audio_mclk = <26000000>;
> +
> +			ti,enable-vibra = <1>;
> +
> +			codec {
> +				ti,ramp_delay_value = <3>;
> +			};
> +
> +		};
> +	};
> +};
> diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
> index ca2d669..a4df8b3a 100644
> --- a/drivers/mfd/twl4030-audio.c
> +++ b/drivers/mfd/twl4030-audio.c
> @@ -28,6 +28,8 @@
>  #include <linux/kernel.h>
>  #include <linux/fs.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/twl4030-audio.h>
> @@ -156,15 +158,46 @@ unsigned int twl4030_audio_get_mclk(void)
>  }
>  EXPORT_SYMBOL_GPL(twl4030_audio_get_mclk);
>  
> +static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
> +			      struct device_node *node)
> +{
> +	if (pdata && pdata->codec)
> +		return true;
> +
> +#ifdef CONFIG_OF
> +	if (of_find_node_by_name(node, "codec"))
> +		return true;
> +#endif
> +
> +	return false;
> +}
> +
> +static bool twl4030_audio_has_vibra(struct twl4030_audio_data *pdata,
> +			      struct device_node *node)
> +{
> +	int vibra;
> +
> +	if (pdata && pdata->vibra)
> +		return true;
> +
> +#ifdef CONFIG_OF
> +	if (!of_property_read_u32(node, "ti,enable-vibra", &vibra) && vibra)
> +		return true;
> +#endif
> +
> +	return false;
> +}
> +
>  static int __devinit twl4030_audio_probe(struct platform_device *pdev)
>  {
>  	struct twl4030_audio *audio;
>  	struct twl4030_audio_data *pdata = pdev->dev.platform_data;
> +	struct device_node *node = pdev->dev.of_node;
>  	struct mfd_cell *cell = NULL;
>  	int ret, childs = 0;
>  	u8 val;
>  
> -	if (!pdata) {
> +	if (!pdata && !node) {
>  		dev_err(&pdev->dev, "Platform data is missing\n");
>  		return -EINVAL;
>  	}
> @@ -175,7 +208,12 @@ static int __devinit twl4030_audio_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mutex_init(&audio->mutex);
> -	audio->audio_mclk = pdata->audio_mclk;
> +	if (pdata)
> +		audio->audio_mclk = pdata->audio_mclk;
> +#ifdef CONFIG_OF
> +	else
> +		of_property_read_u32(node, "ti,audio_mclk", &audio->audio_mclk);
> +#endif
>  
>  	/* Configure APLL_INFREQ and disable APLL if enabled */
>  	switch (audio->audio_mclk) {
> @@ -202,18 +240,22 @@ static int __devinit twl4030_audio_probe(struct platform_device *pdev)
>  	audio->resource[TWL4030_AUDIO_RES_APLL].reg = TWL4030_REG_APLL_CTL;
>  	audio->resource[TWL4030_AUDIO_RES_APLL].mask = TWL4030_APLL_EN;
>  
> -	if (pdata->codec) {
> +	if (twl4030_audio_has_codec(pdata, node)) {
>  		cell = &audio->cells[childs];
>  		cell->name = "twl4030-codec";
> -		cell->platform_data = pdata->codec;
> -		cell->pdata_size = sizeof(*pdata->codec);
> +		if (pdata) {
> +			cell->platform_data = pdata->codec;
> +			cell->pdata_size = sizeof(*pdata->codec);
> +		}
>  		childs++;
>  	}
> -	if (pdata->vibra) {
> +	if (twl4030_audio_has_vibra(pdata, node)) {
>  		cell = &audio->cells[childs];
>  		cell->name = "twl4030-vibra";
> -		cell->platform_data = pdata->vibra;
> -		cell->pdata_size = sizeof(*pdata->vibra);
> +		if (pdata) {
> +			cell->platform_data = pdata->vibra;
> +			cell->pdata_size = sizeof(*pdata->vibra);
> +		}
>  		childs++;
>  	}
>  
> @@ -245,10 +287,17 @@ static int __devexit twl4030_audio_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id twl4030_audio_of_match[] = {
> +	{.compatible = "ti,twl4030-audio", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, twl4030_audio_of_match);
> +
>  static struct platform_driver twl4030_audio_driver = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "twl4030-audio",
> +		.of_match_table = twl4030_audio_of_match,
>  	},
>  	.probe		= twl4030_audio_probe,
>  	.remove		= __devexit_p(twl4030_audio_remove),
> 
