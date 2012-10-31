From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Wed, 31 Oct 2012 14:24:36 +0000
Message-ID: <509134A4.708@mimc.co.uk>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com> <508FB226.20604@mimc.co.uk> <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com> <508FE8BA.1080404@ti.com> <50912A6F.1040501@mimc.co.uk> <79CD15C6BA57404B839C016229A409A83EB563F8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:43765 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422911Ab2JaOYh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 10:24:37 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB563F8@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 31/10/12 13:57, Hiremath, Vaibhav wrote:
> On Wed, Oct 31, 2012 at 19:11:03, Mark Jackson wrote:
>>
>> If I try the latest mainline U-Boot (or the TI branch), I just get to "Starting kernel ..." and then
>> hangs.
>>
> 
> 
> I am using Mainline u-boot and it works for me. Can you paste u-boot boot 
> log and environment variable here?

------------------------
mainline U-Boot boot log
------------------------
U-Boot SPL 2012.10-00434-ged296d2 (Oct 31 2012 - 14:18:50)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2012.10-00434-ged296d2 (Oct 31 2012 - 14:18:50)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Using default environment

Net:   cpsw
Hit any key to stop autoboot:  0
mmc0 is current device
SD/MMC found on device 0
reading uEnv.txt
29 bytes read
Loaded environment from uEnv.txt
Importing environment from mmc ...
4315695 bytes read
Booting from mmc ...
## Booting kernel from Legacy Image at 80200000 ...
   Image Name:   Linux-3.7.0-rc1-47802-ge7289dc-d
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4308448 Bytes = 4.1 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

------------------------
Contents of uEnv.txt
--------------------
mmcrootfstype=ext2 rootwait
