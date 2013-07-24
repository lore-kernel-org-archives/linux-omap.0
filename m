From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Wed, 24 Jul 2013 20:32:03 +0200
Message-ID: <201307242032.03597.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1307231708020.1304-100000@iolanthe.rowland.org> <5977067.8rykRgjgre@flatron>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5977067.8rykRgjgre@flatron>
Sender: linux-doc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Tomasz Figa <t.figa@samsung.com>, Greg KH <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, broonie@kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, kyungmin.park@samsung.com, balbi@ti.com, jg1.han@samsung.com, s.nawrocki@samsung.com, kgene.kim@samsung.com, grant.likely@linaro.org, tony@atomide.com, swarren@nvidia.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-media@vger.kernel.org, linux-fbdev@vger.kernel.org, akpm@linux-foundation.org, balajitk@ti.com, george.cherian@ti.com, nsekhar@ti.com, olof@lixom.netStephen Warren <swarr>
List-Id: linux-omap@vger.kernel.org

On Tuesday 23 July 2013, Tomasz Figa wrote:
> On Tuesday 23 of July 2013 17:14:20 Alan Stern wrote:
> > On Tue, 23 Jul 2013, Tomasz Figa wrote:
> > > Where would you want to have those phy_address arrays stored? There
> > > are no board files when booting with DT. Not even saying that you
> > > don't need to use any hacky schemes like this when you have DT that
> > > nicely specifies relations between devices.
> > 
> > If everybody agrees DT has a nice scheme for specifying relations
> > between devices, why not use that same scheme in the PHY core?
> 
> It is already used, for cases when consumer device has a DT node attached. 
> In non-DT case this kind lookup translates loosely to something that is 
> being done in regulator framework - you can't bind devices by pointers, 
> because you don't have those pointers, so you need to use device names.
> 

Sorry for jumping in to the middle of the discussion, but why does a *new*
framework even bother defining an interface for board files?

Can't we just drop any interfaces for platform data passing in the phy
framework and put the burden of adding those to anyone who actually needs
them? All the platforms we are concerned with here (exynos and omap,
plus new platforms) can be booted using DT anyway.

	Arnd
