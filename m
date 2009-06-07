From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Please help in adding ams-delta support to ASoC
Date: Sun, 7 Jun 2009 10:40:53 +0100
Message-ID: <20090607094053.GA18824@opensource.wolfsonmicro.com>
References: <4A1BEBE3.8010306@tis.icnet.pl> <200906060028.01600.jkrzyszt@tis.icnet.pl> <20090605224532.GA12995@sirena.org.uk> <200906061942.14276.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34487 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752814AbZFGJkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Jun 2009 05:40:51 -0400
Content-Disposition: inline
In-Reply-To: <200906061942.14276.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

On Sat, Jun 06, 2009 at 07:42:12PM +0200, Janusz Krzysztofik wrote:

> Is it possible that the codec speeks I2S, with 8-bit word, 1 word per frame, 2 
> channels at 8kHz each? Or 1 channel at 16 kHz? From what I can read in modem 
> documentation, this should rather be one 8-bit channel at 8kHz. Anyway, can 
> the transmission format I have seen ont the oscilloscope be matched against 
> any format that mcbsp can be set with current code?

The former is more likely.  Since I2S is a stereo protocol I'd not be
surprised to see a mono device choosing to transmit its data in both
left and right channels for maximum interoperability with devices that
do stereo.

> I'm still far from understanding mcbsp, but I wonder what happens if the bit 
> clock stops ater 18th bit while maybe mcbsp expects more. Perhaps this is the 
> cause of dma interrupts not being generated?

That's certainly the sort of behaviour I'd expect to see from a
programmable port like the McBSP - many of them also need to know
exactly how many bit clocks there will be in order to implement I2S due
to not paying attention to one of the edges of frame sync.  In general
things will cope if the bit clock stops providing there have been as
many edges as they're expecting to get a full sample clocked in.
