From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 3/5] SOUND: SOC: CODECS: Add support for the TWL4030 audio codec
Date: Fri, 5 Sep 2008 11:06:46 +0100
Message-ID: <20080905100646.GC12383@sirena.org.uk>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com> <1220504520-6067-2-git-send-email-sakoman@gmail.com> <1220504520-6067-3-git-send-email-sakoman@gmail.com> <1220504520-6067-4-git-send-email-sakoman@gmail.com> <20080904120441.GB21663@sirena.org.uk> <5e088bd90809040748u5f487c4fy3f347b851a8d7d7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4739 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYIEKGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 06:06:48 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809040748u5f487c4fy3f347b851a8d7d7b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>

On Thu, Sep 04, 2008 at 07:48:02AM -0700, Steve Sakoman wrote:
> On Thu, Sep 4, 2008 at 5:04 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> > Normally SND_SOC_BIAS_STANDBY would leave Vmid enabled but your power
> > down function turns it off.  The normal thing here is to have standby
> > bring the codec up and then apply relatively small tweaks in _ON and

...

> > Does the codec have any bypass paths that can be set up?  If not it
> > shouldn't do much harm either way until you implement DAPM.

> How about I add a "TODO" on this?  I'm swamped for the next few weeks
> and won't be able to give it the attention it deserves test-wise.

Like I say, if the codec/driver implement any bypass paths (paths that
carry audio from the inputs to the outputs without using the DAC or ADC)
then it'll break those - the device will be brought down to standby when
there is no playback or record going, which will power the bypass paths
down.  If that is an issue then documenting it (ideally with printks for
users) should cover it for now.

If there aren't any bypass paths then it should be fine to leave it
as-is.
