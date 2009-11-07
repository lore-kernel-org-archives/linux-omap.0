From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: Config problem I suspect
Date: Sat, 07 Nov 2009 00:24:38 +0000
Message-ID: <4AF4BE46.7040402@blueyonder.co.uk>
References: <4AF42564.6090402@blueyonder.co.uk> <4AF44D0E.8040208@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:48562 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751476AbZKGAYk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 19:24:40 -0500
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N6Z6i-0003xS-NA
	for linux-omap@vger.kernel.org; Sat, 07 Nov 2009 00:24:44 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1N6Z6i-0001uq-6b
	for linux-omap@vger.kernel.org; Sat, 07 Nov 2009 00:24:44 +0000
In-Reply-To: <4AF44D0E.8040208@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 06/11/09 16:21, Sid Boyce wrote:
> On 06/11/09 13:32, Sid Boyce wrote:
>> I have been trying the linux-2.6.32-rc5-omap-dss2 kernel and it halts
>> with a USB error, DEBUG_LL configured.
>> Reading boot sector
>> Loading u-boot.bin from mmc
>>
>>
>> U-Boot 2009.01-dirty (Feb 19 2009 - 12:23:21)
>>
>> I2C:   ready
>> OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
>> OMAP3 Beagle board + LPDDR/NAND
>> DRAM:  256 MB
>> NAND:  256 MiB
>> Using default environment
>>
>> MUSB: using high speed
>> In:    serial usbtty
>> Out:   serial usbtty
>> Err:   serial usbtty
>> Board revision C
>> Serial #6b22000300000000040323090d00a00a
>> Hit any key to stop autoboot:  0
>> reading boot.scr
>>
>> 679 bytes read
>> Running bootscript from mmc ...
>> ## Executing script at 80200000
>> reading x-load.bin.ift
>>
>> 19840 bytes read
>> ***** Replacing x-load *****
>> Usage:
>> nand - NAND sub-system
>>
>> HW ECC selected
>>
>> NAND erase: device 0 offset 0x0, size 0x80000
>> ^MErasing at 0x0 --  25% complete.^MErasing at 0x20000 --  50%
>> complete.^MErasing at 0x40000 --  75% complete.^MErasing at 0x60000 --
>> 100% complete.
>> OK
>>
>> NAND write: device 0 offset 0x0, size 0x20000
>>  131072 bytes written: OK
>>
>> NAND write: device 0 offset 0x20000, size 0x20000
>>  131072 bytes written: OK
>>
>> NAND write: device 0 offset 0x40000, size 0x20000
>>  131072 bytes written: OK
>>
>> NAND write: device 0 offset 0x60000, size 0x20000
>>  131072 bytes written: OK
>> reading u-boot-f.bin
>>
>> ** Unable to read "u-boot-f.bin" from mmc 0:1 **
>> ***** Erasing environment settings *****
>> Usage:
>> nand - NAND sub-system
>>
>>
>> NAND erase: device 0 offset 0x160000, size 0x20000
>> ^MErasing at 0x160000 -- 100% complete.
>> OK
>> reading normal.scr
>>
>> 603 bytes read
>> ***** Executing normal.scr *****
>> ## Executing script at 80200000
>> reading uImage.bin
>>
>> 3160016 bytes read
>> ***** Kernel: /dev/mmcblk0p1/uImage.bin *****
>> reading ramdisk.gz
>>
>> ** Unable to read "ramdisk.gz" from mmc 0:1 **
>> ***** RootFS: /dev/mmcblk0p2 *****
>> ## Booting kernel from Legacy Image at 80200000 ...
>>    Image Name:   Linux-2.6.32-rc5-omap-dss2
>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>>    Data Size:    3159952 Bytes =  3 MB
>>    Load Address: 80008000
>>    Entry Point:  80008000
>>    Verifying Checksum ... OK
>>    Loading Kernel Image ... OK
>> OK
>>
>> Starting kernel ...
>>
>> Error, the USB hardware is not on B mode
>>
I got 2.6.32-rc5 git to boot, except it stops for half an hour at the
above error message, then proceeds to the login prompt.
The 2.6.32-rc5-omap-dss2 git kernel did likewise, except it never got to
the login prompt.
I am getting no DVI output.

Configuring in omapfb in 2.6.32-rc6 git, build fails.......
  LD      drivers/video/display/built-in.o
  CC      drivers/video/logo/logo.o
  LD      drivers/video/logo/built-in.o
  LD      drivers/video/omap/built-in.o
  CC [M]  drivers/video/omap/omapfb_main.o
  CC [M]  drivers/video/omap/dispc.o
  CC [M]  drivers/video/omap/lcd_omap3beagle.o
  CC [M]  drivers/video/omap/lcd_mipid.o
  LD [M]  drivers/video/omap/omapfb.o
drivers/video/omap/lcd_omap3beagle.o: In function `init_module':
lcd_omap3beagle.c:(.init.text+0x0): multiple definition of `init_module'
drivers/video/omap/omapfb_main.o:omapfb_main.c:(.init.text+0x0): first
defined here
drivers/video/omap/lcd_omap3beagle.o: In function `cleanup_module':
lcd_omap3beagle.c:(.exit.text+0x0): multiple definition of `cleanup_module'
drivers/video/omap/omapfb_main.o:omapfb_main.c:(.exit.text+0x0): first
defined here
drivers/video/omap/lcd_mipid.o: In function `init_module':
lcd_mipid.c:(.text+0xbe8): multiple definition of `init_module'
drivers/video/omap/omapfb_main.o:omapfb_main.c:(.init.text+0x0): first
defined here
drivers/video/omap/lcd_mipid.o: In function `cleanup_module':
lcd_mipid.c:(.text+0xbdc): multiple definition of `cleanup_module'
drivers/video/omap/omapfb_main.o:omapfb_main.c:(.exit.text+0x0): first
defined here
make[3]: *** [drivers/video/omap/omapfb.o] Error 1
make[2]: *** [drivers/video/omap] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

