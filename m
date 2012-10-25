From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Thu, 25 Oct 2012 12:03:24 -0700
Message-ID: <20121025190324.GW11928@atomide.com>
References: <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
 <20121016181038.GC15569@atomide.com>
 <20121016182642.GF15569@atomide.com>
 <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com>
 <507EA7DB.3070207@compulab.co.il>
 <CAK=Wgba_-k0kCHah6t6L4=qt838j30ZRVRbgAdJ1yzHDyA8frw@mail.gmail.com>
 <20121019170759.GK4730@atomide.com>
 <CAK=WgbbPmuOgssRRSinsV3rXg7TUa9fpOP-Zg+VatZgqgVYixw@mail.gmail.com>
 <20121024015418.GC5605@atomide.com>
 <CAK=WgbZpQBVZiL2Gw_Sg_S0GZXPM0pxG2Nfbwqwk9gtnJyEe8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:36980 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934816Ab2JYTD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 15:03:29 -0400
Content-Disposition: inline
In-Reply-To: <CAK=WgbZpQBVZiL2Gw_Sg_S0GZXPM0pxG2Nfbwqwk9gtnJyEe8Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>

* Ohad Ben-Cohen <ohad@wizery.com> [121024 04:17]:
> On Wed, Oct 24, 2012 at 3:54 AM, Tony Lindgren <tony@atomide.com> wrote:
> > I don't think mach-davinci has wl12xx_board_init() available?
> > Maybe leave this out or define also also somewhere for mach-davinci?
> 
> Yeah let's leave davinci out for now:
> 
> From 665bcaa7ef0ed385cf1765f2d4503bf84aaf488a Mon Sep 17 00:00:00 2001
> From: Ohad Ben-Cohen <ohad@wizery.com>
> Date: Sun, 14 Oct 2012 20:16:01 +0200
> Subject: [PATCH] ARM: OMAP: don't print any error when wl12xx isn't
>  configured
> 
> Stop intimidating users with scary wlan error messages in case wl12xx
> support wasn't even built.
> 
> In addition, when wl12xx_set_platform_data() fails, don't bother
> registering wl12xx's fixed regulator device (on the relevant
> boards).
> 
> While we're at it, extract the wlan init code to a dedicated function to
> make (the relevant boards') init code look a bit nicer.
> 
> Compile tested only.

Seems to work here, tested on panda es with wlan working and
on sdp with the warning gone.
 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks applying into omap-for-v3.7-rc2/fixes-part2.

Regards,

Tony
