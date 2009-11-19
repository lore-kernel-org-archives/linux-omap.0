From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v5 1/4] OMAP2/3: Add support for flash on SDP boards
Date: Thu, 19 Nov 2009 14:05:58 +0530
Message-ID: <ce9ab5790911190035n69c46a75s45ea9d4a725b27b@mail.gmail.com>
References: <ce9ab5790911100208j33822a11s5b521e69a94a08a3@mail.gmail.com>
	<20091112204042.GB24837@atomide.com> <ce9ab5790911180726q7eb27bc8g98c5f151d4e80362@mail.gmail.com>
	<20091118170308.GK29266@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47422 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbZKSIgN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 03:36:13 -0500
Received: by bwz27 with SMTP id 27so2046305bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 00:36:18 -0800 (PST)
In-Reply-To: <20091118170308.GK29266@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wed, Nov 18, 2009 at 10:33 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Vimal Singh <vimal.newwork@gmail.com> [091118 07:25]:
>> On Fri, Nov 13, 2009 at 2:10 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> > * Vimal Singh <vimal.newwork@gmail.com> [091110 02:08]:
>> >> From 42f080e0915bbce1509fc8ab3773569fec0a44f1 Mon Sep 17 00:00:00=
 2001
>> >> From: Vimal Singh <vimalsingh@ti.com>
>> >> Date: Tue, 10 Nov 2009 11:39:39 +0530
>> >> Subject: [PATCH] OMAP2/3: Add support for flash on SDP boards
>> >>
>>
>> [...]
>>
>> >> + =A0 =A0 if (!(__raw_readw(fpga_map_addr + REG_FPGA_REV)))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* we dont have an DEBUG FPGA??? */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Depend on #defines!! default to stra=
ta boot return param */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0x0;
>> >
>> > Should iounmap before returning, or goto unmap.
>>
>> will correct it in next version.
>>
>> >
>> >
>> >> + =A0 =A0 /* S8-DIP-OFF =3D 1, S8-DIP-ON =3D 0 */
>> >> + =A0 =A0 cs =3D __raw_readw(fpga_map_addr + REG_FPGA_DIP_SWITCH_=
INPUT2) & 0xf;
>> >> +
>> >> + =A0 =A0 /* ES2.0 SDP's onwards 4 dip switches are provided for =
CS */
>> >> + =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES1_0)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* change (S8-1:4=3DDS-2:0) to (S8-4:1=3D=
DS-2:0) */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cs =3D ((cs & 8) >> 3) | ((cs & 4) >> 1=
) |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((cs & 2) << 1) | ((cs =
& 1) << 3);
>> >> + =A0 =A0 else
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* change (S8-1:3=3DDS-2:0) to (S8-3:1=3D=
DS-2:0) */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cs =3D ((cs & 4) >> 2) | (cs & 2) | ((c=
s & 1) << 2);
>> >> +
>> >> + =A0 =A0 iounmap(fpga_map_addr);
>> >> + =A0 =A0 return cs;
>> >> +}
>> >> +
>> >> +/**
>> >> + * sdp3430_flash_init - Identify devices connected to GPMC and r=
egister.
>> >> + *
>> >> + * @return - void.
>> >> + */
>> >> +void __init sdp_flash_init(void)
>> >> +{
>> >> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs =3D 0;
>> >> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0nandcs =3D GPMC_CS_NUM + =
1;
>> >> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0onenandcs =3D GPMC_CS_NUM=
 + 1;
>> >> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0idx;
>> >> + =A0 =A0 unsigned char =A0 *config_sel =3D NULL;
>> >> +
>> >> + =A0 =A0 /* REVISIT: Is this return correct idx for 2430 SDP?
>> >> + =A0 =A0 =A0* for which cs configuration matches for 2430 SDP?
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 idx =3D get_gpmc0_type();
>> >> + =A0 =A0 if (idx >=3D MAX_SUPPORTED_GPMC_CONFIG) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Invalid chip selec=
t: %d\n", __func__, cs);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> >> + =A0 =A0 }
>> >> + =A0 =A0 config_sel =3D (unsigned char *)(chip_sel_sdp[idx]);
>> >> +
>> >> + =A0 =A0 /* Configure start address and size of NOR device */
>> >> + =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES1_0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.start =A0=3D FLASH_BAS=
E_SDPV2;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.end =A0 =A0=3D FLASH_B=
ASE_SDPV2
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 + FLASH_SIZE_SDPV2 - 1;
>> >> + =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.start =A0=3D FLASH_BAS=
E_SDPV1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.end =A0 =A0=3D FLASH_B=
ASE_SDPV1
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 + FLASH_SIZE_SDPV1 - 1;
>> >> + =A0 =A0 }
>> >
>> > This should be done with gpmc_cs_request using the chip select and=
 size.
>> > Please see gpmc_smc91x_init() for an example.
>>
>> I do not think this should be done with 'gpmc_cs_request'. NOR flash=
es
>> have been treated somehow differently.
>
> Can you please specify what the issue using gpmc_cs_request is?
>
> To me it seems that if you're not doing gpmc_cs_request, the gpmc can
> be in uninitialized state. I don't think we want to build our kernel
> assuming some hardcoded GPMC settings from the bootloader.

Sorry I was a bit confused. I will fix this too in my next version.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
