From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Wed, 19 Nov 2008 14:07:17 +0200
Message-ID: <1227096438.27458.0.camel@eenurkka-desktop>
References: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com>
	 <200811141145.30171.david-b@pacbell.net>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30258 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbYKSMMX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 07:12:23 -0500
In-Reply-To: <200811141145.30171.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, 2008-11-14 at 11:45 -0800, ext David Brownell wrote:
> On Friday 14 November 2008, ext-eero.nurkkala@nokia.com wrote:
> > The prescalers for 100 kHz and 400 kHz mode
> > are wrong. The internal clock is the fclock
> > divided by the prescaler. The PSC is an 8 bit
> > field in omap3430. Moreover, the scll and
> > sclh values should be adjusted properly.
> > Having the correct prescaler is important in
> > the process of getting a finite i2c clock. In
> > addition, the prescaler is used in the process
> > of activating the correct noise filter and thus,
> > lets more error resilient i2c communications.
> 
> Should this fix the bug causing the need for that
> recent ZOOM patch slowing down twl4030 communication
> to 400 MHz?
> 
> And should it let at least some boards talk to their
> TWL chips at 3.4 MBit/sec (top speed for standard
> highspeed I2C) instead of 2.6 Mbit/sec (pokey slow)?
> I've always wondered why all the boards configured
> those links to be seemingly slower than allowed ...
> 
> - Dave
> 

Well, this should not affect the High speed I2C at all.
Only fast and slow I2C (100 and 400 khz).


