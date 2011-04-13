From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 13 Apr 2011 10:49:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104131041590.24613@xanadu.home>
References: <20110314192538.GH7258@atomide.com> <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com> <4D7FC70D.7050508@ti.com> <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com> <4D80CA2F.8060300@ti.com>
 <alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com> <20110329233243.GR4016@atomide.com> <87lizwskcc.fsf@ti.com> <alpine.DEB.1.10.1103311722520.2634@esdhcp041196.research.nokia.com> <alpine.LFD.2.00.1104012241230.28032@xanadu.home>
 <20110413140429.GF12665@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35318 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363Ab1DMOt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Apr 2011 10:49:28 -0400
Received: by qyk7 with SMTP id 7so2727309qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Apr 2011 07:49:28 -0700 (PDT)
In-Reply-To: <20110413140429.GF12665@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 13 Apr 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nicolas.pitre@linaro.org> [110402 05:40]:
> > On Thu, 31 Mar 2011, Aaro Koskinen wrote:
> > 
> > > Hi,
> > > 
> > > On Wed, 30 Mar 2011, Kevin Hilman wrote:
> > > > Tony Lindgren <tony@atomide.com> writes:
> > > > > FYI, looks like we've started hitting some booter -l kernel size limit
> > > > > in addition to booter -f size limit.. Now kernels built with
> > > > > omap2plus_defconfig won't boot on n900 any longer.
> > > 
> > > I guess you are seeing it just hanging at "Uncompressing Linux... done,
> > > booting the kernel."?
> > > 
> > > > > I guess the way around that is to install the u-boot loader package.
> > > > 
> > > > Alternatively CONFIG_KERNEL_LZMA=y will get the kernel zImage size back
> > > > within size limits that will boot on n900.
> > > 
> > > Hmm, I'm a bit puzzled. For me, .38 works but .39-rc1 does not, and I
> > > can't see any "special" limit exceeded. Also LZMA is broken:
> > > 
> > > 	Uncompressing Linux...
> > > 
> > > 	LZMA data is corrupt
> > > 
> > > 	-- System halted
> > > 
> > > I did some bisecting, and with the following commit reverted -rc1 works:
> > > 
> > > 	commit d239b1dc093d551046a909920b5310c1d1e308c1
> > > 	Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > 	Date:   Mon Feb 21 04:57:38 2011 +0100
> > > 
> > > 	ARM: 6746/1: remove the 4x expansion presumption while decompressing
> > > the kernel
> > > 
> > > With the revert, also bigger gzipped kernel works.
> > 
> > OK I will have a look.
> 
> Hmm while playing with the device tree append patch, decompress_kernel
> trashes the first 16 bytes of the device tree data. Now I wonder if these
> issues are related..
> 
> Aaro, you mentioned to me that reverting commit 
> 6d7d0ae51574943bf571d269da3243257a2d15db helps too?
> 
> With the device tree append patch reverting commit
> d239b1dc093d551046a909920b5310c1d1e308c1 does not help, and reverting
> 6d7d0ae51574943bf571d269da3243257a2d15db requires some manual merging..

You cannot use the DT append patch without 6d7d0ae515 in place.  The 
later is a prerequisite for the former.

> Anyways, that might be another way to reproduce the problem if these
> issues are related.

I've started to instrument the problematic CONFIG_KERNEL_LZMA case.  So 
far this is still a mystery.

Do you have problems with the DT append patch even with 
CONFIG_KERNEL_GZIP=y?


Nicolas
