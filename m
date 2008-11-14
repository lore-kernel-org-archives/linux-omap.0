From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Fri, 14 Nov 2008 23:46:41 +0200
Message-ID: <20081114214635.GC31944@frodo>
References: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com> <200811141145.30171.david-b@pacbell.net> <20081114200214.GA31944@frodo> <200811141208.10600.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57274 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbYKNVqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 16:46:52 -0500
Content-Disposition: inline
In-Reply-To: <200811141208.10600.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org

On Fri, Nov 14, 2008 at 12:08:10PM -0800, David Brownell wrote:
> On Friday 14 November 2008, Felipe Balbi wrote:
> > On Fri, Nov 14, 2008 at 11:45:30AM -0800, David Brownell wrote:
> > > And should it let at least some boards talk to their
> > > TWL chips at 3.4 MBit/sec (top speed for standard
> > > highspeed I2C) instead of 2.6 Mbit/sec (pokey slow)?
> > > I've always wondered why all the boards configured
> > > those links to be seemingly slower than allowed ...
> > 
> > I think it came from board-3430sdp.c
> 
> So you're saying there was *never* a need for that slowdown,
> and everyone was just copying an existing buglet?
> 
> I know I didn't make time to test whether faster speeds
> would work ... but had expected there was a reason, at
> some point, for that detuning.

There was a need. But I think it should be fixed by now. I shall test
tw5030 with 3.4Mbit/sec on monday. Will report.

-- 
balbi
