From: Tony Lindgren <tony@atomide.com>
Subject: Re: [alsa-devel] [PATCH 0/4] ASOC: Add AM3517 EVM support in ASOC
Date: Wed, 3 Feb 2010 17:51:02 -0800
Message-ID: <20100204015102.GO22747@atomide.com>
References: <1256842337-30334-1-git-send-email-anuj.aggarwal@ti.com>
 <20091029222933.GA7953@sirena.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB031E4F20BB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51370 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0BDBuj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 20:50:39 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E4F20BB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

* Aggarwal, Anuj <anuj.aggarwal@ti.com> [100129 00:13]:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> > Sent: Friday, October 30, 2009 4:00 AM
> > To: Aggarwal, Anuj
> > Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org;
> > tony@atomide.com
> > Subject: Re: [alsa-devel] [PATCH 0/4] ASOC: Add AM3517 EVM support in ASOC
> > 
> > On Fri, Oct 30, 2009 at 12:22:17AM +0530, Anuj Aggarwal wrote:
> > > This patch series add support for OMAP3517 / AM3517 EVM in ASOC.
> > > It also enables the required drivers - I2C and McBSP, along with
> > > Alsa SoC subsystem, in the default configuration for the EVM.
> > >
> > > Anuj Aggarwal (4):
> > >   Audio: Adding OMAP3517 / AM3517 EVM support in ASOC
> > >   Audio: Modifying Kconfig/Makefile for AM3517 EVM
> > >   Audio: Modifying board-evm file for audio codec
> > >   Audio: Modifying the defconfig for OMAP3517 / AM3517 EVM
> > 
> > These all look good - I've applied patches 1 and 2 to ASoC, patches 3
> > and 4 should go via OMAP and are
> Tony,
> 
> I could not find patches 3 & 4 on l-o master. Am I looking at the right 
> branch?

Hmm, well I still have about 70 patches pending and have
not yet gotten into looking at the board-*.c files that much..

But looks like I had marked these as "awaiting upstream".
I've marked them "new" again and will queue into omap for-next
when I get to dealing with the board-*.c files.

BTW, I assume these two patches are the missing ones:

http://patchwork.kernel.org/patch/56501/
http://patchwork.kernel.org/patch/56502/

Regards,

Tony

 
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > 
> > if it helps (or even if it doesn't!).  Thanks.
> 
