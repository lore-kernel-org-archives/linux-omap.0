From: Greg KH <greg@kroah.com>
Subject: Re: [GIT PULL] OMAP USB Patches for 2.6.39
Date: Fri, 18 Feb 2011 08:31:44 -0800
Message-ID: <20110218163144.GA11460@kroah.com>
References: <20110218121145.GB11151@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:40283 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab1BRQam (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 11:30:42 -0500
Content-Disposition: inline
In-Reply-To: <20110218121145.GB11151@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Feb 18, 2011 at 02:11:45PM +0200, Felipe Balbi wrote:
> Hi Greg,
> 
> Here are the patches I have for the next merge window.
> 
> The outstanding feature is the introduction of pm_runtime
> support for the OMAP glue layer for MUSB.
> 
> These patches have been tested on omap4430 with g_zero
> + testusb overnight and no problems have come from those.
> 
> These are on top of greg/usb-next, if you want me to rebase
> on top of another commit, please let me know about it and I'll
> do it quickly.
> 
> Thanks, pull request below.
> 
> The following changes since commit 04b31c776f34d127b422da92899272a0b8cda21d:
> 
>   usb: isp1362-hcd: use bitmap_clear() and bitmap_set() (2011-02-17 11:00:24 -0800)
> 
> are available in the git repository at:
>   git://gitorious.org/usb/usb.git for-next

$ git pull git://gitorious.org/usb/usb.git for-next
fatal: The remote end hung up unexpectedly

Something's wrong on gitorious's side and I can't seem to pull this :(

Any ideas?

thanks,

greg k-h
