From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 00/17] OMAP DSS2 model restructuring
Date: Sat, 13 Feb 2010 17:34:30 +0200
Message-ID: <6ed0b2681002130734k77de274fx5ceb169e0853b58d@mail.gmail.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:41513 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab0BMPkR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Feb 2010 10:40:17 -0500
In-Reply-To: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, Feb 8, 2010 at 5:57 PM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> Here are a bunch of patches that change the DSS2 driver's driver mode=
l a bit.
> This change was triggered by trying to support new hardware, and real=
izing that
> the current model just won't work.
>
> Currently the omapdss driver is in control of most aspects of the DSS=
, and
> omapdss calls necessary functions in display drivers. I made it that =
way to
> keep the display drivers simple, and I, naively, thought that it will=
 work
> because the display panels are using standard bus interfaces and thus=
 will be
> very similar. I was so wrong =3D).
>
> This patch set moves the control to the display driver. The display d=
river then
> calls omapdss functions to perform whatever deed is needed at that ti=
me. This
> will make display drivers slightly more complex, but it will be easie=
r to
> control the hardware properly with strange or complex display devices=
=2E
>
> As a simple example, let's look at the update function.
>
> Currently user space app issues OMAPFB_UPDATE_WINDOW ioctl, and omapf=
b driver
> then calls update() in corresponding dss device struct, which goes to=
 omapdss.
> omapdss will configure the update, calling the panel driver if needed=
=2E
>
> After these patches, omapfb will call update() in the panel driver. T=
he panel
> driver will then call functions in omapdss to setup the update, start=
 the
> update, and the panel driver will eventually get a callback informing=
 that the
> update is done.
>
> These patches are still under work, but my basic tests on 3430SDP boa=
rd seems
> to work ok.
>
> The patches can also be found from
> http://gitorious.org/linux-omap-dss2/linux work branch

Tested those along with the other series, seems to work fine on
pandora too. Panel callbacks like set_mirror
also work now, thanks.

Tested-by: Grazvydas Ignotas <notasas@gmail.com>

>
> Tomi Valkeinen (17):
> =A0OMAP: DSS2: DSI: change DSI bus_lock to semaphore
> =A0OMAP: DSS2: DSI: remove auto-update perf measurement
> =A0OMAP: DSS2: move run_test()
> =A0OMAP: DSS2: move memory_read()
> =A0OMAP: DSS2: move set/get_mirror()
> =A0OMAP: DSS2: move get/set_rotate()
> =A0OMAP: DSS2: move wait_vsync()
> =A0OMAP: DSS2: move enable/disable_channel to overlay manager
> =A0OMAP: DSS2: move get_resolution()
> =A0OMAP: DSS2: move get_recommended_bpp()
> =A0OMAP: DSS2: move enable/get_te()
> =A0OMAP: DSS2: move set/get_update_mode()
> =A0OMAP: DSS2: move update() and sync()
> =A0OMAP: DSS2: move enable/disable/suspend/resume
> =A0OMAP: DSS2: move set/get_wss()
> =A0OMAP: DSS2: move timing functions
> =A0OMAP: DSS2: DSI: Add VC support for update
>
> =A0arch/arm/plat-omap/include/plat/display.h =A0 =A0 =A0 =A0 =A0| =A0=
108 ++--
> =A0drivers/video/omap2/displays/panel-generic.c =A0 =A0 =A0 | =A0 56 =
++-
> =A0.../video/omap2/displays/panel-sharp-lq043t1dg01.c | =A0 67 ++-
> =A0.../video/omap2/displays/panel-sharp-ls037v7dw01.c | =A0 42 +-
> =A0drivers/video/omap2/displays/panel-taal.c =A0 =A0 =A0 =A0 =A0| =A0=
221 +++++--
> =A0.../video/omap2/displays/panel-toppoly-tdo35s.c =A0 =A0| =A0 56 ++=
-
> =A0.../video/omap2/displays/panel-tpo-td043mtea1.c =A0 =A0| =A0 61 ++=
-
> =A0drivers/video/omap2/dss/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A07 +
> =A0drivers/video/omap2/dss/dispc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 36 +-
> =A0drivers/video/omap2/dss/display.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 87 +--
> =A0drivers/video/omap2/dss/dpi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0149 +----
> =A0drivers/video/omap2/dss/dsi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0829 ++++----------------
> =A0drivers/video/omap2/dss/dss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A04 +-
> =A0drivers/video/omap2/dss/manager.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 48 +-
> =A0drivers/video/omap2/dss/overlay.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +-
> =A0drivers/video/omap2/dss/rfbi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0321 +-------
> =A0drivers/video/omap2/dss/sdi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0115 +---
> =A0drivers/video/omap2/dss/venc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0294 +++----
> =A0drivers/video/omap2/omapfb/omapfb-ioctl.c =A0 =A0 =A0 =A0 =A0| =A0=
 44 +-
> =A0drivers/video/omap2/omapfb/omapfb-main.c =A0 =A0 =A0 =A0 =A0 | =A0=
 89 ++-
> =A0drivers/video/omap2/omapfb/omapfb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A06 +
> =A021 files changed, 1004 insertions(+), 1638 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
