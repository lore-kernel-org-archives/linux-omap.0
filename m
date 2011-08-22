From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] mfd: omap-usb-host: Make TLL mode work again
Date: Mon, 22 Aug 2011 16:45:24 +0200
Message-ID: <20110822144524.GV4607@sortiz-mobl>
References: <1313664271-694-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1313664271-694-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Anand,

On Thu, Aug 18, 2011 at 04:14:31PM +0530, Anand Gadiyar wrote:
> This code section seems to have been accidentally copy pasted.
> It causes incorrect bits to be set up in the TLL_CHANNEL_CONF
> register and prevents the TLL mode from working correctly.
Patch applied, with Felipe's ACK and stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org Cc'ed.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
