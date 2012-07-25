From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/4] ARM: OMAP4: Remove un-used control
 module headers and defines.
Date: Wed, 25 Jul 2012 14:15:27 +0300
Message-ID: <20120725111526.GI16794@arwen.pp.htv.fi>
References: <500FD2E9.8050408@dev.rtsoft.ru>
	<20120725110635.GE16794@arwen.pp.htv.fi>
	<500FD5DC.7010002@dev.rtsoft.ru>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <500FD5DC.7010002@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 25, 2012 at 03:17:48PM +0400, Konstantin Baydarov wrote:
>   Hi, Balbi.
>=20
> On 07/25/2012 03:06 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Wed, Jul 25, 2012 at 03:05:13PM +0400, Konstantin Baydarov wrote:
> >> Most of the OMAP4 control module register defines are not used and
> >> can be removed. Keep only needed defines and move them to common
> >> control module header just like other OMAP versions.
> >>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> >> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> > Wasn't this one authored by Santosh ?? Where's his From: Santosh
> > Shilimkar ???
>=20
> I hit "edit as new" when I sent patches through thunderbird, I'll fix in =
the next series.

git send-email would help avoiding those ;-)

--=20
balbi

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD9VOAAoJEIaOsuA1yqREvKIP/340312nW5oj2ue9lknbIu09
wNn6oTxpzFN9DYDJneW9FVbagMUm4gXJ6wkaDmjRdg7Ur46erZAeNfafFwB8nyuz
mG0Hgw13YFCFvvwq99lF2GF9EfKijCcTcpq4l0CejV22ZoQy/uYsBIuWcDBrQysY
SZX7hTu0iSSjQHpT9UjIHcPzojw6tFVy7fRt8J0PtpIrDBlZkhNN0F0eLFWS035r
9y8su2d3EfLuC0S1DF+nOcbwBO0OpwyDDOkjaZG2krSiVVjW5zcvfp3i2KvAcbcH
ystMshweSsEHt7IVmuaEt8cR1yQlm6OgUTPYBe9ZhE9RJgxHnW320cuMyp3ShHyV
34KtIP4cEblyQW9ALHsob5i5tQl5DgbVO1xz8JCXLVsWHpncwdFxvqdcgjQdtPlB
DPb6TndekNI9ieHxu++dk9YLpk8q8Udx12yv23Z614IlKCaVCMaebp+zcy/6dQ8d
SBYJ0w5yPP3o4Asa2mwuM54CWRXpoH1EO7MPayYLuDBKX8yu50WVr4R4qLT6iBv+
Pg6an96aywCJYWrD/Vmq95UTP/w4NoqUL23xX0yz/r2IML/1rxSl9XPgFad4Tosk
K0mm7JVtFFyJKGEv3sZLbZF5ao0JxaQpXz6iWBx7tmH2Ja3kFnJGDP6+h4MzOBed
un2gF7bv3XlCDUK+HMlQ
=TtaN
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--
