From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/4] OMAPDSS/ASoC: Repair broken HDMI audio in K3.2-rcX
Date: Tue, 3 Jan 2012 20:09:09 +0000
Message-ID: <20120103200908.GB2843@opensource.wolfsonmicro.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
 <CAP5A+B8ZPMBROeu6wkT8G5v_e1jhYTNrCATP0mi71wcsC2DZHg@mail.gmail.com>
 <20111229184829.GC32392@sirena.org.uk>
 <1325570274.2082.5.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33819 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754731Ab2ACUJM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 15:09:12 -0500
Content-Disposition: inline
In-Reply-To: <1325570274.2082.5.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

On Mon, Jan 02, 2012 at 11:57:54PM -0600, Ricardo Neri wrote:
> On Thu, 2011-12-29 at 18:48 +0000, Mark Brown wrote:
> > On Thu, Dec 29, 2011 at 03:26:48PM +0530, K, Mythri P wrote:

> > > We could not also try to move the ASoC HDMI audio codec driver from
> > > DSS to sound, but this is good for now.

> > You should certainly send the driver for review on the ALSA list...

> Yes, the goal is to move the ASoC OMAP4 HDMI codec to sound for K3.3. I
> will submit to the ALSA list when I have a first draft.

It shouldn't really have hit mainline without ALSA side review.  For the
HDMI stuff it's not actually clear that keeping the CPU side code out of
the video directory is sensible, there's rather more video complexity
than audio going on and the two are heavily interlinked.  The main thing
is to make sure that the code that's there is sensible.
