From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2/3: Reorganize Makefile to add omap4 support
	(Re: [PATCH 7/7][RFC] OMAP4: Enable basic build support.)
Date: Wed, 22 Apr 2009 23:21:30 -0700
Message-ID: <20090423062129.GE25864@atomide.com>
References: <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-6-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-7-git-send-email-santosh.shilimkar@ti.com> <20090421183940.GN25864@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F40C@dbde02.ent.ti.com> <20090422190456.GW25864@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8FADB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55167 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbZDWGVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 02:21:34 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8FADB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090422 22:07]:
> > > > This ifeq else we don't want to do as it breaks things 
> > for multi-omap.
> > > 
> > > How do we handle this. For OMAP4, those files are not 
> > common and needed at this point of time. More so if we agree 
> > that OMAP4 won't support multi-omap, then this should be ok.
> > 
> > No way we're dropping multi-omap for a few ifdefs.
> >
> > We need to have code where we can compile in all the selected things.
> > In this case we should be able to select any combination of 
> > CONFIG_ARCH_OMAP2,
> > CONFIG_ARCH_OMAP3, CONFIG_ARCH_OMAP4. And the code already 
> > gets optimized if
> > only one is selected.
> > 
> > The recent omap2 clock breakage with trivial clock patches is 
> > already a
> > good enough reason to support the multi-omap. So basically 
> > all the developers
> > should do their builds with the multi-omap selected.
> > 
> > Also the distros want multi-omap. Only the product specific kernels
> > should be built with only one option selected to optimize for 
> > speed and size.
> I think most of the things are in place for multi-omap for OMAP4 as well if all the comments are taken care. 

Yeah cool. Looks like the gic interrupt code can also be initialized
from the init_common_hw or so. Of course the entry-macro.S still
needs a separate non-optimized handler for things to boot, I'll
update an earlier patch for that at some point.

> > > Some thing like this can be done but then Makefile will be 
> > completely rewamped. 
> > > 
> > > # Common support
> > > obj-y := id.o io.o control.o mux.o devices.o serial.o 
> > gpmc.o timer-gp.o
> > > 
> > > obj-$(CONFIG_ARCH_OMAP2) += display.o sdrc.o prcm.o clock.o 
> > powerdomain.o clockdomain.o
> > > obj-$(CONFIG_ARCH_OMAP3) += display.o sdrc.o prcm.o clock.o 
> > powerdomain.o clockdomain.o
> > > 
> > > Is this OK ?
> > 
> > How about the attached patch?
> Looks good. After adding clock support stubs we need to compile almost all files except 'clock.c' so we may not need this completely. But any case, the patch looks cleaner.

OK

Tony
