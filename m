From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH RESEND v4 1/4] omap3: nand: prefetch in irq mode support
Date: Fri, 24 Sep 2010 18:03:21 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B031619ED96@dbde02.ent.ti.com>
References: <1284624059-1741-1-git-send-email-s-ghorai@ti.com>
 <1284624059-1741-2-git-send-email-s-ghorai@ti.com>
 <20100917175504.GG29610@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B031606213F@dbde02.ent.ti.com>
 <20100921145820.GQ4611@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58280 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab0IXMdb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 08:33:31 -0400
In-Reply-To: <20100921145820.GQ4611@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, September 21, 2010 8:28 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH RESEND v4 1/4] omap3: nand: prefetch in irq mode
> support
> 
> * Ghorai, Sukumar <s-ghorai@ti.com> [100918 11:16]:
> > >
> > > This handler should be in gpmc.c as it may be needed for other GPMC
> > > connected devices on the same system. You can use chained irq handlers
> > > to allow all the drivers to use the interrupt then.
> >
> > [Ghorai]
> > You mean as this function used the gpmc-irq number in nand file, so
> handler should move to gpmc.c file?
> 
> Yes, other GPMC connected drivers may want to use it too for their chip
> selects.
> 
> > 	1. For that we need to add one io-struct (to keep io buffer status)
> in gpmc.c;
> >
> > 	2. Also need help how to sync between gpmc.c/omap_nand_irq() and
> omap2.c/omap_write_buf_irq_pref(), men how read/write function know that
> work done in interrupt-context? Or you prefer to move the complete IO
> function (omap_read/write_buf_irq_pref) to gpmc.c?
> >
> > 	3. gpmc does not now about the read and write address that's
> applicable for NAND. So how to pass the IO address from omap2.c to gpmc.c,
> interrupt handler?
> 
> Hmm, I don't follow you. You can have the interrupt handler
> both in gpmc.c and in the nand driver with set_irq_chained_handler()
> and set_irq_data(). We are doing that already in lots of places,
> like gpio.c and twl4030-irq.c.
[Ghorai] Thanks. I am working on it; and will re-submit.
> 
> > So, please let me know your suggestion again such that I can post this
> time itself. Otherwise again it will miss from coming release, this was
> posted/reviewed for last release too. And suggest to void repeating of
> missing release window again.
> 
> Yes would be nice to get this patch in, to me it seems that this
> issue is the only blocker. It should be pretty easy change to
> make.
> 
> Regards,
> 
> Tony
