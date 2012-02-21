From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Move Avi-infoframe struct to
 hdmi_ip_data
Date: Tue, 21 Feb 2012 10:40:01 +0200
Message-ID: <1329813601.2090.1.camel@deskari>
References: <1329812560-7945-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-74V7Eq4JXEW6n0hoPHhx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:47126 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752274Ab2BUIkE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 03:40:04 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id s15so962019lag.38
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 00:40:03 -0800 (PST)
In-Reply-To: <1329812560-7945-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-74V7Eq4JXEW6n0hoPHhx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-21 at 13:52 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> With AVI infoframe various parameters of video stream such as
> aspect ratio, quantization range, videocode etc will be indicated
> from source to sink.Thus AVI information needs to be set/accessed
> by the middle ware based on the video content.
> Thus this parameter is now moved to the ip_data structure.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>

I have already applied this patch. Have you made some new changes to it?

 Tomi


--=-74V7Eq4JXEW6n0hoPHhx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPQ1hgAAoJEPo9qoy8lh71TE8QAIPu/slXUWIwgVtbz9MxKfR8
rRl1bSwMuy8cvudCK1BevlvOnexl8VzMdFxoDGcmhi60CPW5qWFx9cFNM5AyQ8cX
QG1lJ8toO3EOL9uW2x3nH5879i+rRyOHVz4xpxCnNywI/fz0G/zhJ+SroHwFO4l3
9GoyUJlXh//zfnJqFopVrr1q2whtSG9NPZXb10fccmtzIh+Dn8Rk3MgKxJj0wlb1
W0eEH5dYKjK+F2b6IgRqxSa0SFuMRQ/mjWAm6rJ5AGWeafSNS3kM6b8QeH+ej+eJ
QeNdnaKquKdh5NSQHt3NbyjcuMHZOuCp43yrfH+fIUkiZ+j31ChQqqNwQnmwOxLA
Gl0LTyjcnerzsSNJ7dy4LPXwQleLUOdtYj0Iwgs5Amv+Isru+AGEmhwJL/IVC9SY
TPCobRRRrHHRlml3ADec9SJHdJT5o6fInE8dJnGr27bjtUhuWcajduGnxvZbhsFQ
AlfPQjVKHVVx6YxLGhel1yy0ighDmITVVKeFzrXTs56X788y38RGuuk9DAKTCfwS
SnRk9GtAgq8RcXPvrJ+hcOJAKc5VeCxTmvFSQRGagu2y734Lmq8CSlV3/woSf7BN
d9uLfGEUKErOLUM2tYJe+bIenHUvj4VAQzP8VekN6oO+jFE0xK2ODxT10dELtB8I
OmEUYvn1LJt46FhZd8Sg
=sj1y
-----END PGP SIGNATURE-----

--=-74V7Eq4JXEW6n0hoPHhx--

