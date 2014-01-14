From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 08/26] dmaengine: omap-dma: consolidate setup of CCR
Date: Tue, 14 Jan 2014 09:04:09 -0800
Message-ID: <20140114170409.GA13306@atomide.com>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk>
 <20140113221425.GD7993@atomide.com>
 <20140113231227.GI27282@n2100.arm.linux.org.uk>
 <20140114133949.GJ27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43544 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750751AbaANREO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2014 12:04:14 -0500
Content-Disposition: inline
In-Reply-To: <20140114133949.GJ27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140114 05:41]:
> On Mon, Jan 13, 2014 at 11:12:27PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 13, 2014 at 02:14:26PM -0800, Tony Lindgren wrote:
> > > * Russell King <rmk+kernel@arm.linux.org.uk> [140102 07:17]:
> > > > Consolidate the setup of the channel control register.  Prepare the
> > > > basic value in the preparation of the DMA descriptor, and write it into
> > > > the register upon descriptor execution.
> > > 
> > > FYI, this patch seems to be the one that causes the
> > > "DMA timeout with device 55" error for omap1.
> > 
> > Okay, looks like I've missed some bit of muxing for DMA signals or
> > something.  I've yet to find any information on this in the OMAP5912
> > docs, so I guess I'm going to have to do this not only blind, but also
> > without hardware.  GAH.
> 
> Do you know which of the OMAP1 variants your device is?  Is it OMAP15xx
> or OMAP16xx?  It looks like OMAP15xx is easy to fix for this as it hasn't
> got the additional multiplexer on the DMA request signals.

This was with Nokia 770, which is 1710. Should be pretty much the same
from SoC point of view as 5912 on OSK.

Tony
