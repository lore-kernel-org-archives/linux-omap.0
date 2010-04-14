From: Venkatraman S <svenkatr@ti.com>
Subject: [INFO] Serial "no clocks available" warning for 3630 SDP
Date: Wed, 14 Apr 2010 13:42:01 +0530
Message-ID: <q2m618f0c911004140112u14ee6e3fh3756ae2fb387a1a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:56381 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab0DNIMC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 04:12:02 -0400
Received: by iwn35 with SMTP id 35so2577844iwn.21
        for <linux-omap@vger.kernel.org>; Wed, 14 Apr 2010 01:12:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, "Raja, Govindraj" <govindraj.raja@ti.com>

On the master branch -rc3 version eba0147, I get this warning when
booting it up on 3630 SDP.
I don't have a fix for this, just curious if someone else has noticed..
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/serial.c:727 omap_serial_init_port+0x5c/0x2e8()
(null): can't init uart3, no clocks available
Modules linked in:
[<c0031034>] (unwind_backtrace+0x0/0xec) from [<c0053fbc>]
(warn_slowpath_common+0x48/0x60)
[<c0053fbc>] (warn_slowpath_common+0x48/0x60) from [<c005400c>]
(warn_slowpath_fmt+0x24/0x30)
[<c005400c>] (warn_slowpath_fmt+0x24/0x30) from [<c000e5d8>]
(omap_serial_init_port+0x5c/0x2e8)
[<c000e5d8>] (omap_serial_init_port+0x5c/0x2e8) from [<c000e88c>]
(omap_serial_init+0x28/0x34)
[<c000e88c>] (omap_serial_init+0x28/0x34) from [<c000fdd0>]
(omap_sdp_init+0x14/0x54)
[<c000fdd0>] (omap_sdp_init+0x14/0x54) from [<c000b3a0>]
(customize_machine+0x18/0x24)
[<c000b3a0>] (customize_machine+0x18/0x24) from [<c002b33c>]
(do_one_initcall+0x5c/0x1b4)
[<c002b33c>] (do_one_initcall+0x5c/0x1b4) from [<c0008578>]
(kernel_init+0x90/0x144)
[<c0008578>] (kernel_init+0x90/0x144) from [<c002cd7c>]
(kernel_thread_exit+0x0/0x8)
---[ end trace 1b75b31a2719ed1c ]---
