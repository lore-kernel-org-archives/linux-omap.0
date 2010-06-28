From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4]usb : musb:USB driver using omap_device_build for
 device registration.
Date: Mon, 28 Jun 2010 16:42:09 +0300
Message-ID: <20100628134209.GH2822@atomide.com>
References: <1277727427-6144-1-git-send-email-hemahk@ti.com>
 <20100628132912.GG2822@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940270191FE9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57046 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab0F1NmB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 09:42:01 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940270191FE9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

* Kalliguddi, Hema <hemahk@ti.com> [100628 16:26]:
>  
> 
> >-----Original Message-----
> >From: Tony Lindgren [mailto:tony@atomide.com] 
> >Sent: Monday, June 28, 2010 6:59 PM
> >To: Kalliguddi, Hema
> >Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Felipe Balbi
> >Subject: Re: [PATCH 4/4]usb : musb:USB driver using 
> >omap_device_build for device registration.
> >
> >* Hema HK <hemahk@ti.com> [100628 15:12]:
> >> -
> >> -	/*
> >> -	 * REVISIT: This line can be removed once all the 
> >platforms using
> >> -	 * musb_core.c have been converted to use use clkdev.
> >> -	 */
> >> -	musb_plat.clock = "ick";
> >
> >This comment is still valid, please don't remove it.
> This is still there. It is moved below under else.

Not in the patch you posted?

Tony
