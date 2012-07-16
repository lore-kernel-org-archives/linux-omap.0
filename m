From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH RFT] regulator: twl: Fix list_voltate for twl6030ldo_ops
Date: Mon, 16 Jul 2012 17:38:32 +0530
Message-ID: <50040440.80703@ti.com>
References: <1342434670.4717.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342434670.4717.6.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, loml <linux-omap@vger.kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Axel,

On Monday 16 July 2012 04:01 PM, Axel Lin wrote:
> According to the datasheet, the voltage for twl6030ldo_ops is not lin=
ear for
> all cases. Linear mapping is only for the selection code from
> 00000001 to 00011000.
>
> Table 9. LDO Output Voltage Selection Code
> CODE     VOUT(V)    COD      VOUT(V)    CODE     VOUT(V)    CODE     =
VOUT(V)
> 00000000 0          00001000 1.7        00010000 2.5        00011000 =
3.3
> 00000001 1.0        00001001 1.8        00010001 2.6        00011001 =
Reserved
> 00000010 1.1        00001010 1.9        00010010 2.7        00011010 =
Reserved
> 00000011 1.2        00001011 2.0        00010011 2.8        00011011 =
Reserved
> 00000100 1.3        00001100 2.1        00010100 2.9        00011100 =
Reserved
> 00000101 1.4        00001101 2.2        00010101 3.0        00011101 =
Reserved
> 00000110 1.5        00001110 2.3        00010110 3.1        00011110 =
Reserved
> 00000111 1.6        00001111 2.4        00010111 3.2        00011111 =
2.75
>
> This patch implements the list_voltage callback based on above table.
>
> Signed-off-by: Axel Lin<axel.lin@gmail.com>

Seems to work fine on my 4460 Panda.

Without this fix..

[    0.337341] V1V8: 1800 mV normal standby
[    0.338531] V2V1: 2100 mV normal standby
[    0.339813] VMMC: 1200 <--> 3000 mV at 3100 mV normal standby
					^^^^^^^^
[    0.341278] VPP: 1800 <--> 2500 mV at 2000 mV normal standby
					^^^^^^^^^
[    0.343505] VCXIO: 1800 mV normal standby
[    0.343597] VCXIO: supplied by V2V1
[    0.345855] VDAC: 1800 mV normal standby
[    0.345947] VDAC: supplied by V2V1
[    0.347717] VAUX2_6030: 1200 <--> 2800 mV at 1900 mV normal standby
						^^^^^^^^
[    0.349212] VAUX3_6030: 1000 <--> 3000 mV at 1300 mV normal standby
						^^^^^^^^

And with the fix..

[    0.337707] V1V8: 1800 mV normal standby
[    0.338897] V2V1: 2100 mV normal standby
[    0.340179] VMMC: 1200 <--> 3000 mV at 3000 mV normal standby
[    0.341674] VPP: 1800 <--> 2500 mV at 1900 mV normal standby
[    0.343383] VCXIO: 1800 mV normal standby
[    0.343475] VCXIO: supplied by V2V1
[    0.345764] VDAC: 1800 mV normal standby
[    0.345825] VDAC: supplied by V2V1
[    0.347656] VAUX2_6030: 1200 <--> 2800 mV at 1800 mV normal standby
[    0.349121] VAUX3_6030: 1000 <--> 3000 mV at 1200 mV normal standby

Thanks for the patch.

Tested-by: Rajendra Nayak <rnayak@ti.com>

> ---
>   drivers/regulator/twl-regulator.c |   31 ++++++++++++++++++++++++--=
-----
>   1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/tw=
l-regulator.c
> index de99b78..242fe90 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -559,6 +559,27 @@ static struct regulator_ops twl6030coresmps_ops =
=3D {
>   	.get_voltage	=3D twl6030coresmps_get_voltage,
>   };
>
> +static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsig=
ned sel)
> +{
> +	struct twlreg_info *info =3D rdev_get_drvdata(rdev);
> +
> +	switch (sel) {
> +	case 0:
> +		return 0;
> +	case 1 ... 24:
> +		/* Linear mapping from 00000001 to 00011000:
> +		 * Absolute voltage value =3D 1.0 V + 0.1 V =C3=97 (sel =E2=80=93 =
00000001)
> +		 */
> +		return (info->min_mV + 100 * (sel - 1)) * 1000;
> +	case 25 ... 30:
> +		return -EINVAL;
> +	case 31:
> +		return 2750000;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   static int
>   twl6030ldo_set_voltage_sel(struct regulator_dev *rdev, unsigned sel=
ector)
>   {
> @@ -577,7 +598,7 @@ static int twl6030ldo_get_voltage_sel(struct regu=
lator_dev *rdev)
>   }
>
>   static struct regulator_ops twl6030ldo_ops =3D {
> -	.list_voltage	=3D regulator_list_voltage_linear,
> +	.list_voltage	=3D twl6030ldo_list_voltage,
>
>   	.set_voltage_sel =3D twl6030ldo_set_voltage_sel,
>   	.get_voltage_sel =3D twl6030ldo_get_voltage_sel,
> @@ -906,12 +927,10 @@ static struct twlreg_info TWL6030_INFO_##label =
=3D { \
>   	.desc =3D { \
>   		.name =3D #label, \
>   		.id =3D TWL6030_REG_##label, \
> -		.n_voltages =3D (max_mVolts - min_mVolts)/100 + 1, \
> +		.n_voltages =3D 32, \
>   		.ops =3D&twl6030ldo_ops, \
>   		.type =3D REGULATOR_VOLTAGE, \
>   		.owner =3D THIS_MODULE, \
> -		.min_uV =3D min_mVolts * 1000, \
> -		.uV_step =3D 100 * 1000, \
>   		}, \
>   	}
>
> @@ -923,12 +942,10 @@ static struct twlreg_info TWL6025_INFO_##label =
=3D { \
>   	.desc =3D { \
>   		.name =3D #label, \
>   		.id =3D TWL6025_REG_##label, \
> -		.n_voltages =3D ((max_mVolts - min_mVolts)/100) + 1, \
> +		.n_voltages =3D 32, \
>   		.ops =3D&twl6030ldo_ops, \
>   		.type =3D REGULATOR_VOLTAGE, \
>   		.owner =3D THIS_MODULE, \
> -		.min_uV =3D min_mVolts * 1000, \
> -		.uV_step =3D 100 * 1000, \
>   		}, \
>   	}
>
