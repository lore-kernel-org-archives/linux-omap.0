From: Mikko Rapeli <mikko.rapeli@teleca.com>
Subject: Beagleboard B6 woes
Date: Mon, 31 Aug 2009 12:38:10 +0300
Message-ID: <20090831093810.GE4927@fitfioullt278>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.telecasystems.de ([212.114.200.71]:59533 "EHLO
	mail.telecasystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbZHaJpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 05:45:49 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

I'd like to test out newer kernel on a Beagleboard B6 but latest
trees from Linus, linux-omap and linux-omap/for-next seem to be failing at
early boot [1] with omap3_beagle_defconfig.

Some bisecting shows that ARM_UNWIND broke something in the defconfig since
kernels before adf8b37bafc1495393201a2ae4235846371870d0 "[ARM] 5386/2:
unwind: Add Makefile and Kconfig entries for ARM stack unwinding" work.

On the other hand, setting ARM_UNWIND to n which falls back to FRAME_POINTERs
work until 84e250ffa76dddc1bad84e04248a27f442c25986 "musb: proper hookup to 
transceiver drivers".

So, is this just a broken config thing? Does anyone have a working
Beagleboard config for linux-2.6 or linux-omap trees?

Thanks,

-Mikko

[1] early boot failing example on Beagleboard:

## Booting kernel from Legacy Image at 80300000 ...
   Image Name:   Linux-2.6.31-rc8-00021-g36d568e-
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1760556 Bytes =  1.7 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux.............................................................


