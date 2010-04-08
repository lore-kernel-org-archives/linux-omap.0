From: Peter Tseng <tsenpet09@gmail.com>
Subject: Re: linux-omap-pm troubles on Gumstix Overo
Date: Wed, 07 Apr 2010 20:12:26 -0400
Message-ID: <4BBD1F6A.6060005@gmail.com>
References: <4BBBF808.80000@gmail.com> <87tyrnfe8c.fsf@deeprootsystems.com> <87ochuapm9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34561 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0DHAMg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 20:12:36 -0400
Received: by vws13 with SMTP id 13so799848vws.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Apr 2010 17:12:35 -0700 (PDT)
In-Reply-To: <87ochuapm9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On 04/07/2010 11:56 AM, Kevin Hilman wrote:
> What's your commandline?

Kernel command line: console=ttyS2,115200n8 mpurate=500 vram=12M
omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_disp=dvi
root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait

On 04/07/2010 06:01 PM, Kevin Hilman wrote:
> OK, after some more digging, the Overo was hitting the same boot
> problem I've been trying to track on Zoom3.  I have now fixed this and
> the PM branch omap3_pm_defconfig should boot again for Overo and
> Zoom3.
> 
> I've updated the PM branch now which includes a fix for a problem
> introduced in in 2.6.34 due to early enabling of interrupts (see
> details on LKML[1]).  Interstingly, this was seen on PM branch where I
> use the SLUB allocator by default, and not on l-o master where the
> SLAB allocator is still used by default.
> 
> Please pull a fresh PM branch and see if you get it booting on Overo.

Thanks, Kevin! Yes, I just pulled the pm branch and the Overo is booting
again. A few quirks to note:

1) As I hadn't grabbed the fixes for the OMAP4 compilation problems, I
had to uncheck OMAP4 in the System Types as before.
2) Since I was booting off an SD card, I had to go to Device
Drivers-->MMC/SD/SDIO Card and have the following be built in (rather
than be a module)
 - MMC block device driver
 - SDHC Interface support
 - TI OMAP High Speed Multimedia Card interface support
3) I have a few error messages with the framebuffer as the kernel is
booting up. It does still work, however. See [1] below.
4) Suspend to memory (echo mem > /sys/power/state) works now, but when I
wake up the board (via a keypress), I am no longer able to type anything
at the prompt. Any clue about this one?

Peter

[1]
open /dev/fb0: No such file or directory
open /dev/fb0: No such file or directory
expr: syntax error
Linux Frame Buffer Device Configuration Version 2.1 (23/06/1999)
(C) Copyright 1995-1999 by Geert Uytterhoeven


Usage: fbset [options] [mode]

Valid options:
(Insert very long options list here)

Starting PVR
Usage: insmod filename [args]
FATAL: Module omaplfb not found.
mknod: missing operand after `0'
Try `mknod --help' for more information.
chmod: cannot access `/dev/pvrsrvkm': No such file or director
