From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ARM : OMAP4 : MUSB : Add USB support to 4430
	SDP board file
Date: Wed, 30 Dec 2009 11:06:48 -0600
Message-ID: <20091230170648.GA7017@lixom.net>
References: <1262183198-14854-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1262183198-14854-1-git-send-email-x0082077-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Dec 30, 2009 at 07:56:38PM +0530, Maulik Mankad wrote:

> --- felipe_musb.orig/arch/arm/mach-omap2/board-4430sdp.c
> +++ felipe_musb/arch/arm/mach-omap2/board-4430sdp.c
> @@ -73,11 +75,21 @@ static void __init omap_4430sdp_init_irq
>  	omap_gpio_init();
>  }
>  
> +static struct omap_musb_board_data musb_board_data = {
> +	.interface_type		= MUSB_INTERFACE_UTMI,
> +	.mode			= MUSB_PERIPHERAL,
> +	.power			= 100,
> +};
>  
>  static void __init omap_4430sdp_init(void)
>  {
>  	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
>  	omap_serial_init();
> +#ifdef CONFIG_NOP_USB_XCEIV
> +	/* OMAP4 SDP uses Internal transceiver so register nop transceiver */
> +	usb_nop_xceiv_register();
> +#endif
> +	usb_musb_init(&musb_board_data);

If you add a select of NOP_USB_XCEIV in the board config option you can
do away with the ifdef.

Is there ever a case, for this board, where you don't want NOP_USB_XCEIV
enabled?

Failing that, add an empty init function to the header file such that
you can always call it even when the option is not enabled. It keeps
the amount of ifdeffery in the code to a minimum.


-Olof

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
