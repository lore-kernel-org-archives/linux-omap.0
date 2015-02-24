From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAPDSS: restore "name" sysfs entry.
Date: Tue, 24 Feb 2015 12:48:07 -0800
Message-ID: <20150224204806.GL11056@atomide.com>
References: <20150224203706.1eafa129@notabene.brown>
 <54EC5520.1020105@ti.com>
 <20150225073131.7fbff605@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery8.ore.mailhop.org ([54.191.158.99]:48756 "EHLO
	pmta1.delivery8.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751774AbbBXUwT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2015 15:52:19 -0500
Content-Disposition: inline
In-Reply-To: <20150225073131.7fbff605@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

* NeilBrown <neilb@suse.de> [150224 12:35]:
> On Tue, 24 Feb 2015 12:40:32 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
> wrote:
> 
> > Hi,
> > 
> > On 24/02/15 11:37, NeilBrown wrote:
> > > 
> > > 
> > > commit 303e4697e762dc92a40405f4e4b8aac02cd0d70b
> > >     OMAPDSS: rename display-sysfs 'name' entry
> > > 
> > > broke the xorg X server on my device as it couldn't find the display
> > > any more.  It needs the 'name' file and now there isn't one.
> > > 
> > > That commit claims that 'name' is not compatible with i2c or spi.
> > > i2c does register it own 'name' file, but spi does not, hence my
> > > problem - I have an spi display.
> > > 
> > > So create a special case for i2c: add the name attribute for non-i2c
> > > devices.
> > 
> > What X driver is that? What's it doing with the display name? Is it just
> > using the display name to show something for the user, and the returned
> > value can be essentially any string?
> > 
> >  Tomi
> > 
> > 
> /usr/lib/xorg/modules/drivers/omapfb_drv.so
> from package xserver-xorg-video-omap3 in Debian.
> 
> I don't know where the main upstream source is, but here:
> 
> https://gitorious.org/gnutoo-s-programs-for-shr/xf86-video-omapfb/source/28c006c94e57ea71df11ec4fff79d7ffcfc4860f:src/omapfb-output-dss.c#L258
> 
> is the code which reads
>    /sys/devices/platform/omapdss/display0/name
> and fails if that file cannot be opened.

Sounds like a kernel interface we need to support forever
and fix the regression.

Regards,

Tony
