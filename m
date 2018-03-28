From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: 8250: omap: Provide ability to enable/disable
 UART as wakeup source
Date: Wed, 28 Mar 2018 15:30:21 -0700
Message-ID: <20180328223020.GL5700@atomide.com>
References: <20180327120217.4749-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180327120217.4749-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [180327 12:03]:
> Enable/Clear module level UART wakeup in UART_OMAP_WER register based on
> return value of device_may_wakeup() in .suspend(). This allows
> userspace to use sysfs to control the ability of UART to wakeup the
> system from deep sleep state. Register is restored back in .startup()
> call that happens as part of resume sequence.
> 
> With this patch, userspace can control UART wakeup capability via sysfs:
> To enable wakeup capability:
> echo enabled >  /sys/class/tty/ttyXX/device/power/wakeup
> For disabling wakeup capability:
> echo disabled > /sys/class/tty/ttyXX/device/power/wakeup

To avoid confusion, can you please add this to the description:

Note that the UART wakeup events configured in the 8250 hardware only
work for idle modes that do not cut off power for the UART. For deeper
idle states, dedicated padconf wakeirqs must be used. Or in some cases
the UART RX pin can be remuxed to GPIO input if the GPIO block stays
powered.

I tested this briefly and the dedicated wakeirqs still work for me,
so from that point of view:

Tested-by: Tony Lindgren <tony@atomide.com>
