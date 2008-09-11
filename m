From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
Date: Thu, 11 Sep 2008 06:21:53 +0300 (EEST)
Message-ID: <20080911.062153.39126340.Hiroshi.DOYU@nokia.com>
References: <20080910.070827.145357958.Hiroshi.DOYU@nokia.com>
	<20080910154414.GB29054@atomide.com>
	<20080910193830.GB13467@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32873 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbYIKDWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 23:22:34 -0400
In-Reply-To: <20080910193830.GB13467@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-omap@vger.kernel.org, x00omar@ti.com, vikram.pandita@ti.com, x0095840@ti.com, h-kanigeri2@ti.com

Thanks for your comments.

From: "ext Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
Date: Wed, 10 Sep 2008 20:38:30 +0100

> On Wed, Sep 10, 2008 at 08:44:14AM -0700, Tony Lindgren wrote:
> > * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080909 21:08]:
> > > Hi,
> > > 
> > > Although this TI bridge patches are not integrated and a bit
> > > independent S/W component, it would be nice to get some comments just
> > > on this bridge header file location from kernel maintainer's
> > > perspective.
> > > 
> > > "arch/arm/plat-omap/include/mach/bridge"
> > >   or "arch/arm/plat-omap/include/bridge"?
> > 
> > How about put the bridge specific headers under include/linux/dspbridge?
> > Then you can have just the omap specific headers under
> > arch/arm/plat-omap/include/mach.
> 
> There's an advantage to having them under arch/arm/plat-omap/include/dspbridge
> - it's portable.  If ever they need to become more visible, they can be easily
> moved to arch/arm/include/dspbridge or include/dspbridge instead.

"arch/arm/plat-omap/include/dspbridge" sounds reasonable, at least,
for the meanwhile.

For this header file directory name, 'dsp' prefix is needed in
"include/'dsp'bridge" because "bridge" is too generic naming and,
instead, "drivers/'dsp'/bridge" has 'dsp' in its path already.

	Hiroshi DOYU


