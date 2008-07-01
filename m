From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/1] usb: musb: pass configuration specifics via pdata
Date: Tue, 1 Jul 2008 16:03:43 +0300
Message-ID: <20080701130343.GD4423@gandalf.research.nokia.com>
References: <1214917011-837-1-git-send-email-felipe.balbi@nokia.com> <1214917011-837-2-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52811 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751AbYGANFy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 09:05:54 -0400
Content-Disposition: inline
In-Reply-To: <1214917011-837-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgre <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Anand Gadiyar <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, Bryan Wu <cooloney@kernel.org>

On Tue, Jul 01, 2008 at 03:56:51PM +0300, Felipe Balbi wrote:

> diff --git a/include/asm-arm/arch-omap/usb-musb.h b/include/asm-arm/arch-omap/usb-musb.h
> index 4f0c830..bd507e7 100644
> --- a/include/asm-arm/arch-omap/usb-musb.h
> +++ b/include/asm-arm/arch-omap/usb-musb.h
> @@ -29,6 +29,9 @@
>  #ifndef __ASM_ARCH_OMAP_USB_MUSB_H
>  #define __ASM_ARCH_OMAP_USB_MUSB_H
>  
> +#include <linux/usb/musb.h>
> +#include <linux/ioport.h>
> +
>  extern void usb_musb_init(void);
>  
>  #endif /* __ASM_ARCH_OMAP_USB_MUSB_H */

this is garbage change... I'll remove and resend.

-- 
	- Balbi
