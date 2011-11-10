From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH] gpiolib: add irq_wake (power-management) sysfs file
Date: Thu, 10 Nov 2011 10:50:13 -0800
Message-ID: <87k477erru.fsf@ti.com>
References: <1320854511-15065-1-git-send-email-p-combes@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36082 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754593Ab1KJSuW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 13:50:22 -0500
Received: by mail-ey0-f175.google.com with SMTP id 9so3521880eyd.20
        for <linux-omap@vger.kernel.org>; Thu, 10 Nov 2011 10:50:21 -0800 (PST)
In-Reply-To: <1320854511-15065-1-git-send-email-p-combes@ti.com> (Patrick
	Combes's message of "Wed, 9 Nov 2011 17:01:51 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Patrick Combes <p-combes@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, b-cousson@ti.com, f-mazard@ti.com, dmurphy@ti.com, Hugo Dupras <h-dupras@ti.com>

Patrick Combes <p-combes@ti.com> writes:

> From: Hugo Dupras <h-dupras@ti.com>
>
> By calling poll() on the /sys/class/gpio/gpioN/value sysfs file, usermode
> application can take benefit of gpio interrupts.
> However, depending on the power state reached, this interrupt may not wake-up
> the CPU.
> This patch creates a new sysfs file /sys/class/gpio/gpioN/irq_wake to enable
> usermode application to set the wake properties of a gpio IRQ.
> This option can be set or not for each gpio to preserve power consumption (e.g
> embedded systems).
>
> Signed-off-by: Hugo Dupras <h-dupras@ti.com>
> Signed-off-by: Patrick Combes <p-combes@ti.com>

Hello,

This is a change to the GPIO core but you only have the OMAP-specific
list here.

Please send this to the GPIO maintainer[1] and the lists.

Also, please copy linux-arm-kernel@lists.infradead.org where there are
lots of GPIOlib users who might be interested in this, and also copy
LKML (linux-kernel@vger.kernel.org)

Thanks,

Kevin

P.S. David Brownell passed away earlier this year, so I removed his
     email from the to list: http://lkml.org/lkml/2011/6/6/32

[1] excerpt from MAINTAINERS file
GPIO SUBSYSTEM
M:	Grant Likely <grant.likely@secretlab.ca>
S:	Maintained
T:	git git://git.secretlab.ca/git/linux-2.6.git
F:	Documentation/gpio.txt
F:	drivers/gpio/
F:	include/linux/gpio*

