From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch v2.6.39 2/3] usb: musb: gadget: beautify
 usb_gadget_probe_driver()/usb_gadget_unregister_driver
Date: Thu, 17 Feb 2011 17:23:25 +0200
Message-ID: <20110217152325.GN22356@legolas.emea.dhcp.ti.com>
References: <1297942221-22995-1-git-send-email-balbi@ti.com>
 <1297942221-22995-3-git-send-email-balbi@ti.com>
 <4D5D1BEE.30704@ru.mvista.com>
 <20110217131510.GI22356@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:42395 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756636Ab1BQPXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 10:23:31 -0500
Content-Disposition: inline
In-Reply-To: <20110217131510.GI22356@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg KH <greg@kroah.com>, Anand Gadiyar <gadiyar@ti.com>, Hema Kalliguddi <hemahk@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

hi,

On Thu, Feb 17, 2011 at 03:15:10PM +0200, Felipe Balbi wrote:
> I can update the commit log, but basically it's the counterpart of
> musb_start(). See that we call:
> 
> if (!is_otg_enabled(musb))
> 	musb_start(musb);
> 
> so we need to undo that on the error path.

Better ?

usb: musb: gadget: beautify usb_gadget_probe_driver()/usb_gadget_unregister_driver

Just a few cosmetic fixes to usb_gadget_probe_driver()
and usb_gadget_unregister_driver().

Decreased a few indentation levels with goto statements.

While at that, also add the missing call to musb_stop().
If we don't have OTG, there's no point of leaving
MUSB prepared for operation if a gadget driver fails
to probe. The same is valid for usb_gadget_unregister_driver(),
since we are removing the gadget driver and we don't have
OTG, we can completely unconfigure MUSB.

Signed-off-by: Felipe Balbi <balbi@ti.com>


-- 
balbi
