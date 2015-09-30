From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Wed, 30 Sep 2015 13:06:44 +0300
Message-ID: <560BB434.6080308@ti.com>
References: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1509270631440.7947@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1509270631440.7947@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Paul,

On 09/27/2015 10:02 AM, Paul Walmsley wrote:
>>  /*
>> + * 'mcasp' class
>> + *
>> + */
>> +static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc =3D {
>> +	.sysc_offs	=3D 0x0004,
>> +	.sysc_flags	=3D SYSC_HAS_SIDLEMODE,
>> +	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>> +	.sysc_fields	=3D &omap_hwmod_sysc_type3,
>> +};
>> +
>> +static struct omap_hwmod_class dra7xx_mcasp_hwmod_class =3D {
>> +	.name	=3D "mcasp",
>> +	.sysc	=3D &dra7xx_mcasp_sysc,
>> +};
>> +
>> +/* mcasp3 */
>> +static struct omap_hwmod dra7xx_mcasp3_hwmod =3D {
>> +	.name		=3D "mcasp3",
>> +	.class		=3D &dra7xx_mcasp_hwmod_class,
>> +	.clkdm_name	=3D "l4per2_clkdm",
>> +	.main_clk	=3D "mcasp3_ahclkx_mux",
>=20
> I'd expect this clock to be something derived from mcasp3_aux_gfclk,=20
> according to Table 24-408 "Clocks and Resets" of SPRUHZ6.  Could you=20
> please doublecheck this?

I can not explain this. If I change the main_clk to "mcasp3_aux_gfclk_m=
ux"
then I can not access to McASP3 register at all.
I don't see anything popping out in the clock data, nor in other places=
=2E

>> +	.flags		=3D HWMOD_SWSUP_SIDLE,

Not sure why this has been added, I can not find any pointers regarding=
 to
this and everything is working w/o this flag. Will remove it in v2.


> Is this needed?  If it is, please add a brief comment describing the =
issue=20
> or bug that it's working around.
>=20
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP3_CLKCTRL_OFFSET,
>> +			.context_offs =3D DRA7XX_RM_L4PER2_MCASP3_CONTEXT_OFFSET,
>> +			.modulemode   =3D MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +};
>> +
>> +/*
>>   * 'mmc' class
>>   *
>>   */
>> @@ -2566,6 +2598,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_mai=
n_1__hdmi =3D {
>>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>>  };
>> =20
>> +/* l4_per2 -> mcasp3 */
>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 =3D {
>> +	.master		=3D &dra7xx_l4_per2_hwmod,
>> +	.slave		=3D &dra7xx_mcasp3_hwmod,
>=20
> So this is the low-speed control/register access port, where the MPU=20
> writes to the McASP3 config registers...
>=20
>> +	.clk		=3D "l3_iclk_div",
>=20
> ... and thus this interface clock doesn't look right for this port, s=
ince=20
> it's most likely generated from the L4PER2, where this port is connec=
ted. =20
> So it should probably be "l4_iclk_div".

There is no "l4_iclk_div" for dra7xx. Looking around the file all other=
 script
generated data uses "l3_iclk_div" for IPs under dra7xx_l4_per2_hwmod.

Tero: do you know the reason for this?

> =20
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>=20
> There's another struct omap_hwmod_ocp_if record missing: the high-spe=
ed=20
> bus-master port that the McASP3 uses to DMA audio data.  This port sh=
ould=20
> most likely be clocked with "l3_iclk_div" per Table 24-408 "Clocks an=
d=20
> Resets".  This port is also where the registers described in Table 24=
-555=20
> "MCASP_DAT Register Summary 3" L3_MAIN column are exposed.  You've go=
t=20
> that address map range blocked out in your DT data reg property, and=20
> associated with this device, right? 0x46000000?

Yes, the McASP3-dat port is not used ATM. This is over the L3 interconn=
ect and
due to a feature we can not use it with sDMA (constant addressing is no=
t
supported through L3 interconnect for DMAs).
We could use eDMA, but there are complications regarding to that.
At the moment we are using the sDMA through the L4 interconnect address=
 space.

>=20
>> +
>>  static struct omap_hwmod_addr_space dra7xx_elm_addrs[] =3D {
>>  	{
>>  		.pa_start	=3D 0x48078000,
>> @@ -3338,6 +3378,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_=
ocp_ifs[] __initdata =3D {
>>  	&dra7xx_l4_wkup__dcan1,
>>  	&dra7xx_l4_per2__dcan2,
>>  	&dra7xx_l4_per2__cpgmac0,
>> +	&dra7xx_l4_per2__mcasp3,
>>  	&dra7xx_gmac__mdio,
>>  	&dra7xx_l4_cfg__dma_system,
>>  	&dra7xx_l3_main_1__dss,
>> --=20
>> 2.5.0
>>
>=20
>=20
> - Paul
>=20


--=20
P=E9ter
