From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/11] omap: musb: get rid of dyn_fifo
Date: Tue, 23 Feb 2010 10:58:07 -0800
Message-ID: <20100223185807.GI28173@atomide.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
 <20100219233036.10559.29778.stgit@baageli.muru.com>
 <4B83EC7C.6020406@corscience.de>
 <f3642e6b1002230709r4dcd09bv9c495875bbd873c7@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321A20527@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54387 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0BWS5R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 13:57:17 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321A20527@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Andreas Hartmetz <ahartmetz@gmail.com>, Thomas Weber <weber@corscience.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [100223 07:18]:
> > > I think this patch breaks musb_hdrc.
> > >
> > > In musb_core_init is musb->config->dyn_fifo checked but is never set.
> > >
> > > So I get the following dmesg output:
> > >
> > > musb_hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split,
> > > HB-ISO Rx, HB-ISO Tx, SoftConn)
> > > musb_hdrc: MHDRC RTL version 1.400
> > > musb_core_init 1405: reconfigure software for Dynamic FIFOs
> > > musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> > >
> > > Thomas
> > 
> > I think I have the same problem.
> > There are other problems right now (I'm trying several different branch/defconfig
> > combinations) so I can't be 100% sure.
> > 
> 
> Ajay reported earlier today [1] that there is a dependency patch [2]
> that needs to be taken in. Looks like it was missed when the MUSB
> patchset was added to linux-omap for extra testing.
> 
> - Anand
> 
> [1] http://marc.info/?l=linux-omap&m=126691578831301&w=2
> [2] http://marc.info/?l=linux-omap&m=126088393130177&w=2

Thanks, I'll drop this patch.

Sounds like Felipe is back from vacation and can then merge it via
linux-usb along with the other patch.

Regards,

Tony
