From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sat, 20 Oct 2012 16:11:36 +0200
Message-ID: <20121020141136.GA6433@netboy.at.omicron.at>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:53686 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885Ab2JTOLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 10:11:48 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so1014796wib.1
        for <linux-omap@vger.kernel.org>; Sat, 20 Oct 2012 07:11:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Oct 18, 2012 at 05:20:46AM +0000, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.7-rc1.
> Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/
> 
> 
> Changes from previous tests
> ---------------------------
> 
> Kernel configs have been reorganized and updated.  AM335x Beaglebone and
> OMAP4460 Pandaboard-ES boards have been added to the testbed.
> 
> 
> Passing tests
> -------------
> 
> Boot to userspace: 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
>                    4430es2panda, 5912osk, am335xbone
> 
> PM ret/off, suspend + dynamic idle: (none)

BeagleBone Rev. A6 does not boot v3.7-rc1, at least not for me.
I recently posted the missing patches needed to make it work (but the
patches are not by me).

Below I include the console log.

Thanks,
Richard


U-Boot SPL 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Using default environment

Net:   cpsw
Hit any key to stop autoboot:  3  0 
U-Boot# tftp 81000000 uImage
link up on port 0, speed 100, full duplex
Using cpsw device
TFTP from server 192.168.0.12; our IP address is 192.168.0.77
Filename 'uImage'.
Load address: 0x81000000
Loading: #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ################################
done
Bytes transferred = 3822248 (3a52a8 hex)
U-Boot#    tftp 82000000 beaglebone-initrd.gz
link up on port 0, speed 100, full duplex
Using cpsw device
TFTP from server 192.168.0.12; our IP address is 192.168.0.77
Filename 'beaglebone-initrd.gz'.
Load address: 0x82000000
Loading: #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #############
done
Bytes transferred = 2059309 (1f6c2d hex)
U-Boot#    tftp 80000000 am335x-bone.dtb
link up on port 0, speed 100, full duplex
Using cpsw device
TFTP from server 192.168.0.12; our IP address is 192.168.0.77
Filename 'am335x-bone.dtb'.
Load address: 0x80000000
Loading: #
done
Bytes transferred = 4391 (1127 hex)
U-Boot#    bootm 81000000 - 80000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.7.0-rc1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3822184 Bytes = 3.6 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80000000
   Booting using the fdt blob at 0x80000000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 8fe66000, end 8fe6a126 ... OK

Starting kernel ...

