From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Mon, 22 Nov 2010 12:22:30 +0200
Message-ID: <20101122102230.GP2446@legolas.emea.dhcp.ti.com>
References: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1290415961-21177-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Nov 22, 2010 at 02:22:40PM +0530, Ajay Kumar Gupta wrote:
>Fixes compilation error as control.h APIs are not available to
>drivers/usb/musb/am35x.c file. Earlier it was getting included
>from <plat/control.h> but now moved to new location by another
>pacth.
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Tony ? Do you ack the usage of that header ?

>---
>Patch created against latest Linus's tree (v2.6.37-rc3)
>
> arch/arm/plat-omap/include/plat/usb.h |    2 ++
> drivers/usb/musb/am35x.c              |    1 -
> 2 files changed, 2 insertions(+), 1 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
>index 59c7fe7..f1b8b40 100644
>--- a/arch/arm/plat-omap/include/plat/usb.h
>+++ b/arch/arm/plat-omap/include/plat/usb.h
>@@ -6,6 +6,8 @@
> #include <linux/usb/musb.h>
> #include <plat/board.h>
>
>+#include "../../../mach-omap2/control.h"
>+
> #define OMAP3_HS_USB_PORTS	3
> enum ehci_hcd_omap_mode {
> 	EHCI_HCD_OMAP_MODE_UNKNOWN,
>diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
>index b0aabf3..30f524a 100644
>--- a/drivers/usb/musb/am35x.c
>+++ b/drivers/usb/musb/am35x.c
>@@ -30,7 +30,6 @@
> #include <linux/clk.h>
> #include <linux/io.h>
>
>-#include <plat/control.h>
> #include <plat/usb.h>
>
> #include "musb_core.h"
>-- 
>1.6.2.4

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
