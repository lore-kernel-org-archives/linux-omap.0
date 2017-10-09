From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] regulator: lp873x: Update the enable mask for LDOs and
 BUCKs
Date: Mon, 9 Oct 2017 18:35:14 +0300
Message-ID: <72182869-6102-1178-91c4-0be632d4be32@ti.com>
References: <1506515140-26058-1-git-send-email-j-keerthy@ti.com>
 <20171009142053.rogvykzmoatduv6i@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171009142053.rogvykzmoatduv6i@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 09/10/17 17:20, Mark Brown wrote:
> On Wed, Sep 27, 2017 at 05:55:40PM +0530, Keerthy wrote:
>> The reset value of the EN_PIN_CTRL bit fields of LDOs and BUCKs
>> need not be set correctly. Hence update the enable mask to include
>> the EN_PIN_CTRL bit. While enabling this should be set to 1 so
>> that all the regulators are tied to EN pin.
>=20
> I'm not sure I follow the logic here entirely.  It sounds like this is a
> register bit to control if the regulators are enabled and disabled via a
> GPIO instead of the register which is something that people might want
> to use in some systems.  Shouldn't this be dependent on some system
> configration instead?

The EN signal coming in to the PMIC is actually used to poweroff the=20
system completely. There is no other mechanism for doing this in lp873x=20
based systems, they removed the bit for controlling dev-power-off from=20
the register space. If the EN bit is down for a specific regulator, it=20
won't go down when attempting to poweroff the system, otherwise the=20
state of a regulator is the result of (EN_PIN | EN_BIT).

I wonder if we should tie this somehow to the system-power-controller=20
property though.... If the PMIC is not system-power-controller, we=20
should disable the EN_PIN_CTRL from all regulators so that they don't go=20
down if the EN_PIN itself is floating for example.

-Tero

