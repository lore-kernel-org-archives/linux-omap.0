From: Tony Lindgren <tony@atomide.com>
Subject: Re: How to keep DM37x GPIO_162 high during off-mode
Date: Tue, 9 Jul 2013 08:55:11 -0700
Message-ID: <20130709155511.GG5523@atomide.com>
References: <51DC238B.2060103@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62089 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752124Ab3GIPzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 11:55:13 -0400
Content-Disposition: inline
In-Reply-To: <51DC238B.2060103@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@logicpd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Peter Barada <peter.barada@logicpd.com> [130709 08:14]:
> I'm working with a 3.0.8 kernel in Android ICS and have run into a
> problem using wl12xx bluetooth after a suspend/resume cycle.
> 
> GPIO_162 in this design is connected to the BT_EN pin of the wl12xx and
> needs to be held high to keep the bluetooth core from resetting while
> the DM37x goes into off mode.
> 
> I've tried muxing the pin using OMAP_PIN_OUTPUT |
> OMAP_PIN_OFF_OUTPUT_HIGH, but the pin goes low when the chip goes into
> off mode.  If I disable off mode via "echo 0 >
> /sys/kernel/debug/pm_debug/enable_off_mode" the pin remains high while
> the chip goes into retention and the bluetooth core works after resume.
> 
> Any ideas why GPIO_162 would go low during suspend to off mode?

Unless the GPIO is in a GPIO bank that's connected to the WKUP
power domain, the GPIO bank context will be lost. So there's a short
period where the  GPIO bank is in an uninitialized state between waking
from off-idle and before the context to the GPIO bank gets restored in
omap_gpio_runtime_resume().

If there's a pull on the line, the period is long enough to change
the line.

Unless the TI people know some magic tricks that I'm not aware of,
there's no way around it, except to use external pulls to keep
the GPIO line in desired state, or move the GPIO somewhere else,
like TWL.

Regards,

Tony
