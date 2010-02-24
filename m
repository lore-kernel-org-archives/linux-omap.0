From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec
	driver
Date: Wed, 24 Feb 2010 10:42:57 +0000
Message-ID: <20100224104256.GB9018@sirena.org.uk>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com> <1267007881.3274.136.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:55919 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab0BXKm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 05:42:59 -0500
Content-Disposition: inline
In-Reply-To: <1267007881.3274.136.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 24, 2010 at 10:38:01AM +0000, Liam Girdwood wrote:
> On Tue, 2010-02-23 at 18:10 -0600, Olaya, Margarita wrote:

> > +       twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &value, reg);
> > +       twl6030_write_reg_cache(codec, reg, value);

> You probably want to read from the cache if the register is not
> volatile. This saves a slow I2C read.

...and if you don't satisfy reads from the cache you may as well not
bother with it - it's just consuming memory.

> > +               /* skip read-only registers (ASICID, ASICREV, STATUS) */
> > +               if ((reg == TWL6030_REG_ASICID) ||
> > +                   (reg == TWL6030_REG_ASICREV) ||
> > +                   (reg == TWL6030_REG_STATUS))
> > +                       continue;
> > +               twl6030_write(codec, reg, cache[reg]);

A switch statement would be nicer here.
