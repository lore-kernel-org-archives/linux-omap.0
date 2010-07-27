From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/2] OMAP: DSS2: enable generic panel configuration
 modification
Date: Tue, 27 Jul 2010 11:00:49 +0300
Message-ID: <1280217649.2427.68.camel@tubuntu.research.nokia.com>
References: <1280140468-8183-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58287 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab0G0IBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 04:01:12 -0400
In-Reply-To: <1280140468-8183-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

On Mon, 2010-07-26 at 12:34 +0200, ext Igor Grinberg wrote:
> This patch enables platforms to modify the dss device configuration
> of the generic panel.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  drivers/video/omap2/displays/panel-generic.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video/omap2/displays/panel-generic.c
> index 300eff5..ad80dd0 100644
> --- a/drivers/video/omap2/displays/panel-generic.c
> +++ b/drivers/video/omap2/displays/panel-generic.c
> @@ -66,7 +66,7 @@ static void generic_panel_power_off(struct omap_dss_device *dssdev)
>  
>  static int generic_panel_probe(struct omap_dss_device *dssdev)
>  {
> -	dssdev->panel.config = OMAP_DSS_LCD_TFT;
> +	dssdev->panel.config |= OMAP_DSS_LCD_TFT;
>  	dssdev->panel.timings = generic_panel_timings;
>  
>  	return 0;


I don't like this. Panel driver should be the one which decides the
config.

I think a better solution is to make panel-generic configurable, which
has been discussed a bit some time ago on l-o.

Briefly:

- Add a struct for the configuration variables (a bit like
arch/arm/plat-omap/include/plat/nokia-dsi-panel.h).

- Fill the struct in the board file, and pass it to the panel driver via
omap_dss_device->data pointer.

- The panel driver get the struct and uses it to do whatever
configuration it needs.

I think there are two ways to implement this:

1) Have lots of fields in the struct, including video timings and video
signaling information, and the driver uses these directly.

2) Have a panel name in the struct, and the panel driver contains a
static list of panels, including configurations for those panels, and
the driver selects the configuration based on the panel name given from
the board file. (like drivers/video/omap2/displays/panel-taal.c does,
except there's currently only one panel defined).

While 1. gives perhaps slightly easier configuration, as you just edit
the board file, I'd go for 2. because the required configuration is
really defined by the panel/chip being used, and so the board file
should just state which panel/chip we have, and the driver handles the
rest. And 2. makes it also easier to use the same panel/chip on multiple
boards.

Implementing this would allow us to remove some panel drivers which
currently are 99% copies of each other.

 Tomi


