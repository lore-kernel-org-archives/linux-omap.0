From: Tony Lindgren <tony@atomide.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 13 Apr 2011 18:09:50 +0300
Message-ID: <20110413150948.GB13345@atomide.com>
References: <4D7FC70D.7050508@ti.com>
 <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com>
 <4D80CA2F.8060300@ti.com>
 <alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com>
 <20110329233243.GR4016@atomide.com>
 <87lizwskcc.fsf@ti.com>
 <alpine.DEB.1.10.1103311722520.2634@esdhcp041196.research.nokia.com>
 <alpine.LFD.2.00.1104012241230.28032@xanadu.home>
 <20110413140429.GF12665@atomide.com>
 <alpine.LFD.2.00.1104131041590.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51303 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130Ab1DMPJx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Apr 2011 11:09:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1104131041590.24613@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Nicolas Pitre <nicolas.pitre@linaro.org> [110413 17:46]:
> On Wed, 13 Apr 2011, Tony Lindgren wrote:
> > 
> > With the device tree append patch reverting commit
> > d239b1dc093d551046a909920b5310c1d1e308c1 does not help, and reverting
> > 6d7d0ae51574943bf571d269da3243257a2d15db requires some manual merging..
> 
> You cannot use the DT append patch without 6d7d0ae515 in place.  The 
> later is a prerequisite for the former.

OK.
 
> > Anyways, that might be another way to reproduce the problem if these
> > issues are related.
> 
> I've started to instrument the problematic CONFIG_KERNEL_LZMA case.  So 
> far this is still a mystery.
> 
> Do you have problems with the DT append patch even with 
> CONFIG_KERNEL_GZIP=y?

Yup. The devicetree data gets trashed by decompress_kernel
with CONFIG_KERNEL_GZIP too with the append patch.

DT data before decompress_kernel:
edfe0dd0 2c010000 38000000 f0000000

DT data after decompress_kernel:
10000000 00000001 38000000 f0000000

So first 8 (not 16 bytes like I mentioned earlier) get trashed.

Regards,

Tony
