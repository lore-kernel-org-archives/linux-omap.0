From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/15] OMAPDSS: remove all old panel drivers
Date: Thu, 29 Aug 2013 17:06:20 +0300
Message-ID: <521F555C.8090802@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com> <1377783120-14001-7-git-send-email-tomi.valkeinen@ti.com> <521F53F0.4030203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aNh9HvMEXNVd8ICvWCNAkPo2XkbiQBri3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58476 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab3H2OGW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 10:06:22 -0400
In-Reply-To: <521F53F0.4030203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--aNh9HvMEXNVd8ICvWCNAkPo2XkbiQBri3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/08/13 17:00, Archit Taneja wrote:
> On Thursday 29 August 2013 07:01 PM, Tomi Valkeinen wrote:
>> The board files now use the new panel drivers, making the old panel
>> drivers obsolete.
>>
>> Remove the old panel drivers, Kconfig and Makefile entries, and the
>> panels' platform data structs.
>=20
> Can we convert the picodlp driver to the new panel driver model, and
> report it as broken for now?

(please cut your quotes a bit, you just included some thousands of lines
of code there =3D).

We could, but I'm not sure what would be the point. The new picodlp
would be (more or less) totally new driver, so we would still end up
removing the old driver. We can as well add it later if we manage to get
it working.

The RFBI case is a bit different, as there we just changed the current
driver a bit and we didn't create a totally new one.

 Tomi



--aNh9HvMEXNVd8ICvWCNAkPo2XkbiQBri3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSH1VcAAoJEPo9qoy8lh71FkUQAKWc1UwI7H3O6CLLuBOS1oX6
RnV2kgq23IKiMqgFhoky+MXkiM9QIf8Yj+UWMjqUUGuMjDpYkdPi1qIEL3lOA/3U
5aXtkXaejAqVlbCmbgkvRMgbYjZcQHiGTCgna1Kt2G//1F2VpX1SEqUukbESUKpw
XqtRwLmt+4y69dWRuHm3Vh1AwM5auWLxp74w0AmKg2Lq3kTM3jRBmrEHqXgwSyGS
0L+ebDIfqjzZMGajUTj3rc4r7QRukRNFap1/VD6Wyc9rff+YDOMnf0uOb8ZU+SyI
S3DikrFRZf/F9L86bUWyc6ZzIs/88xzmg/EYS7IzEJx9HMFniWpgXyJOo+v40rqA
1aqxcyWORRzBfItVp5iwKrboYLtaq7+q3DUeE68Mn84qhR4eGx8f10WQJEELcYk2
xJpfV2MkAGyOL29P5ugCvk62MUBYQch8l9pRrhgdBumNTkA9kXyqtyvXsqriAkPW
yGvEc3Oca+83FkZtZaeMBt7OxXTujJ50gAaouochR/uojwjW08BXApBywyQOX6O5
Y9D7Gu6b0/dCWL4OkUqtKGwf6+6WQPUhw6lek00V3sXZN/VBEq6D3tDVAGPRSopT
prcYuM+kxGVzfFQXpWjgXyNViR8SBf8jwVfY8EJFZxr9mTWDTZ5PKEJwfHS9Se1o
GLvGY/hGHDovp4AK+2m7
=faee
-----END PGP SIGNATURE-----

--aNh9HvMEXNVd8ICvWCNAkPo2XkbiQBri3--
