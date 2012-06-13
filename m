From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH V2 1/5] ARM: OMAP3EVM: Add NAND flash definition
Date: Wed, 13 Jun 2012 16:16:34 +0800
Message-ID: <4FD84C62.1060206@windriver.com>
References: <zumeng.chen@gmail.com> <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com> <1339551850-20827-2-git-send-email-zumeng.chen@gmail.com> <4FD84803.2090006@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <4FD84803.2090006@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Zumeng Chen <zumeng.chen@gmail.com>, tony@atomide.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Afzal Mohammed <afzal@ti.com>
List-Id: linux-omap@vger.kernel.org

=E4=BA=8E 2012=E5=B9=B406=E6=9C=8813=E6=97=A5 15:57, Igor Grinberg =E5=86=
=99=E9=81=93:
> On 06/13/12 04:44, Zumeng Chen wrote:
>> From: Zumeng Chen<zumeng.chen@windriver.com>
>>
>> Signed-off-by: Vaibhav Hiremath<hvaibhav@ti.com>
>> Tested-by: Zumeng Chen<zumeng.chen@windriver.com>
>> ---
>>   arch/arm/mach-omap2/board-omap3evm.c |   39 ++++++++++++++++++++++=
++++++++++++
>>   1 files changed, 39 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-om=
ap2/board-omap3evm.c
>> index 639bd07..0b83d0e 100644
>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> @@ -24,6 +24,10 @@
>>   #include<linux/leds.h>
>>   #include<linux/interrupt.h>
>>
>> +#include<linux/mtd/mtd.h>
>> +#include<linux/mtd/partitions.h>
>> +#include<linux/mtd/nand.h>
>> +
>>   #include<linux/spi/spi.h>
>>   #include<linux/spi/ads7846.h>
>>   #include<linux/i2c/twl.h>
>> @@ -43,6 +47,7 @@
>>
>>   #include<plat/board.h>
>>   #include<plat/usb.h>
>> +#include<plat/nand.h>
>>   #include "common.h"
>>   #include<plat/mcspi.h>
>>   #include<video/omapdss.h>
>> @@ -607,6 +612,37 @@ static struct regulator_consumer_supply dummy_s=
upplies[] =3D {
>>   	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>>   };
>>
>> +static struct mtd_partition omap3evm_nand_partitions[] =3D {
>> +	/* All the partition sizes are listed in terms of NAND block size =
*/
>> +	{
>> +		.name           =3D "X-Loader",
>> +		.offset         =3D 0,
>> +		.size           =3D 4*(SZ_128K),
>> +		.mask_flags     =3D MTD_WRITEABLE
>> +	},
>> +	{
>> +		.name           =3D "U-Boot",
>> +		.offset         =3D MTDPART_OFS_APPEND,
>> +		.size           =3D 14*(SZ_128K),
>> +		.mask_flags     =3D MTD_WRITEABLE
>> +	},
>> +	{
>> +		.name           =3D "U-Boot Env",
>> +		.offset         =3D MTDPART_OFS_APPEND,
>> +		.size           =3D 2*(SZ_128K)
>> +	},
>> +	{
>> +		.name           =3D "Kernel",
>> +		.offset         =3D MTDPART_OFS_APPEND,
>> +		.size           =3D 40*(SZ_128K)
>> +	},
>> +	{
>> +		.name           =3D "File system",
>> +		.size           =3D MTDPART_SIZ_FULL,
>> +		.offset         =3D MTDPART_OFS_APPEND,
>> +	},
>> +};
>> +
>>   static void __init omap3_evm_init(void)
>>   {
>>   	struct omap_board_mux *obm;
>> @@ -656,6 +692,9 @@ static void __init omap3_evm_init(void)
>>   	}
>>   	usb_musb_init(&musb_board_data);
>>   	usbhs_init(&usbhs_bdata);
>> +	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
>> +			     ARRAY_SIZE(omap3evm_nand_partitions));
>> +
> I think, this will interfere with Afzal's patches [1]?
Yes, Igor, thanks for your kind reminder, I have already
noticed Afzal's GPMC patches when at [PATCH v4 00/39]

But I didn't read recently, I'll check them again to see if they
have been in Tony's queue :-)

Regards,
Zumeng

>>   	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
>>   	omap3evm_init_smsc911x();
>>   	omap3_evm_display_init();
> [1] http://www.spinics.net/lists/arm-kernel/msg178664.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
