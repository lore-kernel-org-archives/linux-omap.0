From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 2/2] ARM : OMAP : Remove #ifdef from board-omap3evm.c
Date: Fri, 15 Jan 2010 10:58:01 -0800
Message-ID: <20100115185801.GH12146@kroah.com>
References: <1262681372-7602-1-git-send-email-x0082077@ti.com>
 <20100105105604.GE11291@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:51578 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758210Ab0AOUQt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 15:16:49 -0500
Content-Disposition: inline
In-Reply-To: <20100105105604.GE11291@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Maulik Mankad <x0082077@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>

On Tue, Jan 05, 2010 at 12:56:04PM +0200, Felipe Balbi wrote:
> On Tue, Jan 05, 2010 at 09:49:32AM +0100, ext Maulik Mankad wrote:
> >ARM : OMAP : Remove #ifdef from board-omap3evm.c
> >
> >Remove #ifdef around usb_nop_xceiv_register() from
> >board-omap3evm.c
> >
> >Signed-off-by: Maulik Mankad <x0082077@ti.com>
> >Cc: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Tony, let's wait for Greg's Ack to the previous patch, but if everything 
> is Fine, you can take this one on for-next.

I can take it as I took the one that this depended on.

Or both can go through Tony's tree, I don't care :)

If so, please add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to the patches.

thanks,

greg k-h
