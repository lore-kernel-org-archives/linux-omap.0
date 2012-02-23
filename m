From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/2] mfd: omap-usb-host: Minor omap-usb host fixes
Date: Thu, 23 Feb 2012 16:45:13 +0100
Message-ID: <20120223154513.GH24377@sortiz-mobl>
References: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329301414-31003-1-git-send-email-govindraj.raja-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Govindraj.R" <govindraj.raja-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Govindraj,

On Wed, Feb 15, 2012 at 03:53:32PM +0530, Govindraj.R wrote:
> From: "Govindraj.R" <govindraj.raja-l0cyMroinI0@public.gmane.org>
> 
> Minor fixes, boot tested on panda with ehci enabled.
> Patches based on 3.3-rc3
> 
> Govindraj.R (2):
>   mfd: omap-usb-host: Remove magic numbers for dev dma mask
>   mfd: omap-usb-host: Move usbhs init before allocing child dev
Both patches applied (v2 for the first one).

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
