From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards
Date: Wed, 18 Nov 2009 20:56:03 +0530
Message-ID: <ce9ab5790911180726q7eb27bc8g98c5f151d4e80362@mail.gmail.com>
References: <ce9ab5790911100208j33822a11s5b521e69a94a08a3@mail.gmail.com>
	<20091112204042.GB24837@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:62757 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104AbZKRP0S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 10:26:18 -0500
Received: by fxm21 with SMTP id 21so1299762fxm.21
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 07:26:23 -0800 (PST)
In-Reply-To: <20091112204042.GB24837@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, Nov 13, 2009 at 2:10 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Vimal Singh <vimal.newwork@gmail.com> [091110 02:08]:
>> From 42f080e0915bbce1509fc8ab3773569fec0a44f1 Mon Sep 17 00:00:00 20=
01
>> From: Vimal Singh <vimalsingh@ti.com>
>> Date: Tue, 10 Nov 2009 11:39:39 +0530
>> Subject: [PATCH] OMAP2/3: Add support for flash on SDP boards
>>

[...]

>> + =A0 =A0 if (!(__raw_readw(fpga_map_addr + REG_FPGA_REV)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* we dont have an DEBUG FPGA??? */
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Depend on #defines!! default to strata =
boot return param */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0x0;
>
> Should iounmap before returning, or goto unmap.

will correct it in next version.

>
>
>> + =A0 =A0 /* S8-DIP-OFF =3D 1, S8-DIP-ON =3D 0 */
>> + =A0 =A0 cs =3D __raw_readw(fpga_map_addr + REG_FPGA_DIP_SWITCH_INP=
UT2) & 0xf;
>> +
>> + =A0 =A0 /* ES2.0 SDP's onwards 4 dip switches are provided for CS =
*/
>> + =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES1_0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* change (S8-1:4=3DDS-2:0) to (S8-4:1=3DD=
S-2:0) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 cs =3D ((cs & 8) >> 3) | ((cs & 4) >> 1) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((cs & 2) << 1) | ((cs & 1=
) << 3);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* change (S8-1:3=3DDS-2:0) to (S8-3:1=3DD=
S-2:0) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 cs =3D ((cs & 4) >> 2) | (cs & 2) | ((cs &=
 1) << 2);
>> +
>> + =A0 =A0 iounmap(fpga_map_addr);
>> + =A0 =A0 return cs;
>> +}
>> +
>> +/**
>> + * sdp3430_flash_init - Identify devices connected to GPMC and regi=
ster.
>> + *
>> + * @return - void.
>> + */
>> +void __init sdp_flash_init(void)
>> +{
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs =3D 0;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0nandcs =3D GPMC_CS_NUM + 1;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0onenandcs =3D GPMC_CS_NUM + =
1;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0idx;
>> + =A0 =A0 unsigned char =A0 *config_sel =3D NULL;
>> +
>> + =A0 =A0 /* REVISIT: Is this return correct idx for 2430 SDP?
>> + =A0 =A0 =A0* for which cs configuration matches for 2430 SDP?
>> + =A0 =A0 =A0*/
>> + =A0 =A0 idx =3D get_gpmc0_type();
>> + =A0 =A0 if (idx >=3D MAX_SUPPORTED_GPMC_CONFIG) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Invalid chip select: =
%d\n", __func__, cs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> + =A0 =A0 config_sel =3D (unsigned char *)(chip_sel_sdp[idx]);
>> +
>> + =A0 =A0 /* Configure start address and size of NOR device */
>> + =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES1_0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.start =A0=3D FLASH_BASE_S=
DPV2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.end =A0 =A0=3D FLASH_BASE=
_SDPV2
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + FLASH_SIZE_SDPV2 - 1;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.start =A0=3D FLASH_BASE_S=
DPV1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.end =A0 =A0=3D FLASH_BASE=
_SDPV1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + FLASH_SIZE_SDPV1 - 1;
>> + =A0 =A0 }
>
> This should be done with gpmc_cs_request using the chip select and si=
ze.
> Please see gpmc_smc91x_init() for an example.

I do not think this should be done with 'gpmc_cs_request'. NOR flashes
have been treated somehow differently.

>
>
>> + =A0 =A0 if (platform_device_register(&sdp_nor_device) < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to register NOR de=
vice\n");
>> +
>> + =A0 =A0 while (cs < GPMC_CS_NUM) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (config_sel[cs]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PDC_NAND:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nandcs > GPMC_CS_NUM)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nandcs =3D=
 cs;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PDC_ONENAND:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (onenandcs > GPMC_CS_NU=
M)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 onenandcs =
=3D cs;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> + =A0 =A0 =A0 =A0 =A0 =A0 cs++;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (onenandcs > GPMC_CS_NUM)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OneNAND: Unable to find =
configuration "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " in GPMC\=
n ");
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 board_onenand_init(onenandcs);
>> +
>> + =A0 =A0 if (nandcs > GPMC_CS_NUM)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "NAND: Unable to find con=
figuration "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " in GPMC\=
n ");
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 board_nand_init(nandcs);
>> +}
>> diff --git a/arch/arm/plat-omap/include/plat/board-sdp.h
>> b/arch/arm/plat-omap/include/plat/board-sdp.h
>> new file mode 100644
>> index 0000000..632f21a
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/board-sdp.h
>> @@ -0,0 +1,15 @@
>> +/*
>> + * =A0arch/arm/plat-omap/include/plat/board-sdp.h
>> + *
>> + * =A0Information structures for SDP-specific board config data
>> + *
>> + * =A0Copyright (C) 2009 Nokia Corporation
>> + * =A0Copyright (C) 2009 Texas Instruments
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +extern void sdp_flash_init(void);
>> +
>> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h
>> b/arch/arm/plat-omap/include/plat/gpmc.h
>> index 9c99cda..c752ab7 100644
>> --- a/arch/arm/plat-omap/include/plat/gpmc.h
>> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
>> @@ -27,6 +27,8 @@
>>
>> =A0#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A00x50
>> =A0#define GPMC_STATUS =A0 =A0 =A0 =A0 =A00x54
>> +#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x60
>> +#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 0x30
>>
>> =A0#define GPMC_CONFIG1_WRAPBURST_SUPP =A0 =A0 (1 << 31)
>> =A0#define GPMC_CONFIG1_READMULTIPLE_SUPP =A0(1 << 30)
>> --
>> 1.5.5
>



--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
