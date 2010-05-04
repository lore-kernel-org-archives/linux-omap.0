From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Resubmit: PATCH-V2] AM3517: Add VPFE Capture driver support
Date: Tue, 4 May 2010 16:18:10 -0700
Message-ID: <20100504231810.GS29604@atomide.com>
References: <hvaibhav@ti.com>
 <1268991469-2747-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1268991469-2747-1-git-send-email-hvaibhav@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* hvaibhav@ti.com <hvaibhav@ti.com> [100319 02:34]:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> AM3517 and DM644x uses same CCDC IP, so reusing the driver
> for AM3517.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |  160 +++++++++++++++++++++++++++++++++
>  1 files changed, 160 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
> index f04311f..d2d2ced 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -30,11 +30,164 @@
> 
>  #include <plat/board.h>
>  #include <plat/common.h>
> +#include <plat/control.h>
>  #include <plat/usb.h>
>  #include <plat/display.h>
> 
> +#include <media/tvp514x.h>
> +#include <media/ti-media/vpfe_capture.h>
> +

At least the mainline kernel does not seem to have media/ti-media/,
so I'm not taking this.

Looks like it should be safe to merge via linux-media from omap
point of view.

Acked-by: Tony Lindgren <tony@atomide.com>
