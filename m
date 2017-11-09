From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: USB regression in next-20171108 with hub spamming
Date: Thu, 9 Nov 2017 06:39:33 -0800
Message-ID: <20171109143933.GA28152@atomide.com>
References: <20171108230511.GY28152@atomide.com>
 <20171109080007.GA17098@kroah.com>
 <871sl7sq9i.fsf@linux.intel.com>
 <87wp2zrasg.fsf@linux.intel.com>
 <87shdnrak7.fsf@linux.intel.com>
 <87po8rra42.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87po8rra42.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> [171109 11:01]:
> Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
> > Okay, found it. Testing a patch.
> 
> Here's the patch, I'll send it formally shortly.

Thanks yeah that fixes the issue for me, replied to your formal
patch with a tested by.

Regards,

Tony

> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 0cdc463c9509..c15fbf76f8f7 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -975,6 +975,7 @@ int usb_get_status(struct usb_device *dev, int recip, int type, int target,
>  		}
>  
>  		*(u32 *) data = le32_to_cpu(*(__le32 *) status);
> +		ret = 0;
>  		break;
>  	case 2:
>  		if (type != USB_STATUS_TYPE_STANDARD) {
> @@ -983,6 +984,7 @@ int usb_get_status(struct usb_device *dev, int recip, int type, int target,
>  		}
>  
>  		*(u16 *) data = le16_to_cpu(*(__le16 *) status);
> +		ret = 0;
>  		break;
>  	default:
>  		ret = -EIO;
> -- 
> 2.14.2.642.g20fed7cad4
> 
> 
> -- 
> balbi


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
