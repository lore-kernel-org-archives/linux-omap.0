From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: HDMI: Disable HDMI DDC internal pull up
Date: Wed, 26 Oct 2011 11:30:09 +0300
Message-ID: <1319617809.2097.40.camel@deskari>
References: <1319189226-11019-1-git-send-email-mythripk@ti.com>
	 <1319195967.2870.77.camel@deskari>
	 <CAP5A+B8VxBZSDtPAfV9v2kH6RDLnXKvV9ODfvs5Zjo+EDOOnZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QDNiaBdJ3ad+RCaTWbcR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:55437 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932288Ab1JZIaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Oct 2011 04:30:14 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so1338063bkb.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Oct 2011 01:30:12 -0700 (PDT)
In-Reply-To: <CAP5A+B8VxBZSDtPAfV9v2kH6RDLnXKvV9ODfvs5Zjo+EDOOnZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>


--=-QDNiaBdJ3ad+RCaTWbcR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-10-25 at 15:05 +0530, K, Mythri P wrote:
> Hi,
>=20
> On Fri, Oct 21, 2011 at 4:49 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Fri, 2011-10-21 at 14:57 +0530, mythripk@ti.com wrote:
> >> From: Mythri P K <mythripk@ti.com>
> >>
> >> Disables the internal pull resistor for SDA and SCL enabled by
> >> default as there are expernal pull up's to avoid the EDID read failure=
.
> >
> > What do you mean with external pull up? Outside OMAP? Then it's a board
> > specific feature, isn't it, and not related to the OMAP version?
> yes it is not specific to OMAP. SDP/Panda  boards OMAP 4430 version
> ES2.3 and 4460 have this  board change, but as there is not separate
> board file as such for these boards i have added the check as above.Do
> you have any other idea?

Well, in that case the code is obviously wrong. The choice whether to
enable or disable the pull up has to come from the board file.

 Tomi


--=-QDNiaBdJ3ad+RCaTWbcR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOp8URAAoJEPo9qoy8lh71qIgP/ilm03/qCxMWx1w0JwMKpUZn
v8QiMlsskpWnuaS46Z0IY/mOhdbWsYsKZ1mdzvm1nyBmYasJVT0I6GdSk2v2xtNf
PmQBHrQzkpCRTGECoi0/f5IVAXuEFvtPmW68kfIkxiyHYMI7aTu53VwrD6GJM7eL
GvM/rvgOScWjudWfLCWQw9n2rp2gq8LsaNHE0AJjcINBK4ohq4DdM/1ValoLSHGB
6FavjwHiSAE0KKsvGcfTwvOsJ9uKlZXAqGcg+ptRC8kImaNtqmaCyF1bvgJQw80t
gJAuKuRGGBv8HInst6gl1dBK0sYf+c7tOYiqgX7blKYxxGUgRT3t+R4czbXEi5iw
ua/vMUBHQ4MJBmyAIbX7qp7u6V7j7Yg64hdHP7ocUVUkI+e0L64Zv1Hl9aZ+W/R3
lSRMIplaQWggYAANPhviNXT3D7h+a5hwZ+zqSO87jspgnfQFJCXcWaOxRRYsN/cT
2qMDBxZPXjIj2tHiNMgA2x94e4OcK1pOomKbJjp11nSCvNapIcGX9pyzmRmbcv9w
NG/ryERu1nuAfoMrqWva1HJNzkpksDah+QgQID6/urnPQykvGYmGdIalKS4oz5PL
VoERpUEGkgHtt0cv8HaPzYBYS1vXrii3J8VOHCGNeohax1QxqxBzV7GlWlMPwKlm
9WbZnTWMSk2lcyiC33V1
=uV1Q
-----END PGP SIGNATURE-----

--=-QDNiaBdJ3ad+RCaTWbcR--

