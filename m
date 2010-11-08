From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/3] OMAP: use generic panel data in board files
Date: Mon, 08 Nov 2010 14:26:03 +0200
Message-ID: <1289219163.3297.54.camel@tubuntu>
References: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
	 <1288986236-30210-2-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:42989 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284Ab0KHMYy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 07:24:54 -0500
In-Reply-To: <1288986236-30210-2-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gadiyar@ti.com" <gadiyar@ti.com>, "notasas@gmail.com" <notasas@gmail.com>

Hi,

On Fri, 2010-11-05 at 20:43 +0100, ext Bryan Wu wrote:
> Introduce struct panel config data in panel.h, which will be used to match
> the right panel configurations in generic DPI panel driver and other future
> dsi panel drivers.
> 
> Still keep sharp_ls_panel, since the sharp_ls_panel driver contains blacklight
> control driver code which will be moved out later. Then we can use generic DPI
> driver for sharp_ls_panel.

As mentioned in the other mail, don't touch panel-taal or
nokia-dsi-panel.h. They are not related to this change.

The panel.h file should be spesific for the generic panel driver, so
name the .c and .h files similarly. (yes, panel-taal.c and
nokia-dsi-panel.h are not good examples for this, but I have a patch
fixing it, I just haven't had time to push it forward =).

And remember that the kernel should compile and work after each
individual patch in the patch set. In this patch you set the boards to
use dvi_panel driver, but there is no dvi_panel driver yet.

Also some comments inline.

> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c               |   10 +++-
>  arch/arm/mach-omap2/board-am3517evm.c             |   19 +++++--
>  arch/arm/mach-omap2/board-cm-t35.c                |   19 +++++--
>  arch/arm/mach-omap2/board-devkit8000.c            |   22 +++++---
>  arch/arm/mach-omap2/board-igep0020.c              |   10 +++-
>  arch/arm/mach-omap2/board-omap3beagle.c           |   10 +++-
>  arch/arm/mach-omap2/board-omap3evm.c              |   10 +++-
>  arch/arm/mach-omap2/board-omap3stalker.c          |   19 +++++--
>  arch/arm/plat-omap/include/plat/nokia-dsi-panel.h |   31 -----------
>  arch/arm/plat-omap/include/plat/panel.h           |   57 +++++++++++++++++++++
>  drivers/video/omap2/displays/panel-taal.c         |   26 ++++------
>  11 files changed, 148 insertions(+), 85 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
>  create mode 100644 arch/arm/plat-omap/include/plat/panel.h
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 4e3742c..859b4e5 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -38,6 +38,7 @@
>  #include <plat/dma.h>
>  #include <plat/gpmc.h>
>  #include <plat/display.h>
> +#include <plat/panel.h>
> 
>  #include <plat/gpmc-smc91x.h>
> 
> @@ -270,11 +271,14 @@ static struct omap_dss_device sdp3430_lcd_device = {
>         .platform_disable       = sdp3430_panel_disable_lcd,
>  };
> 
> +static struct panel_data dvi_panel = {
> +       .name           = "generic",
> +};
> +
>  static struct omap_dss_device sdp3430_dvi_device = {
>         .name                   = "dvi",
> -       .driver_name            = "generic_panel",
> -       .type                   = OMAP_DISPLAY_TYPE_DPI,
> -       .phy.dpi.data_lines     = 24,

Why do you remove type and datalines configuration? You do this for the
other panels also.

 Tomi


