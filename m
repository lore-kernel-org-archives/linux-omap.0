From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PREVIEW 2] New display subsystem for OMAP2/3
Date: Mon, 22 Sep 2008 18:10:45 +0300
Message-ID: <20080922151045.GC8171@atomide.com>
References: <1222094917.8299.33.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65195 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbYIVPKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 11:10:49 -0400
Content-Disposition: inline
In-Reply-To: <1222094917.8299.33.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [080922 17:49]:
> Hi,
> 
> I sent a preview of a new display subsystem for OMAP2/3 some time ago:
> http://marc.info/?l=linux-omap&m=122114505030542&w=2
> 
> I now have updated it, the patches are at the same place:
> http://www.bat.org/~tomba/omap-dss/

This discussion should go to linux-fbdev-devel list. Please keep l-o
list Cc'd though. Also you should post the patches as a proper inline
series, please see git-send-email man page.

Tony

> 
> What's new
> ----------
> 
> As was pointed out in the feedback, my version was not enough to fully
> utilize OMAP's DISPC. I did a bit of a rewrite and I now model the
> overlays and overlay managers. This conveniently allows multiple display
> configurations, and it also solved some other problems I had previously.
> The code is still bit of a mess after this change.
> 
> The tv-out and DVI are also now working on OMAP3 SDP board, and you can
> switch between, and combine, LCD, TV-out and DVI outputs. The current
> interface for this is a couple of hackish sysfs files.
> 
> The Kconfig is also a bit more versatile, you can leave out the parts of
> the DSS that you don't need.
> 
> Overlays
> --------
> 
> Here's the default setup on OMAP3 SDP board. All planes go to LCD. DVI
> and TV-out are not in use. The columns from left to right are:
> framebuffers, overlays, overlay managers, displays. Framebuffers are
> handled by omapfb, and the rest by the DSS.
> 
> FB0 --- GFX  -\            DVI
> FB1 --- VID1 --+- LCD ---- LCD
> FB2 --- VID2 -/   TV ----- TV
> 
> In the examples below we use DVI and TV so that the setup changes to the
> following:
> 
> FB0 --- GFX  -\         -- DVI
> FB1 --- VID1 --+- LCD -/   LCD
> FB2 --- VID2 ---- TV ----- TV
> 
> It is also possible to setup a virtual overlay & overlay manager, which
> can be used with displays that can be updated with CPU/sDMA. For
> example:
> 
> FB3 --- VOVL ---- VMGR
> 
> You can also change the overlay to which a framebuffer is connected.
> With this we can, for example, change fb0 from DISPC overlay to virtual
> overlay while X is running on the framebuffer. This way X doesn't notice
> anything, but DISPC is free for other displays.
> 
> And, although not implemented yet, one framebuffer can be connected to
> multiple overlays. This will allow cloning of a framebuffer to multiple
> outputs.
> 
> Sysfs
> -----
> The sysfs interface is a hack, but works for testing. And I don't think
> sysfs interface is the best for this in the final version.
> 
> In /sys/devices/platform/omapfb we have four files: framebuffers,
> overlays, managers and displays. You can read them so see the current
> setup, and change it by writing "arg1:arg2" to it. So changing
> framebuffer 0 to point to vid1 overlay would require writing "0:vid1" to
> framebuffers file.
> 
> Examples
> --------
> In these examples I have symlink omapfb -> /sys/devices/platform/omapfb
> 
> # VIDEO2 plane to TV out
> echo "vid2:" > omapfb/overlays                                 # (1)
> fbset -fb /dev/fb2 -xres 720 -pw 720 -yres 482 -ph 482 -pe 1   # (2)
> echo "vid2:tv" > omapfb/overlays                               # (3)
> echo "tv:1" > omapfb/displays                                  # (4)
> 
> 1. Detach vid2 overlay. Otherwise the DSS will reject the fbset, as
>    the asked resolution is larger than the LCD's resolution.
> 2. Set x/y res, and enable plane
> 3. Attach vid2 to tv overlay manager.
> 4. Enable tv display
> 
> # Use DVI instead of LCD
> echo "lcd:0" > omapfb/displays                                 # (1)
> echo "lcd:" > omapfb/managers                                  # (2)
> # switch the dvi/lcd dip-switch                                # (3)
> fbset -fb /dev/fb0 -xres 800 -pw 800 -yres 600 -ph 600 -pe 1   # (4)
> echo "lcd:dvi" > omapfb/managers                               # (5)
> echo "dvi:1" > omapfb/displays                                 # (6)
> 
> 1. Disable LCD display. We have to disable LCD before we can enable DVI
> 2. Detach LCD overlay manager
> 3. Here you have to set the DIP switch to DVI position
> 4. Set the new resolution
> 5. Attach LCD overlay manager to DVI display
> 6. Enable DVI display
> 
>  Tomi
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
