From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Fri, 19 Oct 2012 10:07:59 -0700
Message-ID: <20121019170759.GK4730@atomide.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com>
 <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
 <20121016181038.GC15569@atomide.com>
 <20121016182642.GF15569@atomide.com>
 <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com>
 <507EA7DB.3070207@compulab.co.il>
 <CAK=Wgba_-k0kCHah6t6L4=qt838j30ZRVRbgAdJ1yzHDyA8frw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42118 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751259Ab2JSRIE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 13:08:04 -0400
Content-Disposition: inline
In-Reply-To: <CAK=Wgba_-k0kCHah6t6L4=qt838j30ZRVRbgAdJ1yzHDyA8frw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>

* Ohad Ben-Cohen <ohad@wizery.com> [121018 10:00]:
> Hi Igor,
> 
> On Wed, Oct 17, 2012 at 2:43 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> > You are adding declarations inside the common-board-devices.h,
> > but the implementation inside the devices.c.
> > I can see that devices.c has only on-soc devices in it.
> > So, I would expect to have the wl12xx_board_init() function implementation
> > inside the common-board-devices.c file.
> 
> I really don't mind. Tony do you have any preference?

Yes common-board-devices.c would be better.
 
> > Another minor nit: I don't think you need to mark the declaration as __init,
> > only the implementation, or is it for documenting it so?
> 
> It may be, but I don't really mind removing it. Let's remove it if
> we'll move to common-board-devices.c, otherwise it probably isn't
> worth the noise.

OK
 
> > Instead of the above, wouldn't it be better to have:
> > #if defined(CONFIG_WL12XX_PLATFORM_DATA)
> > int __init wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int irq_gpio)
> > {
> > ...
> > }
> > #else
> > inline int wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int irq_gpio)
> > {
> >         return 0;
> > }
> > #endif
> 
> I think readability-wise we're probably better off without the #ifdef.

We could optimize away a minimal amount of code for many configurations
with the ifdef? :)

Regards,

Tony
