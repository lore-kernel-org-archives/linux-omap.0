From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Thu, 15 May 2014 15:25:37 +0300
Message-ID: <5374B241.9010201@ti.com>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com> <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com> <20140515060834.3084.5199@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6KxgkLIuRAxNFmGoJDLqJJFn2Mx9g2doC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799AbaEOMZn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2014 08:25:43 -0400
In-Reply-To: <20140515060834.3084.5199@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

--6KxgkLIuRAxNFmGoJDLqJJFn2Mx9g2doC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/05/14 09:08, Mike Turquette wrote:
> Quoting Tomi Valkeinen (2014-05-12 05:13:51)
>> On 12/05/14 15:02, Tero Kristo wrote:
>>> On 05/08/2014 12:06 PM, Tomi Valkeinen wrote:
>>>> The current DPLL code does not try to round the clock rate, and inst=
ead
>>>> returns an error if the requested clock rate cannot be produced exac=
tly
>>>> by the DPLL.
>>>>
>>>> It could be argued that this is a bug, but as the current drivers ma=
y
>>>> depend on that behavior, a new flag 'ti,round-rate' is added which
>>>> enables clock rate rounding.
>>>
>>> Someone could probably argue that this flag is not a hardware feature=
,
>>
>> I fully agree.
>>
>>> but instead is used to describe linux-kernel behavior, and would
>>> probably be frowned upon by the DT enthusiasts. Othen than that, I li=
ke
>>> this approach better than a global setting, but would like second
>>> opinions here.
>>
>> I think the dpll code should always do rounding. That's what
>> round_rate() is supposed to do, afaik. The current behavior of not
>> rounding and returning an error is a bug in my opinion.
>=20
> From include/linux/clk.h:
>=20
> /**
>  * clk_round_rate - adjust a rate to the exact rate a clock can provide=

>  * @clk: clock source
>  * @rate: desired clock rate in Hz
>  *
>  * Returns rounded clock rate in Hz, or negative errno.
>  */
> long clk_round_rate(struct clk *clk, unsigned long rate);
>=20
> Definitely not rounding the rate is a bug, with respect to the API
> definition. Has anyone tried making the new flag as the default behavio=
r
> and seeing if anything breaks?

The v1 of the patch fixed the rounding unconditionally:

http://article.gmane.org/gmane.linux.ports.arm.kernel/295077

Paul wanted it optional so that existing drivers would not break. No one
knows if there is such a driver, or what would the driver's code look
like that would cause an issue.

And, as I've pointed out in the above thread, as clk-divider driver
doesn't an error code from the dpll driver, my opinion is that such
drivers would not work even now.

I like v1 more.

In any case, I hope we'd get something merged ASAP so that we fix the
display AM3xxx boards and we'd still have time to possibly find out if
some other driver breaks.

 Tomi



--6KxgkLIuRAxNFmGoJDLqJJFn2Mx9g2doC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdLJBAAoJEPo9qoy8lh71sd0P/i3nUX0Ebg3Wl9wgEO9fCaEk
H+I0UgRl2QiwnKU7+f8lFbMRXvz+VSepYL4L460Arx/1P0bABRIvNo2LFC9m2TCP
vqGWResivRPX49Y6YlQNVlZeKCuBjaD1r3M+udOVfhqBDbzdUj4ScECASbBR1UQV
7wKPBM/1xKKGCgNYinVKe7fOzp8s+aoMI0FALMfT0Sbg0rVcQDW0TqfyG5OrYqw/
vI5+FYuTNBHwy71kOcLLIPfH2AuJvZ+R8HwTgUBbzml9DQ8vBODnvUp8McA0Q4CX
DDYUvLaKgwQewNhB/6d0l4/QALQXsoewbdP+wXF6/WNicW8AM2ZNtSVN8NhIyroO
QZYwMtS/EGZIP21BF4oGrE3tdtL8nN40KIElWX3Yh1jtHcVa4B03KjWOnZ4kuXUn
GOxO26R6LuBHpNCoVWGRkQxba3BafH2KF1BLy3Ad7V42sBhNSQqWZZ1dwk9+xaWA
8kc6I01pm2YwWSOSj3m9YRskWHPhAT8rTq8V+voQXEJ+sUok3Nperkd+D+j21UVc
g17pbHsp10pC9F5AFW8Mo4eHEoW3Dy/r7HADOTQ22mjZ9GTRt2OZc2sGe4Jv5Yqt
WcydHFkec/6YxWBqIywi6hd8Wkg0tj295I2QkUo1EoX66uxubDswYA6/01aB6v+b
MBg+V7Lj3yXJwCSQbCng
=7aaY
-----END PGP SIGNATURE-----

--6KxgkLIuRAxNFmGoJDLqJJFn2Mx9g2doC--
