From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: 3.20-rc0 breaks nfsroot over usb
Date: Fri, 27 Feb 2015 21:06:37 +0100
Message-ID: <11261945.VmGdV7ZTh2@wuerfel>
References: <20150217185518.GA3825@amd> <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi> <20150227153809.GS11056@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:57762 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbbB0UGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2015 15:06:48 -0500
In-Reply-To: <20150227153809.GS11056@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, sre@debian.org, kernel list <linux-kernel@vger.kernel.org>, sre@ring0.de, Sakari Ailus <sakari.ailus@iki.fi>, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com

On Friday 27 February 2015 07:38:09 Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [150226 15:06]:
> > Hi,
> > 
> > On Thu, Feb 26, 2015 at 11:19:50PM +0100, Pavel Machek wrote:
> > > Ok, it seems that new config dependencies broke my kconfig. These will
> > > not be enabled if you just to make oldconfig; you want to make sure
> > > they are on.
> > > 
> > >  OMAP2430 and onwards (USB_MUSB_OMAP2PLUS) [N/m/y] (NEW)
> > > TWL4030 USB Transceiver Driver (TWL4030_USB) [N/m/y/?] (NEW)
> > 
> > Yes, also other users have reported "USB breakage" with 4.0-rc1 on N900
> > etc caused by this.
> > 
> > Commit fbba7db3990cb707ff91cd6507d53a0a730afe97 (usb: musb:
> > add omap-control dependency) changed USB_MUSB_OMAP2PLUS to depend
> > on OMAP_CONTROL_PHY but that seems to be wrong at least for OMAP3.
> > omap_control_phy.h provides dummy functions when it's not enabled.
> > So there should be no dependency.

The problem I fixed was a link error when USB_MUSB_OMAP2PLUS
is built-in but OMAP_CONTROL_PHY is a loadable module.

> I guess the solution would be to make drivers/phy handle whatever
> omap_control_usb_set_mode is doing in a generic way.

I'm very sorry about the breakage in a patch that is marked for
backports.

Please accept my apology and the workaround patch in the
follow-up mail.

	Arnd
