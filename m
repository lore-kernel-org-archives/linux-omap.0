From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 2/4] SOUND: SOC: CODECS: Add support for
	the TWL4030 audio codec
Date: Tue, 2 Sep 2008 15:53:28 +0100
Message-ID: <20080902145328.GA3764@rakim.wolfsonmicro.main>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com> <1220306279-27977-2-git-send-email-sakoman@gmail.com> <1220306279-27977-3-git-send-email-sakoman@gmail.com> <20080902112633.GB25176@sirena.org.uk> <5e088bd90809020725g1d0dff70ue84f861ea3e22201@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33177 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751325AbYIBOxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 10:53:31 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809020725g1d0dff70ue84f861ea3e22201@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>

On Tue, Sep 02, 2008 at 07:25:48AM -0700, Steve Sakoman wrote:
> On Tue, Sep 2, 2008 at 4:26 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> > This should also be added to SND_SOC_ALL_CODECS to ensure testing
> > coverage.

> Hmm . . . I get no hits grep-ing for SND_SOC_ALL_CODECS.  Could this
> be something we are missing in the linux-omap git?

Yes, it's queued in ALSA for merge in the next window:

    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

> >> +struct twl4030_priv {
> >> +     unsigned int dummy;
> >> +};

> > If this is empty it should be removable?

> I plan to support further codec features in future patches and have a
> strong suspicion that private data may be required.  Is it preferred
> to add the infrastructure now, or wait till it is required in the
> future?  I opted for the former, but don't really care either way.

It'd be a bit cleaner to remove it but it's not a big deal either way -
leave it in if you find it useful.

> >> +             twl4030_write(codec, REG_ARXL2PGA, 0x00);
> >> +             twl4030_write(codec, REG_ARXR2PGA, 0x00);
> >> +             twl4030_write_reg_cache(codec, REG_ARXL2PGA, ldac_reg);
> >> +             twl4030_write_reg_cache(codec, REG_ARXR2PGA, rdac_reg);
> >> +     } else {
> >> +             twl4030_write(codec, REG_ARXL2PGA, ldac_reg);
> >> +             twl4030_write(codec, REG_ARXR2PGA, rdac_reg);
> >> +     }

> > It may be better to make these user visible controls - usually the mute
> > provided here is specifically for the DAC but these look like controls
> > for the PGA.  The intention here is to avoid artifacts from the DAC when
> > the input clock stops and start - if there aren't any then user space
> > may well appreciate the control.  Either way is fine.

> I'm not hearing any clicks & pops, so I will leave this in.

The point is that adding it in suppresses problems that might otherwise
occur - if it doesn't misbehave without this users may find it useful if
the mute control to be visible to them.

> >> +     twl4030_init_chip();
> >> +     twl4030_power_up(codec, APLL_RATE_44100 | OPT_MODE);

> > It looks like the driver is assuming a particular clock rate going into
> > the codec - does the chip require a fixed clock or is the driver only
> > supporting one configuration?  Either is fine.

> There is a fixed clock.

Fixed per board or fixed by the chip?
