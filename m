From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 1/3] OMAP: use generic panel data in board files
Date: Mon, 08 Nov 2010 14:19:23 +0200
Message-ID: <1289218763.3297.47.camel@tubuntu>
References: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
	 <1288986236-30210-2-git-send-email-bryan.wu@canonical.com>
	 <FCCFB4CDC6E5564B9182F639FC356087034BF2D67E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:50615 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284Ab0KHMSQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 07:18:16 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BF2D67E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "notasas@gmail.com" <notasas@gmail.com>

Hi,

On Fri, 2010-11-05 at 22:17 +0100, ext Taneja, Archit wrote:
> Hi,
> 
> linux-omap-owner@vger.kernel.org wrote:
> > Introduce struct panel config data in panel.h, which will be
> > used to match the right panel configurations in generic DPI
> > panel driver and other future dsi panel drivers.
> >
> > Still keep sharp_ls_panel, since the sharp_ls_panel driver
> > contains blacklight control driver code which will be moved
> > out later. Then we can use generic DPI driver for sharp_ls_panel.
> >
> > Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> > ---
> >  arch/arm/mach-omap2/board-3430sdp.c               |   10 +++-
> >  arch/arm/mach-omap2/board-am3517evm.c             |   19 +++++--
> >  arch/arm/mach-omap2/board-cm-t35.c                |   19 +++++--
> >  arch/arm/mach-omap2/board-devkit8000.c            |   22 +++++---
> >  arch/arm/mach-omap2/board-igep0020.c              |   10 +++-
> >  arch/arm/mach-omap2/board-omap3beagle.c           |   10 +++-
> >  arch/arm/mach-omap2/board-omap3evm.c              |   10 +++-
> >  arch/arm/mach-omap2/board-omap3stalker.c          |   19 +++++--
> >  arch/arm/plat-omap/include/plat/nokia-dsi-panel.h |   31 -----------
> >  arch/arm/plat-omap/include/plat/panel.h           |   57
> >  +++++++++++++++++++++ drivers/video/omap2/displays/panel-taal.c         |
> >  26 ++++------ 11 files changed, 148 insertions(+), 85 deletions(-)  delete
> > mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
> >  create mode 100644 arch/arm/plat-omap/include/plat/panel.h
> 
> I am not totally sure about the need of removal of nokia-dsi-panel.h
> and the addition of a generic panel.h.
> 
> I guess the reason why nokia-dsi-panel.h was introduced (and others that
> will be introduced in future) was to easily represent panel-specific data
> across different boards that use the same panel.

Right. Don't touch panel-taal.c or nokia-dsi-panel.h, they are not
related to this DPI panel stuff.

> For example, if there is a new panel which for some reson uses 2 pins, one
> for switching off and one for switching on the panel, then it would make sense
> to introduce a structure for this panel having members on_gpio and off_gpio, this
> struct could then be passed and accessed through dssdev->data in the panel's probe
> giving us the option to have different gpio numbers for different boards but finally
> being accessed in the same way by the driver.
> 
> So, there isn't a need to generalize this struct and the corresponding header file
> for all panels and make it available for all board files.
> 
> As far as the dummy panels are concerned, since the "name" is the only criteria to
> differentiate the panel, I think passing the name to the data member of omap_dss_device
> should itself be enough for the generic dpi driver to handle things.

I think it's a bit confusing to just put a string to the void *data
member, but fortunately we don't need to ponder about that: the generic
DPI panel should be told about reset_gpio, max_backlight_level,
platform_enable/disable and set/get_backlight, which need to be passed
in a struct. So a header and a struct is needed for this generic DPI
driver.

 Tomi


