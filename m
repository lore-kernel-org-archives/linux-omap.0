From: "Maulik" <x0082077-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/4] USB: MUSB: Add OMAP4 support in MUSB driver
Date: Fri, 26 Feb 2010 14:13:31 +0530
Message-ID: <000101cab6bf$c6f64ec0$808918ac@apr.dhcp.ti.com>
References: <1267079785-14529-1-git-send-email-x0082077@ti.com> <4B864F03.3070507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B864F03.3070507-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Sergei Shtylyov' <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Felipe Balbi' <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, 'Greg Kroah-Hartman' <gregkh-l3A5Bk7waGM@public.gmane.org>, 'David Brownell' <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Maulik Mankad wrote:
> This patch adds CONFIG_ARCH_OMAP4 macro within MUSB driver
> code and builds the MUSB driver for OMAP4.
>
> Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> ---
> Index: mainline/drivers/usb/musb/Makefile
> ===================================================================
> --- mainline.orig/drivers/usb/musb/Makefile
> +++ mainline/drivers/usb/musb/Makefile
> @@ -22,6 +22,10 @@ ifeq ($(CONFIG_ARCH_OMAP3430),y)
>  	musb_hdrc-objs	+= omap2430.o
>  endif
>  
> +ifeq ($(CONFIG_ARCH_OMAP4),y)
> +	musb_hdrc-objs  += omap2430.o
> +endif
> +
>  ifeq ($(CONFIG_BF54x),y)
>  	musb_hdrc-objs	+= blackfin.o
>  endif

>>   I think this should be combined with patch 2/4 which doesn't make 
>> much sense otherwise...

Sergei,

I shall take care of this in the next version.

Thanks,
Maulik

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
