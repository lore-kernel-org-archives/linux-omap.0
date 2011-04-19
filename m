From: Tony Lindgren <tony@atomide.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Tue, 19 Apr 2011 03:13:02 -0700
Message-ID: <20110419101302.GF477@atomide.com>
References: <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com>
 <4D80CA2F.8060300@ti.com>
 <alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com>
 <20110329233243.GR4016@atomide.com>
 <87lizwskcc.fsf@ti.com>
 <alpine.DEB.1.10.1103311722520.2634@esdhcp041196.research.nokia.com>
 <alpine.LFD.2.00.1104012241230.28032@xanadu.home>
 <20110413140429.GF12665@atomide.com>
 <alpine.LFD.2.00.1104131041590.24613@xanadu.home>
 <20110413150948.GB13345@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58051 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab1DSKNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 06:13:08 -0400
Content-Disposition: inline
In-Reply-To: <20110413150948.GB13345@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [110413 08:06]:
> * Nicolas Pitre <nicolas.pitre@linaro.org> [110413 17:46]:
> > On Wed, 13 Apr 2011, Tony Lindgren wrote:
> > > 
> > > With the device tree append patch reverting commit
> > > d239b1dc093d551046a909920b5310c1d1e308c1 does not help, and reverting
> > > 6d7d0ae51574943bf571d269da3243257a2d15db requires some manual merging..
> > 
> > You cannot use the DT append patch without 6d7d0ae515 in place.  The 
> > later is a prerequisite for the former.
> 
> OK.
>  
> > > Anyways, that might be another way to reproduce the problem if these
> > > issues are related.
> > 
> > I've started to instrument the problematic CONFIG_KERNEL_LZMA case.  So 
> > far this is still a mystery.
> > 
> > Do you have problems with the DT append patch even with 
> > CONFIG_KERNEL_GZIP=y?
> 
> Yup. The devicetree data gets trashed by decompress_kernel
> with CONFIG_KERNEL_GZIP too with the append patch.
> 
> DT data before decompress_kernel:
> edfe0dd0 2c010000 38000000 f0000000
> 
> DT data after decompress_kernel:
> 10000000 00000001 38000000 f0000000
> 
> So first 8 (not 16 bytes like I mentioned earlier) get trashed.

Aaro and I speculated that boards using u-boot with uImage work,
while n900 is using zImage and fails with the same kernel probably
because of the different placement of compressed image in the
memory.

Also boards using u-boot with uImage fail with the DT append
patch if some DT data is appended to zImage before mkimage.

Hardcoding the uncompressed image size about 2MB larger in
arch/arm/boot/Makefile makes booting n900 work. This will not
solve the DT append problem, or at least would require padding
the uncompressed image size accordingly before appending DT
data..

Tony

