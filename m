From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] omap updates for 2.6.34, part 4
Date: Mon, 22 Feb 2010 13:37:22 -0800
Message-ID: <20100222213722.GU18786@atomide.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C417FF19@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60958 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab0BVVg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 16:36:28 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C417FF19@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100220 00:27]:
> Tony, 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
> > Lindgren
> > Sent: Saturday, February 20, 2010 5:00 AM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: linux-omap@vger.kernel.org
> > Subject: [PATCH 00/11] omap updates for 2.6.34, part 4
> > 
> > Hi all,
> > 
> > Here are few USB platform init patches that have been already
> > posted to linux-usb and linux-omap and have been sitting in for-next.
> > 
> > Posting them one more time to make sure people on linux-arm-kernel
> > have seen these too.
> > 
> > Regards,
> > 
> > Tony
> > 
> > ---
> > 
> > Felipe Balbi (7):
> >       arm: omap: musb: ioremap only what's ours
> >       omap: musb: remove unused data
> >       arm: omap: musb: we can use clk framework
> >       omap: musb: remove unused soft_con field
> >       omap: musb: remove unused dma data
> >       omap: musb: remove unnecessary return
> >       omap: musb: get rid of dyn_fifo
> > 
> > Maulik Mankad (4):
> >       USB: Add empty functions in otg.h
> >       omap: musb: Remove #ifdef from board-omap3evm.c
> >       omap: musb: Pass board specific data from board file
> >       omap: musb: Add USB support to 4430 SDP board file
> >
> We need attached patch to keep multi-omap build booting on omap4
> on top of this series.

Thanks, I'll add it.

Tony
