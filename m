From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5 v3] usb: musb: Power management support
Date: Mon, 28 Feb 2011 13:36:40 -0800
Message-ID: <20110228213640.GA13219@kroah.com>
References: <1298882976-4997-1-git-send-email-hemahk@ti.com>
 <20110228085611.GL2459@legolas.emea.dhcp.ti.com>
 <20110228142030.GA25724@kroah.com>
 <20110228212227.GK20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:44684 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab1B1Vf5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 16:35:57 -0500
Content-Disposition: inline
In-Reply-To: <20110228212227.GK20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Hema HK <hemahk@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Feb 28, 2011 at 01:22:28PM -0800, Tony Lindgren wrote:
> * Greg KH <greg@kroah.com> [110228 06:21]:
> > On Mon, Feb 28, 2011 at 10:56:11AM +0200, Felipe Balbi wrote:
> > > On Mon, Feb 28, 2011 at 02:19:31PM +0530, Hema HK wrote:
> > > > 
> > > > There is some problem with idle path offmode in mainline, I could not test
> > > > with offmode. But I have tested this patch with resetting the controller
> > > > in the idle path when wakeup from retention just to make sure that the
> > > > context is lost, and restore path is working fine.
> > > 
> > > Tony and Greg, how do we handle this one ? Who should take my pull request
> > > for this series ? I hope we still have a little time to get this into
> > > 2.6.39, but if we don't I can hold on to them until 2.6.40.
> > 
> > Doesn't bother me which tree they go through, I can take them, or, if
> > it's easier due to omap merges, Tony can.
> 
> I prefer Greg's queue unless there's some dependency issue to the
> patches we have in omap-for-linus.

If not, Felipe, send them on to me :)

thanks,

greg k-h
