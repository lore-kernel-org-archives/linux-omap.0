From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
Date: Wed, 18 Sep 2013 11:36:49 -0500
Message-ID: <20130918163649.GL21559@radagast>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <20130918133025.GB2953@amd.pavel.ucw.cz>
 <CAAwP0s0nGthkm9Bp1ug23Rtz6-sbR60FFTSfd-Cj9wKMU0RBEA@mail.gmail.com>
 <201309181756.12782@pali>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5858081341090679724=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201309181756.12782@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, linux-usb@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Vorontsov <anton@enomsg.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, freemangordon@abv.bg, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============5858081341090679724==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Content-Disposition: inline

--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2013 at 05:56:12PM +0200, Pali Roh=E1r wrote:
> On Wednesday 18 September 2013 15:57:13 Javier Martinez Canillas=20
> wrote:
> > to split the patch in two since the patch was solving
> > two separate issues
>=20
> My patch does not solving *two* issues. It is *one* regression=20
> and both parts of patch are needed for fixing it. Read commit=20
> message again. It does not make sense to split patch fixing kernel=20
> regression into more one line patches - or please clarify why.

issue 1) twl4030-usb.c doesn't initialize atomic notifier head
issue 2) musb doesn't call notifier chain

do you need a drawing ?

--=20
balbi

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSOdahAAoJEIaOsuA1yqRE3DEP/jghJ8vczhUc/02pY/gikq8K
dP1JgjgcVUyEjXqgqk+ISSFU1psVrMRZoY3NNDPxLWxkNMcWMdhQ+yHCuUqV0dyh
56okmvdDSu8wqv9yLbV8pNUqSu/FKEdArEewCahgj9AW1ZcJtnm1Mi5d4DJpN1St
yyEamsoBt/K0C4V4/TszjcYeT2lPCAmHc21JT8K1hENrb48fGzooPVOqfC311l4v
zZnznKx20tq5Qq/iAjYdQ4YN9Na2igO69ohoM9CNSO+IFjKpUqrAAtl3IbjMXKO1
0GSo7KfBqZaKTWu8Jg/pUn1QmKS/iyx5LivRWyZH/yT7y5IPRUCw1FQcH26hV/1y
Un9b6mcUW53t5dQgxry13Nf9Vjvg0VDb/BN3gaVKvrRV4ovlqyvAmsca4aQhIVBw
6oXLC8+dPZ0d8wnn9T4ILCD7eWooi6O14igAUfrXIUBn5sehNbfXvcfTq6Tvb4sT
29x0NiH7uZCEHUSc8VZYFRARSvAahs50NrXtppXf2EZbO7T8wwt/cVJf9BnNSPoo
N8Q3I33DdZlcnuL3TCRQJeBJPtGl2GfD6rGHkQyuLwK1PMipVvke/75A4Yl4Qe2R
WrUXJwuSu8c2DbELUyvDt9F1h82Li6dYuAtMrGbL0HViuKyACVQ+DB3kKr3JMpyT
wDMHbWZKlxNHfjI79rHT
=jUdC
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--


--===============5858081341090679724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5858081341090679724==--
