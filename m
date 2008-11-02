From: "Ming Lei" <tom.leiming@gmail.com>
Subject: can't boot Linux-2.6.28-rc2-omap1
Date: Sun, 2 Nov 2008 10:47:37 +0800
Message-ID: <d82e647a0811011947i6ab62cf6w463ea462ce49183c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:42206 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYKBCri (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Nov 2008 22:47:38 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard@googlegroups.com, inux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi All,

I am working on testing Linux-2.6.28-rc2 omap kernel on beagle board, and uImage
is compiled from linux-omp git tree in the following way:

     export  CROSS_COMPILE=arm-none-linux-gnueabi-
     make distclean
     make  omap3_beagle_defconfig
     make uImage

Then the boot messages :

-------------------------------------------------------------
    OMAP3 beagleboard.org # mmcinit;fatload mmc 0 0x80300000 ui3
reading ui3

1723104 bytes read
OMAP3 beagleboard.org # bootm 0x80300000
## Booting kernel from Legacy Image at 80300000 ...
   Image Name:   Linux-2.6.28-rc2-omap1-05147-g82
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1723040 Bytes =  1.6 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux...................................................................................
............................ done, booting the kernel.
--------------------------------------------------------------
and it stucks at here.

Thanks for your Helps.



-- 
Lei Ming
