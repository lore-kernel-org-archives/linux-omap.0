From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/3] McBSP: Provide functions for ASoC frame
 syncronization
Date: Tue, 13 Jan 2009 11:02:09 +0200
Message-ID: <20090113110209.10a0b9c7.jarkko.nikula@nokia.com>
References: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
	<12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
	<12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
	<20090113102842.8fa93ecf.jarkko.nikula@nokia.com>
	<1231836080.13843.122.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63808 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbZAMJC6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 04:02:58 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0D92g8D012069
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 11:02:55 +0200
In-Reply-To: <1231836080.13843.122.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

On Tue, 13 Jan 2009 10:41:20 +0200
Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:

> On Tue, 2009-01-13 at 10:28 +0200, Jarkko Nikula wrote:
> > This doesn't fix problem on 2420. I assume when it works on 2420, the
> > same fix will fix the 34xx as well. I fear the mcbsp initialization
> > procedure in omap_mcbsp_start is not correct somewhat for 2420-34xx.
> 
> I somewhat disagree. I think this works OK, just fine.
> The "feature" appears, especially if codec (aic) is a master.
> 
For me, the omap_mcbsp_xmit_enable and omap_mcbsp_recv_enable looks
null op for 2420 so how it can fix problem on N810 (it has AIC33 as a
master)?

> One cannot say in which state the WCLK (provided by aic) is.
> Aic is started prior to McBSP, right?
> So when the DMA transfer starts, the WCLK may be about
> (depending on CPU load etc) to transition down, and then the L
> data goes into R data. As the BCLK clocks in the data. Right?
> 
Channel switching is easy to measure just by looking when playing L or
R data only, that data transfer is started at random WCLK polarity. If
it works, then e.g. left channel data should visible only in low-level
of WCLK when using I2S (+1 bit delay).

IMO, it's task of McBSP block to synhronize properly independently is
the McBSP master or slave for WCLK and to not start DMA transfer at
random edge like it's doing now sometimes.

But something is clearly wrong why DMA transfer now sometimes starts at
random edge? And why it seems to affect only playback, not capture?


Jarkko
