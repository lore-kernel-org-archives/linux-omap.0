From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Fri, 14 Nov 2008 22:02:20 +0200
Message-ID: <20081114200214.GA31944@frodo>
References: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com> <200811141145.30171.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34595 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYKNUCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 15:02:30 -0500
Content-Disposition: inline
In-Reply-To: <200811141145.30171.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org

On Fri, Nov 14, 2008 at 11:45:30AM -0800, David Brownell wrote:
> And should it let at least some boards talk to their
> TWL chips at 3.4 MBit/sec (top speed for standard
> highspeed I2C) instead of 2.6 Mbit/sec (pokey slow)?
> I've always wondered why all the boards configured
> those links to be seemingly slower than allowed ...

I think it came from board-3430sdp.c

All other board files are based on that so is kind of a brainless
change.

Just change a few stuff in the MACHINE_START and some function names.
Remove some unneded functions and that's about it ;-)

-- 
balbi
