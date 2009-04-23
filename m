From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/7][RFC] OMAP4: Update common omap platform headers.
Date: Wed, 22 Apr 2009 23:22:59 -0700
Message-ID: <20090423062259.GF25864@atomide.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com> <20090421182635.GJ25864@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F3B0@dbde02.ent.ti.com> <20090422191135.GX25864@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8FADF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56021 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZDWGXB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 02:23:01 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8FADF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090422 22:18]:
> 
> > > > This ifdef we don't want to do as it blocks the compile
> > > > for multi-omap.
> > > Not sure why this should break multi-omap. As I mentioned 
> > in one of the patch OMAP4 may not be
> > > able to support multi-omap because of major differences on 
> > Memory controller and Interrupt handling.
> > > This macro ensures that only for OMAP4 all the IRQ lines 
> > are offseted by 32 and for rest of the OMAPs the offset is 
> > zero. Because that's the only change necessary.
> > > 
> > > May be I haven't understood your point here.
> > 
> > It makes the irq lines wrong if CONFIG_ARCH_OMAP4 and 
> > CONFIG_ARCH_OMAP3
> > are selected.
> 
> Agree. My assumption was OMAP3 and OMAP4 both won't get selected together. If they are then it's straight makes IRQ lines wrong. 
> > > > 
> > > > How about just add extra + 32 to the omap4 specific
> > > > defines? Something like this maybe:
> > > > 
> > > > #define OMAP4_GIC_OFFSET	32
> > > > #define INT_44XX_SP15_IRQ (69 + IRQ_GIC_START + OMAP4_GIC_OFFSET)
> > > > 
> > > > It's OK to define the numbers separately for each processors:
> > > 
> > > I thought about this but this will have impact on the 
> > drivers as well. In every driver you need to put different 
> > IRQ line macros depending on the OMAP2/3/4.
> > 
> > No. The interrupt numbers are coming from platform_data. You always
> > have separate platform_data for different processors.
> > 
> > > Just as an example UART1 uses "INT_24XX_UART1_IRQ" as the 
> > IRQ line number for OMAP2, OMAP3 and now for OMAP4 ( just 
> > offseted by 32).
> > 
> > This needs to be fixed in the serial code. I believe that's already
> > in Kevin's patches.
> > 
> > > If we define separate macros for each processor, we would 
> > be unnecessarily polluting the driver code with switches. 
> > Secondly, in this file itself we will be adding around 100 + 
> > lines of code just to take care of 32 offset.
> > 
> > The numbers are not the same. It's OK to add separate defines for
> > data that is not the same. The unused defines just will not be
> > used anywhere.
> If we agree to cleanup the driver platform structures wherever needed, then no issues with separate lines. In that case no #ifdef necessary. Bye the way 
> #define INT_44XX_SP15_IRQ (69 + OMAP4_GIC_OFFSET) is sufficient. Any particul;ar reason you want it this way.
> #define INT_44XX_SP15_IRQ (69 + IRQ_GIC_START + OMAP4_GIC_OFFSET) ?

No reason, unless there's some logic to the numbering where the
offset makes things easier to read :)

Tony
