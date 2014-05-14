From: Zhuang Jin Can <jin.can.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: ep0: fix delayed status is queued too early
Date: Tue, 13 May 2014 21:45:51 -0400
Message-ID: <20140514014551.GA16153@intel.com>
References: <20140507215344.GH19925@intel.com>
Reply-To: jin.can.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140507215344.GH19925-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liping.zhou-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Balbi,

Do you have any comment for this patch?

Thanks
Jincan

On Wed, May 07, 2014 at 05:53:44PM -0400, Zhuang Jin Can wrote:
> A delayed status request may be queued before composite framework returns
> USB_GADGET_DELAYED_STATUS, because the thread queueing the request can run
> on a different core in parallel with the control request irq.
> 
> SETUP XferComplete IRQ        		fsg_main_thread
> ----------------------        		---------------
> 	|					|
> spin_lock_irqsave(&dwc->lock)               sleeping
> 	|					|
> 	...					...
> dwc3_ep0_inspect_setup()			|
> 	|					|
> dwc3_ep0_delegate_req() 			|
> 	|					|
> 	...					|
> spin_unlock(&dwc->lock);			|
> 	|					|
> fsg_set_alt()   ======> Signal Wakeup ====>	|
> 	| 					|
> other gadgets->set_alt() 	       handle exception
> 	|					|
> 	|			usb_composite_setup_continue()
> 	|					|
> 	|			spin_lock_irqsave(&dwc->lock)
>   	|			     __dwc3_gadget_ep0_queue()
> 	|				 delay_status is false
> 	|			spin_unlock_irqrestore(&dwc->lock)
> 	|					|
> 	|				     sleeping
> spin_lock(&dwc->lock); 				|
> 	|					|
> delayed_status=true				|
> 	|					|
> 
> 		STATUS XferNotReady IRQ
> 		------------------------
> 			|
> 		dwc3_ep0_xfernotready()
> 			|
> 		   delayed_status is true, return;
> 
> The result is the status packet will never be transferred, and
> delayed_status is not cleared.
> 
> Signed-off-by: Zhuang Jin Can <jin.can.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Reported-by: Zhou Liping <liping.zhou-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/dwc3/ep0.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 21a3520..07292c0 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -1020,7 +1020,11 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
>  		if (dwc->delayed_status) {
>  			WARN_ON_ONCE(event->endpoint_number != 1);
>  			dev_vdbg(dwc->dev, "Mass Storage delayed status\n");
> -			return;
> +
> +			if (list_empty(&dwc->eps[0]->request_list))
> +				return;
> +			else
> +				dwc->delayed_status = false;
>  		}
>  
>  		dwc3_ep0_do_control_status(dwc, event);
> -- 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
