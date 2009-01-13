From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH 2/3] McBSP: Provide functions for ASoC frame
	syncronization
Date: Tue, 13 Jan 2009 11:20:51 +0200
Message-ID: <1231838451.13843.141.camel@eenurkka-desktop>
References: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
	 <12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
	 <12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
	 <20090113102842.8fa93ecf.jarkko.nikula@nokia.com>
	 <1231836080.13843.122.camel@eenurkka-desktop>
	 <20090113110209.10a0b9c7.jarkko.nikula@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42504 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZAMJXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 04:23:15 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0D9MVjG011482
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 03:23:12 -0600
In-Reply-To: <20090113110209.10a0b9c7.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2009-01-13 at 11:02 +0200, Jarkko Nikula wrote:
> On Tue, 13 Jan 2009 10:41:20 +0200
> Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:
> 
> > On Tue, 2009-01-13 at 10:28 +0200, Jarkko Nikula wrote:
> > > This doesn't fix problem on 2420. I assume when it works on 2420, the
> > > same fix will fix the 34xx as well. I fear the mcbsp initialization
> > > procedure in omap_mcbsp_start is not correct somewhat for 2420-34xx.
> > 
> > I somewhat disagree. I think this works OK, just fine.
> > The "feature" appears, especially if codec (aic) is a master.
> > 
> For me, the omap_mcbsp_xmit_enable and omap_mcbsp_recv_enable looks
> null op for 2420 so how it can fix problem on N810 (it has AIC33 as a
> master)?

I was talking about the initilization procedure only. Sorry for
the open door for misinformation.

> Channel switching is easy to measure just by looking when playing L or
> R data only, that data transfer is started at random WCLK polarity. If
> it works, then e.g. left channel data should visible only in low-level
> of WCLK when using I2S (+1 bit delay).
> 
> IMO, it's task of McBSP block to synhronize properly independently is
> the McBSP master or slave for WCLK and to not start DMA transfer at
> random edge like it's doing now sometimes.
> 
That would be definitely a nice feature. Possibly something that cannot
be fixed in 2420? (Maybe the XCCR and RCCR come to save the case).

> But something is clearly wrong why DMA transfer now sometimes starts at
> random edge? And why it seems to affect only playback, not capture?

I've tried also to use 32bit DMA transfers unsuccessfully. (as TRM has a
note that no less than 32 bit transfers should be used for McBSP).
Unsuccessfully meaning it still gets out of L/R sync.

Hmm. Interesting, if it doesn't affect the capture; but it's somewhat
different in the McBSP, possibly behaving differently. Something
to be discussed with TI I guess...


