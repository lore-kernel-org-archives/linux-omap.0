From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: SDMA: Fix omap_stop_dma() API for channel
	linking
Date: Thu, 15 Oct 2009 11:40:16 -0700
Message-ID: <20091015184016.GI14531@atomide.com>
References: <1255500862-29847-1-git-send-email-santosh.shilimkar@ti.com> <20091014170625.GH12700@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CC9F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55403 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933324AbZJOSlA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 14:41:00 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CC9F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, Hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [091014 21:40]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Wednesday, October 14, 2009 10:36 PM
> > To: Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org; S, Venkatraman; Hari n; Jarkko Nikula
> > Subject: Re: [PATCH] ARM: OMAP: SDMA: Fix omap_stop_dma() API for channel
> > linking
> > 
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [091013 23:14]:
> > > OMAP sDMA driver API omap_stop_dma() doesn't really stop the dma when
> > used
> > > in linking scenario. This patch fixes the same.
> > 
> > To me it looks like this will break things for omap1 as the DMA channel
> > interrupt is not disabled first. I guess the fix is to move the
> > "Disable all interrupts on the channel" part above clearing the
> > link mappings.
> Indeed it will break OMAP1. Initially I thought of putting this change at this place so that it takes care of both normal and linking scenario. 
> 
> I will rework this and send v2.

OK, thanks.
 
> > This fix should be tested in linux-omap before we send this to mainline.
> Yes ofcourse. That what I meant by merge.

Yeah, we should still have enough time to get it into mainline kernel
as a fix during this -rc cycle.

Regards,

Tony
