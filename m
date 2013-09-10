From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Tue, 10 Sep 2013 15:40:38 +0300
Message-ID: <522F1346.3020206@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="DHI2P7aGiJMTwxk7hPWFmkN9f48nTQljp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37143 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410Ab3IJMkp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Sep 2013 08:40:45 -0400
In-Reply-To: <522F0F9B.9050705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Stefan Roese <stefan.roese@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

--DHI2P7aGiJMTwxk7hPWFmkN9f48nTQljp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/09/13 15:24, Tero Kristo wrote:
> On 09/10/2013 03:19 PM, Tomi Valkeinen wrote:
>> On 10/09/13 15:12, Tero Kristo wrote:
>>
>>> If it claims it is not locked, it means the DPLL itself is disabled. =
You
>>> could try clk_enable for the clock before doing clk_set_rate.
>>
>> Hmm, so is it required to enable the clock before setting the rate? If=

>> so, I think I'm using the clocks wrong in all the places =3D).
>=20
> In generic case, it is not. But DPLLs behave strangely if they go to lo=
w
> power stop mode. If there is any downstream clock enabled for a specifi=
c
> DPLL it is enabled and things work okay.
>=20
> One could also argue that the API behavior in OMAP is wrong currently,
> as the bypass rate is something you are most likely never actually goin=
g
> to use for anything....
>=20
> Just try the change and check the results.

Ok, so as Stefan said, enabling the clock fixes the issue.

How do you suggest we fix this? Changing omapdss to enable the clock
before changing its rate is not very difficult, so it can be used as a
quick fix. But it doesn't sound like a proper fix if this is not
normally required.

And, maybe I'm missing something as I don't have good understanding of
the PRCM's PLLs, but the current behavior sounds odd. So the DPLL is
off, and in bypass mode. When we try to change the rate of the clock
provided by the PLL, shouldn't it fail, as bypass mode's rate cannot be
changed? Or better, change the non-bypass rate.

How is the DPLL4's clock rate 432000000 anyway in bypass mode. Isn't
bypass mode usually plain sys-clock, or such?

 Tomi



--DHI2P7aGiJMTwxk7hPWFmkN9f48nTQljp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSLxNGAAoJEPo9qoy8lh71VpMP/jDn/9kNn55l7E43BHijaSho
ozVkBooZ8LHiyJh36/X8un0FLcZnK9HpJHRByo7qveLLgZI0B/kjb9efrhxhh0hr
KEG73Yngv9Rq8t57gsPKtl7RhDjWL1YaEt65SRKhYB4kUkKJJaNCZxE9+wrrJojy
wf+XPEGCDk9dVXLUh75CBv54r6UDmqGqnMzrHCHKZeFPLRoEYBD4oUNOLrVHRWHh
DjO26BH98RcBiTGK4ZQIdwaTSKCTcL1NnCVGbzLFwwx9moW47ITMvmXg/AjENKWN
6afgyfYoR7nQuN2D5Mw58mPXcyDh8WyVgbxZ2OUiMIaitFBJ+1+QPx8L4/Ka402K
zAJDdh5UzRfC2yqmXIa/h9PUvdTTpAZmasXjHpdH97ZnpPLUIHvzBXL328660WK4
FopKHMIu1icaIjJ2jfYxztdG2e3iJ3rOPnUsVr7NZmWCkSYWme7q9Zn8NkruSXVo
/1KqUxrkidcFhKK/cVQrioTDzWzsrKr4yuJEqGCLw9lZ47hr6Pk223tT/liGQCd8
PvJ5t41Ie4+JGVxcKwKLy52V1oznN896MH3EvEc1h+8b7hcLyoukTMt/Mh+N6r/q
wVN0IId1vWjBNJir8Zo5ElZnRE6wyWut+T1kDrxvmE0OXBb8Y/0ddWXBxicagnqJ
MFSPxZEjPFHMYq7s8XMd
=6efY
-----END PGP SIGNATURE-----

--DHI2P7aGiJMTwxk7hPWFmkN9f48nTQljp--
