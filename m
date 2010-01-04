From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM : OMAP : Add empty functions in header file
Date: Mon, 4 Jan 2010 14:34:23 +0200
Message-ID: <20100104123423.GA1439@gandalf>
References: <1262603399-13036-1-git-send-email-x0082077@ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1262603399-13036-1-git-send-email-x0082077-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Jan 04, 2010 at 04:39:59PM +0530, Maulik Mankad wrote:
> ARM : OMAP : Add empty functions in header file

not omap-specific. How about USB: instead ?

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

I hope these are copy&paste error

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
