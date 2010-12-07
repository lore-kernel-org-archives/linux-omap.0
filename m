From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Unbalanced IRQ wake disable during resume from static suspend
Date: Tue, 07 Dec 2010 13:32:02 -0800
Message-ID: <87bp4xl165.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com>
	<alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com>
	<1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com>
	<AANLkTikqvVK2BWpiik5SVWPRzC6NMKs=Udvrtru5BfR-@mail.gmail.com>
	<09fd160109a43efec9a472055d541c9e@mail.gmail.com>
	<87y6882rc9.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1012030251230.17078@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48682 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab0LGVcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 16:32:07 -0500
Received: by vws16 with SMTP id 16so356966vws.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 13:32:06 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012030251230.17078@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 3 Dec 2010 03:00:28 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj <govindraj.ti@gmail.com>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin
>
> On Thu, 2 Dec 2010, Kevin Hilman wrote:
>
>> I guess this hasn't been seen before since we haven't tested the sysfs
>> wakeup interface for the omap-serial driver.  For on-chip OMAP UARTs,
>> using the sysfs interface isn't needed as the serial core is already
>> doing device_init_wakeup(dev, true);
>
> Is this the code you're referring to, in serial_core.c?
>
> 	tty_dev = tty_register_device(drv->tty_driver, uport->line, uport->dev);
> 	if (likely(!IS_ERR(tty_dev))) {
> 		device_init_wakeup(tty_dev, 1);
> 		device_set_wakeup_enable(tty_dev, 0);
> 	} else
>
> I may be misreading it, but it appears that the code leaves wakeups 
> disabled for the serial port, by default.

No, I was referring to the code in mach-omap2/serial.c, in omap_serial_init_port():

	if ((cpu_is_omap34xx() && uart->padconf) ||
	    (uart->wk_en && uart->wk_mask)) {
		device_init_wakeup(&od->pdev.dev, true);
		DEV_CREATE_FILE(&od->pdev.dev, &dev_attr_sleep_timeout);
	}

Kevin

> As an aside, this code is somewhat perplexing: it doesn't seem accurate to 
> assume that every serial device really is capable of waking up the system.
