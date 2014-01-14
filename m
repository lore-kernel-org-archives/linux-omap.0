From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v1 0/2] mtd: nand: omap: booting from NAND using u-boot
Date: Tue, 14 Jan 2014 15:27:24 +0100
Message-ID: <CAFqH_51EuZ9BgcuPGSK_9dorDs4hWTrQsACLZZ20=hpgWkNY2w@mail.gmail.com>
References: <1386925978-23705-1-git-send-email-pekon@ti.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA5E07C@DBDE04.ent.ti.com>
	<52CA97FC.4020300@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33966 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaANO10 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2014 09:27:26 -0500
Received: by mail-wi0-f175.google.com with SMTP id hr1so779058wib.14
        for <linux-omap@vger.kernel.org>; Tue, 14 Jan 2014 06:27:24 -0800 (PST)
In-Reply-To: <52CA97FC.4020300@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: "Gupta, Pekon" <pekon@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Igor Grinberg <grinberg@compulab.co.il>, Michael Trimarchi <michael@amarulasolutions.com>, Nikita Kiryanov <nikita@compulab.co.il>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, Artem Bityutskiy <dedekind1@gmail.com>, Brian Norris <computersforpeace@gmail.com>, "Rini, Tom" <trini@ti.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "r.meier@siemens.com" <r.meier@siemens.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Scott Wood <scottwood@freescale.com>linux-omap <linux->

Hi Pekon,

