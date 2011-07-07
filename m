From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Thu, 7 Jul 2011 08:57:43 -0700
Message-ID: <20110707155742.GC16325@opensource.wolfsonmicro.com>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
 <1310041672-18634-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52077 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752226Ab1GGP5r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 11:57:47 -0400
Content-Disposition: inline
In-Reply-To: <1310041672-18634-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>, Benoit Coussoni <b-cousson@ti.com>

On Thu, Jul 07, 2011 at 03:27:50PM +0300, Peter Ujfalusi wrote:

> The current McPDM driver design is not suitable to support both
> the ABE and Legacy DMA operating modes. Therefore remove most

In what way is it not suitable?

> +/*
> + * Enables the transfer through the PDM interface to/from the Phoenix
> + * codec by enabling the corresponding UP or DN channels.
> + */
> +static void omap_mcpdm_start(struct omap_mcpdm *mcpdm)
> +{
> +	u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
> +
> +	ctrl |= (MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
> +	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
> +
> +	ctrl |= mcpdm->dn_channels | mcpdm->up_channels;
> +	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
> +
> +	ctrl &= ~(MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
> +	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
> +}

Presumably this works with any PDM input/output?

> +/* work to delay McPDM shutdown */
> +static void playback_work(struct work_struct *work)
> +{
> +	struct omap_mcpdm *mcpdm = container_of(work,
> +					struct omap_mcpdm, delayed_work.work);
> +
> +	if (!mcpdm->active && omap_mcpdm_active(mcpdm)) {
> +		omap_mcpdm_stop(mcpdm);
> +		omap_mcpdm_close_streams(mcpdm);
> +	}
> +
> +	if (!omap_mcpdm_active(mcpdm))
> +		pm_runtime_put_sync(mcpdm->dev);
> +}

It occurs to me that it'd be much simpler to implement this by doing the
cleanup in your runtime suspend callback, it looks like you're working
around the pm_runtime framework rather than using it.  If you need to do
some cleanup when the device goes idle and you can't do it within a
framework designed to suspend the device when it goes idle then there's
an issue there.

Alternatively, why is this deferred?
