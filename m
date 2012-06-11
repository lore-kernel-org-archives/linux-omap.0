From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 09/12] ARM: OMAP2+: usb_host_fs: add custom
 setup_preprogram for usb_host_fs (fsusb)
Date: Mon, 11 Jun 2012 00:41:33 -0700
Message-ID: <20120611074133.GZ12766@atomide.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004617.20034.21714.stgit@dusk>
 <20120611063416.GT12766@atomide.com>
 <20120611071301.GC6845@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63497 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab2FKHlh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 03:41:37 -0400
Content-Disposition: inline
In-Reply-To: <20120611071301.GC6845@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

* Felipe Balbi <balbi@ti.com> [120611 00:19]:
> On Sun, Jun 10, 2012 at 11:34:17PM -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > Similar comments to the asess patch on this one below.
> > 
> > * Paul Walmsley <paul@pwsan.com> [120610 17:57]:
> > > --- /dev/null
> > > +++ b/include/linux/platform_data/fsusb.h
> > 
> > This would be better as include/linux/platform_data/omap-usb.h.
> > 
> > > +#include <plat/omap_hwmod.h>
> > 
> > This include should not be needed here if the hwmod function is
> > a static function in the some hwmod*.c file.
> > 
> > > +/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS register */
> > > +#define HCCOMMANDSTATUS			0x0008
> > > +
> > > +/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag */
> > > +#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)
> > 
> > I think these already have standard defines in some OHCI header?
> > Felipe may be able to comment more on this?
> 
> Well, yeah... but it's defined on drivers/usb/host/ohci.h and it's
> actually a structure:

OK I guess then the define is OK.

> > This should be "static inline int fsusb_reset_host_controller" as it's
> > in a header.
> 
> why is it even in a header ? Only hwmod_fsusb_preprogram() will use it
> anyway.

Well ideally it would be something that any OHCI driver can use for
it's reset, and whatever bus code can also call to reset and idle
for the unused devices that don't have the driver compiled in. Got
any better suggestions where to place it? I could be a generic
ohci_reset function in some header?

I don't want to have driver specific code under arch/arm/*omap*/* as
the bus level code should not need to know anything about the driver
specific registers.

Regards,

Tony
