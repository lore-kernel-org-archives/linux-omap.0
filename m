From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND
 Flash storage memory
Date: Mon, 30 Apr 2012 18:52:04 +0200
Message-ID: <CAAwP0s3WZRtAk87SWLgeEFaPCeSZzagrdHAXO66a-7ixs+QxAQ@mail.gmail.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
 <1333564586-3259-2-git-send-email-javier@dowhile0.org> <CAFqH_52ukhZ93idQoHaA_OwnouffeCkMYfNDhn1mdV8A8FBaBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49510 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433Ab2D3QwZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 12:52:25 -0400
Received: by yhmm54 with SMTP id m54so1524455yhm.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 09:52:25 -0700 (PDT)
In-Reply-To: <CAFqH_52ukhZ93idQoHaA_OwnouffeCkMYfNDhn1mdV8A8FBaBA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Wed, Apr 25, 2012 at 10:00 AM, Enric Balletb=C3=B2 i Serra
<eballetbo@gmail.com> wrote:
> 2012/4/4 Javier Martinez Canillas <javier@dowhile0.org>:
>> IGEP-based boards can have two different flash memories, a OneNAND o=
r
>> a NAND device. The boot configuration pins (sys_boot) are used to
>> specify which memory is available.
>>
>> Also, this patch removes unnecesary code for registering the OneNAND=
=2E
>>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0 75 +++++++++++++=
+--------------------
>> =C2=A01 files changed, 31 insertions(+), 44 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-om=
ap2/board-igep0020.c
>> index 930c0d3..4af615a 100644
>> --- a/arch/arm/mach-omap2/board-igep0020.c
>> +++ b/arch/arm/mach-omap2/board-igep0020.c
>> @@ -24,6 +24,8 @@
>> =C2=A0#include <linux/i2c/twl.h>
>> =C2=A0#include <linux/mmc/host.h>
>>
>> +#include <linux/mtd/nand.h>
>> +
>> =C2=A0#include <asm/mach-types.h>
>> =C2=A0#include <asm/mach/arch.h>
>>
>> @@ -39,6 +41,8 @@
>> =C2=A0#include "hsmmc.h"
>> =C2=A0#include "sdram-numonyx-m65kxxxxam.h"
>> =C2=A0#include "common-board-devices.h"
>> +#include "board-flash.h"
>> +#include "control.h"
>>
>> =C2=A0#define IGEP2_SMSC911X_CS =C2=A0 =C2=A0 =C2=A0 5
>> =C2=A0#define IGEP2_SMSC911X_GPIO =C2=A0 =C2=A0 176
>> @@ -60,6 +64,10 @@
>> =C2=A0#define IGEP3_GPIO_LED1_RED =C2=A0 =C2=A016
>> =C2=A0#define IGEP3_GPIO_USBH_NRESET =C2=A0183
>>
>> +#define IGEP_SYSBOOT_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1f
>> +#define IGEP_SYSBOOT_NAND =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0f
>> +#define IGEP_SYSBOOT_ONENAND =C2=A0 =C2=A0 =C2=A0 =C2=A00x10
>> +
>> =C2=A0/*
>> =C2=A0* IGEP2 Hardware Revision Table
>> =C2=A0*
>> @@ -110,8 +118,10 @@ static void __init igep2_get_revision(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_free(IGEP2_GPIO_LED1_RED);
>> =C2=A0}
>>
>> -#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
>> - =C2=A0 =C2=A0 =C2=A0 defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
>> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 \
>> + =C2=A0 =C2=A0 =C2=A0 defined(CONFIG_MTD_ONENAND_OMAP2_MODULE) || =C2=
=A0 =C2=A0 \
>> + =C2=A0 =C2=A0 =C2=A0 defined(CONFIG_MTD_NAND_OMAP2) || =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> + =C2=A0 =C2=A0 =C2=A0 defined(CONFIG_MTD_NAND_OMAP2_MODULE)
>>
>> =C2=A0#define ONENAND_MAP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x20000000
>>
>> @@ -123,7 +133,7 @@ static void __init igep2_get_revision(void)
>> =C2=A0* So MTD regards it as 4KiB page size and 256KiB block size 64=
*(2*2048)
>> =C2=A0*/
>>
>> -static struct mtd_partition igep_onenand_partitions[] =3D {
>> +static struct mtd_partition igep_flash_partitions[] =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "X-Loader",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.offset =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 0,
>> @@ -151,50 +161,27 @@ static struct mtd_partition igep_onenand_parti=
tions[] =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
>> =C2=A0};
>>
>> -static struct omap_onenand_platform_data igep_onenand_data =3D {
>> - =C2=A0 =C2=A0 =C2=A0 .parts =3D igep_onenand_partitions,
>> - =C2=A0 =C2=A0 =C2=A0 .nr_parts =3D ARRAY_SIZE(igep_onenand_partiti=
ons),
>> - =C2=A0 =C2=A0 =C2=A0 .dma_channel =C2=A0 =C2=A0=3D -1, =C2=A0 /* d=
isable DMA in OMAP OneNAND driver */
>> -};
>> -
>> -static struct platform_device igep_onenand_device =3D {
>> - =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D =
"omap2-onenand",
>> - =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D -1,
>> - =C2=A0 =C2=A0 =C2=A0 .dev =3D {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =3D=
 &igep_onenand_data,
>> - =C2=A0 =C2=A0 =C2=A0 },
>> -};
>> +static inline u32 igep_get_sysboot_value(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 return omap_ctrl_readl(OMAP343X_CONTROL_STATU=
S) & IGEP_SYSBOOT_MASK;
>> +}
>>
>> =C2=A0static void __init igep_flash_init(void)
>> =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0 u8 cs =3D 0;
>> - =C2=A0 =C2=A0 =C2=A0 u8 onenandcs =3D GPMC_CS_NUM + 1;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 for (cs =3D 0; cs < GPMC_CS_NUM; cs++) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 ret;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gpmc_cs_r=
ead_reg(cs, GPMC_CS_CONFIG1);
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if NAND/=
oneNAND is configured */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((ret & 0xC00)=
 =3D=3D 0x800)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* NAND found */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pr_err("IGEP: Unsupported NAND found\n");
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if ((ret & 0x3F) =3D=3D (ONENAND_MAP >> 24))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ONENAND found */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 onenandcs =3D cs;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> - =C2=A0 =C2=A0 =C2=A0 }
>> -
>> - =C2=A0 =C2=A0 =C2=A0 if (onenandcs > GPMC_CS_NUM) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("IGEP: Una=
ble to find configuration in GPMC\n");
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> - =C2=A0 =C2=A0 =C2=A0 }
>> -
>> - =C2=A0 =C2=A0 =C2=A0 igep_onenand_data.cs =3D onenandcs;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 if (platform_device_register(&igep_onenand_de=
vice) < 0)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("IGEP: Una=
ble to register OneNAND device\n");
>> + =C2=A0 =C2=A0 =C2=A0 u32 mux;
>> + =C2=A0 =C2=A0 =C2=A0 mux =3D igep_get_sysboot_value();
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (mux =3D=3D IGEP_SYSBOOT_NAND) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("IGEP: in=
itializing NAND memory device\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 board_nand_init(i=
gep_flash_partitions,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARRAY_SIZE(igep_flash_partitions=
),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, NAND_BUSWIDTH_16);
>> + =C2=A0 =C2=A0 =C2=A0 } else if (mux =3D=3D IGEP_SYSBOOT_ONENAND) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("IGEP: in=
itializing OneNAND memory device\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 board_onenand_ini=
t(igep_flash_partitions,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(igep_fla=
sh_partitions), 0);
>> + =C2=A0 =C2=A0 =C2=A0 } else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("IGEP: Fla=
sh: unsupported sysboot sequence found\n");
>> =C2=A0}
>>
>> =C2=A0#else
>> --
>> 1.7.7.6
>>
>
> Seems good to me.
>
> Tony, as this is a fix ,may be included ?
>
> Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>
> Cheers,
> =C2=A0 =C2=A0Enric
> --

Tony,

Can you please merge this patch and:

[RESEND PATCH 1/2] ARM: OMAP2+: nand: Make board_onenand_init()
visible to board code

I've sent this two patches several times and no one is against them. I
also had positive feedback such as Enric's acked-by

These two patches are a fix and needed to boot newer versions of the
IGEPv2 board. Without the patches the board doesn't even boot.

Please tell me if you need me to resend the patches.

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
