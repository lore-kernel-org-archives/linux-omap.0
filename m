From: "Premi, Sanjeev" <premi-l0cyMroinI0@public.gmane.org>
Subject: RE: [WL1271 DC supprot on OMAP3EVM 3/5] ARM: Supported for BT
 enable on OMAP3EVM for WL1271 DC
Date: Wed, 13 Oct 2010 17:33:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234405C3F@dbde02.ent.ti.com>
References: <1286967077-20071-1-git-send-email-csanjay@mistralsolutions.com>
 <1286967077-20071-4-git-send-email-csanjay@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286967077-20071-4-git-send-email-csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org" <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> [mailto:linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of 
> csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org
> Sent: Wednesday, October 13, 2010 4:21 PM
> To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sanjay Kumar Champati
> Subject: [WL1271 DC supprot on OMAP3EVM 3/5] ARM: Supported 
> for BT enable on OMAP3EVM for WL1271 DC
> 
> From: Sanjay Kumar Champati <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> 
> * Midified "tty_io.c" and "Kconfig" files to suuport BT 
> enable for WL1271
> 
> Signed-off-by: Sanjay Kumar Champati <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> ---
>  drivers/bluetooth/Kconfig |    7 +++
>  drivers/char/tty_io.c     |  110 
> +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 652367a..2ed159c 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -195,5 +195,12 @@ config BT_MRVL_SDIO
>  	  Say Y here to compile support for Marvell BT-over-SDIO driver
>  	  into the kernel or say M to compile it as module.
>  
> +config BT_WL1271
> +	bool "WL1271 Bluetooth driver support"
> +	depends on BT_HCIUART
> +	help
> +	The core driver to support WL1271 Bluetooth devices.
> +	Say Y here to compile WL1271 Bluetooth driver into the kernel.
> +
>  endmenu
>  
> diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
> index f15df40..a3ae352 100644
> --- a/drivers/char/tty_io.c
> +++ b/drivers/char/tty_io.c
> @@ -107,6 +107,17 @@
>  #include <linux/kmod.h>
>  #include <linux/nsproxy.h>
>  
> +#ifdef CONFIG_BT_WL1271

[sp] No. This isn't the place for it.
     You cannot change the generic driver for custom implementation.

     Same comment applies to all the changes in this file.

[snip]...[snip]
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
