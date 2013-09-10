From: Nishanth Menon <nm@ti.com>
Subject: Re: Vanilla kernel 3.11.0 boot problem on Pandaboard.
Date: Tue, 10 Sep 2013 07:38:10 -0500
Message-ID: <522F12B2.30803@ti.com>
References: <522E2CD8.4050704@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47735 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab3IJMiM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Sep 2013 08:38:12 -0400
In-Reply-To: <522E2CD8.4050704@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sboyce@blueyonder.co.uk
Cc: linux-omap@vger.kernel.org

On 09/09/2013 03:17 PM, Sid Boyce wrote:
> I built the kernel-headers and kernel-image .deb packages using 
> make-kpkg native on the 3.18.3.6 kernel.
> 
> The package installs created new uEnv.txt, uImage an uInitrd.
> 
> Do I need an updated uboot for 3.11?
> 
> [125588.918060] Restarting system.
> 
> Serial console log
> ===========
> U-Boot SPL 2011.12-00002-g1bdc71d (Feb 13 2012 - 18:52:25)
> Texas Instruments OMAP4430 ES2.3
> OMAP SD/MMC: 0
> reading u-boot.img
> reading u-boot.img
> 
> 
> U-Boot 2011.12-00002-g1bdc71d (Feb 13 2012 - 18:52:25)
> 
> CPU  : OMAP4430 ES2.3
> Board: OMAP4 Panda
> I2C:   ready
> DRAM:  1 GiB
> MMC:   OMAP SD/MMC: 0
> Using default environment
> 
> In:    serial
> Out:   serial
> Err:   serial
> Hit any key to stop autoboot:  0
> SD/MMC found on device 0
> reading uEnv.txt
> 
> 119 bytes read
> Loaded environment from uEnv.txt
> Importing environment from mmc ...
> Running uenvcmd ...
> reading uImage
> 
> 4039336 bytes read
> reading uInitrd
> 


Missing dtb load? 3.11 onwards we are purely device tree for OMAP4.

> 2187985 bytes read
> ## Booting kernel from Legacy Image at 80000000 ...
>     Image Name:   kernel 3.11.0-07887-gb409624-dir
>     Image Type:   ARM Linux Kernel Image (uncompressed)
>     Data Size:    4039272 Bytes = 3.9 MiB
>     Load Address: 80008000
>     Entry Point:  80008000
>     Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at 81600000 ...
>     Image Name:   ramdisk 3.11.0-07887-gb409624-di
>     Image Type:   ARM Linux RAMDisk Image (gzip compressed)
>     Data Size:    2187921 Bytes = 2.1 MiB
>     Load Address: 00000000
>     Entry Point:  00000000
>     Verifying Checksum ... OK
>     Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> Regards
> Sid.
> 


-- 
Regards,
Nishanth Menon
