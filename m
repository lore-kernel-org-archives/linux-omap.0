From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH-v4.2-rc6 2/5] arm: boot: dts: am4372: add ARM timers
 and SCU nodes
Date: Wed, 12 Aug 2015 09:52:16 -0500
Message-ID: <20150812145216.GB13884@saruman.tx.rr.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-3-git-send-email-balbi@ti.com>
 <20150812072816.GR4215@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4520663594562430967=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150812072816.GR4215@atomide.com>
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
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============4520663594562430967==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline

--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:28:16AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150810 14:44]:
> > AM437x devices sport SCU, TWD and Global timers,
> > let's add them to DTS so they have a chance to
> > probe and be used by Linux.
>=20
> Is this one safe to apply already without the Kconfig change?
>=20
> Or will it cause multi_v7_defconfig with the timers selected
> to not boot properly?

I'd have to try :-) But it should be safe, just the timers won't be
chosen for anything :-)

--=20
balbi

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy12gAAoJEIaOsuA1yqREKlcP/2P+vKBqZxEUTAIOChasficf
5bJXNTBT6NaI2V2WQ7MFzktrPW8eT6Rs13CxD1uk1hkivsOyQvS8Bar+AOKrxjOo
dQLB9kDYfT6+RXxfQ3IQgq8ffTgZKKoUXuBrvrB4mzDWdLul8MK/yf59uBtoke2g
XfUbsGbwpkwNbfhJfSzupEEtnqTEBmEAuXQstPfC4OjQap2RRVPYK1jYr/5FBmlV
DtN/Fl+63RzBa7B/OXgeNPoQ0cogjMPG/rheAtNdRltX4UCuBqKnUnx9dDW4b948
98dP9+QxpLKNNGRXMzy4REXMN/5U+4jq4F0n5V7QmfuxfOI1oX+FLe016R8Cvi+g
COhihIjV9wCd1/sLGcF9knMpDJiriDXBJj6HM5bIz4Xgpa5J43sn3ggM3RYta1cN
WjEZbHuCWHGaMHFAuUGg/77DPf/XoXR3tfcnWQiHZGvQGpdk+mb9t3H+AVaRzxOT
6HXCNErDgM8jrkfCf4hegQW+6jWyFnj333553PJINKZAj4MLW+5W2VvFV3zNGLae
Wn7XspqfRuj3mwDyf1pWPMKSxUbAZllr6sZPQW4XntAtKz6bmTkXOZwCWL5mtM2x
nqZzzwR7vDJ6VwjJPkx30A0QHx74CxgpEh2iAheAjNcNUA8LAahs87t/izo1vaMx
XH6PcVmqd37Wptya+NLT
=OnO3
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--


--===============4520663594562430967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4520663594562430967==--
