From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/12] usb: ehci-omap: add OMAP4 support
Date: Tue, 30 Nov 2010 09:44:06 -0800
Message-ID: <20101130174406.GB19977@kroah.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:45742 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754786Ab0K3RsN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 12:48:13 -0500
Content-Disposition: inline
In-Reply-To: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>

On Mon, Nov 22, 2010 at 12:10:03AM +0530, Anand Gadiyar wrote:
> This series adds support for the EHCI controller on
> OMAP4 chips. (This enables the ethernet controller
> on the Pandaboard - finally!).
> 
> I'm sorry for the really long delay - I know this has
> been in the works for a while.
> 
> I've tested the series on an OMAP4 SDP and a Pandaboard.
> I'll be testing OMAP3 tomorrow.
> 
> Dependencies:
> One patch depends on the mux framework patches by Benoit
> - which are already in linux-next; however the series
> compiles cleanly against current Linus' tree.
> 
> What's pending:
> - OHCI support
> - Support for TLL and HSIC modes
> - Factoring out code common to ehci-omap and ohci-omap3
> - Conversion to use omap_device and the hwmod database
> - Runtime PM support

Do you want these to go in through the USB or OMAP tree?  Either is fine
with me.

thanks,

greg k-h
