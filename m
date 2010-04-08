From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: linux-omap-pm troubles on Gumstix Overo
Date: Thu, 08 Apr 2010 10:15:37 -0700
Message-ID: <87bpdt6f2e.fsf@deeprootsystems.com>
References: <4BBBF808.80000@gmail.com> <87tyrnfe8c.fsf@deeprootsystems.com>
	<87ochuapm9.fsf@deeprootsystems.com> <4BBD1F6A.6060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33334 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653Ab0DHRPp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 13:15:45 -0400
Received: by pva18 with SMTP id 18so1506722pva.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Apr 2010 10:15:44 -0700 (PDT)
In-Reply-To: <4BBD1F6A.6060005@gmail.com> (Peter Tseng's message of "Wed\, 07 Apr 2010 20\:12\:26 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Tseng <tsenpet09@gmail.com>
Cc: linux-omap@vger.kernel.org

Peter Tseng <tsenpet09@gmail.com> writes:

> On 04/07/2010 11:56 AM, Kevin Hilman wrote:
>> What's your commandline?
>
> Kernel command line: console=ttyS2,115200n8 mpurate=500 vram=12M
> omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_disp=dvi
> root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
>
> On 04/07/2010 06:01 PM, Kevin Hilman wrote:
>> OK, after some more digging, the Overo was hitting the same boot
>> problem I've been trying to track on Zoom3.  I have now fixed this and
>> the PM branch omap3_pm_defconfig should boot again for Overo and
>> Zoom3.
>> 
>> I've updated the PM branch now which includes a fix for a problem
>> introduced in in 2.6.34 due to early enabling of interrupts (see
>> details on LKML[1]).  Interstingly, this was seen on PM branch where I
>> use the SLUB allocator by default, and not on l-o master where the
>> SLAB allocator is still used by default.
>> 
>> Please pull a fresh PM branch and see if you get it booting on Overo.
>
> Thanks, Kevin! Yes, I just pulled the pm branch and the Overo is booting
> again. A few quirks to note:
>
> 1) As I hadn't grabbed the fixes for the OMAP4 compilation problems, I
> had to uncheck OMAP4 in the System Types as before.

OK, alternatively, you could also use the CSL compiler 2009q1 or older.

> 2) Since I was booting off an SD card, I had to go to Device
> Drivers-->MMC/SD/SDIO Card and have the following be built in (rather
> than be a module)
>  - MMC block device driver
>  - SDHC Interface support
>  - TI OMAP High Speed Multimedia Card interface support

By default it should be enabled already (at least in
omap3_pm_defconfig) but be sure you have CONFIG_MMC_UNSAFE_RESUME=y
when you have a rootfs on MMC.

> 3) I have a few error messages with the framebuffer as the kernel is
> booting up. It does still work, however. See [1] below.
> 4) Suspend to memory (echo mem > /sys/power/state) works now, but when I
> wake up the board (via a keypress), I am no longer able to type anything
> at the prompt. Any clue about this one?

Indeed, I was able to reproduce this as well and seems to be a new
regression in the PM branch.  I see the same on omap3evm and n900 now
too.

If you enable the UART timeouts + sleep_while_idle, you should avoid
this problem while I try and figure out what's going on:

echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout 
echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout 
echo 5 > /sys/devices/platform/serial8250.2/sleep_timeout 
echo 1 > /debug/pm_debug/sleep_while_idle  

Kevin

> Peter
>
> [1]
> open /dev/fb0: No such file or directory
> open /dev/fb0: No such file or directory
> expr: syntax error
> Linux Frame Buffer Device Configuration Version 2.1 (23/06/1999)
> (C) Copyright 1995-1999 by Geert Uytterhoeven
>
>
> Usage: fbset [options] [mode]
>
> Valid options:
> (Insert very long options list here)
>
> Starting PVR
> Usage: insmod filename [args]
> FATAL: Module omaplfb not found.
> mknod: missing operand after `0'
> Try `mknod --help' for more information.
> chmod: cannot access `/dev/pvrsrvkm': No such file or director
