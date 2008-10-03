From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc7-omap1-git 1/2] twl4030-core: move to drivers/mfd
Date: Fri, 3 Oct 2008 15:16:31 -0700
Message-ID: <200810031516.32367.david-b@pacbell.net>
References: <200810011947.55057.david-b@pacbell.net> <20081003133704.GB6251@atomide.com> <e5e6ade50810031312o4cd37f4fhc5f2204f31af8dbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:41590 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752156AbYJCWQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 18:16:35 -0400
In-Reply-To: <e5e6ade50810031312o4cd37f4fhc5f2204f31af8dbb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Friday 03 October 2008, Nathan Monson wrote:

>   can't get IRQ 378, err -22
>   twl4030_usb: probe of twl4030_usb failed with error -22
>   Unable to allocate IRQ for power button
> 
> This is a stock linux-omap with no patches.

Did you see "i2c_omap i2c_omap.1: controller timed out"
earlier in the boot sequence?  It would have this symptom,
among others... Earlier in this thread you'll find:

 http://marc.info/?l=linux-omap&m=122297833314280&w=2

commenting on the issue I noted when I posted this patch;
showing how I work around that specific I2C error.  It'd
likely work for you too.

I've seen this i2c adapter hit such failures in other
places too, but that location is more reproducible.
And it has relatively *visible* nasty side effects...

- Dave

p.s. Shades of OMAP1 I2C problems!  I recall similar
     cases of the I2C adapter driver stumbling during
     boot and thus making registrations fail.  The
     same workaround (retry) solved things then too...
