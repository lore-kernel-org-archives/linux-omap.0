From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
Date: Mon, 27 Jun 2011 11:00:37 +0300
Message-ID: <20110627080036.GB2508@legolas.emea.dhcp.ti.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1656929460=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaswinder Singh <jaswinder.singh@linaro.org>
Cc: patches@linaro.org, tony@atomide.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, balbi@ti.com, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============1656929460==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 24, 2011 at 10:37:56PM +0530, Jaswinder Singh wrote:
> [CC'ing Liam and Mark as well]
>=20
> On 24 June 2011 20:07, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> > VUSB is a fixed level line and hence have no set_voltage
> > callback in regulator ops, but has apply_uV set to true.
> > As a result it fails to register with the regulator core.
> > Remove setting apply_uV.
> >
> > Also, assign name to VUSB supply, without which regulator core
> > fails to find it and assigns the default 'dummy' regulator to
> > the ehci-omap device.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> > =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0| =A0 =A06 +++++-
> > =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 =A06 +++++-
> > =A02 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/=
board-4430sdp.c
> > index 63de2d3..1ec60be 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -504,16 +504,20 @@ static struct regulator_init_data sdp4430_vdac =
=3D {
> > =A0 =A0 =A0 =A0},
> > =A0};
> >
> > +static struct regulator_consumer_supply sdp4430_vusb_supply =3D
> > + =A0 =A0 =A0 REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");

this should be an array.

> > =A0static struct regulator_init_data sdp4430_vusb =3D {
> > =A0 =A0 =A0 =A0.constraints =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 3300000,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 3300000,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 true,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =A0 =A0 =3D REGULA=
TOR_MODE_NORMAL
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_MODE_STANDBY,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D =A0 =A0 =A0REGULA=
TOR_CHANGE_MODE
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_CHANGE_STATUS,
> > =A0 =A0 =A0 =A0},
> > + =A0 =A0 =A0 .num_consumer_supplies =A0=3D 1,

ARRAY_SIZE()

> > + =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &sdp4430_vusb_supply,

drop the &.

ditto to other.

--=20
balbi

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOCDikAAoJEAv8Txj19kN1fqkIAJADr0arIhE07+H5aGqVhMpY
6Ydg4loo1xqB3HZ5WfD5aZNtyERxFhh4hJzzKl4xAlcoVHTVyG0r7VAuzVs1tEA4
eYferbf9OXsI9K8qHTcU3SIyiN0Og51wu4AcCr0qL/w8KDAPC8W3wv1nu09j4Y1K
lqRl/UYX8dZUAuniKWSSvHfF7ZhE3OP+EMS5rbHQm4rQ1nOqg/lE+tJtn97whyOY
dX4PtydRFK3H3XvUhvJtjZ7eA1lplAf7638PC4DC3DWzepvZq5YXTzg49eEgJtYa
YkmZew7TuH8FV/Qmfuf6hz0xLaF59P2R+Ba6r4nUtllnJT7a/RYsVxHna515pxU=
=yvGE
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--


--===============1656929460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1656929460==--
