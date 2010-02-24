From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec
	driver
Date: Wed, 24 Feb 2010 13:38:36 +0000
Message-ID: <20100224133835.GP18896@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 23, 2010 at 06:10:27PM -0600, Olaya, Margarita wrote:

> +static int twl6030_set_bias_level(struct snd_soc_codec *codec,
> +                               enum snd_soc_bias_level level)
> +{
> +       struct twl6030_data *priv = codec->private_data;
> +       int audpwron = priv->audpwron;
> +
> +       switch (level) {
> +       case SND_SOC_BIAS_ON:
> +       case SND_SOC_BIAS_PREPARE:
> +       case SND_SOC_BIAS_STANDBY:
> +               if (priv->codec_powered)
> +                       break;
> +

It'd be better to restructure this code so that the powerup triggers on
the OFF->STANDBY transition rather than going in here on transitions
like PREPARE->ON or ON->PREPARE which should never occur and where the
expectation is strongly that the device will already be powered.

> +#ifdef CONFIG_PM
> +static int twl6030_codec_suspend(struct platform_device *pdev,
> +                                pm_message_t msg)
> +{
> +       return snd_soc_suspend_device(&pdev->dev);
> +}
> +
> +static int twl6030_codec_resume(struct platform_device *pdev)
> +{
> +       return snd_soc_resume_device(&pdev->dev);
> +}
> +#else
> +#define twl6030_codec_suspend NULL
> +#define twl6030_codec_resume NULL
> +#endif

This won't compile, those functions have been removed so these functions
can just be dropped.  Please test against the branch you're submitting
against (or -next).