>=20
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/regulator/lp873x-regulator.c | 19 ++++++++++---------
>>   include/linux/mfd/lp873x.h           |  4 ++++
>>   2 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp=
873x-regulator.c
>> index 70e3df6..77bea82 100644
>> --- a/drivers/regulator/lp873x-regulator.c
>> +++ b/drivers/regulator/lp873x-regulator.c
>> @@ -20,7 +20,7 @@
>>   #include <linux/mfd/lp873x.h>
>>  =20
>>   #define LP873X_REGULATOR(_name, _id, _of, _ops, _n, _vr, _vm, _er, _em=
, \
>> -			 _delay, _lr, _cr)				\
>> +			 _dv, _delay, _lr, _cr)				\
>>   	[_id] =3D {							\
>>   		.desc =3D {						\
>>   			.name			=3D _name,		\
>> @@ -36,6 +36,7 @@
>>   			.vsel_mask		=3D _vm,			\
>>   			.enable_reg		=3D _er,			\
>>   			.enable_mask		=3D _em,			\
>> +			.disable_val		=3D _dv,			\
>>   			.ramp_delay		=3D _delay,		\
>>   			.linear_ranges		=3D _lr,			\
>>   			.n_linear_ranges	=3D ARRAY_SIZE(_lr),	\
>> @@ -175,21 +176,21 @@ static int lp873x_buck_get_current_limit(struct re=
gulator_dev *rdev)
>>   	LP873X_REGULATOR("BUCK0", LP873X_BUCK_0, "buck0", lp873x_buck01_ops,
>>   			 256, LP873X_REG_BUCK0_VOUT,
>>   			 LP873X_BUCK0_VOUT_BUCK0_VSET, LP873X_REG_BUCK0_CTRL_1,
>> -			 LP873X_BUCK0_CTRL_1_BUCK0_EN, 10000,
>> -			 buck0_buck1_ranges, LP873X_REG_BUCK0_CTRL_2),
>> +			 LP873X_BUCK_ENABLE_MASK, LP873X_BUCK_DISABLE_VAL,
>> +			 10000, buck0_buck1_ranges, LP873X_REG_BUCK0_CTRL_2),
>>   	LP873X_REGULATOR("BUCK1", LP873X_BUCK_1, "buck1", lp873x_buck01_ops,
>>   			 256, LP873X_REG_BUCK1_VOUT,
>>   			 LP873X_BUCK1_VOUT_BUCK1_VSET, LP873X_REG_BUCK1_CTRL_1,
>> -			 LP873X_BUCK1_CTRL_1_BUCK1_EN, 10000,
>> -			 buck0_buck1_ranges, LP873X_REG_BUCK1_CTRL_2),
>> +			 LP873X_BUCK_ENABLE_MASK, LP873X_BUCK_DISABLE_VAL,
>> +			 10000, buck0_buck1_ranges, LP873X_REG_BUCK1_CTRL_2),
>>   	LP873X_REGULATOR("LDO0", LP873X_LDO_0, "ldo0", lp873x_ldo01_ops, 26,
>>   			 LP873X_REG_LDO0_VOUT, LP873X_LDO0_VOUT_LDO0_VSET,
>> -			 LP873X_REG_LDO0_CTRL,
>> -			 LP873X_LDO0_CTRL_LDO0_EN, 0, ldo0_ldo1_ranges, 0xFF),
>> +			 LP873X_REG_LDO0_CTRL, LP873X_LDO_ENABLE_MASK,
>> +			 LP873X_LDO_DISABLE_VAL, 0, ldo0_ldo1_ranges, 0xFF),
>>   	LP873X_REGULATOR("LDO1", LP873X_LDO_1, "ldo1", lp873x_ldo01_ops, 26,
>>   			 LP873X_REG_LDO1_VOUT, LP873X_LDO1_VOUT_LDO1_VSET,
>> -			 LP873X_REG_LDO1_CTRL,
>> -			 LP873X_LDO1_CTRL_LDO1_EN, 0, ldo0_ldo1_ranges, 0xFF),
>> +			 LP873X_REG_LDO1_CTRL, LP873X_LDO_ENABLE_MASK,
>> +			 LP873X_LDO_DISABLE_VAL, 0, ldo0_ldo1_ranges, 0xFF),
>>   };
>>  =20
>>   static int lp873x_regulator_probe(struct platform_device *pdev)
>> diff --git a/include/linux/mfd/lp873x.h b/include/linux/mfd/lp873x.h
>> index edbec83..53888d4 100644
>> --- a/include/linux/mfd/lp873x.h
>> +++ b/include/linux/mfd/lp873x.h
>> @@ -77,6 +77,8 @@
>>   #define LP873X_BUCK0_CTRL_1_BUCK0_RDIS_EN	BIT(2)
>>   #define LP873X_BUCK0_CTRL_1_BUCK0_EN_PIN_CTRL	BIT(1)
>>   #define LP873X_BUCK0_CTRL_1_BUCK0_EN		BIT(0)
>> +#define LP873X_BUCK_ENABLE_MASK			(BIT(0) | BIT(1))
>> +#define	LP873X_BUCK_DISABLE_VAL			BIT(1)
>>  =20
>>   #define LP873X_BUCK0_CTRL_2_BUCK0_ILIM		0x38
>>   #define LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE	0x07
>> @@ -96,6 +98,8 @@
>>   #define LP873X_LDO0_CTRL_LDO0_RDIS_EN		BIT(2)
>>   #define LP873X_LDO0_CTRL_LDO0_EN_PIN_CTRL	BIT(1)
>>   #define LP873X_LDO0_CTRL_LDO0_EN		BIT(0)
>> +#define LP873X_LDO_ENABLE_MASK			(BIT(0) | BIT(1))
>> +#define LP873X_LDO_DISABLE_VAL			BIT(1)
>>  =20
>>   #define LP873X_LDO1_CTRL_LDO1_RDIS_EN		BIT(2)
>>   #define LP873X_LDO1_CTRL_LDO1_EN_PIN_CTRL	BIT(1)
>> --=20
>> 1.9.1
>>
