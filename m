From: GERBER Patrick <Patrick.Gerber@heig-vd.ch>
Subject: [omap3] Nand flash initialisation error
Date: Wed, 29 Sep 2010 14:05:00 +0200
Message-ID: <8959501C0BAF9F40956CEBAD13FB297F17F38C7574@EINTMBX.einet.ad.eivd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailcl0.heig-vd.ch ([193.134.216.181]:43348 "EHLO heig-vd.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750927Ab0I2OBd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 10:01:33 -0400
Received: from [10.192.41.20] (helo=eintfe.einet.ad.eivd.ch)
	by heig-vd.ch stage1 with esmtp
	(Exim MailCleaner)
	id 1P0vPA-0004Y8-UC
	for <linux-omap@vger.kernel.org>
	from <Patrick.Gerber@heig-vd.ch>; Wed, 29 Sep 2010 14:05:01 +0200
Content-Language: fr-CH
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

I am using 2.6.34.5 vanilla kernel on a gumstix over Fire using OMAP3530.
I have some problems wit the nand flash (the chip on the top of the OMAP). The MTD partition is not created.

When booting the board code is well detecting a Nand on CS0 and call the platform_device_register.
The omap_nand_probe() fail with -16 (EBUSY) after calling request_mem_region() with 0 as a base address.
So the info->phys_base is not initialized.

After looking in older kernel I have tried to add a call gpmc_nand_init(&overo_nand_data) in my board code instead of the call to platform_device_register. 
With this addition the Flash is well detected and the mtd partition created.
But there is some errors due to misconfiguration of the flash (bus width, detecting twice, ...). Of course my platform_device structure is not used because I have to pass only the omap_nand_platform_data struct to gpmc_nand_init(). 

 (the ## prefixed lines are personal debug addition)

...
Found NAND on CS0
## gpmc_baseaddr 0xfe000000, gpmc_cs_baseaddr 0xfe000060
Registering NAND on CS0
...
omap2-nand driver initializing
## omap_nand_probe
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron omap2-nand.0)
NAND bus width 8 instead 16 bit
No NAND device found.
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB 1,8V 16-bit)
cmdlinepart partition parsing not available
Creating 5 MTD partitions on "omap2-nand.0":
...


I have looked on other board initialization (beagle, igep, ...)  and the code seems pretty similar. 
I would like to know if the call to gpmc_nand_init() is still necessary and why the detection is so hesitant ? 
I'd rather use the platform_device_register()  but I dont understand why the info->phys_base is 0 ?!?

Thanks in advance for any help.

Patrick