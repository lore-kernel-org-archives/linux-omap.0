From: David Brownell <david-b@pacbell.net>
Subject: Re: Current git head oops'es at boot on Overo
Date: Mon, 6 Oct 2008 12:53:13 -0700
Message-ID: <200810061253.13997.david-b@pacbell.net>
References: <5e088bd90810061126g75ff7768k8fa768751a31e379@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:20772 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752964AbYJFTxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 15:53:16 -0400
In-Reply-To: <5e088bd90810061126g75ff7768k8fa768751a31e379@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Monday 06 October 2008, Steve Sakoman wrote:
> Build is stock 62c36fdd962de2db5d62a326490913f41c442a5c, no additional patches.
> 
> Without DEBUG_LL, boot silently fails. With DEBUG_LL, one can see that
> the failure is due to a NULL pointer dereference in musb.
> 
> I suspect that the root cause is related to:
> 
> <3>i2c_omap i2c_omap.1: controller timed out
> <4>twl4030_usb: probe of twl4030_usb failed with error -22
> 
> Adding David Brownell's i2c-omap timeout workaround patch eliminates
> this error

Right.  I'd suggest merging that, except that would provide
zero incentive to actually fix the i2c-omap problem.

And I *have* seen those timeout errors on other requests...


> and the boot then fails on EHCI. 
> 
> I disabled EHCI in defconfig and was able to get the boot to complete.

Ditto.  I suspect one of those no-timeout busy-waits is just
neglecting to complete... :(


>  However unlike others, I find that musb is not functional -- and the
> trick of disconnecting the USB cable and then reconnecting it does not
> work.

I observed the same thing.  More specifically, no IRQs arrive at
the twl4030-usb driver.

The *very same kernel* works fine on Beagle... is there something
different about the USB setup that might explain this?

- Dave
