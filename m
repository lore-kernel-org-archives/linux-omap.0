From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: RE: [alsa-devel] [PATCHv4 7/7] ASoC: TWL6030: Detect power-up
	sequence completion
Date: Fri, 26 Feb 2010 18:22:34 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65E7E58C@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B19@dlee06.ent.ti.com>
 <20100224135909.GR18896@rakim.wolfsonmicro.main>
 <1889FA7136B567478A67D4B0F85B0CCE65DD230C@dlee06.ent.ti.com>
 <6119755B-D3CB-4E4C-ADA2-8AE64EBE4711@opensource.wolfsonmicro.com>
 <1889FA7136B567478A67D4B0F85B0CCE65E7E3FF@dlee06.ent.ti.com>
 <20100226212717.GB6615@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39711 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966663Ab0B0AWm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 19:22:42 -0500
In-Reply-To: <20100226212717.GB6615@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Friday, February 26, 2010 3:27 PM  Mark Brown wrote: 

> On Fri, Feb 26, 2010 at 03:04:22PM -0600, Olaya, Margarita wrote:
> 
>> In both cases if READYINIT is not set before the timeout runs out
>> it means the codec is not powering on and the driver reports an
>> error. 
> 
> That's kind of my point - because you're checking for the same
> status there shouldn't be any need to special case the situation
> where there's
> no interrupt, I'd expect to be able to use
> wait_for_timeout_interruptible()
> for the delay and have the timeout completion interrupt cause
> that to be
> signalled.  No *terribly* important but it makes it clearer
> what's going
> on.

Do you mean something like this?
time_left = wait_for_completion_timeout(&priv->ready,
                                        msecs_to_jiffies(48));
if(!time_left) {
	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &intid,
                                        TWL6040_REG_INTID);
      if (!(intid & TWL6040_READYINT))
		goto error;
}

	return 0;

error:
	dev_err(codec->dev, "timeout waiting for READYINT\n");
	return -ETIMEDOUT;

but in this case will it not take unnecessarily 48ms when the
interruption line is not valid?

Regards,
Margarita

