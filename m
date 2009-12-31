From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ARM : OMAP : Add empty function in header file
Date: Thu, 31 Dec 2009 22:34:59 +0300
Message-ID: <4B3CFCE3.2040206@ru.mvista.com>
References: <1262265214-16906-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:53225 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750714AbZLaTfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Dec 2009 14:35:23 -0500
In-Reply-To: <1262265214-16906-1-git-send-email-x0082077@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik Mankad <x0082077@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>

Hello.

Maulik Mankad wrote:

> ARM : OMAP : Add empty function in header file
>
> This patch adds empty functions for usb_nop_xceiv_register()
> and usb_nop_xceiv_unregister() so that these functions
> can be called even when CONFIG_NOP_USB_XCEIV is not 
> enabled. 
>
> It allows to remove ifdef's from board file.
>
> Signed-off-by: Maulik Mankad <x0082077@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Olof Johansson <olof@lixom.net>
> ---
> Index: felipe_musb/include/linux/usb/otg.h
> ===================================================================
> --- felipe_musb.orig/include/linux/usb/otg.h
> +++ felipe_musb/include/linux/usb/otg.h
> @@ -110,9 +110,14 @@ struct otg_transceiver {
>  /* for board-specific init logic */
>  extern int otg_set_transceiver(struct otg_transceiver *);
>  
> +#if defined(CONFIG_USB) || defined(CONFIG_USB_GADGET)
>  /* sometimes transceivers are accessed only through e.g. ULPI */
>  extern void usb_nop_xceiv_register(void);
>  extern void usb_nop_xceiv_unregister(void);
> +#else
> +#define usb_nop_xceiv_register()	do {} while (0)
> +#define usb_nop_xceiv_unregister()	do {} while (0)
>   

   Inline functions are preferrable to macros.

WBR, Sergei


