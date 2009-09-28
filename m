From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 6/7] ASoC: TWL6030: Enable audio interrupt
Date: Mon, 28 Sep 2009 14:34:43 +0100
Message-ID: <20090928133442.GE31899@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391E4@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37836 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751160AbZI1Nek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Sep 2009 09:34:40 -0400
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90A391E4@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 25, 2009 at 09:03:41PM -0500, Lopez Cruz, Misael wrote:

> +/* audio interrupt handler */
> +irqreturn_t twl6030_naudint_handler(int irq, void *data)
> +{
> +	struct snd_soc_codec *codec = data;
> +	struct twl6030_data *priv = codec->private_data;
> +
> +	schedule_work(&priv->audint_work);
> +
> +	/* disable audint irq to let workqueue to execute */
> +	disable_irq_nosync(irq);
> +
> +	return IRQ_HANDLED;
> +}

You should use request_threaded_irq() here and have the body of the work
function in the threaded IRQ handler.  It essentially does the same
thing that you've open coded here but with less code and is a bit more
friendly to the IRQ infrastructure since it lets it know what's going
on more explicitly.

> @@ -954,8 +1008,15 @@ static int __devinit twl6030_codec_probe(struct platform_device *pdev)
>  	struct twl6030_data *priv;
>  	struct snd_soc_codec *codec;
>  	int audpwron_gpio = twl_codec->audpwron_gpio;
> +	int naudint_irq = twl_codec->naudint_irq;
>  	int ret = 0;
>  
> +	/* prerequisites */
> +	if (!naudint_irq) {
> +		dev_err(&pdev->dev, "no audio interrupt irq supplied\n");
> +		return -EINVAL;
> +	}
> +

Is it worth making this optional?  I wouldn't like to rely on boards
remembering to wire up the interrupt line.
