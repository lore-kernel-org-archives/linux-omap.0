From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Fri, 27 Sep 2013 11:41:25 +0300
Message-ID: <524544B5.9050402@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com> <522F1346.3020206@ti.com> <522F1BF9.5050006@ti.com> <523019EE.5000508@ti.com> <5232C413.8010207@gmail.com> <5232F85E.7050502@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fFSSi7AHKDWoSIKRSrqgnS4abiRK9hduW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57627 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab3I0Il3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Sep 2013 04:41:29 -0400
In-Reply-To: <5232F85E.7050502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kristo, Tero" <t-kristo@ti.com>
Cc: Stefan Roese <stefan.roese@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

--fFSSi7AHKDWoSIKRSrqgnS4abiRK9hduW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/09/13 14:34, Kristo, Tero wrote:
> On 09/13/2013 10:51 AM, Stefan Roese wrote:
>> On 11.09.2013 09:21, Tomi Valkeinen wrote:
>>> On 10/09/13 16:17, Tero Kristo wrote:
>>>
>>>> In theory, DPLLs can also be used in their bypass mode to feed custo=
mer
>>>> nodes clocks. I just think the check in the clkoutx2_recalc is wrong=
,
>>>> and should be enhanced to actually check what is the target mode for=
 the
>>>> clock once it is enabled. Maybe something like this would work prope=
rly:
>>>>
>>>> diff --git a/arch/arm/mach-omap2/dpll3xxx.c
>>>> b/arch/arm/mach-omap2/dpll3xxx.c
>>>> index 3a0296c..ba218fb 100644
>>>> --- a/arch/arm/mach-omap2/dpll3xxx.c
>>>> +++ b/arch/arm/mach-omap2/dpll3xxx.c
>>>> @@ -658,14 +658,12 @@ unsigned long omap3_clkoutx2_recalc(struct clk=
_hw
>>>> *hw,
>>>>
>>>>          dd =3D pclk->dpll_data;
>>>>
>>>> -       WARN_ON(!dd->enable_mask);
>>>> -
>>>> -       v =3D __raw_readl(dd->control_reg) & dd->enable_mask;
>>>> -       v >>=3D __ffs(dd->enable_mask);
>>>> -       if ((v !=3D OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_=
TYPE))
>>>> +       if ((dd->flags & DPLL_J_TYPE) ||
>>>> +           __clk_get_rate(dd->clk_bypass) =3D=3D __clk_get_rate(pcl=
k))
>>>>                  rate =3D parent_rate;
>>>>          else
>>>>                  rate =3D parent_rate * 2;
>>>> +
>>>>          return rate;
>>>>   }
>>>
>>> Stefan, are you able to test the above?
>>>
>>> I'd rather have a proper fix for this, than hack omapdss =3D).
>>
>> Okay, I finally found some time to test this. The patch above generate=
s
>> this warning:
>>
>> arch/arm/mach-omap2/dpll3xxx.c: In function 'omap3_clkoutx2_recalc':
>> arch/arm/mach-omap2/dpll3xxx.c:663:6: warning: passing argument 1 of '=
__clk_get_rate' from incompatible pointer type [enabled by default]
>> include/linux/clk-provider.h:423:15: note: expected 'struct clk *' but=
 argument is of type 'struct clk_hw_omap *'
>=20
> Yea sorry about that, I just quickly hacked the patch together without =

> testing it at all. :P
>=20
>>
>> I then changed it (not 100% sure if correctly) to this version:
>>
>> +       if ((dd->flags & DPLL_J_TYPE) ||
>> +           __clk_get_rate(dd->clk_bypass) =3D=3D __clk_get_rate(pclk-=
>hw.clk))
>>
>> And this seems to work. At least the clock rate mismatch warning does =
not
>> appear with this patch applied (and without the clk_enable) in the
>> bootlog any more.
>=20
> Yea, looks good to me, however I guess I would like second opinion on=20
> this also.

Tero, can you queue this patch? Or who should handle this?

 Tomi



--fFSSi7AHKDWoSIKRSrqgnS4abiRK9hduW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRUS1AAoJEPo9qoy8lh71nmAQAIqwh+h9Zk7Txsarcdu0YLSC
EpZz+34XVSXGAHxBkgKoXzx/zkdRLUIeWJLziX4WNcWaHpowzTkr6xmLiPhS6sJp
3IYhDVR6CFPM0InwS2G2CDfbwPqQObjpw4arq8ADfsTdC8xWdSPNMoYAu9he74Xq
0MtrH94PxviP9xltJQYFVfgqZOrceBMngw3GmIXMCZZ+MhSsw2DtMULmUJ5qrJH9
r2tGkYu9Xjaow2/qUfK5PoB27gkeWx6O2TgHDMMiOq/UBri5JsUNQZoThCqQFog6
WRptc0ikryxscyNxdWuT9NLHRAysoxwTw5Rn8o5pD5tcsAYZUqSgM4G6YBTXdDp2
iZSuW3+3Uwx+hD6zuXo84uhjSykYkN7OIvBWuuHV3Zrgu2RFCJS6ZCGPrBVhUpjm
N7RmpPM1KMIMBRGnheo55x4KxUWdYUI20M0MP2SxBgk4QZnKyNBz/3eUHLxAwYK2
gUdUgR6Y7Sd4hpFhlENR/STLTc6iQzg3TMjSGfYuCXqxXLJa/+2qzllu2MzM4mkw
5X0w0DK9C1RZnZEBmKA4SoT7+2QF/4Qyd/4OOVLKkQo+CpaHcfoqXqWW/ZvjMe6u
aye+/MC/DMZMfuJNlsTZncE3qwfi/sMZbMHrbvZdXKw5jiqqUFJg5LnCCjdw0L0A
UXufsw4w3n+gFErjRbXB
=gwEP
-----END PGP SIGNATURE-----

--fFSSi7AHKDWoSIKRSrqgnS4abiRK9hduW--
