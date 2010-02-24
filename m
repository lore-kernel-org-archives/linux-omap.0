From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: RE: [alsa-devel] [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec
	driver
Date: Wed, 24 Feb 2010 17:57:25 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65DD22F0@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com>
 <1267007881.3274.136.camel@odin> <20100224104256.GB9018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40799 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758636Ab0BXX5e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 18:57:34 -0500
In-Reply-To: <20100224104256.GB9018@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, February 24, 2010 4:43 AM
> To: Liam Girdwood
> Cc: Olaya, Margarita; alsa-devel@alsa-project.org; linux-omap@vger.kernel.org
> Subject: Re: [alsa-devel] [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec driver
> 
> On Wed, Feb 24, 2010 at 10:38:01AM +0000, Liam Girdwood wrote:
> > On Tue, 2010-02-23 at 18:10 -0600, Olaya, Margarita wrote:
> 
> > > +       twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &value, reg);
> > > +       twl6030_write_reg_cache(codec, reg, value);
> 
> > You probably want to read from the cache if the register is not
> > volatile. This saves a slow I2C read.
> 
> ...and if you don't satisfy reads from the cache you may as well not
> bother with it - it's just consuming memory.

We have different functions for those cases.

> 
> > > +               /* skip read-only registers (ASICID, ASICREV, STATUS) */
> > > +               if ((reg == TWL6030_REG_ASICID) ||
> > > +                   (reg == TWL6030_REG_ASICREV) ||
> > > +                   (reg == TWL6030_REG_STATUS))
> > > +                       continue;
> > > +               twl6030_write(codec, reg, cache[reg]);
> 
> A switch statement would be nicer here.

You mean something like this?

	switch (reg) {
	case TWL6030_REG_ASICID:
	case TWL6030_REG_ASICREV:
	case TWL6030_REG_STATUS:
		continue;
	default:
	break:
	}

Regards,
Margarita
