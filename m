From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 0/7] Create platform device for audio support
Date: Tue, 6 Nov 2012 13:36:19 +0200
Message-ID: <5098F633.5040200@ti.com>
References: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE1A780B47925B42CDF7A3866"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46142 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab2KFLgV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 06:36:21 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA6BaLId025806
	for <linux-omap@vger.kernel.org>; Tue, 6 Nov 2012 05:36:21 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA6BaLw2004358
	for <linux-omap@vger.kernel.org>; Tue, 6 Nov 2012 05:36:21 -0600
In-Reply-To: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

--------------enigE1A780B47925B42CDF7A3866
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-06 08:19, Ricardo Neri wrote:
> Hi Tomi, l-o list,
>=20
> The main purpose of this patch set is to create a platform device for a=
udio
> support from the OMAPDSS HDMI driver. This tries to follow an approach =
similar
> to MFD drivers in which a core driver creates domain-specific devices. =
Under
> this approach, the OMAPDSS HDMI drivers acts as the core driver, retrie=
ves its
> resources (from DT or hwmod) and passes the relevant audio resources fo=
r
> other drivers to use.
>=20
> This is also beneficial for future DT boot support, as the OMAP HDMI IP=
 will be
> represented by a single node in the tree.
>=20
> Before creating the platform device for audio, I also did minor cleanup=
 to the
> OMAPDSS HDMI driver probe function.
>=20
> Changes from v2:
> *Check the validity of the audio platform device by checking a non-NULL=
 condition
>  rather than an error pointer condition.
> *Pass the ID of the HDMI platform device to handle more than one instan=
ce of
>  HDMI audio platform devices. This is for future implementations that s=
upport
>  more than one HDMI output.
>=20
> Changes from v1:
> *Simplify ioremap further by using devm_request_and_ioremap.
> *Pass to the audio driver only the DMA port and not the whole register =
space.
> *Use a local array for the audio resources and init them with DEFINE_RE=
S_MEM.
> *Obtain the DMA port address offset and size from the HDMI IP-specific =
library.
>=20
> v2 is accessible here:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg79529.html
>=20
> v1 is accessible here:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg77861.html

Looks good to me, I'll apply to omapdss tree.

 Tomi



--------------enigE1A780B47925B42CDF7A3866
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQmPYzAAoJEPo9qoy8lh71F0kP/iRrTGs1VVJjTdXu3uHAUZ3i
GpD/orwXNMwzqaU1e5DrjXDW65jUg1MvkV3YzuDzB8tiWcTcHG5WPBWZcJGo+Tca
DoGyb4MR3DbDogLYHp7+wWk6CuNhxGrwS9Vo96DKISA/CcUIWVVMF+U62s3+v/i2
cfRha4rGjH1jTmPFeHSCqf7ODHMeXSLOG9wF+GPhMDTaHgEPJrbbgUVDdvS1dPfJ
l4YdtNRo4F/xEv9bnMu1IssP+R//rak1zNVrUS2eqYtECaITlCZYj8w/ksrmS9qo
5U2JgDalQvBc/BpXU7AtJu+enwPEfQhc8KpwNvnJXKh5YlCzGgAhmZsQ6nOAdfJQ
9cjnt85PRsPSpYzlwIu5y/jpkYhH/3CNwnzqnXJK1qYgzhbfHnNBuOeuOD7nCwAI
CoDnH0y4KMhA4dKSAoqjBsq79MJsKQ8BLV4tz4vTsK8ZxxOAysC1ySU4ZrH7vZuN
ELGZrjb31x7vElm+Z3r3u4ZOpSfyd4N6vA8EQiVxoxa42LROlZ3CNao4vInbzM/t
cR06l9zj7drel/por1PxH+LSZ9Yz1DV7CHNTHG+WuUREc3v4ZXI81fA7Ys9yeZmH
F3nqB94fOP1/u+RgTVLaePBlgOE6qYTLE4VBqB/4zMo/+Gs/hwdorgVHIF9ib1j9
1+AWk+w5YQkAtpAVdJ1K
=ziMH
-----END PGP SIGNATURE-----

--------------enigE1A780B47925B42CDF7A3866--
