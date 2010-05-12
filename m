From: "Aguirre, Sergio" <saaguirre-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH RFC 4/5] omap: 3430sdp: add ohci platform init
Date: Wed, 12 May 2010 15:14:37 -0500
Message-ID: <A24693684029E5489D1D202277BE8944555077E0@dlee02.ent.ti.com>
References: <1270220652-29127-1-git-send-email-gadiyar@ti.com>
 <1270220652-29127-2-git-send-email-gadiyar@ti.com>
 <1270220652-29127-3-git-send-email-gadiyar@ti.com>
 <1270220652-29127-4-git-send-email-gadiyar@ti.com>
 <1270220652-29127-5-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1270220652-29127-5-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Gregory Clement <gclement00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Anand,

> -----Original Message-----
> From: Gadiyar, Anand
> Sent: Friday, April 02, 2010 10:04 AM
> To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: David Brownell; Gregory Clement; Felipe Balbi; Aguirre, Sergio;
> Gadiyar, Anand
> Subject: [PATCH RFC 4/5] omap: 3430sdp: add ohci platform init
> 
> Add platform initialization code for OHCI on the 3430SDP.
> 
> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> Index: linux-2.6/arch/arm/mach-omap2/board-3430sdp.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c
> +++ linux-2.6/arch/arm/mach-omap2/board-3430sdp.c
> @@ -675,6 +675,12 @@ static const struct ehci_hcd_omap_platfo
>  	.reset_gpio_port[2]  = -EINVAL
>  };
> 
> +static const struct ohci_hcd_omap_platform_data ohci_pdata __initconst =
> {
> +	.port_mode[0] = OMAP_OHCI_PORT_MODE_UNUSED,
> +	.port_mode[1] = OMAP_OHCI_PORT_MODE_UNUSED,
> +	.port_mode[2] = OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0,
> +};

I just noticed that this patch broke the 3430sdp build for me.

I see following error:

arch/arm/mach-omap2/board-3430sdp.c: In function 'omap_3430sdp_init':
arch/arm/mach-omap2/board-3430sdp.c:840: error: ohci_pdata causes a section type conflict

Removing the "const", to make it similar to ehci struct above it, solves the problem.

Regards,
Sergio

> +
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
> @@ -817,6 +823,7 @@ static void __init omap_3430sdp_init(voi
>  	sdp3430_display_init();
>  	enable_board_wakeup_source();
>  	usb_ehci_init(&ehci_pdata);
> +	usb_ohci_init(&ohci_pdata);
>  }
> 
>  static void __init omap_3430sdp_map_io(void)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
