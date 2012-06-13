From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH V2 2/5] ARM: OMAP3EVM: Adding USB internal LDOs board
 file
Date: Wed, 13 Jun 2012 16:23:19 +0800
Message-ID: <4FD84DF7.8050400@windriver.com>
References: <zumeng.chen@gmail.com> <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com> <1339551850-20827-3-git-send-email-zumeng.chen@gmail.com> <4FD84C57.5000605@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <4FD84C57.5000605@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Zumeng Chen <zumeng.chen@gmail.com>, tony@atomide.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=E4=BA=8E 2012=E5=B9=B406=E6=9C=8813=E6=97=A5 16:16, Igor Grinberg =E5=86=
=99=E9=81=93:
> On 06/13/12 04:44, Zumeng Chen wrote:
>> From: Zumeng Chen<zumeng.chen@windriver.com>
>>
>> EHCI PHY requires these regulators:
>>          EVM Rev>=3DE  -->  VAUX2
>>          EVM Rev<  E  -->  VUSB1V5, VUSB1V8
>>
>> Adding USB internal LDOs (vusb1v5&  vusb1v8) and VAUX2 to omap3evm
>> board file. Also removing vaux2_{1/2/3} supplies as they are not
>> used on omap3 evm.
>>
>> But we need not to add vaux2 in twl4030_platform_data since it will
>> be added conditionally.
>>
>> Signed-off-by: Ajay Kumar Gupta<ajay.gupta@ti.com>
>> Signed-off-by: Vaibhav Hiremath<hvaibhav@ti.com>
>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>> ---
>>   arch/arm/mach-omap2/board-omap3evm.c |   27 ++++++++++++++++++++++=
+++++
>>   1 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-om=
ap2/board-omap3evm.c
>> index 0b83d0e..3c91534 100644
>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> @@ -466,6 +466,30 @@ struct wl12xx_platform_data omap3evm_wlan_data =
__initdata =3D {
>>   };
>>   #endif
>>
>> +/* VAUX2 for USB */
>> +static struct regulator_consumer_supply omap3evm_vaux2_supplies[] =3D=
 {
>> +	REGULATOR_SUPPLY("VDD_CSIPHY1", "omap3isp"),	/* OMAP ISP */
>> +	REGULATOR_SUPPLY("VDD_CSIPHY2", "omap3isp"),	/* OMAP ISP */
>> +	REGULATOR_SUPPLY("hsusb1", "ehci-omap.0"),
>> +	{
>> +		.supply		=3D "vaux2",
>> +	}
> This too can use the REGULATOR_SUPPLY() macro, why not use it?
Yes, Of course from me, I'll try to see if there is other consideration=
s
from the original patch. If no I'll change it.

Regards,
Zumeng
>> +};
>> +
>> +static struct regulator_init_data omap3evm_vaux2 =3D {
>> +	.constraints =3D {
>> +		.min_uV		=3D 2800000,
>> +		.max_uV		=3D 2800000,
>> +		.apply_uV	=3D true,
>> +		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
>> +					| REGULATOR_MODE_STANDBY,
>> +		.valid_ops_mask		=3D REGULATOR_CHANGE_MODE
>> +					| REGULATOR_CHANGE_STATUS,
>> +	},
>> +	.num_consumer_supplies		=3D ARRAY_SIZE(omap3evm_vaux2_supplies),
>> +	.consumer_supplies		=3D omap3evm_vaux2_supplies,
>> +};
>> +
>>   static struct twl4030_platform_data omap3evm_twldata =3D {
>>   	/* platform_data for children goes here */
>>   	.keypad		=3D&omap3evm_kp_data,
>> @@ -659,6 +683,9 @@ static void __init omap3_evm_init(void)
>>   	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
>>   	omap_hsmmc_init(mmc);
>>
>> +	if (get_omap3_evm_rev()>=3D OMAP3EVM_BOARD_GEN_2)
>> +		omap3evm_twldata.vaux2 =3D&omap3evm_vaux2;
>> +
>>   	omap3_evm_i2c_init();
>>
>>   	omap_display_init(&omap3_evm_dss_data);

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
