From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] serial: 8250: omap: Provide ability to enable/disable
 UART as wakeup source
Date: Thu, 29 Mar 2018 11:02:03 +0530
Message-ID: <c43b081a-a94a-fb89-d2d7-9c4947bac4a6@ti.com>
References: <20180327120217.4749-1-vigneshr@ti.com>
 <20180328223020.GL5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180328223020.GL5700@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Thursday 29 March 2018 04:00 AM, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [180327 12:03]:
>> Enable/Clear module level UART wakeup in UART_OMAP_WER register based on
>> return value of device_may_wakeup() in .suspend(). This allows
>> userspace to use sysfs to control the ability of UART to wakeup the
>> system from deep sleep state. Register is restored back in .startup()
>> call that happens as part of resume sequence.
>> 
>> With this patch, userspace can control UART wakeup capability via sysfs:
>> To enable wakeup capability:
>> echo enabled >  /sys/class/tty/ttyXX/device/power/wakeup
>> For disabling wakeup capability:
>> echo disabled > /sys/class/tty/ttyXX/device/power/wakeup
> 
> To avoid confusion, can you please add this to the description:
> 
> Note that the UART wakeup events configured in the 8250 hardware only
> work for idle modes that do not cut off power for the UART. For deeper
> idle states, dedicated padconf wakeirqs must be used. Or in some cases
> the UART RX pin can be remuxed to GPIO input if the GPIO block stays
> powered.
> 

That makes sense, I will add it to patch description in v2.

> I tested this briefly and the dedicated wakeirqs still work for me,
> so from that point of view:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks for testing!

-- 
Regards
Vignesh
