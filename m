From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Problems using DSS2 on OMAP3 EVM / Angstrom with rotation
Date: Thu, 26 Nov 2009 16:20:14 +0200
Message-ID: <1259245214.2438.460.camel@tubuntu.research.nokia.com>
References: <4B0C76E2.1070804@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20399 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbZKZOUe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 09:20:34 -0500
In-Reply-To: <4B0C76E2.1070804@stanford.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Eino-Ville Talvala <talvala@stanford.edu>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2009-11-25 at 01:14 +0100, ext Eino-Ville Talvala wrote:
> Hi,
> 
> I'm trying to get Xorg running on an Angstrom distro image on the OMAP3
> EVM, with a rotated framebuffer.  The default screen orientation on the
> EVM is portrait, and I'm trying to change this to landscape.  Without
> any tweaking, using a kernel with your latest v5 DSS patches added on
> top (and Vaibhav's OMAP3 EVM DSS patches), DSS works and Angstrom
> happily displays both its initial bootup screen, and then the X server
> starts successfully.
> 
> Using the omapfb.rotate=1 kernel command-line option, the initial bootup
> screen still works, but as soon as the X server tries to start up, I get
> the following error on the console:
> 
> Starting GPE display manager: gpe-dm
> omapdss MANAGER error: dispc_setup_plane failed for ovl 0
> omapdss MANAGER error: configure_overlay 0 failed

It sounds to me that gpe-dm (or something running after that) is trying
to configure the overlay to 480x640 mode, and failing. If the initial
bootup screen (I believe this is drawn from the linux side, not boot
loader?) is fine, it hints that the problem is in the X server or some
other user space component.

> My kernel bootargs are:
> mem=128M console=ttyS0,115200n8 noinitrd rw root=/dev/mmcblk0p2
> rootfstype=ext2 rootdelay=1 nohz=off omapfb.rotate=1 omapfb.vrfb=y
> omapfb.debug=y omapdss.debug=y
> 
> Without vrfb=y, the initial boot screen won't show up, with a console
> message of 'omapdss DISPC error: GFX_FIFO_UNDERFLOW, disabling GFX', and
> the same error for Xorg.

In practice you always have to use VRFB rotation on OMAP3, so no point
in trying without.

> I'd appreciate any advice you could give me - doing this (in theory
> simple) screen orientation change is really stumping me.

It sounds to me that the DSS and omapfb is working fine. I also tried
booting SDP board with similar boot arguments, and it's working fine
(although I'm not running X).

Perhaps there's some application that checks the display dimensions,
which are 480x640, and tries to use those regardless of the rotation.

 Tomi


