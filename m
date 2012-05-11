From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Fri, 11 May 2012 18:38:04 +0300
Message-ID: <1336750684.2625.97.camel@sauron.fi.intel.com>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
	 <20120509002927.GF5088@atomide.com> <20120509081047.GC17333@parrot.com>
	 <20120509153141.GI5088@atomide.com>
	 <1336655257.2625.8.camel@sauron.fi.intel.com>
	 <20120510151725.GA11107@parrot.com> <1336665138.2243.1.camel@brekeke>
	 <20120510174527.GA11275@parrot.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zMpYfk1O6GK3+K6hhntK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16502 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759866Ab2EKPek (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 11:34:40 -0400
In-Reply-To: <20120510174527.GA11275@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: Tony Lindgren <tony@atomide.com>, "afzal@ti.com" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>


--=-zMpYfk1O6GK3+K6hhntK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-10 at 19:45 +0200, Ivan Djelic wrote:
> On Thu, May 10, 2012 at 04:52:18PM +0100, Artem Bityutskiy wrote:
> > On Thu, 2012-05-10 at 17:17 +0200, Ivan Djelic wrote:
> > > But in order to do so, I need the changes that Afzal has submitted
> > > (in particular [3]). Those changes (and as a consequence, my new patc=
h)
> > > won't hit 3.5.
> > >=20
> > > So, when Afzal's patches are pushed, I'll submit a new, single MTD pa=
tch.
> >=20
> > But this is not going to happen this merge window as I understood, may
> > be not even the next one. We need to make UBIFS happy sooner than that,
> > I think. So may be we go forward with your original patch?
>=20
> I'm OK with this too, as the patches are ready and tested.
> The MTD patch is [2], it depends on [1] which has been pushed, then dropp=
ed by Tony.
> Do you need me to repost [2] ?
>=20
> Tony, sorry to backpedal on this: would you re-push patch [1], if indeed =
Afzal's patches
> are not going to be merged soon ? In the meantime, I can prepare a patch =
on top of Afzal's to
> have a smooth transition w.r.t BCH support. What do you think ?

OK, since we now have Tony's ack - I have applied both patches to
l2-mtd.git. Thanks. I have a question though - will send separately.

--=20
Best Regards,
Artem Bityutskiy

--=-zMpYfk1O6GK3+K6hhntK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPrTJcAAoJECmIfjd9wqK0aEAQAILr6bS0Wz6ry6+BOiqA+knn
GZFTEiJK3CiAFzZ2mBjHbZGEU217qfgBBER7oFciHLW9+urjeF5MuhpCjuxMXbeU
7fkSCwbDAzdKBCf8EDk5hsPUGRpislTHkk0TEVYbAo9JBjpUNGeP5nW99AwUNm6X
eu0Crt6EWdRTgmSWX4maHN8wXk0Jw5BCPSR/b15b4N4XyvKMD1Ax2ARPwzz7XNpX
Q2zUxDGnXUnarduyeP9Liaeqfrn6sFNYYOLAtPiA3uiM0OTjyXkIn3wT8jQ9s222
m6cVZHNok9ptMDXYEwVCiaNCp/mun/bxB5Bqs7F4Tn7X432esBQEzb+P0yyvdvhE
B+FF+cjKZDUo8m40FUvN6C5ESf8xlRN9iXR+GZHDePtjn/ibN7gpt0inAdQSKA0x
0lOF1x8BroJzMlIdUW3eHcIULDgsHsXuB46b3Q9ZzisQ7ZpZlCk2rTqJ/Nc2H8Ku
vKPjT5cdRCnlmasY7nfTOhpEY/3R4G1jQd6sQkDBDiSYMFjPb8k6tOdFn32ElME9
eWjKqXk5gkirc/n28qQRILBdiwc3b7jBCwA4NE0dGxvR2TTc2QM/sEwVKLXBmxXN
/BdcRGrowRyOlU5KmwNGRbnt8AMeAx02+C0Ol/jB9lpBoi79oaUO3VvNz7aQ3g2d
IiGgIOtxUvv+BP5B/Gh/
=5aE+
-----END PGP SIGNATURE-----

--=-zMpYfk1O6GK3+K6hhntK--

