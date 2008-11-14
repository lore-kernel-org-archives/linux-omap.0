From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Fri, 14 Nov 2008 12:08:10 -0800
Message-ID: <200811141208.10600.david-b@pacbell.net>
References: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com> <200811141145.30171.david-b@pacbell.net> <20081114200214.GA31944@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:23318 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752335AbYKNUIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 15:08:13 -0500
In-Reply-To: <20081114200214.GA31944@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org

On Friday 14 November 2008, Felipe Balbi wrote:
> On Fri, Nov 14, 2008 at 11:45:30AM -0800, David Brownell wrote:
> > And should it let at least some boards talk to their
> > TWL chips at 3.4 MBit/sec (top speed for standard
> > highspeed I2C) instead of 2.6 Mbit/sec (pokey slow)?
> > I've always wondered why all the boards configured
> > those links to be seemingly slower than allowed ...
> 
> I think it came from board-3430sdp.c

So you're saying there was *never* a need for that slowdown,
and everyone was just copying an existing buglet?

I know I didn't make time to test whether faster speeds
would work ... but had expected there was a reason, at
some point, for that detuning.


> All other board files are based on that so is kind of a brainless
> change.
> 
> Just change a few stuff in the MACHINE_START and some function names.
> Remove some unneded functions and that's about it ;-)


