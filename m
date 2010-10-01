From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [omap3] Nand flash initialisation error
Date: Fri, 1 Oct 2010 11:32:26 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0356476FBF@dbde02.ent.ti.com>
References: <8959501C0BAF9F40956CEBAD13FB297F17F38C7574@EINTMBX.einet.ad.eivd.ch>
 <8959501C0BAF9F40956CEBAD13FB297F17F38C7575@EINTMBX.einet.ad.eivd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43023 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab0JAGCg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 02:02:36 -0400
In-Reply-To: <8959501C0BAF9F40956CEBAD13FB297F17F38C7575@EINTMBX.einet.ad.eivd.ch>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: GERBER Patrick <Patrick.Gerber@heig-vd.ch>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of GERBER Patrick
> Sent: Wednesday, September 29, 2010 7:35 PM
> To: GERBER Patrick; linux-omap@vger.kernel.org
> Subject: RE : [omap3] Nand flash initialisation error
>=20
> In complement to my previous mail I have found that if I only add a c=
all
> to gpmc_cs_request the info->phys_base is well initialized.
> So I could after call the platform_device_register as usual.
[Ghorai] I am agree with your. You can -=20
408   //if (platform_device_register(&omap3beagle_nand_device) < 0)
409   if (gpmc_nand_init(&omap3beagle_nand_data) < 0)
=20
>=20
> Anyway I still  have the bogus (but working) detection of the flash:
>=20
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron omap2-nand.=
0)
> NAND bus width 8 instead 16 bit
> No NAND device found.
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB=
 1,8V
> 16-bit)
>=20
> Any idea ?
[Ghorai] This is ok .. because _probe is common for all omap board. And=
 they have different NAND in different platform; and its check for any =
8x nand preset and followed by check if any 16x device preset. And code=
 as followes.

 877 static int __devinit omap_nand_probe(struct platform_device *pdev)
=2E.
 998         if (nand_scan(&info->mtd, 1)) {
 999                 info->nand.options ^=3D NAND_BUSWIDTH_16;
1000                 if (nand_scan(&info->mtd, 1)) {

>
[Ghorai] Are you still facing any issue other then this detection log?

=20
> ________________________________________
> De : linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.o=
rg]
> de la part de GERBER Patrick [Patrick.Gerber@heig-vd.ch]
> Date d'envoi : mercredi, 29. septembre 2010 14:05
> =C0 : linux-omap@vger.kernel.org
> Objet : [omap3] Nand flash initialisation error
>=20
> Hello,
>=20
> I am using 2.6.34.5 vanilla kernel on a gumstix over Fire using OMAP3=
530.
> I have some problems wit the nand flash (the chip on the top of the O=
MAP).
> The MTD partition is not created.
>=20
> When booting the board code is well detecting a Nand on CS0 and call =
the
> platform_device_register.
> The omap_nand_probe() fail with -16 (EBUSY) after calling
> request_mem_region() with 0 as a base address.
> So the info->phys_base is not initialized.
>=20
> After looking in older kernel I have tried to add a call
> gpmc_nand_init(&overo_nand_data) in my board code instead of the call=
 to
> platform_device_register.
> With this addition the Flash is well detected and the mtd partition
> created.
> But there is some errors due to misconfiguration of the flash (bus wi=
dth,
> detecting twice, ...). Of course my platform_device structure is not =
used
> because I have to pass only the omap_nand_platform_data struct to
> gpmc_nand_init().
>=20
>  (the ## prefixed lines are personal debug addition)
>=20
> ...
> Found NAND on CS0
> ## gpmc_baseaddr 0xfe000000, gpmc_cs_baseaddr 0xfe000060
> Registering NAND on CS0
> ...
> omap2-nand driver initializing
> ## omap_nand_probe
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron omap2-nand.=
0)
> NAND bus width 8 instead 16 bit
> No NAND device found.
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB=
 1,8V
> 16-bit)
> cmdlinepart partition parsing not available
> Creating 5 MTD partitions on "omap2-nand.0":
> ...
>=20
>=20
> I have looked on other board initialization (beagle, igep, ...)  and =
the
> code seems pretty similar.
> I would like to know if the call to gpmc_nand_init() is still necessa=
ry
> and why the detection is so hesitant ?
> I'd rather use the platform_device_register()  but I dont understand =
why
> the info->phys_base is 0 ?!?
>=20
> Thanks in advance for any help.
>=20
> Patrick--
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
