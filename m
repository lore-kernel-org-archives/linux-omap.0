From: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
Subject: Re: N8x0 display support (was: Re: The old omapfb support)
Date: Fri, 29 Apr 2011 23:05:45 +0200
Message-ID: <1304111145.30575.14.camel@maggie>
References: <1303215626.32281.70.camel@deskari>
	 <20110419123036.GF15620@atomide.com>  <1303216485.27432.7.camel@maggie>
	 <1303216889.32281.80.camel@deskari>  <1303217114.27432.9.camel@maggie>
	 <1304084019.5605.75.camel@deskari>  <1304111048.30575.12.camel@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:37486 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757956Ab1D2VFt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 17:05:49 -0400
In-Reply-To: <1304111048.30575.12.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: lo-ml <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Fri, 2011-04-29 at 23:04 +0200, Michael B=C3=BCsch wrote:=20
> On Fri, 2011-04-29 at 16:33 +0300, Tomi Valkeinen wrote:=20
> > So, my question is: what are the uses of N800's display with the
> > mainline kernel? Are we happy with just having basic display
> > functionality, or do people need all the features in the older bliz=
zard
> > driver?
>=20
> Well, not sure.
> The OpenWRT project runs an X server on the n810.
> It does so by using the X.org "omapfb" driver module, which
> accesses the hardware through /dev/fb0.
> http://git.pingu.fi/xf86-video-omapfb/
>=20
> So we basically need that to work in one way or another.
> Another thing that we require is turning off the display for
> power saving reasons. We currently do this through
> FBIOBLANK ioctl with parameters FB_BLANK_POWERDOWN/FB_BLANK_UNBLANK.
> (The backlight is turned off by other means with the device asic)

Oh and we currently run the framebuffer in auto-update mode.
I don't have any idea what would be needed to get it working
in manual update mode.

--=20
Greetings Michael.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
