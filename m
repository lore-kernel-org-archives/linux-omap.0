From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: omap: fix the warning unused variable 'status'
Date: Tue, 5 Oct 2010 14:55:14 +0530
Message-ID: <8e6442005e187448bc6aa0703c1dee5d@mail.gmail.com>
References: <1286227213-16182-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286227213-16182-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nishant Kamat <nskamat-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Keshava Munegowda wrote:
> This patch fix the follwing warning when compiling usb code for OMAP
defconfigs.
> arch/arm/mach-omap2/board-omap4panda.c:277: warning: unused variable
'status'
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>


Already posted by Sanjeev, and queued in for-next.

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=comm
itdiff;h=ca828760f96ee8f0b6c93400599844761aa69dc0

> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    2 --
>  1 file changed, 2 deletions(-)
>
> Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
> +++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
> @@ -274,8 +274,6 @@ static int __init omap4_panda_i2c_init(v
>  }
>  static void __init omap4_panda_init(void)
>  {
> -	int status;
> -
>  	omap4_panda_i2c_init();
>  	omap_serial_init();
>  	omap4_twl6030_hsmmc_init(mmc);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
