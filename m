From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Wed, 11 Mar 2015 20:36:54 +0100
Message-ID: <20150311193654.GA3126@earth>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com>
 <F7BA143D-5CF9-42E3-AFA8-B83B149EF77E@goldelico.com>
 <20150311174316.GD5264@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150311174316.GD5264@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 11, 2015 at 10:43:17AM -0700, Tony Lindgren wrote:
> No no, "capacity-uah" is what we should use, but you need an ack from
> the battery and device tree people that this is OK. Let's not add
> "ti,capacity-uah=E2=80=9D as that can obviously be a generic property.

I'm okay with capacity-uah.

> > [...]
>=20
> Oh if they are battery spicific, then ideally we'd have generic batery
> voltage to capacity maps property rather than a custom ti specific
> property.
>=20
> To avoid extra hassles later on, maybe you could submit a generic
> binding patch only documenting it to the battery people and the device
> tree people? That will make it easier to maintain this driver in the
> long run.

Actually the proper way would be to differentiate between the
battery and the measurement chip / adc and that should be
implemented in the long run. The kernel's power supply framework
is not yet ready for it, though.

Example DT:

battery {
    battery-specific-data;
};

fuel-gauge {
    measures =3D <&battery>;
};

charger {
    charges =3D <&battery>;
};

Since infrastructure for generic bindings is missing, I think its
best to have the vendor properties for now and map this to generic
properties, once they have been specified.

-- Sebastian

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVAJlPAAoJENju1/PIO/qaQxoP/123HIcSZD6reqXfhuvTOkwX
tuWxVsAIGvgRwvn6m4ixNiQ9sFMtFJrsNiTfq+u9guZbJ9bhtJ2bjkRW4GCUsH/U
/asxHBiOcdM/shJ7At6NvWxgghFVVTBwYvl+BLyVKz1Jmgr5o25AUng6cEe4kTq5
93CNIFTcF0wDqMuqPxKkgWMuPbxmZfLlxGn8DGTzi2HLAVse6JfQ52pV+8PlfGnK
JjFqOuZQzCn1pMG4+GjvTkhcgmnybHlUhegSYdrt5nb0sDkCi2/w644hmgMMXmMC
gIfR1gzm/Zbj1txkvu3b1w3uQBNSBYcBhBdA6U8ojCNC9DpGrmCIp5y91UGlPfsy
O5lgwPMyDBpiDKiI626Ow9wM0CfN5mKY5s8Hz7noZS6KzJjbQGVQwX/h5tZ9T825
N+Uf0EE86A/NArJWAn4G0l/Ulh3v6tGE7Dy2rPyA3g/aZQ+fTiGC1mj8FT7xE5+H
QB/9EgBW2+oftrMHzgQrX3UOHtvK2/e98nC+//PycUEiIc76ar3yCX8xmrSlcbny
ECyZy4wrD4qEunO+RRxNWCCCnUNkx9pRr08/sP9yUh0cig8+yd7R11q/17rkKqbF
hEnMpyGfhR5QdcjVGbG2WAihEr3gJ7k755uFESMPZ+LloZCT+X1jTPNzsipZGlRn
y+9xE4dzt6PHQzgaeMt/
=7vJk
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
