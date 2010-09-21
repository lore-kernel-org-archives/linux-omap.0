From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND v4 1/4] omap3: nand: prefetch in irq mode support
Date: Tue, 21 Sep 2010 07:58:21 -0700
Message-ID: <20100921145820.GQ4611@atomide.com>
References: <1284624059-1741-1-git-send-email-s-ghorai@ti.com>
 <1284624059-1741-2-git-send-email-s-ghorai@ti.com>
 <20100917175504.GG29610@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B031606213F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56609 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab0IUO6T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 10:58:19 -0400
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B031606213F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Ghorai, Sukumar <s-ghorai@ti.com> [100918 11:16]:
> > 
> > This handler should be in gpmc.c as it may be needed for other GPMC
> > connected devices on the same system. You can use chained irq handlers
> > to allow all the drivers to use the interrupt then.
> 
> [Ghorai] 
> You mean as this function used the gpmc-irq number in nand file, so handler should move to gpmc.c file? 

Yes, other GPMC connected drivers may want to use it too for their chip selects.

> 	1. For that we need to add one io-struct (to keep io buffer status) in gpmc.c; 
>
> 	2. Also need help how to sync between gpmc.c/omap_nand_irq() and omap2.c/omap_write_buf_irq_pref(), men how read/write function know that work done in interrupt-context? Or you prefer to move the complete IO function (omap_read/write_buf_irq_pref) to gpmc.c?
> 
> 	3. gpmc does not now about the read and write address that's applicable for NAND. So how to pass the IO address from omap2.c to gpmc.c, interrupt handler?

Hmm, I don't follow you. You can have the interrupt handler
both in gpmc.c and in the nand driver with set_irq_chained_handler()
and set_irq_data(). We are doing that already in lots of places,
like gpio.c and twl4030-irq.c. 
 
> So, please let me know your suggestion again such that I can post this time itself. Otherwise again it will miss from coming release, this was posted/reviewed for last release too. And suggest to void repeating of missing release window again.

Yes would be nice to get this patch in, to me it seems that this
issue is the only blocker. It should be pretty easy change to
make.

Regards,

Tony
