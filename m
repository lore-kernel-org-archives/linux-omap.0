From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
 (try #7)
Date: Wed, 17 Nov 2010 18:17:17 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035E84A65B@dbde02.ent.ti.com>
References: <1289960640-8782-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58845 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab0KQMra convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 07:47:30 -0500
In-Reply-To: <1289960640-8782-1-git-send-email-bryan.wu@canonical.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.

Acked-by: Archit Taneja <archit@ti.com>

bryan.wu@canonical.com wrote:
> There are 4 duplicated DPI panel drivers in DSS2 display
> driver. They are similar and a generic DPI panel driver can
> support all them with specific panel configuration. And new
> DPI panel driver can be easily supported by adding panel
> configurations into generic panel DPI driver.
> 
> This patchset introduces a generic panel DPI driver, remove 3
> panel drivers and enable generic panel DPI driver in board
> files. And it is based on 2.6.37-rc2.
> 
> Building with omap2plus_defconfig is successful.
> 
> Keep sharp_ls_panel, since it contains blacklight control
> code which will be moved out later.
> 
> Bryan Wu (3):
>   OMAP: DSS2: Add generic DPI panel display driver
>   OMAP: use generic DPI panel driver in board files
>   OMAP: DSS2: remove generic DPI panel driver duplicated panel drivers
> 
>  arch/arm/mach-omap2/board-3430sdp.c                |   12 +-
>  arch/arm/mach-omap2/board-am3517evm.c              |   23 +-
>  arch/arm/mach-omap2/board-cm-t35.c                 |   23 +-
>  arch/arm/mach-omap2/board-devkit8000.c             |   26 +-
>  arch/arm/mach-omap2/board-igep0020.c               |   12 +-
>  arch/arm/mach-omap2/board-omap3beagle.c            |   12 +-
>  arch/arm/mach-omap2/board-omap3evm.c               |   12 +-
>  arch/arm/mach-omap2/board-omap3stalker.c           |   23 +-
>  .../arm/plat-omap/include/plat/panel-generic-dpi.h |   37 ++
>  drivers/video/omap2/displays/Kconfig               |   22 +-
>  drivers/video/omap2/displays/Makefile              |    4 +-
>  drivers/video/omap2/displays/panel-generic-dpi.c   |  348
>  ++++++++++++++++++++ drivers/video/omap2/displays/panel-generic.c       | 
>  174 ---------- .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  165
>  --------- .../video/omap2/displays/panel-toppoly-tdo35s.c    |  164 ---------
>  15 files changed, 497 insertions(+), 560 deletions(-)
> create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>  create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
>  delete mode 100644 drivers/video/omap2/displays/panel-generic.c  delete mode
> 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c  delete mode
> 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c