From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] usb: musb: fix build break due to partial rename
Date: Tue, 5 Oct 2010 16:00:43 -0700
Message-ID: <20101005230043.GC28530@kroah.com>
References: <1285965264-17972-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46817 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225Ab0JEXBF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 19:01:05 -0400
Content-Disposition: inline
In-Reply-To: <1285965264-17972-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Michal Nazarewicz <m.nazarewicz@samsung.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Sat, Oct 02, 2010 at 02:04:24AM +0530, Anand Gadiyar wrote:
> Patch "usb gadget: don't save bind callback in struct usb_gadget_driver"
> in Greg's USB queue missed one conversion of
> usb_gadget_register_driver to usb_gadget_probe_driver,
> causing a build break when MUSB is built in gadget mode.
> 
> Fix this.
> 
> Reported-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Uwe Kleine-Koenig<u.kleine-koenig@pengutronix.de>
> Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> Greg,
> 
> Since Uwe's original patch isn't yet in mainline, maybe you could
> fold this patch into the original.

I've folded it into the original, thanks.

greg k-h
