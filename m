From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] clocksource: Allow toggling between runtime and
 persistent clocksource for idle
Date: Mon, 6 Jul 2015 10:51:05 -0700
Message-ID: <CALAqxLXrPus4EMuXWLgq2qP1pF0=qg-oki0KB=D+Z6N2zPJJ8g@mail.gmail.com>
References: <1436166725-18353-1-git-send-email-tony@atomide.com>
	<alpine.DEB.2.11.1507061558040.3916@nanos>
	<20150706152201.GJ10705@atomide.com>
	<alpine.DEB.2.11.1507061737280.3916@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1507061737280.3916@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 6, 2015 at 8:46 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 6 Jul 2015, Tony Lindgren wrote:
>> * Thomas Gleixner <tglx@linutronix.de> [150706 07:20]:
>> > On Mon, 6 Jul 2015, Tony Lindgren wrote:
>> The timekeeping accuracy issue certainly needs some thinking, and
>> also the resolution between the clocksources can be different.. In the
>> test case I have the slow timer is always on and of a lower resolution
>> than the ARM global timer being used during runtime.
>>
>> Got some handy timer test in mind you want me to run to provide data
>> on the accuracy?
>
> John Stultz might have something.

You can turn on ntp stats in your ntp.conf and chart the loopstats
data w/ gnuplot:

set terminal png
set output "loopstat.png"
plot "/var/log/ntpstats/loopstats.<dateoftest>" using 2:3 with linespoints


I also have  the drift-log.py and graph-log.py scripts I use here:
https://github.com/johnstultz-work/timetests

But those aren't really ready for mass consumption, as they're
probably not very cross-distro compatible.

thanks
-john
