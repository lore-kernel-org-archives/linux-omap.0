From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/4]usb: musb: HWMOD database structures addition for
 OMAP3
Date: Mon, 28 Jun 2010 17:10:10 +0400
Message-ID: <4C289F32.7070709@ru.mvista.com>
References: <1277727391-6041-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41565 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab0F1NLL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 09:11:11 -0400
In-Reply-To: <1277727391-6041-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, tony@atomide.com

Hello.

Hema HK wrote:

> OMAP3 hwmod data stuctures are populated with base address, L3 and L4 
> interface clocks, IRQs,and sysconfig register details. 

> Signed-off-by: Hema HK <hemahk@ti.com>
> Cc: Felipe Balbi <felipe.balbi@nokia.com>,tony@atomide.com
[...]
> @@ -90,6 +99,37 @@ static struct omap_hwmod_ocp_if omap3xxx
>  	.user	= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +/*
> +* USBHSOTG interface data
> +*/
> +
> +static struct omap_hwmod_addr_space omap3xxx_usbhsotg_addrs[] = {
> +	{
> +	.pa_start	= OMAP34XX_HSUSB_OTG_BASE,
> +	.pa_end		= OMAP34XX_HSUSB_OTG_BASE + SZ_4K - 1,
> +	.flags		= ADDR_TYPE_RT

    Indentation: should add one more tab.

> +	},
> +};

[...]

> @@ -197,6 +237,56 @@ static struct omap_hwmod omap3xxx_iva_hw
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
>  };
>  
> +/*
> + * USBHSOTG (USBHS)
> + */
> +static struct omap_hwmod_class_sysconfig omap3xxx_usbhsotg_sysc = {
> + 	.rev_offs	= 0x0400,
> + 	.sysc_offs	= 0x0404,
> + 	.syss_offs	= 0x0408,
> + 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
> + 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> + 			   SYSC_HAS_AUTOIDLE),
> + 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),

    Parens are not useful here.

WBR, Sergei
