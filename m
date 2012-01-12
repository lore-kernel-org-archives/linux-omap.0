From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/4] OMAPDSS/ASoC: Repair broken HDMI audio in K3.2-rcX
Date: Thu, 12 Jan 2012 02:59:35 +0000
Message-ID: <20120112025933.GA22775@opensource.wolfsonmicro.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com> <CAP5A+B8ZPMBROeu6wkT8G5v_e1jhYTNrCATP0mi71wcsC2DZHg@mail.gmail.com> <20111229184829.GC32392@sirena.org.uk> <1325570274.2082.5.camel@dexx0075479.dextra-mty.naucm.ext.ti.com> <20120103200908.GB2843@opensource.wolfsonmicro.com> <1326249881.1938.202.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40780 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752392Ab2ALC7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jan 2012 21:59:38 -0500
Content-Disposition: inline
In-Reply-To: <1326249881.1938.202.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

On Tue, Jan 10, 2012 at 08:44:41PM -0600, Ricardo Neri wrote:

> The approach that I am planning to follow is to move the ASOC HDMI OMAP4
> codec to the sound directory and leave all the IP-specific functions
> (e.g., to set registers) in the video directory. The audio code should
> be generic in the sense that it does not change an IP register directly.
> This is to follow a similar approach as that followed by DSS in which
> all IP-specific code is separated from DSS code. Also, it makes more
> sense to me to have the ASoC codec under sound/soc/codecs. 

Depending on how abstract that interface is it may be better to make it
into something more cross platform than just an OMAP thing - if you're
talking about not having any knowledge of the registers or anything then
it seems like that should be possible.  It would preclude the use of
something OMAP specific like DSS though.
