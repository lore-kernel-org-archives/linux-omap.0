From: Tony Lindgren <tony@atomide.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Tue, 19 Apr 2011 07:15:31 -0700
Message-ID: <20110419141531.GH477@atomide.com>
References: <alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com>
 <20110329233243.GR4016@atomide.com>
 <87lizwskcc.fsf@ti.com>
 <alpine.DEB.1.10.1103311722520.2634@esdhcp041196.research.nokia.com>
 <alpine.LFD.2.00.1104012241230.28032@xanadu.home>
 <20110413140429.GF12665@atomide.com>
 <alpine.LFD.2.00.1104131041590.24613@xanadu.home>
 <20110413150948.GB13345@atomide.com>
 <20110419101302.GF477@atomide.com>
 <alpine.LFD.2.00.1104190924030.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:33638 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1DSOPh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 10:15:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1104190924030.24613@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Nicolas Pitre <nicolas.pitre@linaro.org> [110419 06:24]:
> On Tue, 19 Apr 2011, Tony Lindgren wrote:
> 
> > Aaro and I speculated that boards using u-boot with uImage work,
> > while n900 is using zImage and fails with the same kernel probably
> > because of the different placement of compressed image in the
> > memory.
> 
> Could you try the following (by changing the argument to mkimage 
> accordingly).
>
> Try to load the kernel at the following offsets:
> 
> - 0x8000 from start of memory
> 
> - 0x100000 from start of memory
> 
> - 0x3000000 from start of memory
> 
> and tell me if any of those behaves differently?

Hmm good idea, but no luck so far :( Did the tests with
setenv loadaddr in u-boot as that's what it seems to use.

v2.6.39-rc4 boots uImage with all those just fine. And with
the DT append and related patches, it always fails if DT data
is appended.

So for some reason loading a kernel on n900 with flasher -l
always fails (except for smaller kernels) and DT append with
data appended always fails.

Regards,

Tony
