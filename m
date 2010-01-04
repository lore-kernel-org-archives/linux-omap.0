From: "Maulik" <x0082077@ti.com>
Subject: RE: [PATCH v2 1/2] ARM : OMAP : Add empty functions in header file
Date: Mon, 4 Jan 2010 18:18:08 +0530
Message-ID: <016301ca8d3c$2d2b7f60$808918ac@apr.dhcp.ti.com>
References: <1262603399-13036-1-git-send-email-x0082077@ti.com> <20100104123423.GA1439@gandalf>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60851 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab0ADMsn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 07:48:43 -0500
In-Reply-To: <20100104123423.GA1439@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, 'Tony Lindgren' <tony@atomide.com>, 'Felipe Balbi' <felipe.balbi@nokia.com>, 'Greg Kroah-Hartman' <gregkh@suse.de>, 'Olof Johansson' <olof@lixom.net>, 'Sergei Shtylyov' <sshtylyov@ru.mvista.com>, "'Gupta, Ajay Kumar'" <ajay.gupta@ti.com>


>>not omap-specific. How about USB: instead ?

[Maulik] Yes this can go through linux-usb.

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

>>I hope these are copy&paste error

[Maulik] Nope. When 'extern' is dropped I get the following error while
compiling when CONFIG_USB_NOP_XCEIV is NOT defined. 

arch/arm/plat-omap/built-in.o: In function `usb_nop_xceiv_unregister':
/share/maulik/felipe_musb/include/linux/usb/otg.h:123: multiple definition
of `usb_nop_xceiv_unregister'
arch/arm/mach-omap2/built-in.o:/share/maulik/felipe_musb/include/linux/usb/o
tg.h:123: first defined here
arch/arm/plat-omap/built-in.o: In function `usb_nop_xceiv_register':
/share/maulik/felipe_musb/include/linux/usb/otg.h:119: multiple definition
of `usb_nop_xceiv_register'
arch/arm/mach-omap2/built-in.o:/share/maulik/felipe_musb/include/linux/usb/o
tg.h:119: first defined here
make: *** [vmlinux.o] Error 1

I referred some kernel code which uses extern inline. 

Any suggestions?

Regards,
Maulik

