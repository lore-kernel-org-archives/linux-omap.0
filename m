From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [RFC][PATCH v2 08/13] usb: otg: hub: Notify OTG fsm when A
 device sets b_hnp_enable
Date: Fri, 17 Apr 2015 10:28:15 +0800
Message-ID: <20150417022814.GC13764@shlinux2>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
 <1429008120-5395-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bn1bon0133.outbound.protection.outlook.com ([157.56.111.133]:28989
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751506AbbDQCax (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Apr 2015 22:30:53 -0400
Content-Disposition: inline
In-Reply-To: <1429008120-5395-9-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, Apr 14, 2015 at 01:41:55PM +0300, Roger Quadros wrote:
> This is the a_set_b_hnp_enable flag in the OTG state machine
> diagram and must be set when the A-Host has successfully set
> the b_hnp_enable feature of the OTG-B-Peripheral attached to it.
> 
> When this bit changes we kick our OTG FSM to make note of the
> change and act accordingly.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/core/hub.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index d7c3d5a..ab0d498 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -22,6 +22,7 @@
>  #include <linux/usb/hcd.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/quirks.h>
> +#include <linux/usb/usb-otg.h>
>  #include <linux/workqueue.h>
>  #include <linux/mutex.h>
>  #include <linux/random.h>
> @@ -2270,6 +2271,9 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
>  						"can't set HNP mode: %d\n",
>  						err);
>  					bus->b_hnp_enable = 0;
> +				} else {
> +					/* notify OTG fsm about a_set_b_hnp_enable */
> +					usb_otg_kick_fsm(udev->bus->controller);
>  				}
>  			}
>  		}
> @@ -4244,8 +4248,13 @@ hub_port_init (struct usb_hub *hub, struct usb_device *udev, int port1,
>  	 */
>  	if (!hdev->parent) {
>  		delay = HUB_ROOT_RESET_TIME;
> -		if (port1 == hdev->bus->otg_port)
> +		if (port1 == hdev->bus->otg_port) {
>  			hdev->bus->b_hnp_enable = 0;
> +#ifdef CONFIG_USB_OTG
> +			/* notify OTG fsm about a_set_b_hnp_enable change */
> +			usb_otg_kick_fsm(hdev->bus->controller);
> +#endif
> +		}
>  	}
>  
>  	/* Some low speed devices have problems with the quick delay, so */
> -- 
> 2.1.0
> 

Since the fsm has already kicked, the only thing we need is update
fsm.a_set_b_hnp_enable, but this flag is missing at current fsm
structure.

-- 

Best Regards,
Peter Chen
