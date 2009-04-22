From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Wed, 22 Apr 2009 19:55:39 +0100
Message-ID: <20090422185539.GG10356@sirena.org.uk>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:54288 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbZDVSzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 14:55:41 -0400
Content-Disposition: inline
In-Reply-To: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>

On Wed, Apr 22, 2009 at 01:58:01PM -0400, twebb wrote:

> Problem 1:
> The WM8978 sample rate PLL does not seem to be stable while DCVDD =
> DBVDD = 1.8V.  FCLK mean = 44.5KHz and jittering. Increasing DCVDD and
> DBVDD voltage above 2V increases PLL stability. We have a workaround
> for this for now.

Can I suggest that you contact Wolfson's applications support team
regarding this issue - there's a web form at:

	http://www.wolfsonmicro.com/support/technical/

Looking at the datasheet the PLL is specified as requiring a minimum of
1.9V - see page 6 of:

	http://www.wolfsonmicro.com/uploads/documents/en/WM8978_Rev4.3.pdf

> Problem 2:
> Test tone is being presented by the user application, providing a 1Khz
> tone sampled at 44.1Khz. The data are S16_LE, right channel only. Left
> channel is quiet. The data seems to slip back and forth from left to
> right channel. This is reproducable and verified with a scope trace.

> Anybody have any ideas what might be going wrong here?  Traces for
> codec reg dump and mcbsp are attached.

There have been some recent threads on this list regarding the
configuration of the McBSP port configuration for various formats - it's
probably worth checking the latest changes to the OMAP code in the
topic/asoc branch of:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

That said, I2S with the CODEC as clock master is one of the most common
configurations for OMAP so I'd expect it to be well tested.  Have you
tried testing recording?

Also CCing in Peter and Jarkko, our resident OMAP audio experts.
