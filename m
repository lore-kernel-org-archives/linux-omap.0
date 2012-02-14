From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 1/3] OMAPDSS: HDMI: Move Avi-infoframe struct to
 hdmi_ip_data
Date: Tue, 14 Feb 2012 14:30:09 +0200
Message-ID: <1329222609.1845.87.camel@deskari>
References: <1328682261-22493-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-bM3LqOBdKo45sKBsT3D/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38240 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755211Ab2BNMaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 07:30:12 -0500
Received: by mail-lpp01m020-f172.google.com with SMTP id gk8so3577637lbb.31
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 04:30:11 -0800 (PST)
In-Reply-To: <1328682261-22493-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-bM3LqOBdKo45sKBsT3D/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-08 at 11:54 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> With AVI infoframe various parameters of video stream such as
> aspect ratio, quantization range, videocode etc will be indicated
> from source to sink.Thus AVI information needs to be set/accessed
> by the middle ware based on the video content.
> Thus this parameter is now moved to the ip_data structure.

This looks fine and separate from the full/limited range stuff, so I'll
apply this patch already.

 Tomi


--=-bM3LqOBdKo45sKBsT3D/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOlPRAAoJEPo9qoy8lh71HiQP/3VQzahVGZjq+K5xXWXf4MdS
7yueEDbJs/hp7Jb2VxQFFzqg+IVZ0f7oHZUOyTVPiHe5LGx/DYg0vhBuoGQbtQKo
nwquairJKqJvFxQn8OiDUDDsOfeDtXrRLMWOheWBkM3fV2NfQaFSXwEJ2DN6kxso
jfb1+dgXtdVXhKDQkbMKvffhGJVLbrV9B650rVWMW5f9WjbUPkcM+RM8m3tVsddP
bOUtcltXW0xE203+SE4xHgxFSobDJ8Lr1lvI59ejtQfuySb3i8YYgBwpRb/KSB2l
5/54SH51dAwzg/JqCzx5Dh/ZlTgb8XkP3tADDahsGPFPfz5FrfK2UP3uhdsGceNN
CbvAH2w4W5THvIq1hfOLNHb+n+zpGG9XZ1VTqpXTQFenOaZeJ0qN2SpGZyDv5MjU
HZGk6Vhih2Ek/3ss/HpP4HgLd5cF12s0kB1PwIG3+ohpVPKe6VPtH9Zm6+gdrAd6
O8RiVNINpHZnkK0lPgRou9OFfzmPhI0nWkPefO6z/IGzE3v+v8kIbOdW3+0r3nz4
FZ6bdsiHZFdCeXYOXyIvfAK28bFcOQ51q3osImkty/PhbImk4hIzjlGO7oKpvKLF
T/oI1Ow71hb3/mxZWj2IiGbJQacXHzeUXsZAbbsy97+uuwzD9/S0wECjYyZtHnsD
ghoZLdn/f7PmLEIEm5vB
=45iz
-----END PGP SIGNATURE-----

--=-bM3LqOBdKo45sKBsT3D/--

