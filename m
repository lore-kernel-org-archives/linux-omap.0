From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/6] pwm: pwm-omap-dmtimer: Fix frequency when using
 prescaler
Date: Wed, 28 Mar 2018 00:14:02 +0200
Message-ID: <20180327221401.GD28163@mithrandir>
References: <20180223101254.GA5746@lenoch> <20180223101553.GE5746@lenoch>
 <20180327215332.GC28163@mithrandir>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1446875616141096061=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180327215332.GC28163@mithrandir>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-pwm@vger.kernel.org, aaro.koskinen@iki.fi, Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, t-kristo@ti.com, narmstrong@baylibre.com, robh+dt@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Brecht Neyrinck <brechtneyrinck@gmail.com>, sebastian.reichel@collabora.co.uk, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============1446875616141096061==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 11:53:33PM +0200, Thierry Reding wrote:
> On Fri, Feb 23, 2018 at 11:15:53AM +0100, Ladislav Michl wrote:
> > Prescaler setting is currently not taken into account.
> > Fix that by introducing freq member variable and initialize
> > it at device probe time. This also avoids frequency
> > recomputing at each pwm configure time.
> >=20
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  drivers/pwm/pwm-omap-dmtimer.c | 93 +++++++++++++++++++++++++---------=
--------
> >  1 file changed, 55 insertions(+), 38 deletions(-)
>=20
> Applied, thanks.

Actually, that was a little premature. It seems like this conflicts with
a patch series by Keerthy that Tony merged into his tree and that you've
based this on.

I think it'd be easiest if Tony merged this through the TI tree, or we
wait until v4.17-rc1 to resolve the dependency. Given how late we are in
the release cycle, I think it'd have to be the latter.

Tony, if you think you can find a way to still take this in for
v4.17-rc1, feel free to do so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6wiYACgkQ3SOs138+
s6Gg1Q//a5nTJ4pj23nLaK67duhDFk9ybO4yU/KORYzcwvoib+BE4v4hNQasJaCw
yAcCv6V37n0ry/yd6B5IXoIcuaR6dnlDVEzNqRuUvroNbB3hgNXxfbSomMuAag6L
9bh+X4U60hdNuXUeTSIeimrxPbHy4LWs1cUIEAdeucdDoU4in6A5U019/RLIe/aL
lmzuRoE1eWdOua8zpMkW12PgnYsa6E1mgvzRhfitGafG1IC9sXdt5sFicEr9/A89
s3VAZPmNk+poa7hHey+7K/kX0cICaaq7qG7EzaN0yo4SOBafcUDEqSR6Rd8oELBy
7tuNFH3VCxMxJVzHG98eeCJh/kSpKzNhlj0Tl3oCSJqHBxKy9a/nk+T/IhdbTC3x
LltXZ0XslLRuI3rpARiXS4bnfLzfuvU8aUQjnc8yW9VJeilfFMa4dlUczIUpwfaa
/tP0ui2KxTq1QqmLK/ulbseT863EvV09AjY3alC623TVbV2i72frqJJpdZCn2NEw
ioNtLAWMyGpmW3Vhcc+tyf4UKcTl2zC1WzmLArJNybJ8byvSY5D+ERZ8hMP5cwEk
3HeBVICeH4BgFnGYxgVyeUFQBUVEBNEbAY73Ri9e5Y4uhe3FhFN4zZ3RD0dyjItt
TKwkf+rj867bc6z/Fb62npxAZVU2k1gvmFElNhTEVaNoH2OGZzE=
=AJMH
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--


--===============1446875616141096061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1446875616141096061==--
