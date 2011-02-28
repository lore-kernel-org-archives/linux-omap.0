From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/10 v1] EHCI and OHCI patches of OMAP3 and OMAP4
Date: Mon, 28 Feb 2011 21:11:43 +0200
Message-ID: <20110228191143.GT2459@legolas.emea.dhcp.ti.com>
References: <1298910712-2051-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1298910712-2051-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 28, 2011 at 10:01:42PM +0530, Keshava Munegowda wrote:
> this is how it EHCI/OHCI code re oraganize look like:
> 	. we have EHCI and OHCI be children of a usbhs "core driver"
> 		which will take care of all accesses to
> 		UHH and TLL bases. 
> 
> 	. we pass enable/disable functions down from EHCI and OHCI drivers.
> 		to USBHS driver.
> 
> 	. UHH and TLL power management will eventually move to
> 		omap-usb-host.c

Anand, I'm not taking this directly. I need a pull request from you in
order for me to send a pull request to Greg. Bear in mind we have little
time for this merge window, I'll wait until tomorrow and if I have no
reply, this won't be going into this merge window. Sorry but I also have
other MUSB patches which will be waiting until tomorrow due to these
EHCI/OHCI patches.

Greg, I'll be sending a pull request for you tomorrow with or without
these patches.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
