From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 09/11] OMAP3: PM: Smartreflex Class3 initialization from board files.
Date: Thu, 14 Oct 2010 16:50:21 -0700
Message-ID: <87aamgpc5e.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-10-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41907 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab0JNXuX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 19:50:23 -0400
Received: by pzk33 with SMTP id 33so20378pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 16:50:23 -0700 (PDT)
In-Reply-To: <1285166719-19352-10-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 22 Sep 2010 20:15:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch enables smartreflex class3 functionality for OMAP3430SDP,
> OMAP3630SDP, ZOOM2 and ZOOM3 boards.

This patch doesn't touch 3630sdp.

> Signed-off-by: Thara Gopinath <thara@ti.com>

I'm having some doubts about whether this should be done by board files or
not.  Seems like the general case will be that by default will be SoC
specific, and only boards that want something other than the default
class should need to override this.

Thoughts?

Kevin

> ---
>  arch/arm/mach-omap2/board-3430sdp.c          |    2 ++
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 67b95b5f..9a04a2e 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -47,6 +47,7 @@
>  #include "sdram-qimonda-hyb18m512160af-6.h"
>  #include "hsmmc.h"
>  #include "pm.h"
> +#include "smartreflex-class3.h"
>  
>  #define CONFIG_DISABLE_HFCLK 1
>  
> @@ -813,6 +814,7 @@ static void __init omap_3430sdp_init(void)
>  	sdp3430_display_init();
>  	enable_board_wakeup_source();
>  	usb_ehci_init(&ehci_pdata);
> +	sr_class3_init();
>  }
>  
>  MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 6b39849..98dffc6 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -26,6 +26,7 @@
>  
>  #include "mux.h"
>  #include "hsmmc.h"
> +#include "smartreflex-class3.h"
>  
>  /* Zoom2 has Qwerty keyboard*/
>  static int board_keymap[] = {
> @@ -282,4 +283,5 @@ void __init zoom_peripherals_init(void)
>  	omap_i2c_init();
>  	usb_musb_init(&musb_board_data);
>  	enable_board_wakeup_source();
> +	sr_class3_init();
>  }
