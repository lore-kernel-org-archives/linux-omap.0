From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Tue, 8 Feb 2011 16:35:37 -0800
Message-ID: <20110209003537.GQ20795@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
 <20110208164747.GD6188@n2100.arm.linux.org.uk>
 <78d0134576ace6be5874871076cf0c10@mail.gmail.com>
 <alpine.LFD.2.00.1102081537010.14920@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42345 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab1BIAgJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 19:36:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102081537010.14920@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110208 12:41]:
> On Tue, 8 Feb 2011, Santosh Shilimkar wrote:
> 
> > > I think it's probably going to be better to _purposely_ break the 
> > > OMAP build when it covers v6 and v7 CPUs in these kernels as I don't 
> > > think it's sanely fixable given where we are.
> 
> Agreed.  At least making SMP unavailable when both v6 and v7 are 
> configured should be small and good enough for 2.6.38-rc5.

That's probably the best solution as then we can still do boot
testing on all omap2plus_defconfig boards.

Tony
