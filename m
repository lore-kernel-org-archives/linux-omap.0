From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Gumstix Overo Low Power Standby?
Date: Wed, 20 May 2009 10:11:07 -0700
Message-ID: <87ws8bog2c.fsf@deeprootsystems.com>
References: <E7CF933B-CAC8-4F9E-AA3F-C64F36063C8F@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:32092 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZETRLJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 13:11:09 -0400
Received: by wf-out-1314.google.com with SMTP id 26so189102wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 10:11:11 -0700 (PDT)
In-Reply-To: <E7CF933B-CAC8-4F9E-AA3F-C64F36063C8F@cornell.edu> (Blazej Kot's message of "Wed\, 20 May 2009 11\:18\:23 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Blazej Kot <bjk45@cornell.edu>
Cc: linux-omap@vger.kernel.org

Blazej Kot <bjk45@cornell.edu> writes:

> I have been working with the linux-pm kernel on the Gumstix Overo,
> seeing how low it's power consumption can go, both during the cpu "on"
> and especially while the CPU is suspended. Thus far, I've had some
> disappointing results, the best I could get is about 500mW while on,
> and 250mW while suspended (ie by running "echo mem > /sys/power/
> state"). I am led to believe that the OMAP processor is capable of
> much lower power consumption during standby.
>
> I am wondering if anybody in the gumstix community is looking into the
> software support for very-low-power modes on the overo. If so, I am
> wondering what the lowest power levels are which you have reached
> during standby are.
>
> I have seen this:
>
> http://markmail.org/message/ge5hec5f5asp7a67#query:omap%20linux
> %2080%20ma+page:1+mid:t2erlwweknakm767+state:results
>
> Which seems to indicate the lowest power reached is 80mA at 3.3V ->
> 0.264 W, which is about what I'm seeing. Is it really true that the
> overo draws a quarter of a watt when doing absolutely nothing?

There are lots of factors involved.

The current OMAP PM branch is focused on minimizing power consumed by
the OMAP SoC itself.  However, there are lots of other things on-board
(audio codecs, regulators, WiFi chipsets etc.) that can consume power
that we may not be currently managing in the omap kernel.

I don't have an Overo so am not familiar with all the on board
peripherals, but you should probably do some experiments where you
can put all the on-board devices into low-power/off states and
run some experiments as well.

In the case of the Beagle results you referenced, I'm pretty sure it
is something on board that is drawing the ~80mA and not on-chip.  I
assume this because setting the OMAP to use OFF-mode in suspend or
idle results in the drop of a few mA reflecting an expected drop in
power consumed by OMAP itself, but still leaving lots of power
consumed.

For example, testing today's PM branch on Beagle gives me roughly the
same numbers as the post you referenced, but slightly better:

- boot idle: 323 mA 

- screen blank: 216 mA 
  # echo 3 > /sys/class/graphics/fb0/blank

- suspend (OMAP retention): 75 mA 
  # echo mem > /sys/power/state

- sleep-while-idle: 75 mA - this same power state as suspend,
  but happens in idle 
  # echo 1 > /sys/power/sleep_while_idle 

- suspend (OMAP off): 72 mA
  # echo 1 > /sys/power/enable_off_mode
  # echo 1 > /sys/power/voltage_off_while_idle

Ultimitately the answer is that more work needs to be done with the
using the regulator framework and/or the drivers for the on-chip
peripherals to be sure they can be powered off when needed.

Hope that helps,

Kevin
