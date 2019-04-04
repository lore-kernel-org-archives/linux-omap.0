From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in
 self refresh mode
Date: Thu, 4 Apr 2019 12:51:11 +0200
Message-ID: <20190404125111.3800e26d@kemnade.info>
References: <20190322171619.4180-1-j-keerthy@ti.com>
 <20190322171619.4180-4-j-keerthy@ti.com>
 <20190401175245.GJ49658@atomide.com>
 <20190401203854.3b6ec1a2@kemnade.info>
 <20190401204033.GK49658@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3047837441057493532=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401204033.GK49658@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, d-gerlach@ti.com, Keerthy <j-keerthy@ti.com>, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3047837441057493532==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zBEpOfvpEgH9e0gZc=FJ858"; protocol="application/pgp-signature"

--Sig_/zBEpOfvpEgH9e0gZc=FJ858
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2019 13:40:33 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190401 18:39]:
> > On Mon, 1 Apr 2019 10:52:45 -0700
> > Tony Lindgren <tony@atomide.com> wrote:
> >  =20
> > > Hi,
> > >=20
> > > * Keerthy <j-keerthy@ti.com> [190322 17:16]: =20
> > > > +static int am43xx_check_off_mode_enable(void)
> > > > +{
> > > > +	/*
> > > > +	 * Check for am437x-sk-evm which due to HW design cannot support
> > > > +	 * this mode reliably.
> > > > +	 */
> > > > +	if (of_machine_is_compatible("ti,am437x-sk-evm") && enable_off_mo=
de) {
> > > > +		pr_warn("WARNING: This platform does not support off-mode, enter=
ing DeepSleep suspend.\n");
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	return enable_off_mode;
> > > > +}   =20
> > >=20
> > > Considering off-mode suspend depends on how the board is
> > > wired for various things such as memory, PMIC and the related
> > > signal lines, I agree using the machine compatible is the best
> > > check we can do here.
> > >=20
> > > But since the device can hang during suspend unless things are
> > > configured right for the board, I suggest you rather list allowed
> > > boards here that are known to work with off-mode.
> > >  =20
> > Could we somehow describe this property of the hardware
> > (is-offmode-capable or is-wired-for-offmode) as a separate devicetree
> > property of the soc?
> >=20
> > In mmc we have for example "cap-power-off-card" for
> > indicating some is-wired-suitable-for thing. =20
>=20
> And we also have "regulator-off-in-suspend".
>=20
> How about "soc-off-in-suspend" for the generic name?
>=20
Well, remember my "omap3: give off mode enable a more prominent place"
maybe we can use the same  capability property for both proposes.

I was a bit unsure about it, so I did not continue with it yet

Regards,
Andreas

--Sig_/zBEpOfvpEgH9e0gZc=FJ858
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlyl4aAACgkQl4jFM1s/
ye9U5w//T34g0MW+LB3Q7G9x68lh+6J5P3XCgBURVZ/W43orCCNdDqXTC+5l4j+0
75q+jiK8XN5A9YBRU7AVE94FPTdVhvbEYvaKIT2qAuT2NZRWlITHsjxFv3sY2Pse
3zU+OvzYVRpt8d/X1OHouIe9APy4zqsfIT+bq1YizvpAIofOQEe/0EDwvaSq8SCH
cYb1h+RQLGIUphYQ8wWJeBxLzr0gRuXPwdYzU7tx2UmJEVZNePUg0rf9ftTg9GT0
UbZ5FvrlM/cv7d/NPfpfEpNnATEa0edZumrOOGsptuRjH4iGKP97UFa6ItN/K/lS
sQWYJH5WgkEsFHtFVDWnt0jn4qF1o0uYWDGHDc5/o7oJYOBgunikNPfgui7ARkBK
xLlqQmmpsgMoxHVwMlYqxt/iAD7b/o+VAFG05Za4Pce5NP/ff4BEJJ2xKU4ushvx
Y6dUFpVl6gU4JVR59sbeCIAWJAsOWFoTNFJZnc5ZXBQvSzUnuijKULtVt60CyiWg
ytV7Atfl5XW38Nryi86haI9wycljGOeZTmg4Q6HSx4yuzAscvjSyRIVFgGQ6cJP3
x+WPeRN2EjDcQzjX0ktsb4Akt/dcak1wNoOs8ix/UVe4WoKF3d8Zyb5uXfVk9xPp
ZpZoXRHtsDcMrxrKR+NMU4z7rSQgLNTn+I5t6MXGo3zPz1iHm5c=
=Izd4
-----END PGP SIGNATURE-----

--Sig_/zBEpOfvpEgH9e0gZc=FJ858--


--===============3047837441057493532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3047837441057493532==--
