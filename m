From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio
Date: Mon, 21 May 2012 19:07:58 +0300
Message-ID: <1337616478.2717.13.camel@deskari>
References: <20120509163649.GN5088@atomide.com>
	 <1336601703-27977-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-XWMhZuEoqLLBbLVDg3MF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47190 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754655Ab2EUQIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 12:08:10 -0400
Received: by lbbgo11 with SMTP id go11so3413866lbb.3
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 09:08:07 -0700 (PDT)
In-Reply-To: <1336601703-27977-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, chase.maupin@ti.com, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>


--=-XWMhZuEoqLLBbLVDg3MF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 15:15 -0700, Russ Dill wrote:
> This removes several boot warnings from board-omap3beagle.c:
>=20
>  - gpio_request: gpio--22 (DVI reset) status -22
>  - Unable to get DVI reset GPIO
>=20
> There is a combination of leftover code and revision confusion.
> Additionally, xM support is currently a hack.
>=20
> For original Beagleboard this removes the double initialization of GPIO
> 170, properly configures it as an output, and wraps the initialization
> in an if block so that xM does not attempt to request it.
>=20
> For Beagleboard xM it removes reference to GPIO 129 which was part
> of rev A1 and A2 designs, but never functioned. It then properly assigns
> beagle_dvi_device.reset_gpio in beagle_twl_gpio_setup and removes the
> hack of initializing it high. Additionally, it uses
> gpio_set_value_cansleep since this GPIO is connected through i2c.
>=20
> Unfortunately, there is no way to tell the difference between xM A2 and
> A3. However, GPIO 129 does not function on rev A1 and A2, and the TWL
> GPIO used on A3 and beyond is not used on rev A1 and A2, there are no
> problems created by this fix.
>=20
> v4
>  - Rebase onto git://gitorious.org/linux-omap-dss2/linux.git for-l-o-3.5
>  - Use dvi_pd_gpio instead of reset_gpio to match with new naming

Hmm, was this rebased correctly? It doesn't apply to for-l-o-3.5 branch.

 Tomi


--=-XWMhZuEoqLLBbLVDg3MF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPumheAAoJEPo9qoy8lh71//EP/2nlReuIdzD7QHRRnBME8ADT
9oCzudtfG6bFOdKcDcz4BX5nw++rYgTRI91gRQ4YjmyyOcLyED8niddpnC6DhaEk
UbCSUPpD2MV4AxwceLCPF+ic9mt527yt2/YSgFKupA7n2pOPXVB5Sg4qEHmZ7AmB
I0b1hsZwqj8ZIUeSGns/MNLvVy/PD1HvgRWw2I7jJd8y7/ymdF7bSfITpKaDr1O4
v21JPm9WQpXS1fMJCu1sfi3rZq9iS6C6a8bOgfePs784L0sFqr5WE0fVHZxalCbT
zr7I8HvwFm0lKkZpCvmDoWA80plfUYpCOPAVZZOAKiEGbqHpJlu9ZZ8r4cibSzDN
NHzRgsG7/Vv9ejzjarUm2UwlpVK2qPQjW6wktxvNUwD0M/roCbngYpbXpWUBXCRR
ED9hMfsl6G7BRvjgUxGdXHKTcTsRb3BeZ6hp0gquF7SAM1LocN20z2yZzS3bxxb2
MmkLTkUGUoPTLXW/2FN5J8KJ49Pkb9W5UO0aD4SoSddQnS7EqvSusgzStztWEkuf
+tylKNuyenVtbAzHwohaZP8LDxzT6rpMo8uf50ml6/2FN/OHydHCJAi60mMz3KiD
kW/BnHrKEcAqmo32BeAg3JgQOQoR/MREIUNrL4eZBjvysetHTrZRUoBjj0f0YNG6
9TnemloPi7TXfFkumv0e
=FFp2
-----END PGP SIGNATURE-----

--=-XWMhZuEoqLLBbLVDg3MF--

