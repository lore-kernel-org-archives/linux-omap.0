From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: twl4030-usb.c
Date: Wed, 21 Jan 2009 14:28:34 +0200
Message-ID: <1232540914.6515.360.camel@ubuntu>
References: <1232536259.6515.351.camel@ubuntu>
	 <20090121113207.GA9233@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sink.edelkey.net ([213.138.147.137]:34631 "EHLO
	sink.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604AbZAUM2u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 07:28:50 -0500
In-Reply-To: <20090121113207.GA9233@scadufax.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Wed, 2009-01-21 at 13:32 +0200, Felipe Balbi wrote:
> On Wed, Jan 21, 2009 at 01:10:59PM +0200, ext Kalle Jokiniemi wrote:
> > 
> > The twl4030-usb.c seems to have moved from /drivers/usb/otg back
> > to /drivers/i2c/chips after the recent mainline merge. Felipe, any plans
> > to put it back to drivers/usb/otg?
> > 
> > I have a patch for twl4030-usb enabling regulator switching, so I'm just
> > wondering against what tree should I post the patch. And to which list?
> 
> how about you git pull ?? For me it appears under drivers/usb/otg:

Ugh, I did a git pull, but it seems that our IT department has been
active and closed the git port. I just didn't notice the error before.
Well, switching to http.

- Kalle

> 
> HEAD: commit 45e5c5ffd32ade5a21a5e87b4040072590ec3ae1
> 
> ~/workspace/linux-omap-2.6$ ls drivers/usb/otg/
> gpio_vbus.c  isp1301_omap.c  Kconfig  Makefile  otg.c  twl4030-usb.c
> 
