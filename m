From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Fri, 14 Nov 2008 12:38:16 -0800
Message-ID: <5e088bd90811141238g15f76540j79f760648874e188@mail.gmail.com>
References: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com>
	 <200811141145.30171.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:27611 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbYKNUiT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 15:38:19 -0500
Received: by nf-out-0910.google.com with SMTP id d3so792746nfc.21
        for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 12:38:17 -0800 (PST)
In-Reply-To: <200811141145.30171.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org

On Fri, Nov 14, 2008 at 11:45 AM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 14 November 2008, ext-eero.nurkkala@nokia.com wrote:
>> The prescalers for 100 kHz and 400 kHz mode
>> are wrong. The internal clock is the fclock
>> divided by the prescaler. The PSC is an 8 bit
>> field in omap3430. Moreover, the scll and
>> sclh values should be adjusted properly.
>> Having the correct prescaler is important in
>> the process of getting a finite i2c clock. In
>> addition, the prescaler is used in the process
>> of activating the correct noise filter and thus,
>> lets more error resilient i2c communications.
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

When I put a scope to Beagle and Overo a couple of months back it
looked to me like the i2c signals were just *barely* in spec for
2.6Mbit/sec, so I think that hardware might have been the limiting
factor in the decision to choose 2.6 Mit/sec

Steve
