From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Config problem I suspect
Date: Fri, 6 Nov 2009 19:09:44 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A704F24@dbde02.ent.ti.com>
References: <4AF42564.6090402@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56416 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757997AbZKFNjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 08:39:45 -0500
In-Reply-To: <4AF42564.6090402@blueyonder.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "sboyce@blueyonder.co.uk" <sboyce@blueyonder.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sid Boyce wrote:
> I have been trying the linux-2.6.32-rc5-omap-dss2 kernel and it halts
> with a USB error, DEBUG_LL configured.
> Reading boot sector
> Loading u-boot.bin from mmc
> 
> 
> U-Boot 2009.01-dirty (Feb 19 2009 - 12:23:21)
> 
> I2C:   ready
> OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
> OMAP3 Beagle board + LPDDR/NAND
> DRAM:  256 MB
> NAND:  256 MiB
> Using default environment
> 
> MUSB: using high speed
> In:    serial usbtty
> Out:   serial usbtty
> Err:   serial usbtty
> Board revision C
> Serial #6b22000300000000040323090d00a00a
> Hit any key to stop autoboot:  0
> reading boot.scr
> 
> 679 bytes read
> Running bootscript from mmc ...
> ## Executing script at 80200000
> reading x-load.bin.ift
> 
> 19840 bytes read
> ***** Replacing x-load *****
> Usage:
> nand - NAND sub-system
> 
> HW ECC selected
> 
> NAND erase: device 0 offset 0x0, size 0x80000
> ^MErasing at 0x0 --  25% complete.^MErasing at 0x20000 --  50%
> complete.^MErasing at 0x40000 --  75% complete.^MErasing at 0x60000 --
> 100% complete.
> OK
> 
> NAND write: device 0 offset 0x0, size 0x20000
>  131072 bytes written: OK
> 
> NAND write: device 0 offset 0x20000, size 0x20000
>  131072 bytes written: OK
> 
> NAND write: device 0 offset 0x40000, size 0x20000
>  131072 bytes written: OK
> 
> NAND write: device 0 offset 0x60000, size 0x20000
>  131072 bytes written: OK
> reading u-boot-f.bin
> 
> ** Unable to read "u-boot-f.bin" from mmc 0:1 **
> ***** Erasing environment settings *****
> Usage:
> nand - NAND sub-system
> 
> 
> NAND erase: device 0 offset 0x160000, size 0x20000
> ^MErasing at 0x160000 -- 100% complete.
> OK
> reading normal.scr
> 
> 603 bytes read
> ***** Executing normal.scr *****
> ## Executing script at 80200000
> reading uImage.bin
> 
> 3160016 bytes read
> ***** Kernel: /dev/mmcblk0p1/uImage.bin *****
> reading ramdisk.gz
> 
> ** Unable to read "ramdisk.gz" from mmc 0:1 **
> ***** RootFS: /dev/mmcblk0p2 *****
> ## Booting kernel from Legacy Image at 80200000 ...
>    Image Name:   Linux-2.6.32-rc5-omap-dss2
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3159952 Bytes =  3 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> Error, the USB hardware is not on B mode
> 

I don't think this error comes from the stock linux-omap kernel.
Can you locate it in the kernel that you compiled? (grep -r maybe?)

Or in your u-boot?


Do you have a USB cable connected? Is the ID pin on the connector
connected to the USBOTG port on your board accidentally grounded?

- Anand
