From: GERBER Patrick <Patrick.Gerber@heig-vd.ch>
Subject: RE : [omap3] Nand flash initialisation error
Date: Wed, 29 Sep 2010 16:05:08 +0200
Message-ID: <8959501C0BAF9F40956CEBAD13FB297F17F38C7575@EINTMBX.einet.ad.eivd.ch>
References: <8959501C0BAF9F40956CEBAD13FB297F17F38C7574@EINTMBX.einet.ad.eivd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailcl1.heig-vd.ch ([193.134.216.182]:42025 "EHLO heig-vd.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751299Ab0I2OIp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 10:08:45 -0400
Received: from [10.192.41.22] (helo=eintfe.einet.ad.eivd.ch)
	by heig-vd.ch stage1 with esmtp
	(Exim MailCleaner)
	id 1P0xKt-0006rF-3X
	for <linux-omap@vger.kernel.org>
	from <Patrick.Gerber@heig-vd.ch>; Wed, 29 Sep 2010 16:08:43 +0200
In-Reply-To: <8959501C0BAF9F40956CEBAD13FB297F17F38C7574@EINTMBX.einet.ad.eivd.ch>
Content-Language: fr-CH
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: GERBER Patrick <Patrick.Gerber@heig-vd.ch>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

In complement to my previous mail I have found that if I only add a cal=
l to gpmc_cs_request the info->phys_base is well initialized.
So I could after call the platform_device_register as usual.

Anyway I still  have the bogus (but working) detection of the flash:

NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron omap2-nand.0)
NAND bus width 8 instead 16 bit
No NAND device found.
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB 1=
,8V 16-bit)

Any idea ?

________________________________________
De : linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org=
] de la part de GERBER Patrick [Patrick.Gerber@heig-vd.ch]
Date d'envoi : mercredi, 29. septembre 2010 14:05
=C0 : linux-omap@vger.kernel.org
Objet : [omap3] Nand flash initialisation error

Hello,

I am using 2.6.34.5 vanilla kernel on a gumstix over Fire using OMAP353=
0.
I have some problems wit the nand flash (the chip on the top of the OMA=
P). The MTD partition is not created.

When booting the board code is well detecting a Nand on CS0 and call th=
e platform_device_register.
The omap_nand_probe() fail with -16 (EBUSY) after calling request_mem_r=
egion() with 0 as a base address.
So the info->phys_base is not initialized.

After looking in older kernel I have tried to add a call gpmc_nand_init=
(&overo_nand_data) in my board code instead of the call to platform_dev=
ice_register.
With this addition the Flash is well detected and the mtd partition cre=
ated.
But there is some errors due to misconfiguration of the flash (bus widt=
h, detecting twice, ...). Of course my platform_device structure is not=
 used because I have to pass only the omap_nand_platform_data struct to=
 gpmc_nand_init().

 (the ## prefixed lines are personal debug addition)

=2E..
=46ound NAND on CS0
## gpmc_baseaddr 0xfe000000, gpmc_cs_baseaddr 0xfe000060
Registering NAND on CS0
=2E..
omap2-nand driver initializing
## omap_nand_probe
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron omap2-nand.0)
NAND bus width 8 instead 16 bit
No NAND device found.
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB 1=
,8V 16-bit)
cmdlinepart partition parsing not available
Creating 5 MTD partitions on "omap2-nand.0":
=2E..


I have looked on other board initialization (beagle, igep, ...)  and th=
e code seems pretty similar.
I would like to know if the call to gpmc_nand_init() is still necessary=
 and why the detection is so hesitant ?
I'd rather use the platform_device_register()  but I dont understand wh=
y the info->phys_base is 0 ?!?

Thanks in advance for any help.

Patrick--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
