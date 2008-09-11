From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
Date: Thu, 11 Sep 2008 13:47:56 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E1358259F@dlee03.ent.ti.com>
References: <20080910.070827.145357958.Hiroshi.DOYU@nokia.com>
	<20080910154414.GB29054@atomide.com>
	<20080910193830.GB13467@flint.arm.linux.org.uk>
 <20080911.062153.39126340.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbYIKSsN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 14:48:13 -0400
In-Reply-To: <20080911.062153.39126340.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

Thank you for suggesting this. We will make this change.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Wednesday, September 10, 2008 10:22 PM
> To: linux@arm.linux.org.uk
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; Ramirez Luna, Omar;
> Pandita, Vikram; Guzman Lugo, Fernando; Kanigeri, Hari
> Subject: Re: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
> 
> Thanks for your comments.
> 
> From: "ext Russell King - ARM Linux" <linux@arm.linux.org.uk>
> Subject: Re: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
> Date: Wed, 10 Sep 2008 20:38:30 +0100
> 
> > On Wed, Sep 10, 2008 at 08:44:14AM -0700, Tony Lindgren wrote:
> > > * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080909 21:08]:
> > > > Hi,
> > > >
> > > > Although this TI bridge patches are not integrated and a bit
> > > > independent S/W component, it would be nice to get some comments
> just
> > > > on this bridge header file location from kernel maintainer's
> > > > perspective.
> > > >
> > > > "arch/arm/plat-omap/include/mach/bridge"
> > > >   or "arch/arm/plat-omap/include/bridge"?
> > >
> > > How about put the bridge specific headers under
> include/linux/dspbridge?
> > > Then you can have just the omap specific headers under
> > > arch/arm/plat-omap/include/mach.
> >
> > There's an advantage to having them under arch/arm/plat-
> omap/include/dspbridge
> > - it's portable.  If ever they need to become more visible, they can be
> easily
> > moved to arch/arm/include/dspbridge or include/dspbridge instead.
> 
> "arch/arm/plat-omap/include/dspbridge" sounds reasonable, at least,
> for the meanwhile.
> 
> For this header file directory name, 'dsp' prefix is needed in
> "include/'dsp'bridge" because "bridge" is too generic naming and,
> instead, "drivers/'dsp'/bridge" has 'dsp' in its path already.
> 
> 	Hiroshi DOYU
> 
> 

