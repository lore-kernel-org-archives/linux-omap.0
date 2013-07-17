From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: musb: dsps: make it work with two instances
Date: Wed, 17 Jul 2013 19:12:29 +0200
Message-ID: <20130717171229.GA1516@linutronix.de>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
 <CALF0-+Vo64Znw_iY0gOx5hGJ9mgw7OXFQ5HqBrTW4udW-Z=N+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37455 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab3GQRMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jul 2013 13:12:31 -0400
Content-Disposition: inline
In-Reply-To: <CALF0-+Vo64Znw_iY0gOx5hGJ9mgw7OXFQ5HqBrTW4udW-Z=N+g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <elezegarcia@gmail.com>, Felipe Balbi <balbi@ti.com>
Cc: george.cherian@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, b-cousson@ti.com

* Ezequiel Garcia | 2013-07-06 18:39:50 [-0300]:

>Hi Sebastian,
Hi Ezequiel,

>After some minor DT tweaking on the current patchset,
>I've managed to detect an USB mass storage device in the
>second instance (host / usb1) using a Beaglebone black board.

Beaglebone black, that one has a different device tree which is not
mainline, right?

>However, after I unplug the device, it's not recognized
>when I replug it. Maybe you can take a look at this;
>i'll do some more testings and see what I can come up with.

I figured out why my Host is not recognized on the second plug:
At module load time, musb_start() is executed and it sets the
MUSB_DEVCTL_SESSION in devctl.
After the device is unplugged dsps_musb_try_idle() schedules a timer
which executes the local otg_timer() function. Since the phy is in
OTG_STATE_A_WAIT_BCON state, the MUSB_DEVCTL_SESSION bit gets removed.
If the removal of the bit is ignored, the device is recognized after a
re-plug.

Now a question: I see that am35x and anothers also remove that flag in
thsi case. How is the flag supposed to come back?
I see that blackfin removes that bit and stuffs it back in. Any idea
what should be done here?

>Also, FWIW, I think that having a separate USB phy for am35xx would be
>much better.
So you would prefer a new file with 90% copy of what we already have in
the nop_phy?

Sebastian
