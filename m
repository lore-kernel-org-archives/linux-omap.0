From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 04/11] omap: clock: add clkdev aliases for EHCI clocks
Date: Tue, 30 Nov 2010 10:40:35 -0800
Message-ID: <20101130184034.GT17222@atomide.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <1290364814-4417-2-git-send-email-gadiyar@ti.com>
 <1290364814-4417-3-git-send-email-gadiyar@ti.com>
 <1290364814-4417-4-git-send-email-gadiyar@ti.com>
 <1290364814-4417-5-git-send-email-gadiyar@ti.com>
 <20101122101913.GO2446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101122101913.GO2446-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [101122 02:09]:
> On Mon, Nov 22, 2010 at 12:10:07AM +0530, Anand Gadiyar wrote:
> >Add clkdev aliases for the USBHOST and USBTLL clocks on OMAP3 and
> >OMAP4, so that the driver can refer to the clocks using a common alias.
> >
> >This will disappear when the driver is converted to use the hwmod
> >database, but until then this patch is needed.
> >
> >Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> 
> Tony, I need your Ack here too.

Looks good to me:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
