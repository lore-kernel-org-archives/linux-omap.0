From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Timekeeping issue on aggressive suspend/resume
Date: Fri, 11 Jun 2010 09:21:35 +0200
Message-ID: <20100611092135.415c2155@surf>
References: <AANLkTinIO5a1EeK6Ej2ljkuyL9zv06OMfbyiZBaxTQTd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.191.76.200]:60272 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab0FKHVn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 03:21:43 -0400
In-Reply-To: <AANLkTinIO5a1EeK6Ej2ljkuyL9zv06OMfbyiZBaxTQTd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

Hello Suresh,

On Wed, 9 Jun 2010 12:50:39 -0700
Suresh Rajashekara <suresh.raj+linuxomap@gmail.com> wrote:

> I have an application (running on 2.6.29-omap1) which puts an OMAP1
> system to suspend aggressively. The system wakes up every 4 seconds
> and stays awake for about 35 milliseconds and sleeps again for another
> 4 seconds. This design is to save power on a battery operated device.
> 
> This aggressive suspend resume action seems like creating an issue to
> other applications in the system waiting for some timeout to happen
> (especially an application which is waiting using the mq_timedreceive
> and is supposed to timeout every 30 seconds. It seems to wake up every
> 90 seconds). Seems like the timekeeping is not happening properly in
> side the kernel.
> 
> If the suspend duration is changed from 4 second to 1 second, then
> things work somewhat better. On reducing it to 0.5 second (which was
> our earlier design on 2.6.16-rc3), the problem seems to disappear.

I've done a relatively similar thing on different CPU architecture: in
the idle loop, when the CPU is going to be idle for a sufficiently long
period of time, I power down the CPU completely. Before that, I've
programmed a RTC (clocked at 32 khz) to wake-up the CPU a little bit
*before* the expiration of the next timer. When the CPU wakes-up, I
adjust the clocksource (in this case the CPU cycle counter) to
compensate the time spent while the CPU was off, and I reprogram the
clockevents to make sure that the timer will actually expire at the
correct time, also by compensating the time during which the CPU was
off (note: when the CPU is off, the cycle counter stops incrementing,
and the timer used as clockevents stops decrementing). This way, the
CLOCK_MONOTONIC time continues to go forward even when the CPU is off.
The goal was to make the "CPU is off" case just another idle state of
the system, which should just be as transparent to the life of the
system as other idle states. So an application that uses a periodic
timer of say, 30 milliseconds, will see its timer actually fired every
30 milliseconds even though the CPU goes off between each timer
expiration (we've done measurements with a scope, and the timer rely
expires every 30 milliseconds as expected).

FWIW, we do not use the normal suspend/resume infrastructure for this,
because it was way too slow (in the order of ~100ms). On the particular
hardware we're using, it takes roughly ~1ms to go OFF, and ~2ms to
completely wake-up, so we can very aggressively put the CPU in the OFF
state.

However, the way we're doing the "time compensation" is quite hackish,
and it would be great to hear Thomas Gleixner's ideas on how this
should be implemented properly at the clocksource/clock_event_device
level.

Sincerely,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
