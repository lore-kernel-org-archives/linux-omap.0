From: Tony Lindgren <tony@atomide.com>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Thu, 4 Oct 2012 18:39:10 -0700
Message-ID: <20121005013910.GI3874@atomide.com>
References: <20121004173107.GD3874@atomide.com>
 <20121004175742.GB9702@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49058 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756000Ab2JEBjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 21:39:13 -0400
Content-Disposition: inline
In-Reply-To: <20121004175742.GB9702@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [121004 11:04]:
> Hi,
> 
> On Thu, Oct 04, 2012 at 10:31:08AM -0700, Tony Lindgren wrote:
> > Hi Felipe & Kishon,
> > 
> > Looks like musb is broken at least on pandaboard es
> > in current linux next while it works with v3.6:
> > 
> > [    1.933074] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> > [    1.939422] unable to find transceiver of type USB2 PHYrouping on.  Total pages: 251648
> > [    1.945190] HS USB OTG: no transceiver configured
> > [    1.950134] musb-hdrc musb-hdrc.0: musb_init_controller failed with status -19
> > [    1.958160] couldn't find an available UDC
> > 
> > I do have CONFIG_OMAP_USB2 set.
> > 
> > Note that we won't be able to flip omap4 over to be
> > device tree only probably until v3.9 because of the
> > bindings we're still missing from usability point of
> > view. So this regression should be fixed.
> 
> I see. Kishon, can you cook a patch adding platform_data until we
> actually move to DT-only for OMAP4 ?
> 
> > Also on the EHCI port, I've seen issues where unplugging
> > the cable hangs kernel with an infinite loop. But that happens
> > only occasionally, sorry does not seem to happen right
> > now so no output to paste here. Or maybe this issue
> > has already been fixed?
> 
> Keshava, would you have time to look into this for this -rc cycle ?

Also, can you guys also please do a patch to move plat/usb.h to
include/linux/platform_data/usb-omap.h that only contains
platform data? The init functions should be in local usb.h under
arch/arm/*omap*/*. Then also please remove the cpu_is_omap usage
from drivers/mfd/omap-usb-host.c if not done already.

These are needed to make plat/cpu.h local to mach-omap*
for the ARM common zImage support.

Thanks,

Tony
