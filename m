From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: USB: Fix compile warnings in board-2430sdp-usb.c
Date: Fri, 23 Nov 2007 13:46:00 -0800
Message-ID: <20071123214600.GO559@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804E3D369@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804E3D369@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [071123 07:41]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> Fixes warnings during compilation with CONFIG_USB_GADGET_MUSB_HDRC=y
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp-usb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-2.6-NOV23/arch/arm/mach-omap2/board-2430sdp-usb.c
> ===================================================================
> --- linux-omap-2.6-NOV23.orig/arch/arm/mach-omap2/board-2430sdp-usb.c	2007-11-23 11:36:45
> +++ linux-omap-2.6-NOV23/arch/arm/mach-omap2/board-2430sdp-usb.c	2007-11-23 11:41:41
> @@ -37,9 +37,9 @@
>  static struct musb_hdrc_platform_data musb_plat = {
>  #ifdef CONFIG_USB_MUSB_OTG
>  	.mode		= MUSB_OTG,
> -#elif CONFIG_USB_MUSB_HDRC_HCD
> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
>  	.mode		= MUSB_HOST,
> -#elif CONFIG_USB_GADGET_MUSB_HDRC
> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>  	.mode		= MUSB_PERIPHERAL,
>  #endif
>  	.multipoint	= 1,

Pushing today.

Tony
