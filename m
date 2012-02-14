From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 3/3] OMAPDSS: HDMI: Sysfs support to configure
 quantization
Date: Tue, 14 Feb 2012 14:22:03 +0200
Message-ID: <1329222123.1845.82.camel@deskari>
References: <1328682261-22493-1-git-send-email-mythripk@ti.com>
	 <1328682261-22493-2-git-send-email-mythripk@ti.com>
	 <1328682261-22493-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-q94CFq6x0RsH1MXZVojp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:58280 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754193Ab2BNMW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 07:22:27 -0500
Received: by mail-lpp01m010-f54.google.com with SMTP id z14so7097806lag.13
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 04:22:06 -0800 (PST)
In-Reply-To: <1328682261-22493-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>


--=-q94CFq6x0RsH1MXZVojp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2012-02-08 at 11:54 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Add sysfs support for the user space to configure limited range or full r=
ange
> quantization for HDMI.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>

I'd rather not add another non-standard sysfs entry.

The color range is something that desktops have to handle also, so
there's probably ways to handle it in DRM. DisplayPort also has the same
range setting, so it's not specific to HDMI.

So I propose to add a kernel API for this in the omap_dss_driver, so
that the users of omapdss may handle setting the range as they see best.

Btw, the displayport spec speaks of VESA and CEA ranges. Does HDMI spec
only speak about limited/full range?

I also only now realized that we have full/limited range setting in
video overlay's ATTRIBUTEs also. And it seems that we currently set it
always to 0, i.e. limited range. I wonder if this causes color
degradation in case the HDMI/DP output also sets limited range, and thus
the color range gets scaled down twice...=20

 Tomi


--=-q94CFq6x0RsH1MXZVojp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOlHrAAoJEPo9qoy8lh71QQUP/0IKkgKybqfhU3TXqTSZYNw0
rU8UtBN/+ymH1NZLeKgAlj9h9p3yqJPOTjkTj91fIvhCUAx+39tPTVweL7NW+CCy
7ffCpQ87rV/733ihSxeLRDeE25+7RzZAW4SgfkZ6UgmlXzqymUOYtiaTHdNSd4aj
68t5O2OLXZxFqoo5pezbbTNCuVpuzEsheecp+zKtG56XMTYvXiyY25DrnP5055go
ixlQhUfUTRuzpcf6u5kE5jvU+pdAXopO48WY5p0pQY0GJTH4OHjYgE9rIC6eqwji
dpY2xpeY8GcWJBi5oJY9ysC/CHrgMIfAzy+qXponCFD9OooNrLzFtmj+UsuqMThY
gVjZwGD+f7gKRLye1KXeFddFk5AUqbcgU2vOjgklQftDizgkxNbCkX+H/bi6M+fk
rPPj06ZdSWuKX3mo1d2hl4W6u/oBb0QVpyyqZEeNp6w0gbVol98lodLVmeN9cheP
+UZgUejz8hGycRf8IMcdmqKQrPotpwk/PzBDHb8Q3iaiOJEcy493R3StR/YQrvjY
Pzj2N56QDu6c74BS/WGdXQBOJ/uPzFVcPzVbOUi1gFPBfs4qXFulDmiusK9H3Vpt
kGETLldK6qMgGBIa9FhGX7lxVf2CfFg7C28ksXjAbnBqTNPK23h/eKd0lcSpy/Kg
5e6NJjQM76OIq5/KYd4K
=0kbi
-----END PGP SIGNATURE-----

--=-q94CFq6x0RsH1MXZVojp--

