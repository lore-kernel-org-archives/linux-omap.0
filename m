From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3 v5] musb: add musb support for AM35x
Date: Fri, 1 Oct 2010 09:02:03 +0300
Message-ID: <20101001060203.GD2925@legolas.emea.dhcp.ti.com>
References: <1285823949-27694-1-git-send-email-ajay.gupta@ti.com>
 <1285823949-27694-2-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1285823949-27694-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 30, 2010 at 12:19:08AM -0500, Gupta, Ajay Kumar wrote:
>AM35x has musb interface and uses CPPI4.1 DMA engine.
>Current patch supports only PIO mode. DMA support can be
>added later once basic CPPI4.1 DMA patch is accepted.
>
>Also added USB_MUSB_AM35X which is required to differentiate musb ips
>between OMAP3x and AM35x. This config would be used to for below
>purposes,
>        - Select am35x.c instead of omap2430.c for compilation
>          at drivers/usb/musb directory. Please note there are
>          significant differneces in these two files as musb ip
>          in quite different on AM35x.
>        - Select workaround codes applicable for AM35x musb issues.
>          one such workaround is for bytewise read issue on AM35x.
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

this one doesn't apply of top of my musb-2.6.37 branch.

patching file drivers/usb/musb/Kconfig
Hunk #1 succeeded at 60 with fuzz 2.
Hunk #2 FAILED at 158.
1 out of 2 hunks FAILED -- saving rejects to file drivers/usb/musb/Kconfig.rej
patching file drivers/usb/musb/Makefile
Hunk #1 FAILED at 23.
1 out of 1 hunk FAILED -- saving rejects to file drivers/usb/musb/Makefile.rej
patching file drivers/usb/musb/am35x.c
patching file drivers/usb/musb/musb_core.h
Hunk #1 FAILED at 330.
1 out of 1 hunk FAILED -- saving rejects to file drivers/usb/musb/musb_core.h.rej

could you refresh and resend this one ??

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
