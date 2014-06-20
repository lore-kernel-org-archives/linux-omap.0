From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP 3630 random crashes
Date: Fri, 20 Jun 2014 02:14:32 -0700
Message-ID: <20140620091431.GA28884@atomide.com>
References: <1403254242990.39117@grundfos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65425 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbaFTJOd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jun 2014 05:14:33 -0400
Content-Disposition: inline
In-Reply-To: <1403254242990.39117@grundfos.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Casper Lyngesen Mogensen <clmogensen@grundfos.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Casper Lyngesen Mogensen <clmogensen@grundfos.com> [140620 01:52]:
> Hi
> 
> I have  custom board with a Gumstix Overo, my board is similar to a
> Tobi board. Right now i have it running with a 3.5.0 kernel. I'm
> trying to upgrade the kernel, and have tried several versions (3.10 ->
> 3.15) and i seem to be hitting the same problem with all versions, i
> get random crashes. Found a way to  trigger the crash within
> minutes/seconds:
> 
> # dd if=/dev/urandom of=/tmp/test.file bs=1024 count=100000
> 
> A count > 10000 will at some point trigger the crash. The hang/crash
> is repeatable everytime but the log is not, sometimes i do not get
> any trace at all. I can provide more logs if necessary.  Config and
> crash log are below..
> 
> Have tried disabling various peripherals, such as sound, usb,
> ethernet, wifi, bluetooth, but with no luck. Also tried different Overo
> boards.
> 
> Hope someone can help me/point me in the right direction

I was seeing similar issues with NFSroot until commit dcf21919
(ARM: dts: Fix GPMC timings for LAN9220). Turns out LAN9220 has
much slower timings compared to LAN9221. So you need to check that
you're using right timings if you have LAN9220.

Also, check what rate your bootloader is setting the L3 speed.
If it's set to 200MHz, then LAN9220 timings seem to overflow the
GPMC registers for the calculated values and bootloader timings
are used instead.
 
> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.15.0 (clmo@N66266) (gcc version 4.8.1 (crosstool-NG 1.19.0) ) #3 SMP Wed Jun 11 23:50:13 CEST 2014
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine model: OMAP36xx/AM37xx/DM37xx Gumstix Overo on Tobi
> [    0.000000] cma: CMA: reserved 16 MiB at 8d800000
> [    0.000000] Memory policy: Data cache writeback
> [    0.000000] CPU: All CPU(s) started in SVC mode.
> [    0.000000] OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
> [    0.000000] PERCPU: Embedded 9 pages/cpu @cecc6000 s14080 r8192 d14592 u36864
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 60704
> [    0.000000] Kernel command line: console=ttyO2,115200n8 root=/dev/nfs nfsroot=192.168.100.1:/export/bbroot,nolock rw ip=192.168.100.7::192.168.100.1:::eth0:off mem=240M

Maybe also check if your test works with NFSroot idsabled.

Regards,

Tony
