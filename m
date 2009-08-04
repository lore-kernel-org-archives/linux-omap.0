From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Tue, 4 Aug 2009 22:46:09 +0200
Message-ID: <200908042246.09919.jkrzyszt@tis.icnet.pl>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl> <4A76ED80.6040001@tis.icnet.pl> <20090803181405.6249b843.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:35181 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbZHDUqs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Aug 2009 16:46:48 -0400
In-Reply-To: <20090803181405.6249b843.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Arun K S <arunks@mistralsolutions.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Monday 03 August 2009 17:14:05 Jarkko Nikula wrote:
> So it looks that McBSP-DMA for another stream cease to work if there is
> more than certain delay between first stream start and second one but
> omap_mcbsp_pollwrite or _pollread will clear the error condition. Can
> you debug is this due clearing the possible XSYNC_ERR, waiting for
> transmit/receive confirmation or playing with data registers there?

I have temporarily modified those omap_mcbsp_pollwrite/_pollread() to do 
nothing but reporting, put them into omap_mcbsp_dai_trigger() as before and 
additionally into a newly created and registered omap_mcbsp_dai_prepare(), 
called before omap_start_dma(), and got the following result:

For both playback start while capturing and capture start while playing, 
XSYNC_ERR/RSYNC_ERR is clear and XRDY/RRDY is ready, respectively, both 
before and after omap_start_dma(). No DMA transfer is actually started, so 
the operation fails with i/o error.

My interpretation based on my SPRU592 and SPRU674 understanding:

While starting the first stream, omap_mcbsp_start(), called by 
omap_mcbsp_dai_trigger(), instructs McBSP to start shifting bits in both 
directions, no matter which one has just been requested. After that, the 
direction, for which a corresponding DMA transfer has just been started from 
omap_pcm_trigger() with omap_start_dma(), starts doing its job, while the 
opposite direction, after shifting in one word in case of capture, issues a 
DMA event that is missed and waits for an I/O to occur.

Then, when omap_pcm_trigger() starts DMA for the opposite direction, the DMA 
controller, configured for synchronized transfer, waits for a corresponding 
DMA event before it performs its first I/O operation. That event already 
occurred far before and will not occur again, so the transfer will not start 
without any intervention. This time, omap_mcbsp_start() is not called again 
for an already started hardware action (correct), so there is no chance for 
the transfer to start that way.

With my patch, performing an I/O operation by calling 
omap_mcbsp_pollwrite/_pollread() forces McBSP to issue next DMA event, that 
initiates the transfer.

While starting both streams (semi)simultaneously, it may happen that the DMA 
event for the opposite direction will occur after the DMA has just been 
started for that direction as well and will not be missed, so both streams 
will run correctly.

Does it make sense, or am I missing something?

If my analysis is correct, the best solution I can see would be starting McBSP 
transfer for one direction only, not both, so the opposite direction can be 
started when needed. That requires deeper and wider OMAP knowledge and a 
change in omap_mcbsp_start() API though. I am not in a position to deal with 
this myself, I'm afraid.

Thanks,
Janusz

PS: Not CCing arch/arm/plat-omap/mcbsp.c author as his email address is 
probably out-of-date.
