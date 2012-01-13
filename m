From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 0/4] OMAPDSS/ASoC: Repair broken HDMI audio in K3.2-rcX
Date: Thu, 12 Jan 2012 20:23:33 -0600
Message-ID: <1326421413.2015.54.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
	 <CAP5A+B8ZPMBROeu6wkT8G5v_e1jhYTNrCATP0mi71wcsC2DZHg@mail.gmail.com>
	 <20111229184829.GC32392@sirena.org.uk>
	 <1325570274.2082.5.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
	 <20120103200908.GB2843@opensource.wolfsonmicro.com>
	 <1326249881.1938.202.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
	 <20120112025933.GA22775@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35789 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427Ab2AMCXi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 21:23:38 -0500
In-Reply-To: <20120112025933.GA22775@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "K, Mythri P" <mythripk@ti.com>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

HI Mark,
On Thu, 2012-01-12 at 02:59 +0000, Mark Brown wrote:
> On Tue, Jan 10, 2012 at 08:44:41PM -0600, Ricardo Neri wrote:
> 
> > The approach that I am planning to follow is to move the ASOC HDMI OMAP4
> > codec to the sound directory and leave all the IP-specific functions
> > (e.g., to set registers) in the video directory. The audio code should
> > be generic in the sense that it does not change an IP register directly.
> > This is to follow a similar approach as that followed by DSS in which
> > all IP-specific code is separated from DSS code. Also, it makes more
> > sense to me to have the ASoC codec under sound/soc/codecs. 
> 
> Depending on how abstract that interface is it may be better to make it
> into something more cross platform than just an OMAP thing - if you're
> talking about not having any knowledge of the registers or anything then
> it seems like that should be possible.  It would preclude the use of
> something OMAP specific like DSS though.

Maybe what I am trying to do is something similar to what is done for
the TWL6040 drivers: the power part goes to drivers/mfd and and the
audio part goes to sound. In my case, the video part goes to DSS and the
audio part goes to sound plus taking advantage of the the register
abstraction and functionality that DSS is trying to provide. As you
mention, this ties me to OMAP atm. I am an audio person :) and I am not
sure all the functionality I require for audio is exported to more
generic layers to allow not using DSS. I could try go take a look.

Ricardo

