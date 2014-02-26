From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: TWL6040 fails to initialize
Date: Wed, 26 Feb 2014 12:28:35 +0200
Message-ID: <530DC1D3.8040800@ti.com>
References: <530C70B3.4010103@epfl.ch> <530CA8DA.8050806@ti.com> <530CB9C6.60806@epfl.ch> <530D972F.805@ti.com> <530DB97E.80309@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49963 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbaBZK3D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 05:29:03 -0500
In-Reply-To: <530DB97E.80309@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@epfl.ch>

On 02/26/2014 11:53 AM, Florian Vaussard wrote:
> On 02/26/2014 08:26 AM, Peter Ujfalusi wrote:
>> On 02/25/2014 05:41 PM, Florian Vaussard wrote:
>>> If the power was not enabled at all, I would be unable to read the
>>> revision register, no? And delaying the probe by one millisecond wo=
uld
>>> be of no help in this case IMHO.
>>
>> One thing which might cause this is that if the audpwron GPIO is set=
 high
>> before the twl6040 module is probing. When I request the GPIO I ask =
it to be
>> set to low. If the line was high before this means we initiate the p=
ower off
>> sequence.
>> Can you try something like this:
>>
>=20
> I statistically checked that the sleep should be placed after the GPI=
O
> request, so indeed this seems to be the problem, and your explanation=
 is
> plausible. Can you send a proper patch?
>=20
> Now, related to this, I managed to found a part of the datasheet on t=
he
> Great Internet. Looking at the "Power-Up Sequence" section, it is wri=
tten:
>=20
> - NRESPWRON goes high -> plug detect and GPO are available
> - V2V1 goes high -> hook-detect available by I2C programming (sleep m=
ode)
> - AUDPWRON goes high && READYINT -> ready to communicate through I2C =
and PDM
>=20
> So, although there seems to be some contradictions on when it is
> possible to access the I2C, shouldn't we enable the AUDPWRON GPIO
> _before_ making any I2C access?
>=20
> For the twl6040_probe, the following path would seem more correct to =
me:
>=20
> 1) enable regulators
> 2) request AUDPWRON
> 3) twl6040_power(ON) && regcache_cache_only(false)
> 4) wait for READYINT (or sleep if deterministic)
> 5) perform all required I2C accesses (read revision, etc.)
> 6) twl6040_power(OFF) && regcache_cache_only(true)
>=20
> What do you think?

Even when the AUDPWRON signal is low we can access to registers in VIO =
domain,
plug detect and GPO functions. So there's no need to power on the codec=
 just
to power it down later.


> Thanks,
> Florian
>=20
>> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
>> index 75316fb33448..d2a0bd1539ae 100644
>> --- a/drivers/mfd/twl6040.c
>> +++ b/drivers/mfd/twl6040.c
>> @@ -674,6 +674,9 @@ static int twl6040_probe(struct i2c_client *clie=
nt,
>>                                             GPIOF_OUT_INIT_LOW, "aud=
pwron");
>>                 if (ret)
>>                         goto gpio_err;
>> +
>> +               /* power-down sequence latency */
>> +               usleep_range(500, 700);
>>         }
>>
>>         ret =3D regmap_add_irq_chip(twl6040->regmap, twl6040->irq, I=
RQF_ONESHOT,
>>
>>


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
