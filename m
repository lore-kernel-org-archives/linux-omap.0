From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about serial stuff)
Date: Thu, 18 Oct 2012 18:58:30 +0200
Message-ID: <CAK=Wgba_-k0kCHah6t6L4=qt838j30ZRVRbgAdJ1yzHDyA8frw@mail.gmail.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com> <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
 <20121016181038.GC15569@atomide.com> <20121016182642.GF15569@atomide.com>
 <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com> <507EA7DB.3070207@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59060 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338Ab2JRQ6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 12:58:52 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so5714481vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 09:58:51 -0700 (PDT)
In-Reply-To: <507EA7DB.3070207@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>

Hi Igor,

On Wed, Oct 17, 2012 at 2:43 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> You are adding declarations inside the common-board-devices.h,
> but the implementation inside the devices.c.
> I can see that devices.c has only on-soc devices in it.
> So, I would expect to have the wl12xx_board_init() function implementation
> inside the common-board-devices.c file.

I really don't mind. Tony do you have any preference?

> Another minor nit: I don't think you need to mark the declaration as __init,
> only the implementation, or is it for documenting it so?

It may be, but I don't really mind removing it. Let's remove it if
we'll move to common-board-devices.c, otherwise it probably isn't
worth the noise.

> Instead of the above, wouldn't it be better to have:
> #if defined(CONFIG_WL12XX_PLATFORM_DATA)
> int __init wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int irq_gpio)
> {
> ...
> }
> #else
> inline int wl12xx_board_init(struct wl12xx_platform_data *wlan_data, int irq_gpio)
> {
>         return 0;
> }
> #endif

I think readability-wise we're probably better off without the #ifdef.

Thanks,
Ohad.
