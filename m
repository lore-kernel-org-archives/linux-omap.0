From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 48/48] usb: gadget: epautoconf: cleanup dead code
Date: Tue, 14 Jul 2015 14:16:27 +0300
Message-ID: <55A4EF8B.7090806@cogentembedded.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
 <1436866776-5004-49-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436866776-5004-49-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org, balbi@ti.com
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, andrzej.p@samsung.com, m.szyprowski@samsung.com
List-Id: linux-omap@vger.kernel.org

Hello.

On 7/14/2015 12:39 PM, Robert Baldyga wrote:

> Function find_ep() is no longer needed here, so we can remove it.
> We also don't use anything from gadget_chips.h header any longer.

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>   drivers/usb/gadget/epautoconf.c | 14 --------------
>   1 file changed, 14 deletions(-)

> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> index e9a8682..9a80925 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -20,20 +20,6 @@
>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
>
> -#include "gadget_chips.h"
> -
> -static struct usb_ep *
> -find_ep (struct usb_gadget *gadget, const char *name)
> -{
> -	struct usb_ep	*ep;
> -
> -	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
> -		if (0 == strcmp (ep->name, name))
> -			return ep;
> -	}
> -	return NULL;
> -}
> -

    I don't think duplicating the function in each driver that needs it is 
better than turniong this function into public.

WBR, Sergei
