From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] usb: ehci-omap: Update platform header file path
Date: Wed, 25 Nov 2009 04:53:26 -0800
Message-ID: <20091125125326.GA18175@suse.de>
References: <20091125090259.GB30331@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39342 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934657AbZKYNGw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 08:06:52 -0500
Content-Disposition: inline
In-Reply-To: <20091125090259.GB30331@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: tony@atomide.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Nov 25, 2009 at 03:02:59AM -0600, Olof Johansson wrote:
> The OMAP usb header file has moved, update the driver so it will build.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> Greg, any chance you can just ack this so Tony can merge it through his
> tree for .33? The header files changes in question are going in through
> that tree.

Sure, but for such a trivial change, I doubt you need my ack :)

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
