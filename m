From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/4] USB: MUSB: Add OMAP4 support in MUSB driver
Date: Thu, 25 Feb 2010 13:20:51 +0300
Message-ID: <4B864F03.3070507@ru.mvista.com>
References: <1267079785-14529-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:56744 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087Ab0BYKVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 05:21:20 -0500
In-Reply-To: <1267079785-14529-1-git-send-email-x0082077@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik Mankad <x0082077@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <david-b@pacbell.net>

Hello.

Maulik Mankad wrote:
> This patch adds CONFIG_ARCH_OMAP4 macro within MUSB driver
> code and builds the MUSB driver for OMAP4.
>
> Signed-off-by: Maulik Mankad <x0082077@ti.com>
> Cc: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: David Brownell <david-b@pacbell.net>
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

   I think this should be combined with patch 2/4 which doesn't make 
much sense otherwise...

WBR, Sergei

