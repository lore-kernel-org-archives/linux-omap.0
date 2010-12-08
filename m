From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 5/7] usb: musb: TWL6030: Selecting TWL6030_USB transceiver
Date: Wed, 08 Dec 2010 19:03:59 +0300
Message-ID: <4CFFAC6F.9000808@ru.mvista.com>
References: <1291824130-7181-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:42384 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab0LHQFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 11:05:22 -0500
In-Reply-To: <1291824130-7181-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hello.

Hema HK wrote:

> Selecting the twl6030-usb for OMAP4430SDP and OMAP4 PANDA board and
> adding OMAP4 internal phy code for compilation

> Signed-off-by: Hema HK <hemahk@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
[...]

> Index: linux-2.6/drivers/usb/musb/Kconfig
> ===================================================================
> --- linux-2.6.orig/drivers/usb/musb/Kconfig
> +++ linux-2.6/drivers/usb/musb/Kconfig
> @@ -12,6 +12,7 @@ config USB_MUSB_HDRC
>  	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
>  	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
>  	select TWL4030_USB if MACH_OMAP_3430SDP
> +	select TWL6030_USB if (MACH_OMAP_3430SDP || MACH_OMAP4_PANDA)

    Parens are not necessary. Though the previous code uses them...

WBR, Sergei

