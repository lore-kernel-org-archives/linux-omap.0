From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] mfd: add bq2415x charger driver
Date: Tue, 6 Dec 2011 13:43:06 +0200
Message-ID: <CAMP44s0VSdVo6EhvgVUcwryK39iss0mvDbxKjaeH_S+Vp4DwBw@mail.gmail.com>
References: <1323124541-7590-1-git-send-email-felipe.contreras@nokia.com>
	<20111206113131.GE17194@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62473 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933231Ab1LFLnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Dec 2011 06:43:06 -0500
In-Reply-To: <20111206113131.GE17194@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Pali Roh??r <pali.rohar@gmail.com>, Aliaksei Katovich <aliaksei.katovich@nokia.com>, Vladimir Zapolskiy <vz@mleia.com>

On Tue, Dec 6, 2011 at 1:31 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Dec 06, 2011 at 12:35:41AM +0200, Felipe Contreras wrote:
>
>> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
>> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> @@ -925,6 +925,9 @@ static struct i2c_board_info __initdata rx51_per=
ipherals_i2c_board_info_2[] =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2C_BOARD_INFO("bq2=
7200", 0x55),
>> =C2=A0 =C2=A0 =C2=A0 },
>> =C2=A0#endif
>> + =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2C_BOARD_INFO("bq24150"=
, 0x6b),
>> + =C2=A0 =C2=A0 },
>
> Clearly this is orthogonal.

Yes, I added it just to demonstrate how to activate it.

>> +static inline int bq2415x_i2c_read(struct i2c_client *cli, u8 reg)
>> +{
>> + =C2=A0 =C2=A0 return i2c_smbus_read_byte_data(cli, reg);
>> +}
>> +
>> +static inline int bq2415x_i2c_write(struct i2c_client *cli, u8 reg,=
 u8 val)
>> +{
>> + =C2=A0 =C2=A0 return i2c_smbus_write_byte_data(cli, reg, val);
>> +}
>
> regmap might be useful here (it's got an update bits operation and
> cache).

Will take a look.

>> +static int bq2415x_set_current_limit(struct i2c_client *cli,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int min_uA, int max_uA)
>> +{
>> + =C2=A0 =C2=A0 int res;
>> +
>> + =C2=A0 =C2=A0 res =3D bq2415x_i2c_read(cli, BQ2415X_GEN_CTL);
>> + =C2=A0 =C2=A0 if (res < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return res;
>> +
>> + =C2=A0 =C2=A0 res &=3D ~BQ2415X_IIN_LIMIT_UNLIM_MASK;
>> +
>> + =C2=A0 =C2=A0 if (min_uA >=3D BQ2415X_IIN_LIMIT_100 && max_uA < BQ=
2415X_IIN_LIMIT_500)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;
>> + =C2=A0 =C2=A0 else if (min_uA >=3D BQ2415X_IIN_LIMIT_500 && max_uA=
 < BQ2415X_IIN_LIMIT_800)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res |=3D BQ2415X_IIN_LIM=
IT_500_MASK;
>> + =C2=A0 =C2=A0 else if (min_uA >=3D BQ2415X_IIN_LIMIT_800 && max_uA=
 < BQ2415X_IIN_LIMIT_UNLIM)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res |=3D BQ2415X_IIN_LIM=
IT_800_MASK;
>> + =C2=A0 =C2=A0 else if (min_uA >=3D BQ2415X_IIN_LIMIT_UNLIM)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res |=3D BQ2415X_IIN_LIM=
IT_UNLIM_MASK;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> +
>> + =C2=A0 =C2=A0 return bq2415x_i2c_write(cli, BQ2415X_GEN_CTL, res);
>> +}
>
> This is the sort of stuff that people were pushing through the regula=
tor
> API (and you have cloned the interface...) in order to allow a separa=
te
> bit of code to pick the current limits. =C2=A0At the minute it looks =
like
> you're hard coding the settings, the regulator API would at least let
> you punt those to machines with fixed configurations and provides a h=
ook
> for anything which does want to play with the configuration at runtim=
e.
> Don't know if there's a better API, but it does seem like this is a
> general thing for chargers and should therefore go through a generic
> API.

Yes, for this particular case the regulator API might be useful, but I
don't see how external code will use this. Will they have to search
for the name of this regulator, and then try to change the
current_limit?

Anyway, there are other levels I'm not sure the regulator interface is
good for, like a "weak battery" voltage threshold, that most likely
would only make sense to handle internally in the driver.

> On the other hand if you just set limits and let the charger get on w=
ith
> its thing and run autonomously starting, stopping and fast charging b=
y
> itself then a power supply driver seems like a good fit - just provid=
e
> the upper limits as platform data or something and watch it go.

It would have to change its behavior depending on external events,
like charger plugged/unplugged, different types of chargers, and so
on. I'm thinking the rx51 board code could join some hooks from
isp1704 (which detects the events) into this driver.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
