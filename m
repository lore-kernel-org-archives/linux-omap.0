From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: [PATCH 1/1] TWL: USB: disable VUSB regulators when cable
	unplugged
Date: Wed, 28 Jan 2009 08:36:55 +0200
Message-ID: <1233124615.6515.517.camel@ubuntu>
References: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com>
	 <200901220955.51986.david-b@pacbell.net> <1233049803.6515.475.camel@ubuntu>
	 <200901271802.21196.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from harmaja.edelkey.net ([213.138.147.141]:59488 "EHLO
	harmaja.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbZA1GhL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 01:37:11 -0500
In-Reply-To: <200901271802.21196.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Tue, 2009-01-27 at 18:02 -0800, David Brownell wrote:
> On Tuesday 27 January 2009, Kalle Jokiniemi wrote:
> > On Thu, 2009-01-22 at 09:55 -0800, David Brownell wrote:
> > > On Wednesday 21 January 2009, Kalle Jokiniemi wrote:
> > > > This patch disables USB regulators VUSB1V5, VUSB1V8, and VUSB3V1
> > > > when the USB cable is unplugged to reduce power consumption.
> > > 
> > > Worked fine on a Beagle, now I'm trying to find out
> > > what's borked on an Overo ...
> > 
> > Did you manage to get it working on Overo? 
> 
> Yes.  It must have either been a bad build, or an issue
> with one of the other patches, or something.

OK, great :)

> 
> 
> > BTW. Should I post this patch to linux-usb as well?
> 
> If you like, but it can't merge yet ... the twl4030
> regulator code isn't in mainline yet.  I think it's
> ready given the patches I posted earlier.

Oh, so it seems. I guess I'll have to wait for the regulator code to hit
mainline.

- Kalle

> 
> - Dave
>  
> 
> 
