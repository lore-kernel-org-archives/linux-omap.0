From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 0/4] OMAPDSS/ASoC: Repair broken HDMI audio in K3.2-rcX
Date: Tue, 10 Jan 2012 20:44:41 -0600
Message-ID: <1326249881.1938.202.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
	 <CAP5A+B8ZPMBROeu6wkT8G5v_e1jhYTNrCATP0mi71wcsC2DZHg@mail.gmail.com>
	 <20111229184829.GC32392@sirena.org.uk>
	 <1325570274.2082.5.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
	 <20120103200908.GB2843@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55345 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756993Ab2AKCot (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 21:44:49 -0500
In-Reply-To: <20120103200908.GB2843@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "K, Mythri P" <mythripk@ti.com>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

Hi Mark,

Sorry, I missed this e-mail...

On Tue, 2012-01-03 at 20:09 +0000, Mark Brown wrote:
> On Mon, Jan 02, 2012 at 11:57:54PM -0600, Ricardo Neri wrote:
> > On Thu, 2011-12-29 at 18:48 +0000, Mark Brown wrote:
> > > On Thu, Dec 29, 2011 at 03:26:48PM +0530, K, Mythri P wrote:
> 
> > > > We could not also try to move the ASoC HDMI audio codec driver from
> > > > DSS to sound, but this is good for now.
> 
> > > You should certainly send the driver for review on the ALSA list...
> 
> > Yes, the goal is to move the ASoC OMAP4 HDMI codec to sound for K3.3. I
> > will submit to the ALSA list when I have a first draft.
> 
> It shouldn't really have hit mainline without ALSA side review.  For the
> HDMI stuff it's not actually clear that keeping the CPU side code out of
> the video directory is sensible, there's rather more video complexity
> than audio going on and the two are heavily interlinked.  The main thing
> is to make sure that the code that's there is sensible.

The approach that I am planning to follow is to move the ASOC HDMI OMAP4
codec to the sound directory and leave all the IP-specific functions
(e.g., to set registers) in the video directory. The audio code should
be generic in the sense that it does not change an IP register directly.
This is to follow a similar approach as that followed by DSS in which
all IP-specific code is separated from DSS code. Also, it makes more
sense to me to have the ASoC codec under sound/soc/codecs. 

In order to implement it, we would obtain the parameters required by
audio (such as the pixel clock, deep color configuration) using DSS
functions. Also, callbacks would be required to notify events such as
HDMI plug/unplug events, changes in video resolutions, etc.

In my opinion, this would make the code clearer and more logical. It
could also help in isolating future changes that are audio or
IP-specific. On the down side, it could also slow-down the intergration
of some changes. For instance, if a new IP-specific function is required
by audio, audio code could only be integrated after the IP-specific
change is integrated under DSS, but as you mention, HDMI video and audio
are tightly interlinked and such dependency will never go away.

What do you think?

Ricardo

