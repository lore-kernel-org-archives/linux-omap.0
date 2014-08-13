From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 5/5] tty: serial: Add 8250-core based omap driver
Date: Wed, 13 Aug 2014 18:20:54 +0200
Message-ID: <53EB9066.3060208@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de> <1405521903-5877-6-git-send-email-bigeasy@linutronix.de> <20140717070859.GD18374@atomide.com> <20140717074219.GA29193@linutronix.de> <20140717081232.GH18374@atomide.com> <53C7A01C.50107@linutronix.de> <20140718062456.GJ18374@atomide.com> <20140721093528.GS18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46923 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbaHMQVD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2014 12:21:03 -0400
In-Reply-To: <20140721093528.GS18374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 07/21/2014 11:35 AM, Tony Lindgren wrote:

> Looks like the following is needed to avoid the error, no idea why..
> But this is what we also do in omap-serial.c. It may be needed in
> other places too?

Yes, there was a third one on shutdown.

> Also, no luck yet on runtime PM. If the console is enabled omap won't
> idle, and if no serial console is enabled, it just hangs. Will try
> to debug this part further, it may be also related to the above.

My beaglebone xm won't do idle:

| omap3_pm_off_mode_enable: Core OFF disabled due to errata i583

but it would if it could, right? That means that I can't test the wake
via UART on this one?

So I will try to fix the tx-pm, fold patches and then prepare another
batch.
And I could verify that DMA works on that omap3 :)

> Regards,
> 
> Tony

Sebastian
