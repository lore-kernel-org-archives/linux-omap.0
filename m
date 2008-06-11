From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Added sleep support to UART
Date: Wed, 11 Jun 2008 17:32:07 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806111712520.21166@utopia.booyaka.com>
References: <> <1213106931-17954-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54355 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYFKXcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 19:32:09 -0400
In-Reply-To: <1213106931-17954-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Tero,

A few minor comments based on a quick look.

In terms of the OMAP3 code, is that for retention-idle only, or does it 
work with off-idle also?  

On Tue, 10 Jun 2008, Tero Kristo wrote:

> +const u32 omap2_uart_wk_bit[OMAP_MAX_NR_PORTS] = {
> +       OMAP24XX_ST_UART1, OMAP24XX_ST_UART2, OMAP24XX_ST_UART3
> +};

Looks like that can be static.  

> +/* UART padconfig registers, these may differ if non-default padconfig
> +   is used */
> +#define CONTROL_PADCONF_UART1_RX 0x48002182
> +#define CONTROL_PADCONF_UART2_RX 0x4800217A
> +#define CONTROL_PADCONF_UART3_RX 0x4800219E
> +#define PADCONF_WAKEUP_ST 0x8000

Please use omap_ctrl_read{b,w,l}() rather than omap_read{b,w,l}() for SCM 
addresses.

Also, the above are register addresses + 2.  Is it possible to use the 
actual register addresses (ideally they should be defined in 
include/asm-arm/arch-omap/control.h), do long reads, and simply shift the 
register contents for the serial ports that need it?


- Paul
