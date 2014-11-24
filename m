From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 1/5] video: omapdss: Add opa362 driver
Date: Mon, 24 Nov 2014 13:47:49 +0200
Message-ID: <54731AE5.7080607@ti.com>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com> <1415830247-31633-2-git-send-email-marek@goldelico.com> <54649B43.1000801@ti.com> <9FD016B8-4EA2-4A0D-B790-6494AB449B31@goldelico.com> <5464DF26.2010707@ti.com> <BF6765C1-8D5C-4ABA-8796-195058C82E17@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="asMv6T3AhxpSsONL8BhSXnENaI4SpaU7P"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BF6765C1-8D5C-4ABA-8796-195058C82E17@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Marek Belisko <marek@goldelico.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, grant.likely@linaro.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, gta04-owner@goldelico.com
List-Id: linux-omap@vger.kernel.org

--asMv6T3AhxpSsONL8BhSXnENaI4SpaU7P
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19/11/14 17:10, Dr. H. Nikolaus Schaller wrote:

>> You don't need to ask. The connector calls invert_vid_out_polarity
>> before enabling the output.
>=20
> Unfortunately it doesn=92t. At least not always.
>=20
> It does only for pdata systems but not for DT based systems:
>=20
> 	if (!ddata->dev->of_node) {
> 		in->ops.atv->set_type(in, ddata->connector_type);
> 		in->ops.atv->invert_vid_out_polarity(in,
> 			ddata->invert_polarity);
> 	}
>=20
> Not calling is in our case different from calling with ddata->invert_po=
larity =3D=3D 0.

Ah, sorry, my mistake. I should've read the code more carefully =3D).

So, with DT only approach, those calls above are not supported. If you
make the OPA driver DT only, you can remove those functions.

You only need to set the invert-polarity property in the venc DT node.

 Tomi



--asMv6T3AhxpSsONL8BhSXnENaI4SpaU7P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcxrlAAoJEPo9qoy8lh71VfIP/1K809jW8yR4bjZJb3fbcU/F
CxhFr1i6//Iwb2iadzBBP8mYzboTSHtRBBXQ0TS3A0+JPO8gAy0eblkR4wsEFbRa
+7mYVu1bsrMqu9YDWghZvfwNpEIDfHMRu3Lq0sdPPLYTcxx/suero7rLUSDpocwJ
2UB17hVPYDV6YP1XCIkB38MzAWDmJVAL3O3pspfLo/a8tfA5E+6ffkkMdYPhQTZG
uiNB/FSu3I+RsuQUmsb6Q5RADNIIzzg882XLNG2Emsrfv5MHjqO9+sowDsVhgAuS
OOWm8MY9BfohZiFUFk9ghA11LadqdPRAlOtNcg0W8WN9wEJ4Hfh9eLi15n3NKPTs
I1oL8D5ab6JH/JiBw4h8eNcjtKQvDBJe4V+lolCYw5NnNQAsgpW9BCx4dIn2yTr8
zH26VgGHJ+6npstDP63pWvwO3kw9ChjewzqClf/nIciHoU+3Tlfxu6i0EP+1ZOE3
3WMJI5qw6zyCCfwigVpOI72g/9+4bqZQpet1ASqqWErrcpuSGZuUh7cykfiWmCj9
mUxSKAzpF+NGeauKQz0ug560Wp45U11R1iO4mVWyO4bmrtl6BJiVCHFcvAHKFo09
mgO3RLDIN49/KTHdhJ6cO7us1c0xaJ03bWrbaeKgdUE4k4IiqwC0oUkw0njhQBR1
AfXetgHxat4hR0IyjHih
=tfEx
-----END PGP SIGNATURE-----

--asMv6T3AhxpSsONL8BhSXnENaI4SpaU7P--
