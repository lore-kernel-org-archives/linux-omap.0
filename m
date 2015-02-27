From: Tony Lindgren <tony@atomide.com>
Subject: Re: 3.20-rc0 breaks nfsroot over usb
Date: Fri, 27 Feb 2015 07:38:09 -0800
Message-ID: <20150227153809.GS11056@atomide.com>
References: <20150217185518.GA3825@amd>
 <20150226221950.GC10204@amd>
 <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery8.ore.mailhop.org ([54.191.158.99]:41964 "EHLO
	pmta1.delivery8.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751270AbbB0PmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Feb 2015 10:42:13 -0500
Content-Disposition: inline
In-Reply-To: <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, Sakari Ailus <sakari.ailus@iki.fi>

* Aaro Koskinen <aaro.koskinen@iki.fi> [150226 15:06]:
> Hi,
> 
> On Thu, Feb 26, 2015 at 11:19:50PM +0100, Pavel Machek wrote:
> > Ok, it seems that new config dependencies broke my kconfig. These will
> > not be enabled if you just to make oldconfig; you want to make sure
> > they are on.
> > 
> >  OMAP2430 and onwards (USB_MUSB_OMAP2PLUS) [N/m/y] (NEW)
> > TWL4030 USB Transceiver Driver (TWL4030_USB) [N/m/y/?] (NEW)
> 
> Yes, also other users have reported "USB breakage" with 4.0-rc1 on N900
> etc caused by this.
> 
> Commit fbba7db3990cb707ff91cd6507d53a0a730afe97 (usb: musb:
> add omap-control dependency) changed USB_MUSB_OMAP2PLUS to depend
> on OMAP_CONTROL_PHY but that seems to be wrong at least for OMAP3.
> omap_control_phy.h provides dummy functions when it's not enabled.
> So there should be no dependency.

I guess the solution would be to make drivers/phy handle whatever
omap_control_usb_set_mode is doing in a generic way.

Regards,

Tony
