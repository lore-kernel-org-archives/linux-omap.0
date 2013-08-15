From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: OMAP: fix USB regression on Nokia boards
Date: Thu, 15 Aug 2013 22:18:08 +0300
Message-ID: <20130815191808.GA3067@blackmetal.musicnaut.iki.fi>
References: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1375808776-14975-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Aug 06, 2013 at 08:06:14PM +0300, Aaro Koskinen wrote:
> USB subsystem changes broke the USB peripheral/gadget on N800, N810 and
> RX-51/N900 during the merge window. We need to fix this in board files. I
> tested all these with 3.11-rc4 + g_ether + ssh.

Ping?

A.

> Aaro Koskinen (1):
>   ARM: OMAP: rx51: change musb mode to OTG
> 
> Daniel Mack (1):
>   ARM: omap2: fix musb usage for n8x0
> 
>  arch/arm/mach-omap2/board-n8x0.c | 4 ----
>  arch/arm/mach-omap2/board-rx51.c | 2 +-
>  arch/arm/mach-omap2/usb-musb.c   | 5 +----
>  3 files changed, 2 insertions(+), 9 deletions(-)
> 
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
