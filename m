From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: linux-next: manual merge of the omap_dss2 tree
Date: Fri, 11 Oct 2013 08:18:34 +0300
Message-ID: <52578A2A.10304@ti.com>
References: <20131010175020.GS21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="XNqRQXMNldPvDr7dARvo8RFQxgfO1pSIR"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131010175020.GS21581@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-omap@vger.kernel.org

--XNqRQXMNldPvDr7dARvo8RFQxgfO1pSIR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mark, Jean-Christophe,

On 10/10/13 20:50, Mark Brown wrote:
> Today's linux-next merge of the omap_dss2 tree got conflicts in
> drivers/video/omap2/dss/hdmi4_core.[ch] caused by ef26958a (omapdss:
> HDMI: Rename hdmi driver files to nicer names) interacting with a range=

> of commits from Ricardo Neri in the fbdev tree and possibly some other
> stuff.  git is unfortunately not giving me a useful diff right now :/

Jean-Christophe has slightly different versions of my patches in his
fbdev for-next branch, so they conflict with my updated versions.

Jean-Christophe, I expected this to happen with the current way of you
having a copy of my for-next branch in yours. Can I now take your
atmel_lcdfb patches to my for-next, and you'll remove all patches from
your for-next?

 Tomi



--XNqRQXMNldPvDr7dARvo8RFQxgfO1pSIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSV4oqAAoJEPo9qoy8lh71j9EP/3p2wrXE1HG9AxVh7vTQfL+z
k/ER29SY3vxgDBXgKwoVTAy8Ui1/h9wrx1gfOLYbJck3vjKMSfW1bjJn8Sx2TNZg
0yImVz8jcJg1Hx7hfwaygFysRnyqniKHw2H0uVRUW8j0b0W9/6EwwAdruHBAcWN1
xvUKTVMsOKzZqhtf7jr600Gn0XBffMaXOgd2vgRaSicaTFfJRe1NzbKynn52qKu0
8GRHFrwEyhsatNPy5UEmtG/aKhQDrqNuEYXavi9/Puv/qB0W/fY84LvI0Sv7uDEM
3/GQbvvm4pYcHaKJpGrhoI+B9GUmamOQ+S9crZPXp4sOCgM7J+6co9//QWaoVHb2
62gs2a1lsSagc5H6wykChKRzv3KovVo+w8uzgLfvLSXIWU1FD1ze1gPAfbOX9OOy
6v0KD1ApGxGUTSKUBUSpgTZ0Pq5qNFmxKSz7TofVMZezq7k8++rsMT3ywKJlAyNC
y4VGWFa8TZUwgf9cSNrfm7bST1E9I2cqWxbl8ioM/RGFqpzAxFzy1OaFrLeHmKVh
DIOXZa5lNfBJUO6YDY+O011h1HbdBTEYTktoN12370VtTKY8w2WepUnC3yA2mvkI
Fcqf1NyU7IN0TCeFKR/NQh9vkbWpzVvcrlFuKjjrU2t+o6wZqVbtYN3BgJ3Vyv2Q
nqeKKrSdBLbrlL/CK844
=J0Qn
-----END PGP SIGNATURE-----

--XNqRQXMNldPvDr7dARvo8RFQxgfO1pSIR--
