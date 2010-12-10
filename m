From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/8 V3] usb: otg: TWL6030: Add twl6030_usb file for compilation
Date: Fri, 10 Dec 2010 16:28:58 +0300
Message-ID: <4D022B1A.8090705@ru.mvista.com>
References: <1291984837-26002-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291984837-26002-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 10-12-2010 15:40, Hema HK wrote:

> Add the twl6030_usb transceiver file for compilation.

> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>

> Index: usb/drivers/usb/otg/Makefile
> ===================================================================
> --- usb.orig/drivers/usb/otg/Makefile
> +++ usb/drivers/usb/otg/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_USB_OTG_UTILS)	+= otg.o
>   obj-$(CONFIG_USB_GPIO_VBUS)	+= gpio_vbus.o
>   obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
>   obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
> +obj-$(CONFIG_TWL6030_USB)	+= twl6030-usb.o

    Why not do it in the patch 3, along with adding the Kconfig entry?! Or 
even in patch 2, along with the driver itself? Why "smear" these simple things 
it over N patches?!

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
