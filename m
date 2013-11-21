From: Felipe Balbi <balbi@ti.com>
Subject: Re: commit c368e5fc2a190923b786f2de3e79430ea3566a25 regresses MMC
Date: Wed, 20 Nov 2013 20:48:41 -0600
Message-ID: <20131121024840.GA22970@saruman.home>
References: <20131120175814.GC27423@saruman.home>
 <20131120203400.GL2674@sirena.org.uk>
 <20131120205143.GA9182@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131120205143.GA9182@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, ldewangan@nvidia.com, lgirdwood@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2013 at 02:51:43PM -0600, Felipe Balbi wrote:
> Hi,
>=20
> On Wed, Nov 20, 2013 at 08:34:00PM +0000, Mark Brown wrote:
> > On Wed, Nov 20, 2013 at 11:58:14AM -0600, Felipe Balbi wrote:
> >=20
> > > commit c368e5fc2a190923b786f2de3e79430ea3566a25 (regulator: fixed: get
> > > rid of {get|list}_voltage()) regresses any MMC host controller which
> > > uses fixed regulator for functionality.
> >=20
> > This is already fixed in -next.  Please remember to always CC
> > maintainers on mails and please try to write subject lines which are
>=20
> that's why Liam and Laxman are in Cc. Looks like only you were missed.

actually, I didn't miss you at all. your broonie@linaro.org was in Cc
of original email thread. The same email which was used to sign-off on
original commit.

--=20
balbi

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSjXSIAAoJEIaOsuA1yqRE8nQQAI4hldStT39hQmHAsFw3Af0r
TiHQQE+bTOi+VuqZYSoh7Unx21g3H38j3f4IHysT41dSFpPSr5dpT8JCHRwxGv1P
8duUlTEUngX0AM9s2Q2ta+8ofdeNUCAw8mYM0aEYl4VvsExjbR74VS2EN3Elr4DP
1u7eo966Gk4XOtvegBPMvzN1hsWU5IazRVhoxdop2efJjO0IDEQtepmvjprIlgML
3GOVGm6mWc1jzjKl8ZviZW/GaSOosi/tbJZM14MsI9jcA3vo2lwllDiv9ljYdkQi
D8vfChdbuetmlMlZj3QXEqOslon5uO1HaxPMgYBhOuYNujKEF1EGc6zPlHDumTCQ
DlQEQqOVjpI84FvbwkmDmo3l+/fgGl4Ns0b8AHd5TZWNvrfwRsTr+DzoGzdhPhDv
SfFtzLEgTH4fj5tRoKwM3GVo9Xv7p1qdv5XfcACJogEz6KpiMYhkMjjYizBF3JMV
Ea5t7T2FVRWC0J9pmx9siUOJB874LJKe6itDkxxLzgUAyU5uawRbHL78mqHlhibY
1qDv3hHjPFSzZ8zIgTSeqke6ITn8XcmQwt462WmD5iJYqjZV/jOR1s/HpSxto4Jn
6mxnyJgfqGmFBKaisdNr0OCc/N/CTZxNG4xFLESnm3i5rQ9l79pRWIdpZjrY8pnJ
dqQ3Wv8LLWSsE0R02B5/
=29YV
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
