From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 10/11] omap4: thermal: add basic CPU
	thermal zone
Date: Mon, 28 May 2012 12:48:51 +0300
Message-ID: <20120528094850.GS18918@arwen.pp.htv.fi>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-11-git-send-email-eduardo.valentin@ti.com>
	<CAMQu2gxNa4sPMKPLXGkKz_wkbQF8bTYipo4910p-ui9WNdeVFQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5482863990623590358=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMQu2gxNa4sPMKPLXGkKz_wkbQF8bTYipo4910p-ui9WNdeVFQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: amit.kucheria@linaro.org, kbaidarov@dev.rtsoft.ru, kishon@ti.com, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============5482863990623590358==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IQvoI1rdlCKiYEYW"
Content-Disposition: inline


--IQvoI1rdlCKiYEYW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 28, 2012 at 03:03:26PM +0530, Shilimkar, Santosh wrote:
> On Fri, May 25, 2012 at 1:56 PM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
> > This patch exposes OMAP4 thermal sensor as a thermal zone
> > named "cpu". Only thermal creation is done here.
> >
> > TODO:
> >
> > =A0- Add cooling bindings
> > =A0- Add extrapolation rules
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> > ---
> > =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 | =A0 12 ++++++
> > =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
> > =A0drivers/thermal/omap-bandgap.c =A0| =A0 =A01 +
> > =A0drivers/thermal/omap-bandgap.h =A0| =A0 12 ++++++
> > =A0drivers/thermal/omap4-thermal.c | =A0 72 +++++++++++++++++++++++++++=
++++++++++++
> > =A05 files changed, 98 insertions(+), 0 deletions(-)
> > =A0create mode 100644 drivers/thermal/omap4-thermal.c
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index ffdd240..2e82797 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -39,3 +39,15 @@ config OMAP_BANDGAP
> > =A0 =A0 =A0 =A0 =A0This includes alert interrupts generation and also t=
he TSHUT
> > =A0 =A0 =A0 =A0 =A0support.
> >
> > +config OMAP4_THERMAL
> > + =A0 =A0 =A0 bool "Texas Instruments OMAP4 thermal support"
> > + =A0 =A0 =A0 depends on OMAP_BANDGAP
> > + =A0 =A0 =A0 depends on ARCH_OMAP4
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 If you say yes here you get thermal support for the T=
exas Instruments
> > + =A0 =A0 =A0 =A0 OMAP4 SoC family. The current chip supported are:
> > + =A0 =A0 =A0 =A0 =A0- OMAP4460
> > +
> It's more of IP feature than OMAP specific, so something like
>=20
> config  HAVE_BANDGAP_THERMAL_SUPPORT
>=20
> and then let processor's which support enable it. That OMAP varients
> in AMXX etc if needed can make use of it.

Those are just an OMAP in disguise.

> If you agree, then rest of the driver also can be cleaned to avoid
> omap_* in file names and variables.
>=20
> Apart from this minor comment, rest of the patch looks fine to me.

Then it will appear as a fully generic bandgap driver, which is not the
case. This is really a TI thing, right ?

--=20
balbi

--IQvoI1rdlCKiYEYW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw0oCAAoJEIaOsuA1yqREi8UP/jdb0KahOucagrAZcYuEfokz
fN3RGtXHpzkZT8RWKBzo4m6T+RtVVZEjn6ccusMFVUPlysJSYQsEZoe/Sn4SU/0m
KqolGa3rwD/CrUHCqpxDoE5iY4ArhpIyVLUdftjE8W8WYa91xGuWgJotpe3WapC7
M6SCFPHX7Gr2heJfC7Gc/qLQPNEvSv6zfLW/T8EzXrtoqtmEVoMMKuO8Qav8fpxc
la3BeTmBX/S0SjiQwGDBsOLOhsYqn2wLvlUPPf5xEFdHIgIEqSE4Lxw595t0Qz97
m8r8/S3Pal+oex+Adhv2x3NlEdLDTNoQn0ypcqMsei8lxVPcnRr4RIb1WMm7+AkY
FhgtemdTttukFvf9lMXZwE1S7Y9DHyyFfjM/kw5OYOwQBJ2m+zwGwGAd7V74eCNa
w9znEbxNyoTtOJoi8ImMBiKw7tjcPvD9CjRvquHaz6XRHNmbmOxqp3jaqD8e5xf1
LCdCmD05M292wrs7K++tTwLZZh3sT5+KXgGHU0VLSj12cQK0dRP0ZTyYF4xgpKtA
6ukLhfqJJgqW9mTTP+nn52rvKX9zhnl0R5htc6gA+rKEngTLiiwZ9zu+6zjIPJkH
IKrMimkPBUo/fyLlwRxTo+30mUhf6mFpsp45F9B+yJj+uggFaMwC2uk3oc+pMkng
fz6PN30e1ujCYJs5Hooe
=h/ld
-----END PGP SIGNATURE-----

--IQvoI1rdlCKiYEYW--

--===============5482863990623590358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5482863990623590358==--
