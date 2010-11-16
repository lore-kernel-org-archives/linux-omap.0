From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH v4 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Tue, 16 Nov 2010 15:32:55 +0200
Message-ID: <1289914375.2668.96.camel@tubuntu>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
	 <1289219065-1362-4-git-send-email-archit@ti.com>
	 <1289904957.2668.75.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087034C10218C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:26795 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756565Ab0KPNdC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 08:33:02 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034C10218C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

On Tue, 2010-11-16 at 12:22 +0100, ext Taneja, Archit wrote:
> Hi,
> 
> Tomi Valkeinen wrote:
> > Hi,
> > 
> 
> [snip]
> 
> >> diff --git a/arch/arm/plat-omap/include/plat/display.h
> >> b/arch/arm/plat-omap/include/plat/display.h
> >> index 586944d..3e6eec1 100644
> >> --- a/arch/arm/plat-omap/include/plat/display.h
> >> +++ b/arch/arm/plat-omap/include/plat/display.h
> >> @@ -434,6 +434,7 @@ struct omap_dss_device {
> >>         struct omap_overlay_manager *manager;
> >> 
> >>         enum omap_dss_display_state state;
> >> +       enum omap_channel channel;
> > 
> > Isn't this the same as dssdev->manager->id?
> > 
> > Yes, this channel stuff is a bit confusing, even the enum "omap_channel"
> > is badly named (should at least have "dss" in it). But
> > omap_overlay_manager should represent the output pipe, so I
> > don't think there's need for channel field in dss_device.
> 
> The panel somehow needs to tell which manager it is connected to. We went with
> with the way of declaring a new member 'channel' and setting that parameter up in the
> board file.
> 
> The current way to relate the manager and device is done by checking the dssdev->type
> in dss_recheck_connections() and then calling set_device()
> 
> This is not sufficient any more since two of the managers can support similar types of
> displays.
> 
> So in the channel approach the following happens:
> 
> -mgr->id's are initialized at bootup.
> -devices and managers are connected using 'channel'.
> -mgr->id automatically becomes equal to channel.
> 
> Can we set something like dssdev->manager->id in the board file itself?

Right, now I see.

The dss_recheck_connections() felt like a hack when I wrote it =).
Clearly we need some way to define in the board file which panel
connects to which manager.

Perhaps move the channel-field up, just below "enum omap_display_type
type". The lines in the beginning of omap_dss_device are things which
define the interface etc, and later there are miscallaneous dynamic
things. And this belongs to the former.

Now, if we have the channel defined in this way in the omap_dss_device,
I'm wondering if:
1) the manager pointer is needed at all, as the channel tells which
manager it is?
2) if we keep the manager pointer (as a helper shortcut), should the
code use generally use dssdev->channel or dssdev->manager->id?
3) having this channel field requires a change to every board file,
because the channel has to be defined?

And answering to myself, I guess the manager pointer is needed, because
DSS2 supports (at least in theory) multiple panels in the same interface
(not at the same time, of course). This means that we could have to
panels, with the same interface and channel, but only one would be in
use. So the one in use should have manager pointing to the correct
manager, and the other would have manager NULL.

And thus perhaps using dssdev->channel only for connecting the right
manager to right panel, and using dssdev->manager->id for other uses
would be the best? The values would of course be the same, but at least
we'd get a crash if somehow an unconnected display is being used for
configuration.

Does this make sense?

 Tomi


