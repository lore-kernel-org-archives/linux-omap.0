From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v9 0/9] OMAP3: PM: TWL4030 power scripts and workaround
 for TWL erratum 27
Date: Tue, 3 May 2011 15:21:52 +0200
Message-ID: <BANLkTikHjZLGRogYpkpt=zJsyPcrqT0vyg@mail.gmail.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50355 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab1ECNVx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 09:21:53 -0400
Received: by qyg14 with SMTP id 14so34953qyg.19
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 06:21:52 -0700 (PDT)
In-Reply-To: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Thu, Apr 14, 2011 at 2:27 PM, Lesly A M <leslyam@ti.com> wrote:
> Patch series for TWL4030 power scripts and workaround for TWL erratum 27.
>
> Changes for implementing TWL4030 power scripts recommended by hardware team.
> Introduced a new TWL4030 power script file, which can be used by different
> OMAP3 board with the power companion chip TWL4030.
>
> Updated the changes for TWL4030 errata 27 & 28, and modified
> the TWL4030 power script.
> Workaround for TWL4030 erratum 27 is required for Si version less than or
> equal to TWL5030 ES1.1.
>
...

> This changes are tested on OMAP3430 & OMAP3630 SDP with off mode enabled in suspend path.
With the patches series applied and a board file change for
Beagleboard (similar to patch 7/9 for SDP), the Beagleboard is not
consistently booting. Most of the time it is hanging at boot, cf. dump
below. In the case it boots OK no voltage drop is observed when going
to OFF mode.

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.39-rc5-09490-gf4c2b2b (def@defasus)
(gcc version 4.4.1 (Sourcery G++ L
ite 2010q1-202) ) #694 SMP Tue May 3 14:11:31 CEST 2011
[    0.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
...
[    0.350830] OMAP3 Beagle Rev: Ax/Bx
[    0.365203] omap_device: omap_uart.0: new worst case activate
latency 0: 30517
[    0.365570] omap_device: omap_uart.0: new worst case deactivate
latency 0: 30517
[    0.385253] Found NAND on CS0
[    0.388427] Registering NAND on CS0
[    0.393585] Unable to get DVI reset GPIO
[    0.398284] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.425659] OMAP DMA hardware revision 4.0
[    0.509674] bio: create slab <bio-0> at 0
[    0.526092] SCSI subsystem initialized
[    0.531158] omap_device: omap2_mcspi.1: new worst case activate
latency 0: 30517
[    0.541351] omap_device: omap2_mcspi.1: new worst case deactivate
latency 0: 30517
[    0.557586] usbcore: registered new interface driver usbfs
[    0.564971] usbcore: registered new interface driver hub
[    0.572082] usbcore: registered new device driver usb
[    0.579925] omap_device: omap_i2c.1: new worst case activate latency 0: 30517
[    0.587768] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz

AFAICT the main difference in the wiring is that the PMIC CLKREQ is
not connected to the OMAP and is tied to VIO_1V8.

Any thought on how to support the T2 scripts on Beagle?

Regards,
Jean