2014/1/6 Stefan Roese <sr@denx.de>:
> Hi Pekon,
>
> On 06.01.2014 08:40, Gupta, Pekon wrote:
>> Hello Enric, Nikita, and other OMAP3 users,
>>
>>>
>>> As there were parallel set of patches running between u-boot and kernel.
>>> hence, some patch-sets caused regression for OMAP3x platforms when booting
>>> using u-boot specifically for ecc-schemes (like BCH4_SW).
>>>
>>> Hence this patch series fixes those regressions, and tests complete
>>> NAND boot sequence for multiple ecc-schemes on AM335x-EVM board.
>>> (following configurations are required for building u-boot driver which is
>>> compatible to kernel ecclayout for selected ecc-scheme)
>>>
>>>
>>>    (BCH8_HW)      (HAM1_HW)         (HAM1_HW)         (HAM1_HW)  (UBIFS)
>>> ROM ---------> SPL ---------> U-Boot ---------> Kernel ---------> File-System
>>>
>>>    (BCH8_HW)      (BCH8_SW)         (BCH8_SW)         (BCH8_SW)  (UBIFS)
>>> ROM ---------> SPL ---------> U-Boot ---------> Kernel ---------> File-System
>>>
>>>    (BCH8_HW)      (BCH8_HW)         (BCH8_HW)         (BCH8_HW)  (UBIFS)
>>> ROM ---------> SPL ---------> U-Boot ---------> Kernel ---------> File-System
>>>
>>> *Configurations used to build u-boot and kernel for end-to-end NAND boot*
>>> +------------+--------------------------------------------+------------------+
>>> | ecc-scheme |  u-boot/SPL configs                        | kernel DTS       |
>>> +------------+--------------------------------------------+------------------+
>>> |            |                                            |                  |
>>> | HAM1_HW    | #define CONFIG_NAND_OMAP_ECCSCHEME     \   |ti,nand-ecc-opts= |
>>> |            |         OMAP_ECC_HAM1_CODE_HW              |    "ham1"        |
>>> | (1-bit     | #define CONFIG_SYS_NAND_ECCBYTES       3   |                  |
>>> | Hamming    | #define CONFIG_SYS_NAND_ECCPOS \           |                  |
>>> | using h/w) |      { 1, 2, 3, 4, 5, 6, 7, 8, 9, \        |                  |
>>> |            |        10, 11, 12 }                        |                  |
>>> |            | (for NAND page-size=2048)                  |                  |
>>> |            |                                            |                  |
>>> +------------+--------------------------------------------+------------------+
>>> |            |                                            |                  |
>>> | BCH8_SW    | #define CONFIG_NAND_OMAP_ECCSCHEME    \    |ti,nand-ecc-opts= |
>>> |            |         OMAP_ECC_BCH8_CODE_HW_DETECTION_SW |    "bch8"        |
>>> |(8-bit BCH  | #define CONFIG_SYS_NAND_ECCBYTES       13  |(without ELM node)|
>>> | using s/w  | #define CONFIG_BCH                         |                  |
>>> |library for | #undef CONFIG_SPL_NAND_AM33XX_BCH          |                  |
>>> |for ECC     | #define CONFIG_SPL_NAND_SIMPLE             |                  |
>>> | error      | #define CONFIG_SYS_NAND_ECCPOS \           |                  |
>>> |correction) |     {2,  3,  4,  5,  6,  7,  8,  9, 10, \  |                  |
>>> |            |     11, 12, 13, 14, \                      |                  |
>>> |            |     16, 17, 18, 19, 20, 21, 22, 23, 24, \  |                  |
>>> |            |     25, 26, 27, 28, \                      |                  |
>>> |            |     30, 31, 32, 33, 34, 35, 36, 37, 38, \  |                  |
>>> |            |     39, 40, 41, 42, \                      |                  |
>>> |            |     44, 45, 46, 47, 48, 49, 50, 51, 52, \  |                  |
>>> |            |     53, 54, 55, 56, }                      |                  |
>>> |            | (for NAND page-size=2048)                  |                  |
>>> |            | #define CONFIG_SYS_NAND_ECCSIZE       512  |                  |
>>> |            |                                            |                  |
>>> +------------+--------------------------------------------+------------------+
>>> |            |                                            |                  |
>>> | BCH8_HW    | #define CONFIG_NAND_OMAP_ECCSCHEME    \    |ti,nand-ecc-opts= |
>>> |            |         OMAP_ECC_BCH8_CODE_HW              |    "bch8"        |
>>> |(8-bit BCH  | #define CONFIG_SYS_NAND_ECCBYTES       14  |                  |
>>> | using ELM  | #define CONFIG_SPL_NAND_AM33XX_BCH         |(with ELM node)   |
>>> | h/w engine | #define CONFIG_SYS_NAND_ECCPOS  \          |ti,elm-id=<&elm>  |
>>> |for ECC     |       {2,  3,  4,  5,  6,  7,  8,  9, \    |                  |
>>> | error      |       10, 11, 12, 13, 14, 15, 16, 17, \    |                  |
>>> |correction) |       18, 19, 20, 21, 22, 23, 24, 25, \    |                  |
>>> |            |       26, 27, 28, 29, 30, 31, 32, 33, \    |                  |
>>> |            |       34, 35, 36, 37, 38, 39, 40, 41, \    |                  |
>>> |            |       42, 43, 44, 45, 46, 47, 48, 49, \    |                  |
>>> |            |       50, 51, 52, 53, 54, 55, 56, 57, }    |                  |
>>> |            | (for NAND page-size=2048)                  |                  |
>>> |            | #define CONFIG_SYS_NAND_ECCSIZE       512  |                  |
>>> |            |                                            |                  |
>>> +------------+--------------------------------------------+------------------+
>>>
>>> #* In addition following patches need to be pulled for u-boot:
>>>   http://lists.denx.de/pipermail/u-boot/2013-December/168506.html
>>>   http://lists.denx.de/pipermail/u-boot/2013-December/169021.html
>>>
>>>
>>> Test1: flash ubi image from u-boot and boot the kernel
>>>   U-boot> mw 0x82000000 0xff <u-boot.img size aligned to NAND block boundary>
>>>   U-boot> fatload mmc 0 0x82000000 u-boot.img
>>>   U-boot> nand erase <u-boot_offset> <u-boot.img size>
>>>   U-boot> nand write 0x82000000  <u-boot_offset> <u-boot.img size>
>>>   U-boot> setenv bootargs 'console=ttyO0,115200n8 noinitrd mem=256M \
>>>                root=ubi0 rw rootfstype=ubifs ubi.mtd=<mtdpart-of-rootfs>,\
>>>                <page-size> ip=off init=/init'
>>>   U-boot> bootm <kernel_offset>
>>>
>>> Test2: update u-boot.img from kernel and re-boot
>>>   Kernel> flash_erase /dev/<mtdpart-of-u-boot>  0 0
>>>   Kernel> nandwrite -s 0  /dev/<mtdpart-of-u-boot>   u-boot.img
>>>   Kernel> reboot
>>>
>>> Signed-off-by: Pekon Gupta <pekon@ti.com>
>>> ---
>>
>> Though I have done initial level of testing on AM335x as mentioned above,
>> But will it be possible for you to test and confirm if these set of patches
>> solve regressions on your OMAP3 boards ?
>
> Those patches work fine on our custom AM335x board. So:
>
> Tested-by: Stefan Roese <sr@denx.de>
>
> Thanks,
> Stefan
>

Sorry for this long delay, I'm doing this in my free time and
sometimes it's difficult to find the time. Those patches also worked
on my OMAP3 boards so

Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>

Many thanks for your great work.

Best Regards,
   Enric

>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
