From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] MUSB: BULK request on different available endpoints
Date: Thu, 9 Oct 2008 17:17:54 +0300
Message-ID: <20081009141754.GC19375@gandalf.research.nokia.com>
References: <1223372257-8100-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1223372257-8100-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 07, 2008 at 03:07:37PM +0530, Ajay Kumar Gupta wrote:
> Fixes co-working issue of usb serial device with usb/net devices while
> oter endpoints are free and can be used.This patch implements the policy
> that if endpoint resources are available then different BULK request goes
> to different endpoint otherwise they are multiplexed to one reserved
> endpoint as currently done.
> 
> Switch statement case is reordered in musb_giveback() to take care of 
> bulk request both in multiplex scenario and otherwise.
> 
> NAK limit scheme has to be added for multiplexed BULK request scenario
> to avoid endpoint starvation due to usb/net devices.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

applied.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
