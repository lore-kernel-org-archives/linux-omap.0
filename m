From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 1/2] ARM : OMAP : Add empty functions in header file
Date: Mon, 4 Jan 2010 17:59:47 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A277F29@dbde02.ent.ti.com>
References: <1262603399-13036-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262603399-13036-1-git-send-email-x0082077-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Mankad, Maulik Ojas
> Sent: Monday, January 04, 2010 4:40 PM
> To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mankad, Maulik Ojas; Tony Lindgren; Felipe
> Balbi; Greg Kroah-Hartman; Olof Johansson; Sergei Shtylyov; Gupta, Ajay
> Kumar
> Subject: [PATCH v2 1/2] ARM : OMAP : Add empty functions in header file
> 
> ARM : OMAP : Add empty functions in header file
> 
> Add empty functions for usb_nop_xceiv_register()
> and usb_nop_xceiv_unregister() so that these functions
> can be called even when CONFIG_NOP_USB_XCEIV is not
> enabled.
> 
> It allows to remove ifdef's from board file.
> 
> Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> Cc: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> Cc: Gupta, Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
> Index: felipe_musb/include/linux/usb/otg.h
> ===================================================================
> --- felipe_musb.orig/include/linux/usb/otg.h
> +++ felipe_musb/include/linux/usb/otg.h
> @@ -110,9 +110,19 @@ struct otg_transceiver {
>  /* for board-specific init logic */
>  extern int otg_set_transceiver(struct otg_transceiver *);
> 
> +#if defined(CONFIG_USB_NOP_XCEIV)
>  /* sometimes transceivers are accessed only through e.g. ULPI */
>  extern void usb_nop_xceiv_register(void);
>  extern void usb_nop_xceiv_unregister(void);
> +#else
> +extern inline void usb_nop_xceiv_register()
> +{
> +}
> +
> +extern inline void usb_nop_xceiv_unregister()
   ^^^^^^

'extern' should not be used here.

-Ajay
> +#endif
> 
>  /* helpers for direct access thru low-level io interface */
>  static inline int otg_io_read(struct otg_transceiver *otg, u32 reg)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
