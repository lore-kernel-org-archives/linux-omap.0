From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: OMAP: replace checks for CONFIG_USB_GADGET_OMAP
Date: Fri, 16 May 2014 14:15:39 -0700
Message-ID: <20140516211539.GH12881@atomide.com>
References: <1400187345.11786.28.camel@x220>
 <20140515231229.GA25523@saruman.home>
 <1400232974.20342.22.camel@x220>
 <1400234457.20342.25.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400234457.20342.25.camel@x220>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org> [140516 03:01]:
> Commit 193ab2a60700 ("usb: gadget: allow multiple gadgets to be built")
> apparently required that checks for CONFIG_USB_GADGET_OMAP would be
> replaced with checks for CONFIG_USB_OMAP. Do so now for the remaining
> checks for CONFIG_USB_GADGET_OMAP, even though these checks have
> basically been broken since v3.1.
> 
> And, since we're touching this code, use the IS_ENABLED() macro, so
> things will now (hopefully) also work if USB_OMAP is modular.
> 
> Fixes: 193ab2a60700 ("usb: gadget: allow multiple gadgets to be built")
> Signed-off-by: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
> ---
> v2: us IS_ENABLED() as Felipe requested. Still untested.

Thanks applying into omap-for-v3.16/board.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
