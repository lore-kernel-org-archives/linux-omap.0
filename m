From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 01:00:11 -0700
Message-ID: <20120607080009.GA12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk>
 <20120607073112.GX12766@atomide.com>
 <20120607073323.GD16342@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:12031 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab2FGIAP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 04:00:15 -0400
Content-Disposition: inline
In-Reply-To: <20120607073323.GD16342@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

* Felipe Balbi <balbi@ti.com> [120607 00:39]:
> Hi,
> 
> On Thu, Jun 07, 2012 at 12:31:13AM -0700, Tony Lindgren wrote:
> > * Paul Walmsley <paul@pwsan.com> [120606 23:26]:
> > > From: Tero Kristo <t-kristo@ti.com>
> > > 
> > > Add a custom reset function for the usb_host_fs/fsusb IP block, and
> > > connect it to the OMAP4 FSUSB block.
> > > 
> > > This is the first of two fixes required to get rid of the boot
> > > warning:
> > > 
> > > omap_hwmod: usb_host_fs: _wait_target_disable failed
> > > 
> > > and to allow the module to idle.
> > > 
> > > It may be necessary to use this reset method for OMAP2xxx SoCs as
> > > well; this is left for a future patch.
> > 
> > Here too I think driver like features like this should live in the
> > driver init for omap OHCI driver. In the likely case that FS OHCI is
> > not in use on the board, the OHCI glue can just reset it.
> 
> this I don't agree. It means we will have to add some OHCI code even
> when OHCI is disabled.

That's because the bus level code alone is not enough for the reset and
driver features are needed to reset it. Nothing wrong with the code itself,
it should be just something that's part of the driver rather than the bus
level code. It could be always built in for sure even if it lives under
drivers.

Tony 
