From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 3/5] SOUND: SOC: CODECS: Add support for the TWL4030 audio codec
Date: Fri, 5 Sep 2008 11:30:40 +0100
Message-ID: <20080905103040.GD12383@sirena.org.uk>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com> <1220504520-6067-2-git-send-email-sakoman@gmail.com> <1220504520-6067-3-git-send-email-sakoman@gmail.com> <1220504520-6067-4-git-send-email-sakoman@gmail.com> <20080904132632.e64c3ce2.jarkko.nikula@nokia.com> <5e088bd90809040732x24b2123cl68fa9d2242ae2ae0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3059 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbYIEKan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 06:30:43 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809040732x24b2123cl68fa9d2242ae2ae0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

On Thu, Sep 04, 2008 at 07:32:28AM -0700, Steve Sakoman wrote:
> On Thu, Sep 4, 2008 at 3:26 AM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:

> >> +static void twl4030_dump_registers(void)
> >> +{

> > This is not needed since there is already nice function
> > for it: sound/soc/soc-core.c: codec_reg_show.

> I could probably get rid of this function.  It was quite useful during
> debugging and I was not aware of codec_reg_show.  IIRC, most of the
> other codec drivers also have the equivalent of this function, so we
> might want to clean them up too if there is a standard function to
> replace them.

Any references?  None of the in-tree drivers have them...

> >> +static void twl4030_power_down(struct snd_soc_codec *codec)
> >> +{
> > ...
> >> +     udelay(10);
> >> +}
> > REVISIT comment for these kind of magic delays if doesn't work without.

> It *seems* to work without them, but every historic TI driver seemed
> to have them.  I figured that they might know something not reflected
> in the documentation.  I will add a REVIST comment.

This sort of stuff is very common in codec drivers - normally the delays
are there to allow the analogue side of the system time to settle down
(waiting for capacitors to charge/discharge or reference voltages to
stabalise, for example).  Ideally they have comments saying what's going
on, of course.  Missing these delays often won't actually stop things
working completely but will instead do things like reduce performance or
generate audio artefacts - and sometimes it's application dependant if
these are important.
