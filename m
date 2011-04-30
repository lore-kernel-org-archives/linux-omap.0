From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: N8x0 display support (was: Re: The old omapfb support)
Date: Sat, 30 Apr 2011 09:01:03 +0300
Message-ID: <1304143263.2080.5.camel@deskari>
References: <1303215626.32281.70.camel@deskari>
	 <20110419123036.GF15620@atomide.com>  <1303216485.27432.7.camel@maggie>
	 <1303216889.32281.80.camel@deskari>  <1303217114.27432.9.camel@maggie>
	 <1304084019.5605.75.camel@deskari>  <1304111048.30575.12.camel@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57464 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496Ab1D3GBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Apr 2011 02:01:12 -0400
Received: by eydd26 with SMTP id d26so2549460eyd.30
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 23:01:09 -0700 (PDT)
In-Reply-To: <1304111048.30575.12.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: lo-ml <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Fri, 2011-04-29 at 23:04 +0200, Michael B=C3=BCsch wrote:
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

A quick grep shows that there's some manual update support in that tree=
=2E
However, all the OMAPFB_UPDATE_WINDOW calls are in omapfb-xv-blizzard.c=
,
and to me it looks like manual-update is used when Xv is being used, an=
d
auto-update otherwise. So that probably needs some work, either in the
driver or in X.

Perhaps I'll see if I can add deferred IO support to omapfb driver,
which would be turned on when a manual-update display is set to
auto-update mode. That's not exactly the same as auto update, but I
guess it should work for almost all the cases.

While I don't like having auto-update for manual-update displays, I
guess it's still good to have for testing and prototyping purposes.

> So we basically need that to work in one way or another.
> Another thing that we require is turning off the display for
> power saving reasons. We currently do this through
> FBIOBLANK ioctl with parameters FB_BLANK_POWERDOWN/FB_BLANK_UNBLANK.
> (The backlight is turned off by other means with the device asic)

Blanking works with FBIOBLANK. It also turns off the backlight. The
backlight brightness can be controlled
via /sys/class/backlight/display0/

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
