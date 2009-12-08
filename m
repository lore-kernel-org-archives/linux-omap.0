From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] USB ehci: replace mach header with plat
Date: Tue, 8 Dec 2009 15:43:07 -0800
Message-ID: <20091208234306.GZ24013@atomide.com>
References: <1260274506-8805-1-git-send-email-weber@corscience.de>
 <20091208134750.GE24510@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62779 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966899AbZLHXnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 18:43:07 -0500
Content-Disposition: inline
In-Reply-To: <20091208134750.GE24510@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Thomas Weber <weber@corscience.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [091208 05:49]:
> On Tue, Dec 08, 2009 at 01:15:06PM +0100, ext Thomas Weber wrote:
> >Replace the mach/usb.h with plat/usb.h
> >
> >Patch was already done in commit:
> >801db9180010676f97bb3fbd7074291128b7b5fc , but overwritten.
> >
> >Signed-off-by: Thomas Weber <weber@corscience.de>
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Tony, this should probably go into for-next or for-next-vol2.

I'll add this into omap-testing for now as the ehci-omap.c is
still not merged into mainline from Greg's queue.

I'll move it into omap-fixes once the ehci-omap.c hits the
mainline.

Tony

