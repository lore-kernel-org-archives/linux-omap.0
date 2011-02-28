From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5 v3] usb: musb: Power management support
Date: Mon, 28 Feb 2011 13:22:28 -0800
Message-ID: <20110228212227.GK20560@atomide.com>
References: <1298882976-4997-1-git-send-email-hemahk@ti.com>
 <20110228085611.GL2459@legolas.emea.dhcp.ti.com>
 <20110228142030.GA25724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57767 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194Ab1B1VWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 16:22:34 -0500
Content-Disposition: inline
In-Reply-To: <20110228142030.GA25724@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Felipe Balbi <balbi@ti.com>, Hema HK <hemahk@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

* Greg KH <greg@kroah.com> [110228 06:21]:
> On Mon, Feb 28, 2011 at 10:56:11AM +0200, Felipe Balbi wrote:
> > On Mon, Feb 28, 2011 at 02:19:31PM +0530, Hema HK wrote:
> > > 
> > > There is some problem with idle path offmode in mainline, I could not test
> > > with offmode. But I have tested this patch with resetting the controller
> > > in the idle path when wakeup from retention just to make sure that the
> > > context is lost, and restore path is working fine.
> > 
> > Tony and Greg, how do we handle this one ? Who should take my pull request
> > for this series ? I hope we still have a little time to get this into
> > 2.6.39, but if we don't I can hold on to them until 2.6.40.
> 
> Doesn't bother me which tree they go through, I can take them, or, if
> it's easier due to omap merges, Tony can.

I prefer Greg's queue unless there's some dependency issue to the
patches we have in omap-for-linus.

Tony
