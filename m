From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Tue, 28 Dec 2010 14:18:00 +0000
Message-ID: <20101228141759.GA31883@opensource.wolfsonmicro.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47554 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753123Ab0L1ORu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Dec 2010 09:17:50 -0500
Content-Disposition: inline
In-Reply-To: <1293509826-23253-2-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Mon, Dec 27, 2010 at 10:17:02PM -0600, David Lambert wrote:

> +	case 19200000:
> +		if (div == 5)
> +			div_sel = 0x1;
> +		else if (div == 8)
> +			div_sel = 0x0;
> +		break;

A switch statement for the valid div values would feel more natural,
together with a default case to report errors though that's handled
below so could be skipped.

> +	/* Acknowledge irq event */
> +	omap_dmic_write(dmic, OMAP_DMIC_IRQSTATUS, irq_status);
> +	if (irq_status & OMAP_DMIC_IRQ_FULL)

Blank line between these two.

> +		dev_dbg(dmic->dev, "DMIC FIFO error %x\n", irq_status);
> +
> +	if (irq_status & OMAP_DMIC_IRQ_EMPTY)
> +		dev_dbg(dmic->dev, "DMIC FIFO error %x\n", irq_status);

I'd expect these errors to be displayed by default.

> +	if (irq_status & OMAP_DMIC_IRQ)
> +		dev_dbg(dmic->dev, "DMIC write request\n");

A comment explaining why we don't actually do anything with the request
would be helpful.  Given that we're ignoring the event it'd seem better
to just leave it masked and not take the interrupt in the first place.

> +static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
> +				  struct snd_soc_dai *dai)
> +{
> +	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
> +
> +	if (!dmic->active++)
> +		pm_runtime_get_sync(dmic->dev);

The pm_runtime API does refcounting for you so you should be able to
just skip the active count check here, IIRC there's a pm_runtime API you
could use to query if the DMIC is enabled so you could skip the local
refcount entirely.

> +static int omap_dmic_dai_hw_free(struct snd_pcm_substream *substream,
> +				  struct snd_soc_dai *dai)
> +{
> +	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
> +	struct omap_dmic_link *link = dmic->link;
> +	int ret = 0;
> +
> +	if (dmic->active == 1) {
> +		ret = omap_dmic_close(dmic);
> +		link->channels = 0;
> +	}

I'd feel a bit more happy if this were done in the same place as the
drop of the refcount though this should actually be OK I think.

> +	switch (freq) {
> +	case 19200000:
> +	case 24000000:
> +	case 24576000:
> +	case 12000000:
> +		dmic->clk_freq = freq;
> +		break;
> +	default:
> +		dev_err(dai->dev, "clk freq not supported %d\n", freq);
> +		ret = -EINVAL;
> +		goto err_freq;
> +	}

Can't you ask the parent clock what rate it's set to?

> +	ret = request_threaded_irq(dmic->irq, NULL, omap_dmic_irq_handler,
> +				   IRQF_ONESHOT, "DMIC", (void *)dmic);
> +	if (ret) {
> +		dev_err(dmic->dev, "irq request failed\n");
> +		goto err_irq;
> +	}

Does this really need to be a threaded IRQ - the IRQ was just reading
from CPU registers as far as I remember?

> +MODULE_AUTHOR("David Lambert <dlambert@ti.com>");
> +MODULE_DESCRIPTION("OMAP DMIC SoC Interface");
> +MODULE_LICENSE("GPL");

Should have a MODULE_ALIAS too in case it gets built modular.
