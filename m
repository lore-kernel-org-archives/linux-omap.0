From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Thu, 7 Jul 2011 17:32:42 +0100
Message-ID: <4E15DFAA.7030508@ti.com>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com> <1310041672-18634-2-git-send-email-peter.ujfalusi@ti.com> <20110707155742.GC16325@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39590 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab1GGQhJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 12:37:09 -0400
In-Reply-To: <20110707155742.GC16325@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On 07/07/11 16:57, Mark Brown wrote:
> On Thu, Jul 07, 2011 at 03:27:50PM +0300, Peter Ujfalusi wrote:
> 
>> The current McPDM driver design is not suitable to support both
>> the ABE and Legacy DMA operating modes. Therefore remove most
> 
> In what way is it not suitable?

It cant support both the ABE and Legacy DMA modes without adding some unnecessary and complicated logic. My preference is 1 driver to support both modes of operation and this is the easiest way to do so (also keeping the maintenance easier too).

> 
>> +/*
>> + * Enables the transfer through the PDM interface to/from the Phoenix
>> + * codec by enabling the corresponding UP or DN channels.
>> + */
>> +static void omap_mcpdm_start(struct omap_mcpdm *mcpdm)
>> +{
>> +	u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
>> +
>> +	ctrl |= (MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
>> +	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
>> +
>> +	ctrl |= mcpdm->dn_channels | mcpdm->up_channels;
>> +	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
>> +
>> +	ctrl &= ~(MCPDM_SW_DN_RST | MCPDM_SW_UP_RST);
>> +	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl);
>> +}
> 
> Presumably this works with any PDM input/output?

Yes.

> 
>> +/* work to delay McPDM shutdown */
>> +static void playback_work(struct work_struct *work)
>> +{
>> +	struct omap_mcpdm *mcpdm = container_of(work,
>> +					struct omap_mcpdm, delayed_work.work);
>> +
>> +	if (!mcpdm->active && omap_mcpdm_active(mcpdm)) {
>> +		omap_mcpdm_stop(mcpdm);
>> +		omap_mcpdm_close_streams(mcpdm);
>> +	}
>> +
>> +	if (!omap_mcpdm_active(mcpdm))
>> +		pm_runtime_put_sync(mcpdm->dev);
>> +}
> 
> It occurs to me that it'd be much simpler to implement this by doing the
> cleanup in your runtime suspend callback, it looks like you're working
> around the pm_runtime framework rather than using it.  If you need to do
> some cleanup when the device goes idle and you can't do it within a
> framework designed to suspend the device when it goes idle then there's
> an issue there.
> 
> Alternatively, why is this deferred?

There are some power, clock and pop dependencies here between the CODEC, ABE and McPDM interface and this deferred work allows us to shutwdown McPDM (in a pop free manner) and satisfy the dependencies without causing a data abort and/or locking the ABE firmware.

Liam

