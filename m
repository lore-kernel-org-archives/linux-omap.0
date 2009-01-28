From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] TWL: USB: disable VUSB regulators when cable unplugged
Date: Tue, 27 Jan 2009 18:02:21 -0800
Message-ID: <200901271802.21196.david-b@pacbell.net>
References: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com> <200901220955.51986.david-b@pacbell.net> <1233049803.6515.475.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:47820 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752098AbZA1CCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2009 21:02:23 -0500
In-Reply-To: <1233049803.6515.475.camel@ubuntu>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Tuesday 27 January 2009, Kalle Jokiniemi wrote:
> On Thu, 2009-01-22 at 09:55 -0800, David Brownell wrote:
> > On Wednesday 21 January 2009, Kalle Jokiniemi wrote:
> > > This patch disables USB regulators VUSB1V5, VUSB1V8, and VUSB3V1
> > > when the USB cable is unplugged to reduce power consumption.
> > 
> > Worked fine on a Beagle, now I'm trying to find out
> > what's borked on an Overo ...
> 
> Did you manage to get it working on Overo? 

Yes.  It must have either been a bad build, or an issue
with one of the other patches, or something.


> BTW. Should I post this patch to linux-usb as well?

If you like, but it can't merge yet ... the twl4030
regulator code isn't in mainline yet.  I think it's
ready given the patches I posted earlier.

- Dave
 


