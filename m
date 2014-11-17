From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fail to enter retention
Date: Mon, 17 Nov 2014 08:22:10 -0800
Message-ID: <20141117162209.GE7046@atomide.com>
References: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16186 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751138AbaKQQWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 11:22:33 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-omap@vger.kernel.org

* Ran Shalit <ranshalit@gmail.com> [141116 12:13]:
> Hello,
> 
> I'm using OMAP3530 with custom board. I have enabled all power mode
> features as described in PSP wiki, but it still fails to enter any
> state different from state0.

Works for me with pretty much all omap3 boards I have here with
mainline kernel since v3.17 using omap2plus_defconfig. And the
following script to idle uarts and enable off-idle (or retention).

USB needs to be disconnected and EHCI probably still cannot be
enabled.
 
> The next thing was trying to get the uart to sleep (though there might
> be also problems with other domains ?) .
> 
> On trying to enable uart as wakeup source I get the following:
> 
> echo enabled >  /sys/devices/platform/omap/omap_uart.2/power/wakeup
> 
> cat  /sys/devices/platform/omap/omap_uart.2/power/wakeup
> 
> #> disabled      (?????)
> 
> echo 1 >  /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> ~ # [   85.006622] omap_device: omap_uart.2: new worst case deactivate
> latency 0: 61035
> [   85.559844] omap_device: omap_uart.2: new worst case activate
> latency 0: 61035
> [  982.415161] omap_device: omap_uart.2: new worst case deactivate
> latency 0: 91552
> 
> < console hangs here >

Sounds like you need to enable the wake-up interrupt for the UART.
See the interrupts-extended entry for many omap3-*.dts files:

interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;

If you get it working, care to update the instructions in the wiki
too?

Regards,

Tony

8< ----------------------
#!/bin/bash

uarts=$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
for uart in $uarts; do
	echo 3000 > $uart/autosuspend_delay_ms 2>&1
done

uarts=$(find /sys/class/tty/ttyO*/power/ -type d 2>/dev/null)
for uart in $uarts; do
	echo enabled > $uart/wakeup 2>&1
	echo auto > $uart/control 2>&1
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
