From: Tony Lindgren <tony@atomide.com>
Subject: Re: [alsa-devel] [PATCH 3/5] ALSA: ASoC: Add support for TWL4030
	audio codec (rev 3)
Date: Mon, 8 Sep 2008 17:49:46 -0700
Message-ID: <20080909004945.GK29054@atomide.com>
References: <1220769704-16705-1-git-send-email-sakoman@gmail.com> <1220769704-16705-2-git-send-email-sakoman@gmail.com> <1220769704-16705-3-git-send-email-sakoman@gmail.com> <1220769704-16705-4-git-send-email-sakoman@gmail.com> <20080908095607.GC790@sirena.org.uk> <5e088bd90809081116v58ff6b14rd2331e5fccaeb097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59030 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbYIIAtt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 20:49:49 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809081116v58ff6b14rd2331e5fccaeb097@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>

* Steve Sakoman <sakoman@gmail.com> [080908 11:16]:
> On Mon, Sep 8, 2008 at 2:56 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> > On Sat, Sep 06, 2008 at 11:41:42PM -0700, sakoman@gmail.com wrote:
> >
> >> +
> >> +config SND_SOC_TWL4030
> >> +     tristate
> >> +     depends on SND_SOC && I2C
> >> +
> >
> > Sorry, didn't notice earlier: this should depend on whatever the config
> > option is for the TWL4030 core driver rather than on I2C since it
> > doesn't actually interact with I2C directly.  Although in most
> > applications this won't make much odds since the machine driver will
> > select the codec driver and select ignores the dependencies anyway.
> 
> You are correct.  Good catch, though as you say it doesn't really
> matter in practice.
> 
> I will re-submit a version with this fixed nonetheless.

Pushing this series to linux-omap today with the re-submitted version
of patch 3/5.

Tony
