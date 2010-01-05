From: Paul Walmsley <paul@pwsan.com>
Subject: Re: dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98 breaks omapfb (old
 non-dss2)
Date: Tue, 5 Jan 2010 10:32:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001051030580.2083@utopia.booyaka.com>
References: <48239d390912150158xdf2999dr6b43f21c64456002@mail.gmail.com> <1260890578.6017.11.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53909 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab0AERct (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 12:32:49 -0500
In-Reply-To: <1260890578.6017.11.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Sergey Lapin <slapinid@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Tue, 15 Dec 2009, Tomi Valkeinen wrote:

> On Tue, 2009-12-15 at 10:58 +0100, ext Sergey Lapin wrote:
> > dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98
> > OMAP: OMAPFB: add omapdss device
> > 
> >     The upcoming new display subsystem driver is divided to two devices,
> >     omapdss and omapfb, of which omapdss handles the actual hardware.
> > 
> >     This patch adds a dummy omapdss platform device for the current omapfb
> >     driver, which is then used to get the clocks. This will make it possible
> >     for the current and the new display drivers to co-exist.
> > 
> >     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> >     Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > breaks old omapfb.
> 
> I didn't look at this further, but I quickly tested with OMAP3 SDP
> board, reverting the patch that makes SDP use DSS2, and it seems to work
> fine with the old omapfb.
> 
> Perhaps you have more kernel debug options enabled, and then it
> complains about missing release function. I'll look at it tomorrow.

This also affects omap_2430sdp_defconfig on 2430SDP:

omapfb omapfb: timeout waiting for FRAME DONE
------------[ cut here ]------------
WARNING: at drivers/base/core.c:131 device_release+0x68/0x7c()
Device 'omapdss' does not have a release() function, it is broken and must 
be fixed.
Modules linked in:
[<c002c748>] (unwind_backtrace+0x0/0xdc) from [<c0049874>] 
(warn_slowpath_common+0x48/0x60)
[<c0049874>] (warn_slowpath_common+0x48/0x60) from [<c00498c4>] 
(warn_slowpath_fmt+0x24/0x30)
[<c00498c4>] (warn_slowpath_fmt+0x24/0x30) from [<c01b0544>] 
(device_release+0x68/0x7c)
[<c01b0544>] (device_release+0x68/0x7c) from [<c01706a8>] 
(kobject_release+0x60/0x74)
[<c01706a8>] (kobject_release+0x60/0x74) from [<c01713c4>] 
(kref_put+0x5c/0x6c)
[<c01713c4>] (kref_put+0x5c/0x6c) from [<c018df44>] 
(omapfb_free_resources+0xec/0x130)
[<c018df44>] (omapfb_free_resources+0xec/0x130) from [<c018f030>] 
(omapfb_do_probe+0x6dc/0x810)
[<c018f030>] (omapfb_do_probe+0x6dc/0x810) from [<c0191088>] 
(sdp2430_panel_probe+0xc/0x18)
[<c0191088>] (sdp2430_panel_probe+0xc/0x18) from [<c01b3f24>] 
(platform_drv_probe+0x18/0x1c)
[<c01b3f24>] (platform_drv_probe+0x18/0x1c) from [<c01b3114>] 
(driver_probe_device+0xa0/0x14c)
[<c01b3114>] (driver_probe_device+0xa0/0x14c) from [<c01b3220>] 
(__driver_attach+0x60/0x84)
[<c01b3220>] (__driver_attach+0x60/0x84) from [<c01b2990>] 
(bus_for_each_dev+0x44/0x74)
[<c01b2990>] (bus_for_each_dev+0x44/0x74) from [<c01b22e8>] 
(bus_add_driver+0x9c/0x224)
[<c01b22e8>] (bus_add_driver+0x9c/0x224) from [<c01b34f4>] 
(driver_register+0xa8/0x130)
[<c01b34f4>] (driver_register+0xa8/0x130) from [<c0026364>] 
(do_one_initcall+0x5c/0x1b4)
[<c0026364>] (do_one_initcall+0x5c/0x1b4) from [<c0008408>] 
(kernel_init+0xa0/0x124)
[<c0008408>] (kernel_init+0xa0/0x124) from [<c0027ed4>] 
(kernel_thread_exit+0x0/0x8)
---[ end trace da227214a82491b7 ]---


- Paul
