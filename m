From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: NAND ECC in linux-omap
Date: Sat, 28 Aug 2010 02:06:42 +0530
Message-ID: <AANLkTinWS=bQ_LLrRsHsL9REvDUDkKX+=OWkjLQVq0BX@mail.gmail.com>
References: <AANLkTimABq72N98Ca6yJ9FgYnyDpod3qRPoTypkDn-4A@mail.gmail.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E8188DB@dbde02.ent.ti.com>
 <AANLkTik4+gApkw5fQ561QnJPLX5ED7oN3oU0P6F0+Gsv@mail.gmail.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E9299EA@dbde02.ent.ti.com>
 <AANLkTinuR_g53r4Q6a3LCmy4LR9ox8j7uCOFVB4OmRz4@mail.gmail.com>
 <AANLkTi=br81XgtJWE52NpE_0Kdbbpe6OTSXVAnhXDj2+@mail.gmail.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B031584E052@dbde02.ent.ti.com>
 <AANLkTi=n_ojiG=BY0AskW-AhTX1mt2hxauLxDSvyfh4b@mail.gmail.com>
 <AANLkTik3MADx8Vvp2z_KqqEG=oJEV8AQENMELCbAchBY@mail.gmail.com> <AANLkTinr_0iX9RyJ=S_0c7YL84LJX3q1anqWp16DMW_K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52628 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab0H0UhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 16:37:03 -0400
Received: by qyk9 with SMTP id 9so1044472qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 13:37:02 -0700 (PDT)
In-Reply-To: <AANLkTinr_0iX9RyJ=S_0c7YL84LJX3q1anqWp16DMW_K@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "Kamat, Nishant" <nskamat@ti.com>, linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>

Adding LO and MTD list too for more comments.

On Sat, Aug 28, 2010 at 1:40 AM, Vimal Singh <vimal.newwork@gmail.com> =
wrote:
> On Sat, Aug 28, 2010 at 12:00 AM, Cliff Brake <cliff.brake@gmail.com>=
 wrote:
>> On Fri, Aug 27, 2010 at 2:29 PM, Cliff Brake <cliff.brake@gmail.com>=
 wrote:
>>> On Fri, Aug 27, 2010 at 11:13 AM, Ghorai, Sukumar <s-ghorai@ti.com>=
 wrote:
>>>>
>>>>> -----Original Message-----
>>>>> From: Vimal Singh [mailto:vimal.newwork@gmail.com]
>>>>> Sent: Tuesday, August 24, 2010 10:41 PM
>>>>> To: Cliff Brake
>>>>> Cc: Ghorai, Sukumar; Linux OMAP Users; Kamat, Nishant
>>>>> Subject: Re: NAND ECC in linux-omap
>>>>>
>>>>> On Tue, Aug 24, 2010 at 8:04 PM, Cliff Brake <cliff.brake@gmail.c=
om>
>>>>> wrote:
>>>>> >
>>>>> > flash_erasall -j /dev/mtd4
>>>>>
>>>>> Give a try without using '-j' option... If ECC layout is the susp=
ect..
>>>>> this may help.
>>>> [Ghorai]
>>>> Cliff,
>>>> I did not able to spend much time on it to get into the problem.
>>>> But would you please try using these additional patch(4) that yet =
to upstream?
>>>> https://patchwork.kernel.org/patch/116554/
>>>> https://patchwork.kernel.org/patch/116553/
>>>> https://patchwork.kernel.org/patch/116555/
>>>> https://patchwork.kernel.org/patch/116556/
>>>> And select/change the proper ECC in -
>>>> arch/arm/mach-omap2/board-flash.c: line No.148;
>>>> board_nand_data.ecc_opt =A0 =A0 =A0 =A0 =3D OMAP_ECC_HAMMING_CODE_=
HW;
>>>
>>> Thanks for the patches. =A0Now I get the following:
>>>
>>> root@ts3:~# flash_eraseall /dev/mtd1
>>> Erasing 128 Kibyte @ 1c0000 -- 100 % complete.
>>> root@ts3:~# nandwrite -p /dev/mtd1 /media/mmcblk0p1/u-boot.bin
>>> Writing data to block 0 at offset 0x0
>>>
>>> And the operation hangs.
>
> Drop these patches. Please just give one more try after reverting las=
t
> 2 commits in omap2.c driver:
> 1. omap3 nand: cleanup virtual address usages
> and
> 2. omap3 gpmc: functionality enhancement
>
> I suspect something wrong with patch '2'. I will look into it more.

I can see the problem in '1' patch only. In this patch, see below chang=
e:

------------------------------------------

static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int =
ctrl)
 {
        struct omap_nand_info *info =3D container_of(mtd,
                                        struct omap_nand_info, mtd);
-       switch (ctrl) {
-       case NAND_CTRL_CHANGE | NAND_CTRL_CLE:
-               info->nand.IO_ADDR_W =3D info->gpmc_cs_baseaddr +
-                                               GPMC_CS_NAND_COMMAND;
-               info->nand.IO_ADDR_R =3D info->gpmc_cs_baseaddr +
-                                               GPMC_CS_NAND_DATA;
-               break;
-
-       case NAND_CTRL_CHANGE | NAND_CTRL_ALE:
-               info->nand.IO_ADDR_W =3D info->gpmc_cs_baseaddr +
-                                               GPMC_CS_NAND_ADDRESS;
-               info->nand.IO_ADDR_R =3D info->gpmc_cs_baseaddr +
-                                               GPMC_CS_NAND_DATA;
-               break;
-
-       case NAND_CTRL_CHANGE | NAND_NCE:
-               info->nand.IO_ADDR_W =3D info->gpmc_cs_baseaddr +
-                                               GPMC_CS_NAND_DATA;
-               info->nand.IO_ADDR_R =3D info->gpmc_cs_baseaddr +
-                                               GPMC_CS_NAND_DATA;
-               break;
-       }

-       if (cmd !=3D NAND_CMD_NONE)
-               __raw_writeb(cmd, info->nand.IO_ADDR_W);
+       if (cmd !=3D NAND_CMD_NONE) {
+               if (ctrl & NAND_CLE)
+                       gpmc_nand_write(info->gpmc_cs, GPMC_NAND_COMMAN=
D, cmd);
+
+               else if (ctrl & NAND_ALE)
+                       gpmc_nand_write(info->gpmc_cs, GPMC_NAND_ADDRES=
S, cmd);
+
+               else /* NAND_NCE */
+                       gpmc_nand_write(info->gpmc_cs, GPMC_NAND_DATA, =
cmd);
+       }
 }

---------------------------------------------

The new (changed) hwcontrol routine still can latch command and
address to correct gpmc nand registers. But it is failing to set '
info->nand.IO_ADDR_W' and 'info->nand.IO_ADDR_R'.
Which will be used by write/read routines to:  write to (IO_ADDR_W) or
read from (IO_ADDR_R).


--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
