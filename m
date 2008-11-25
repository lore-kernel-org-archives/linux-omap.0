From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 18:45:03 +0100
Message-ID: <26A46655-D823-4AE1-A058-79A769051398@student.utwente.nl>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-20-219800378"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:18690 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbYKYRpP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 12:45:15 -0500
In-Reply-To: <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-20-219800378
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable


Op 25 nov 2008, om 17:59 heeft Grazvydas Ignotas het volgende =20
geschreven:

> Hi,
>
> TWL4030 and compatibles have 2 pulse-width modulation (PWM) generators
> (PWM0 and PWM1). They are used for backlight control and charger LED
> in pandora board. I wasn't able to find any drivers for them in
> linux-omap tree. Is there anyone working on these? If not, what would
> be the proper way to expose them? May be as LED driver?
> I saw lcd_omap*evm.c just write to LED PWM registers over i2c to
> control backlight, I wonder if I should just do the same.

Regardless of what implementation you choose, it would be *great* if =20
people used the backlight class for things like backlights. /sys/class/=20=

backlight/<foo>/brightness is such a nice standard that lots and lots =20=

of usespace tools rely on it.

regards,

Koen


>
>
> Gra=9Evydas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-=20
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-20-219800378
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJLDmhMkyGM64RGpERAmXKAJ0W1rBliHc8uV00BhCDB7w7bgph0gCeO/ae
j5h5/eh/+SPBjespZywEM9s=
=S4TQ
-----END PGP SIGNATURE-----

--Apple-Mail-20-219800378--
