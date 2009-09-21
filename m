From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC] OMAP: DSS2: Add flag to enable/disable TVOUTBYPASS for
 VENC
Date: Mon, 21 Sep 2009 10:10:07 +0300
Message-ID: <1253517007.4690.11.camel@tubuntu>
References: <1253283578-24377-1-git-send-email-y>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:27306 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbZIUHLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 03:11:18 -0400
In-Reply-To: <1253283578-24377-1-git-send-email-y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext y@ultratronik.de" <y@ultratronik.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Matthias Ludwig <mludwig@ultratronik.de>

Hi,

On Fri, 2009-09-18 at 16:19 +0200, ext y@ultratronik.de wrote:
> From: Matthias Ludwig <mludwig@ultratronik.de>
> 
> Signed-off-by: Matthias Ludwig <mludwig@ultratronik.de>
> ---
> 
> OMAP CPU can only provide a level of about 0.8V at TVOUT, which is not
> compliant with NTSC nor PAL. If one wants to have a compliant signal
> external buffers need to be added. This requires TVOUTBYPASS to be set.
> This patch implements a simple way to set it from dss platform data.
> 
> Is there a more elegant way to get register address?

Where does OMAP2_TVOUTBYPASS come from? It doesn't exist in my tree.

I have a hack in my board files that just do:

l = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1) | (1 << 18);
omap_ctrl_writel(l, OMAP343X_CONTROL_DEVCONF1);

A flag in the omap_dss_device would be the proper way to do it, as you
did, but I think venc.c should call some function somewhere in arch/arm/
to actually do the setup.

 Tomi

> 
>  arch/arm/plat-omap/include/mach/display.h |    1 +
>  drivers/video/omap2/dss/venc.c            |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/display.h b/arch/arm/plat-omap/include/mach/display.h
> index 4c7422e..3013be0 100644
> --- a/arch/arm/plat-omap/include/mach/display.h
> +++ b/arch/arm/plat-omap/include/mach/display.h
> @@ -380,6 +380,7 @@ struct omap_dss_device {
>  		struct {
>  			enum omap_dss_venc_type type;
>  			bool invert_polarity;
> +			bool bypass_tvout;
>  		} venc;
>  	} phy;
>  
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
> index cf7827e..cb35a0d 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -35,6 +35,7 @@
>  #include <linux/regulator/consumer.h>
>  
>  #include <mach/display.h>
> +#include <mach/control.h>
>  #include <mach/cpu.h>
>  
>  #include "dss.h"
> @@ -532,6 +533,21 @@ static void venc_power_on(struct omap_dss_device *dssdev)
>  
>  	venc_write_reg(VENC_OUTPUT_CONTROL, l);
>  
> +	if (dssdev->phy.venc.bypass_tvout) {
> +		u32 dc1, dc1_addr;
> +#ifdef CONFIG_ARCH_OMAP3430
> +		dc1_addr = OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1);
> +#elif defined(CONFIG_ARCH_OMAP2430)
> +		dc1_addr = OMAP243X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1);
> +#elif defined(CONFIG_ARCH_OMAP2420)
> +		dc1_addr = OMAP242X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1);
> +#else
> +		bug();
> +#endif
> +		dc1 = readl(dc1_addr) | OMAP2_TVOUTBYPASS;
> +		writel(dc1, dc1_addr);
> +	}
> +
>  	dispc_set_digit_size(dssdev->panel.timings.x_res,
>  			dssdev->panel.timings.y_res/2);
>  

