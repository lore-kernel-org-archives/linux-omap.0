From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 3/5] SOUND: SOC: CODECS: Add support for the TWL4030 audio codec
Date: Thu, 4 Sep 2008 13:25:42 +0100
Message-ID: <20080904122542.GC21663@sirena.org.uk>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com> <1220504520-6067-2-git-send-email-sakoman@gmail.com> <1220504520-6067-3-git-send-email-sakoman@gmail.com> <1220504520-6067-4-git-send-email-sakoman@gmail.com> <20080904132632.e64c3ce2.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1704 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbYIDMZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 08:25:48 -0400
Content-Disposition: inline
In-Reply-To: <20080904132632.e64c3ce2.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "ext sakoman@gmail.com" <sakoman@gmail.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

On Thu, Sep 04, 2008 at 01:26:32PM +0300, Jarkko Nikula wrote:

> > +static void twl4030_dump_registers(void)
> > +{
> This is not needed since there is already nice function
> for it: sound/soc/soc-core.c: codec_reg_show.

It's doing something slighly different and dumping the chip registers
rather than the register cache (the read() operation for this chip is
_read_reg_cache()) but yes, should be sensible to drop it.

> > +static void twl4030_power_down(struct snd_soc_codec *codec)
> > +{
> ...
> > +	udelay(10);
> > +}
> REVISIT comment for these kind of magic delays if doesn't work without.

Alternatively, if writes to CODECPDZ are always supposed to have delays
after them according to the datasheet perhaps a function to wrap up the
write plus delay would be a good idea?

> > +static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> > +		int clk_id, unsigned int freq, int dir)
> > +{
> ...
> > +
> > +	infreq |= APLL_EN;
> > +	twl4030_write(codec, REG_APLL_CTL, infreq);
> > +
> > +	return 0;
> > +}

> If this actually place for set_pll callback if one wants to manage PLL
> (APLL_EN bit) dynamically?

Might be nice, yes.  That said, how much flexibility is there regarding
the PLL on this part?  If the configuration is determined very strongly
by the audio configuration and it's likely that the configuration is
entirely determined by the current audio status then it may not be worth
exposing the decision making to the user, at least for a first pass.
The impression I got from the code was that it was very fixed purpose.

If you do do this then make sure it interacts well with power_up() and
power_down().
