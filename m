From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Problems using DSS2 on OMAP3 EVM / Angstrom with rotation
Date: Mon, 30 Nov 2009 11:17:20 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043716A90F@dbde02.ent.ti.com>
References: <4B0C76E2.1070804@stanford.edu>
 <1259245214.2438.460.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60428 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbZK3FrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 00:47:21 -0500
In-Reply-To: <1259245214.2438.460.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, ext Eino-Ville Talvala <talvala@stanford.edu>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> Sent: Thursday, November 26, 2009 7:50 PM
> To: ext Eino-Ville Talvala
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Problems using DSS2 on OMAP3 EVM / Angstrom with
> rotation
> 
> Hi,
> 
> On Wed, 2009-11-25 at 01:14 +0100, ext Eino-Ville Talvala wrote:
> > Hi,
> >
> > I'm trying to get Xorg running on an Angstrom distro image on the
> OMAP3
> > EVM, with a rotated framebuffer.  The default screen orientation
> on the
> > EVM is portrait, and I'm trying to change this to landscape.
> Without
> > any tweaking, using a kernel with your latest v5 DSS patches added
> on
> > top (and Vaibhav's OMAP3 EVM DSS patches), DSS works and Angstrom
> > happily displays both its initial bootup screen, and then the X
> server
> > starts successfully.
> >
> > Using the omapfb.rotate=1 kernel command-line option, the initial
> bootup
> > screen still works, but as soon as the X server tries to start up,
> I get
> > the following error on the console:
> >
> > Starting GPE display manager: gpe-dm
> > omapdss MANAGER error: dispc_setup_plane failed for ovl 0
> > omapdss MANAGER error: configure_overlay 0 failed
> 
> It sounds to me that gpe-dm (or something running after that) is
> trying
> to configure the overlay to 480x640 mode, and failing. If the
> initial
[Hiremath, Vaibhav] I think this is the issue, I have seen many peoples doing same mistakes, and it ends up to the application, which doesn't care about rotation and tries to set 480x640 in all rotation angles.

> bootup screen (I believe this is drawn from the linux side, not boot
> loader?) is fine, it hints that the problem is in the X server or
> some
> other user space component.
> 
> > My kernel bootargs are:
> > mem=128M console=ttyS0,115200n8 noinitrd rw root=/dev/mmcblk0p2
> > rootfstype=ext2 rootdelay=1 nohz=off omapfb.rotate=1 omapfb.vrfb=y
> > omapfb.debug=y omapdss.debug=y
> >
> > Without vrfb=y, the initial boot screen won't show up, with a
> console
> > message of 'omapdss DISPC error: GFX_FIFO_UNDERFLOW, disabling
> GFX', and
> > the same error for Xorg.
> 
> In practice you always have to use VRFB rotation on OMAP3, so no
> point
> in trying without.
> 
> > I'd appreciate any advice you could give me - doing this (in
> theory
> > simple) screen orientation change is really stumping me.
> 
> It sounds to me that the DSS and omapfb is working fine. I also
> tried
> booting SDP board with similar boot arguments, and it's working fine
> (although I'm not running X).
[Hiremath, Vaibhav] Just to add, same bootargs has been tested thoroughly on OMAP3EVM and it is working fine for me.

Thanks,
Vaibhav

> 
> Perhaps there's some application that checks the display dimensions,
> which are 480x640, and tries to use those regardless of the
> rotation.
> 
>  Tomi
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
