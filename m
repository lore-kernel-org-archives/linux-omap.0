From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP3 low power mode broken on l-o
Date: Tue, 02 Nov 2010 13:38:57 +0000
Message-ID: <87sjzjetfy.fsf@deeprootsystems.com>
References: <AANLkTikzVLW08MrZUPWmVx6+w4E8sXN5NHwM1R7Ya8zX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41707 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab0KBNjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 09:39:07 -0400
Received: by eye27 with SMTP id 27so3800362eye.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 06:39:05 -0700 (PDT)
In-Reply-To: <AANLkTikzVLW08MrZUPWmVx6+w4E8sXN5NHwM1R7Ya8zX@mail.gmail.com>
	(Jean Pihet's message of "Thu, 28 Oct 2010 22:40:43 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> The low power mode on the latest l-o master branch is broken, so I
> investigated a bit. Here are the results. This has been tested on
> OMAP3EVM and Beagleboard.
>
> The problem is that the CORE does not reach the desired mode (RET,
> OFF). It is caused by the I2C1 fclk that is left enabled at suspend
> time.
> Extra printks has been added in the clock enable and disable functions
> for I2C and a stack dump has been added in the suspend path if the
> clock is still enabled, cf. log below.
>
> In the devices suspend sequence the RTC gets suspended, which triggers
> a read of the TWL RTC through the I2C bus, which in turn enables the
> I2C1 fclk. That clock is only disabled on devices resume.
>
> I am guessing this is linked to the recent changes in the I2C for HWMOD support.
> What is the correct fix to have the I2C modules correctly shut off
> before the suspend?

I2C clocks are supposed to be disabled after each transaction.  This
isn't happening.

My guess is that the 'put' that happens after TX doesn't actually
actually result in a call to omap_device_idle() since system suspend is
active.  Static suspend/resume take the runtime PM lock, effectively
disabling runtime PM suspend during static suspend.

I have a patch/workaround for this problem which is part of my pm-core
branch, but I did not submit for 2.6.37 as I'm not entirely convinced of
it yet.  Basically, in the OMAP bus-methods for static suspend/resume I
tinker with the runtime PM usecounting such that the devices can idle.

Please take a look at the tip patch in my pm-suspend branch, try it out
and see if it fixes your problem.

Thanks,

Kevin
