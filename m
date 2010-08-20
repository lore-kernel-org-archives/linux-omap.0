From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [RFC] [PATCH 3/7] usb: ehci-omap: omap: Add OMAP4 support
Date: Fri, 20 Aug 2010 11:33:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324222B6C@dbde02.ent.ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <20100820053844.GB15196@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324222B50@dbde02.ent.ti.com>
 <20100820055204.GF15196@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50549 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab0HTGD6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 02:03:58 -0400
In-Reply-To: <20100820055204.GF15196@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi wrote:
> Hi,
> 
> On Fri, Aug 20, 2010 at 07:47:07AM +0200, ext Gadiyar, Anand wrote:
> >The differences between OMAP3 and OMAP4 are:
> >- The OMAP4 has a different set of clocks which do not exist on OMAP3.
> >- The register bits for configuring port modes is different
> 
> is it a different ip core or just a modification of the previous ?
> 
> >For the clock handling:
> >One approach: On OMAP3, have a set of dummy clocks corresponding to the
> >per-port clocks on OMAP4. Then the driver wouldn't need to know which
> >SoC it is running on.
> >
> >Another approach:
> >Have a different glue layer driver for OMAP4.
> >
> >For the register bit differences, we do need to know which SoC we are
> >running on to be able to use the correct register bits. For this,
> 
> isn't the ehci ip revision different ? Why don't you use that instead of 
> cpu_is_omap* 
> 

Yes the revision - but that's not as good a test as using UHH_REVISION.
The difference between the IPs is a function of the UHH_REVISION, and to
me reading EHCI revision/capabilities is more hack-ish than just using
UHH_REVSION.

> >One approach:
> >At the very minimum, we need a set of clocks to be enabled to be able to
> >read the UHH_REVISION register, and we could use that to figure out which
> >bits we need to use.
> 
> exactly
> 
> >The other approach I can think of is to have platform data tell us (I'm
> >guessing this is a bad idea).
> 
> yeah, that would be bad...
> 
> >What do you think?
> 
> another approach:
> 
> make ohci and ehci play well together

Yes - this is long overdue and work in progress.

> have an omap3-specific and one 
> omap4-specific MFD-like driver that will instantiate ehci and ohci 
> platform_drivers and handle clock + locking to shared address space.
> 
> then you define a set of accessor functions for registers with different 
> offset that act differently depending on revision of the ip core.
> 
> Does that work ?

The shared address spaces need to be configured once at init - their values
are board dependent and wouldn't need to be changed at runtime.

This should work. We'll work on it.

- Anand

