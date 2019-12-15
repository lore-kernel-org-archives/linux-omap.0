From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] w1: omap-hdq: Simplify driver with PM runtime
 autosuspend
Date: Sun, 15 Dec 2019 20:33:19 +0100
Message-ID: <20191215203319.2874ac04@aktux>
References: <20191215173817.47918-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191215173817.47918-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Evgeniy Polyakov <zbr@ioremap.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, "Andrew F . Davis" <afd@ti.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sun, 15 Dec 2019 09:38:17 -0800
Tony Lindgren <tony@atomide.com> wrote:

> We've had generic code handling module sysconfig and OCP reset registers
> for omap variants for many years now and all the drivers really needs to
> do is just call runtime PM functions.
> 
> Looks like the omap-hdq driver got only partially updated over the years
> to use runtime PM, and still has lots of custom PM code left.
> 
> We can replace all the custom code for sysconfig, OCP reset, and PM with
> just a few lines of runtime PM autosuspend code.
> 
> Note that the earlier driver specific usage count limit of four seems
> completely artificial and should not be an issue in normal use.
> 
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Andreas Kemnade <andreas@kemnade.info>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> 
> Can you guys please review and and test on gta04 and torpedo?
> 
I tried this after booting with init=/bin/bash and mounting kernel
filesystems (no off mode enabled):
root@(none):/# echo on >/sys/bus/platform/devices/480b2000.1w/power/control
root@(none):/# modprobe omap_hdq
[   49.590820] Driver for 1-wire Dallas network protocol.
[   49.598327] omap_hdq 480b2000.1w: OMAP HDQ Hardware Rev 0.5. Driver in Interrupt mode
root@(none):/# [   49.624572] w1_master_driver w1_bus_master1: Attaching one wire slave 01.000000000000 crc 3d
[   49.660980] power_supply bq27000-battery: power_supply_get_battery_info currently only supports devicetree

root@(none):/# time cat /sys/class/power_supply/bq27000-battery/voltage_now 
0

real    0m2.561s
user    0m0.008s
sys     0m0.002s
root@(none):/# time cat /sys/class/power_supply/bq27000-battery/voltage_now 
0

real    0m12.601s
user    0m0.010s
sys     0m0.002s
root@(none):/# time cat /sys/class/power_supply/bq27000-battery/voltage_now 
0

real    0m12.601s
user    0m0.010s
sys     0m0.002s
root@(none):/# 

No data could be read but some detection work seem to be done.
Of course, I also tried without that forced power on.

I hope I can find more time to analyze.
Looks like a nice cleanup but needs some work.

Regards,
Andreas
