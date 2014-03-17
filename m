From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/8] clk: divider: fix rate calculation for fractional
 rates
Date: Mon, 17 Mar 2014 14:53:03 +0200
Message-ID: <5326F02F.2030604@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com> <1392285846-13199-2-git-send-email-tomi.valkeinen@ti.com> <52FE1DF2.2040707@ti.com> <20140227022524.12081.32368@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ekdfFKVcD8dkMS1BFm4PLhLbUIkQbGQGp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46697 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932906AbaCQMxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2014 08:53:30 -0400
In-Reply-To: <20140227022524.12081.32368@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--ekdfFKVcD8dkMS1BFm4PLhLbUIkQbGQGp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27/02/14 04:25, Mike Turquette wrote:
> Quoting Tero Kristo (2014-02-14 05:45:22)
>> On 02/13/2014 12:03 PM, Tomi Valkeinen wrote:
>>> clk-divider.c does not calculate the rates consistently at the moment=
=2E
>>>
>>> As an example, on OMAP3 we have a clock divider with a source clock o=
f
>>> 864000000 Hz. With dividers 6, 7 and 8 the theoretical rates are:
>>>
>>> 6: 144000000
>>> 7: 123428571.428571...
>>> 8: 108000000
>>>
>>> Calling clk_round_rate() with the rate in the first column will give =
the
>>> rate in the second column:
>>>
>>> 144000000 -> 144000000
>>> 143999999 -> 123428571
>>> 123428572 -> 123428571
>>> 123428571 -> 108000000
>>>
>>> Note how clk_round_rate() returns 123428571 for rates from 123428572 =
to
>>> 143999999, which is mathematically correct, but when clk_round_rate()=
 is
>>> called with 123428571, the returned value is surprisingly 108000000.
>>>
>>> This means that the following code works a bit oddly:
>>>
>>> rate =3D clk_round_rate(clk, 123428572);
>>> clk_set_rate(clk, rate);
>>>
>>> As clk_set_rate() also does clock rate rounding, the result is that t=
he
>>> clock is set to the rate of 108000000, not 123428571 returned by the
>>> clk_round_rate.
>>>
>>> This patch changes the clk-divider.c to use DIV_ROUND_UP when
>>> calculating the rate. This gives the following behavior which fixes t=
he
>>> inconsistency:
>>>
>>> 144000000 -> 144000000
>>> 143999999 -> 123428572
>>> 123428572 -> 123428572
>>> 123428571 -> 108000000
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> Cc: Mike Turquette <mturquette@linaro.org>
>>> ---
>>>   drivers/clk/clk-divider.c | 10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>>> index 5543b7df8e16..ec22112e569f 100644
>>> --- a/drivers/clk/clk-divider.c
>>> +++ b/drivers/clk/clk-divider.c
>>> @@ -24,7 +24,7 @@
>>>    * Traits of this clock:
>>>    * prepare - clk_prepare only ensures that parents are prepared
>>>    * enable - clk_enable only ensures that parents are enabled
>>> - * rate - rate is adjustable.  clk->rate =3D parent->rate / divisor
>>> + * rate - rate is adjustable.  clk->rate =3D DIV_ROUND_UP(parent->ra=
te / divisor)
>>>    * parent - fixed parent.  No clk_set_parent support
>>>    */
>>>
>>> @@ -115,7 +115,7 @@ static unsigned long clk_divider_recalc_rate(stru=
ct clk_hw *hw,
>>>               return parent_rate;
>>>       }
>>>
>>> -     return parent_rate / div;
>>> +     return DIV_ROUND_UP(parent_rate, div);
>>>   }
>>>
>>>   /*
>>> @@ -185,7 +185,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw,=
 unsigned long rate,
>>>               }
>>>               parent_rate =3D __clk_round_rate(__clk_get_parent(hw->c=
lk),
>>>                               MULT_ROUND_UP(rate, i));
>>> -             now =3D parent_rate / i;
>>> +             now =3D DIV_ROUND_UP(parent_rate, i);
>>>               if (now <=3D rate && now > best) {
>>>                       bestdiv =3D i;
>>>                       best =3D now;
>>> @@ -207,7 +207,7 @@ static long clk_divider_round_rate(struct clk_hw =
*hw, unsigned long rate,
>>>       int div;
>>>       div =3D clk_divider_bestdiv(hw, rate, prate);
>>>
>>> -     return *prate / div;
>>> +     return DIV_ROUND_UP(*prate, div);
>>>   }
>>>
>>>   static int clk_divider_set_rate(struct clk_hw *hw, unsigned long ra=
te,
>>> @@ -218,7 +218,7 @@ static int clk_divider_set_rate(struct clk_hw *hw=
, unsigned long rate,
>>>       unsigned long flags =3D 0;
>>>       u32 val;
>>>
>>> -     div =3D parent_rate / rate;
>>> +     div =3D DIV_ROUND_UP(parent_rate, rate);
>>>       value =3D _get_val(divider, div);
>>>
>>>       if (value > div_mask(divider))
>>>
>>
>> Basically the patch looks good to me, but it might be good to have a=20
>> testing round of sort with this. It can potentially cause regressions =
on=20
>> multiple boards if the drivers happen to rely on the "broken" clock=20
>> rates. Same for patch #2 which is a copy paste of this one, but only=20
>> impacts TI boards.
>=20
> Agreed. I've taken patches #1 & #2 into clk-next. Let's let them stew i=
n
> -next for a while and see if anyone's board catches on fire.

Are these on the way to 3.15?

 Tomi



--ekdfFKVcD8dkMS1BFm4PLhLbUIkQbGQGp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJvAvAAoJEPo9qoy8lh71AbsP/i6t0Q7GSiZC/mo3Xm59xBC4
L28UNoOZVus36S+EIGiyQwYPJNj/qxOfB3Frqua90g8h6XDZL7JX8lXwUrbwD/Fh
R2BC/jUtBMN16ngftEjCH1zwll/SwdUMbfb8njeM8foM7eGy6UxhacF/dSBe61si
QzbDfvUN5ZtAb2zcBhipBaw9l5ERGOysCXyMk1Zpa3a/FdDWixpier98l3HhUb/R
R0yzaFvz8Oo7lih2vD0zHG7sIkcYYTK0xangdAZKqk/yAGe0K4EH71CZazMgrr+X
qk6Fo0X88xx9ZNdXjcaJhAlkIw0e3AkXSc6miqme+xHNzVznC1Lzr5YbzMYMoxJZ
fFvoh7RNSlEjm4tGRMZqD/SqdaFipnOgKQAbLFjbo0xpZvQT0zXlfINONpUfpQCL
3imYKHbZhcYOH6WOV3nb/61GpUfjRzyKqtFhGyjV3iAklxh1TGqd/u0iOFZy318G
e/xs7qrJz3iXon7Vz7j/5W4UYw3T5kmjb3/yzy61CWDJ5ucfOo1NgHyqm+iWuirn
K4AB9rYIG6/+8+YodFKcCNVREX23rP8hNQlB4cQd8deYOaQmFqU1qc3Yd/FzCbU0
NUtxqpyF984P0FD/fnEGltA8bXQzG1mm26WxdLfKMzz6TftTc9afGHv3/pbbl+00
IhoasrIFR8xbB6cNkiyO
=r7Ii
-----END PGP SIGNATURE-----

--ekdfFKVcD8dkMS1BFm4PLhLbUIkQbGQGp--
