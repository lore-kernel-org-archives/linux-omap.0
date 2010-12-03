From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Unbalanced IRQ wake disable during resume from static suspend
Date: Fri, 3 Dec 2010 03:00:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012030251230.17078@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com> <alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com> <1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com> <AANLkTikqvVK2BWpiik5SVWPRzC6NMKs=Udvrtru5BfR-@mail.gmail.com>
 <09fd160109a43efec9a472055d541c9e@mail.gmail.com> <87y6882rc9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35561 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932353Ab0LCKA3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 05:00:29 -0500
In-Reply-To: <87y6882rc9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj <govindraj.ti@gmail.com>, linux-omap@vger.kernel.org

Hi Kevin

On Thu, 2 Dec 2010, Kevin Hilman wrote:

> I guess this hasn't been seen before since we haven't tested the sysfs
> wakeup interface for the omap-serial driver.  For on-chip OMAP UARTs,
> using the sysfs interface isn't needed as the serial core is already
> doing device_init_wakeup(dev, true);

Is this the code you're referring to, in serial_core.c?

	tty_dev = tty_register_device(drv->tty_driver, uport->line, uport->dev);
	if (likely(!IS_ERR(tty_dev))) {
		device_init_wakeup(tty_dev, 1);
		device_set_wakeup_enable(tty_dev, 0);
	} else

I may be misreading it, but it appears that the code leaves wakeups 
disabled for the serial port, by default.

As an aside, this code is somewhat perplexing: it doesn't seem accurate to 
assume that every serial device really is capable of waking up the system.


- Paul
