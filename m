From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/16] OMAP USB Host cleanup
Date: Tue, 20 Nov 2012 15:13:12 -0800
Message-ID: <20121120231312.GP18567@atomide.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <87fw49cnvh.fsf@deeprootsystems.com>
 <50AA05C3.7010003@ti.com>
 <876251b2kq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:62043 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752125Ab2KTXNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 18:13:16 -0500
Content-Disposition: inline
In-Reply-To: <876251b2kq.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi Roger,

* Kevin Hilman <khilman@deeprootsystems.com> [121119 15:24]:
> Roger Quadros <rogerq@ti.com> writes:
> 
> > Kevin,
> >
> > On 11/16/2012 10:08 PM, Kevin Hilman wrote:
> >> Roger Quadros <rogerq@ti.com> writes:
> >> 
> >>> Hi,
> >>>
> >>> This patchset addresses the following
> >>>
> >>> - Avoid addressing clocks one by one by name and use a for loop + bunch
> >>>   of cleanups.
> >>> - Get number of channels/ports dynamically either from revision register
> >>>   or from platform data. Avoids getting clocks that are not present.
> >>> - Add OMAP5 and HSIC mode (Not tested)
> >>> - Save power on Panda when EHCI driver is not loaded.
> >>>
> >> 
> >> Seeing the clock changes/cleanups, I gave this a spin on OMAP3
> >> (3530/Beagle, 3530/Overo, 3730/Beagle-xM, 3730/OveroSTORM) to see if it
> >> fixed up the problem where CORE does not hit retention in idle when USB
> >> host is enabled, even with no devices attached.
> >> 
> >> Unfortunately, it didn't help. :(
> >
> > oh that's bad. But this series wasn't meant to fix that ;).
> 
> Oh, sorry.  Yeah, I didn't mean this as a nak.  Just an opportunity to
> complain to the maintainers that a long-standing issue needs to be
> addressed.

It seems that drivers/mfd/omap-usb-host.c is one of the last users
of cpu_is_omap macros blocking enabling ARM multiplatform support for
omap2+.

Please fix that ASAP as early as possible in this patch series to
remove the dependencies between core omap code development and driver
development.

Basically you need to remove #include <plat/cpu.h> and pass the
revision information in platform data (and device tree compatible
flag when that is supported).

Regards,

Tony
