From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v9 0/9] OMAP3: PM: TWL4030 power scripts and workaround
 for TWL erratum 27
Date: Wed, 4 May 2011 19:58:41 +0530
Message-ID: <BANLkTimzdOqDZoabAbp9iyRLqYk7WY__3Q@mail.gmail.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
	<BANLkTikHjZLGRogYpkpt=zJsyPcrqT0vyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:34287 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753863Ab1EDO2o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 10:28:44 -0400
Received: by mail-wy0-f173.google.com with SMTP id 42so1179764wyb.18
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 07:28:42 -0700 (PDT)
In-Reply-To: <BANLkTikHjZLGRogYpkpt=zJsyPcrqT0vyg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Jean,

On Tue, May 3, 2011 at 6:51 PM, Jean Pihet <jean.pihet@newoldbits.com> =
wrote:
> On Thu, Apr 14, 2011 at 2:27 PM, Lesly A M <leslyam@ti.com> wrote:
>> Patch series for TWL4030 power scripts and workaround for TWL erratu=
m 27.
>>
>> Changes for implementing TWL4030 power scripts recommended by hardwa=
re team.
>> Introduced a new TWL4030 power script file, which can be used by dif=
ferent
>> OMAP3 board with the power companion chip TWL4030.
>>
>> Updated the changes for TWL4030 errata 27 & 28, and modified
>> the TWL4030 power script.
>> Workaround for TWL4030 erratum 27 is required for Si version less th=
an or
>> equal to TWL5030 ES1.1.
>>
> ...
>
>> This changes are tested on OMAP3430 & OMAP3630 SDP with off mode ena=
bled in suspend path.
> With the patches series applied and a board file change for
> Beagleboard (similar to patch 7/9 for SDP), the Beagleboard is not
> consistently booting. Most of the time it is hanging at boot, cf. dum=
p
> below. In the case it boots OK no voltage drop is observed when going
> to OFF mode.
>
> Uncompressing Linux... done, booting the kernel.
> [ =A0 =A00.000000] Linux version 2.6.39-rc5-09490-gf4c2b2b (def@defas=
us)
> (gcc version 4.4.1 (Sourcery G++ L
> ite 2010q1-202) ) #694 SMP Tue May 3 14:11:31 CEST 2011
> [ =A0 =A00.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7)=
, cr=3D10c53c7f
> [ =A0 =A00.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
> instruction cache
> [ =A0 =A00.000000] Machine: OMAP3 Beagle Board
> [ =A0 =A00.000000] bootconsole [earlycon0] enabled
> [ =A0 =A00.000000] Memory policy: ECC disabled, Data cache writeback
> [ =A0 =A00.000000] OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
> ...
> [ =A0 =A00.350830] OMAP3 Beagle Rev: Ax/Bx
> [ =A0 =A00.365203] omap_device: omap_uart.0: new worst case activate
> latency 0: 30517
> [ =A0 =A00.365570] omap_device: omap_uart.0: new worst case deactivat=
e
> latency 0: 30517
> [ =A0 =A00.385253] Found NAND on CS0
> [ =A0 =A00.388427] Registering NAND on CS0
> [ =A0 =A00.393585] Unable to get DVI reset GPIO
> [ =A0 =A00.398284] hw-breakpoint: debug architecture 0x4 unsupported.
> [ =A0 =A00.425659] OMAP DMA hardware revision 4.0
> [ =A0 =A00.509674] bio: create slab <bio-0> at 0
> [ =A0 =A00.526092] SCSI subsystem initialized
> [ =A0 =A00.531158] omap_device: omap2_mcspi.1: new worst case activat=
e
> latency 0: 30517
> [ =A0 =A00.541351] omap_device: omap2_mcspi.1: new worst case deactiv=
ate
> latency 0: 30517
> [ =A0 =A00.557586] usbcore: registered new interface driver usbfs
> [ =A0 =A00.564971] usbcore: registered new interface driver hub
> [ =A0 =A00.572082] usbcore: registered new device driver usb
> [ =A0 =A00.579925] omap_device: omap_i2c.1: new worst case activate l=
atency 0: 30517
> [ =A0 =A00.587768] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz
>
> AFAICT the main difference in the wiring is that the PMIC CLKREQ is
> not connected to the OMAP and is tied to VIO_1V8.
>
> Any thought on how to support the T2 scripts on Beagle?

I have not tested this script on Beagle board.

This script actually expects the clk_req to go low during off_mode.
So you can try removing the P3 from resource configuration struct for
VDD1/VDD2 & check the voltage rails during OFF.

Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
