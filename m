From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Fri, 14 Nov 2008 11:45:30 -0800
Message-ID: <200811141145.30171.david-b@pacbell.net>
References: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:27769 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752864AbYKNTpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 14:45:32 -0500
In-Reply-To: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

On Friday 14 November 2008, ext-eero.nurkkala@nokia.com wrote:
> The prescalers for 100 kHz and 400 kHz mode
> are wrong. The internal clock is the fclock
> divided by the prescaler. The PSC is an 8 bit
> field in omap3430. Moreover, the scll and
> sclh values should be adjusted properly.
> Having the correct prescaler is important in
> the process of getting a finite i2c clock. In
> addition, the prescaler is used in the process
> of activating the correct noise filter and thus,
> lets more error resilient i2c communications.

Should this fix the bug causing the need for that
recent ZOOM patch slowing down twl4030 communication
to 400 MHz?

And should it let at least some boards talk to their
TWL chips at 3.4 MBit/sec (top speed for standard
highspeed I2C) instead of 2.6 Mbit/sec (pokey slow)?
I've always wondered why all the boards configured
those links to be seemingly slower than allowed ...

- Dave

