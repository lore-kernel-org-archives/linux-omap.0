From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Thu, 27 Nov 2008 12:36:47 +0000
Message-ID: <20081127123645.GB3933@sirena.org.uk>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com> <20081126110854.GA6234@sirena.org.uk> <20081126134028.b3c6aa46.jarkko.nikula@nokia.com> <200811261034.42356.david-b@pacbell.net> <20081126200750.GK6234@sirena.org.uk> <40134428-B064-4C6A-9229-FBEC8918B296@student.utwente.nl> <6ed0b2680811270242i1b857f13i9494826f6089bf15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3245 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYK0Mg4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 07:36:56 -0500
Content-Disposition: inline
In-Reply-To: <6ed0b2680811270242i1b857f13i9494826f6089bf15@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Jarkko Nikula <jarkko.nikula@nokia.com>, "Stanley.Miao" <stanley.miao@windriver.com>, Steve Sakoman <steve@sakoman.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, Nov 27, 2008 at 12:42:12PM +0200, Grazvydas Ignotas wrote:

> Pandora board uses different master/slave configuration for McBSP bus,
> compared to most other boards. It also has another audio path (in
> addition to TWL4030) - another McBSP link connected to external DAC.
> The DAC needs 256*Fs clock from TWL4030 to function, and is used for
> main audio output. TWL4030 is to be used for 2 MIC + line inputs only,
> and has no outputs connected.

This definitely needs to be a separate machine driver.

> I have main audio path working (McBSP2 to DAC), but not inputs (McBSP4
> to TWL4030). How can this be implemented using current framework?
> Should I register 2 platform devices? Sorry for possible derail or
> stupid questions.

This should all be one ASoC device, especially given that the fact that
all the paths use the TWL4030 somehow.  Have a look at how, eg, the
neo1973 driver handles the bluetooth.  For now there's not
*particularly* sane support for multiple codecs.  Does the DAC have any
software control?  If not it should be fairly straightforward to handle.
