From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: RE: [PATCHv4 7/7] ASoC: TWL6030: Detect power-up sequence completion
Date: Wed, 24 Feb 2010 18:24:05 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65DD230C@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B19@dlee06.ent.ti.com>
 <20100224135909.GR18896@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46134 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758574Ab0BYAYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 19:24:13 -0500
In-Reply-To: <20100224135909.GR18896@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>



> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, February 24, 2010 7:59 AM
> To: Olaya, Margarita
> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org; lrg@slimlogic.co.uk
> Subject: Re: [PATCHv4 7/7] ASoC: TWL6030: Detect power-up sequence completion
> 
> On Tue, Feb 23, 2010 at 06:10:54PM -0600, Olaya, Margarita wrote:
> 
> > +	if (naudint) {
> > +		/* wait for ready interrupt with 48 ms timeout */
> > +		time_left = wait_for_completion_timeout(&priv->ready,
> > +					msecs_to_jiffies(48));
> > +	} else {
> > +		/* retry 3 times only */
> > +		for (time_left = 3; time_left > 0; time_left--) {
> > +			mdelay(16);
> > +			twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &intid,
> > +					TWL6030_REG_INTID);
> > +			if (intid & TWL6030_READYINT)
> > +				break;
> > +		}
> > +	}
> 
> It strikes me that you could combine these two cases - the
> wait_for_completion_timeout() will function just as well as a delay.
> I'd also expect to see an error reported if the device doesn't report as
> ready one way or another.

It is split to prevent the case of none valid irq line connected, in such case, wait_for_completion won't work.

Regards,
Margarita 
