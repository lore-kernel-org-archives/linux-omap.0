From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/5] I2C: TWL4030: Kconfig and Makefile changes
Date: Thu, 03 Apr 2008 13:20:06 -0700
Message-ID: <20080403202006.C174F35F704@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <1207224865-21527-1-git-send-email-felipe.balbi@nokia.com>
 <1207224865-21527-2-git-send-email-felipe.balbi@nokia.com>
 <200804031113.11115.david-b@pacbell.net>
 <3B6D69C3A9EBCA4BA5DA60D91302742903F1415B@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:48165 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752666AbYDCUTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 16:19:12 -0400
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742903F1415B@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r-woodruff2@ti.com, felipe.balbi@nokia.com
Cc: mikko.k.ylinen@nokia.com, linux-omap@vger.kernel.org

> > Again, what's a MADC?
>
> It's an 'upset C' of course ;)

Better than obfuscated C, I guess.  http://www.ioccc.org/ ... :)


> Really:
>
> It's a 10-bit analog-to-digital converter combined with a 16-input
> analog multiplexer.  Multiplexed-ADC I suppose.  It is used by
> processor groups, battery charger and USB sub-chip.
>
> 8 of the 16 inputs are externally useable and the other 8 are used
> by battery, speaker, usb.

In short, a fairly typical 10-bit/16-channel ADC, with some channels
serving dedicated functions.  Thanks.  That should be in the driver,
and in the Kconfig helptext.


> On the lines of documentation a public 3430 TRM should be here any
> day if not already.  I'm not sure on T2, though I'll ask the question.

I grabbed an OMAP 35x TRM yesterday, the "one big PDF" version, but
as of this morning there was no documentation on the TWL4030 page.

- Dave

