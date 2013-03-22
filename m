From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Fri, 22 Mar 2013 10:03:54 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1303220958040.7975@pmeerw.net>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net> <514C1C78.3090702@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55929 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab3CVJDz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Mar 2013 05:03:55 -0400
In-Reply-To: <514C1C78.3090702@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org


> > I'm running Linux 3.7 on a beagle-xm and observe very reproducible stereo 
> > channel swapping issue on playback of a stereo stream (one channel has a 
> > sine, the other is zero); the channel swap occurs on starting the playback

> Always? Or in like 50% of the runs? And is the record stream (IOW: the
> clocks) already running when you switch on playback?

in 10 runs, the swap can maybe observed 3 times; so: not always

I can easily turn on/off the clock for the McBSP3/TLV320AIC3104 setup; 
with McBSP3 being master I ONLY have the issue when the clock is already 
running; when I start the stream first, then turn on the clock, there is 
NO SWAP

I am not sure about the McBSP2/TWL4030 setup

> Maybe it's unreleated, but your report reminded me of this commit, which
> fixed a similar bug for pxa socs: 273b72c8c ("ASoC: pxa-ssp: atomically
> set stream active masks").

will have a look, thanks!

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
