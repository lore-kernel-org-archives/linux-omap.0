From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: fix build break due to partial rename
Date: Mon, 4 Oct 2010 09:38:03 +0300
Message-ID: <20101004063803.GC2559@legolas.emea.dhcp.ti.com>
References: <1285965264-17972-1-git-send-email-gadiyar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53999 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab0JDGiR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 02:38:17 -0400
Content-Disposition: inline
In-Reply-To: <1285965264-17972-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Michal Nazarewicz <m.nazarewicz@samsung.com>, "Balbi, Felipe" <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Fri, Oct 01, 2010 at 03:34:24PM -0500, Gadiyar, Anand wrote:
>Patch "usb gadget: don't save bind callback in struct usb_gadget_driver"
>in Greg's USB queue missed one conversion of
>usb_gadget_register_driver to usb_gadget_probe_driver,
>causing a build break when MUSB is built in gadget mode.
>
>Fix this.
>
>Reported-by: Grazvydas Ignotas <notasas@gmail.com>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>Cc: Uwe Kleine-Koenig<u.kleine-koenig@pengutronix.de>
>Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
>Cc: Felipe Balbi <balbi@ti.com>

wow, good catch :-)

Acked-by: Felipe Balbi <balbi@ti.com>

>Cc: Greg Kroah-Hartman <gregkh@suse.de>
>---
>Greg,
>
>Since Uwe's original patch isn't yet in mainline, maybe you could
>fold this patch into the original.

Fine by me to fold on original patch.

-- 
balbi
