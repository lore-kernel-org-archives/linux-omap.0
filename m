From: Clayton Craft <clayton@craftyguy.net>
Subject: RE: [BISECTED,REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Thu, 20 Jul 2017 18:28:27 -0700
Message-ID: <20170721012827.GI3@computer.craftyguy.net>
References: <ef561ff4-c96d-b59c-0df1-dfcac8163259@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ef561ff4-c96d-b59c-0df1-dfcac8163259@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, aaro.koskinen@iki.fi, peter.ujfalusi@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, laurent.pinchart@ideasonboard.com
List-Id: linux-omap@vger.kernel.org


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Well, I tried that (attached), but it didn't work either. For some
> reason the error worker seems to stop after the disable. Possibly the
> irq flood keeps it from running, so maybe it should catch all the errors
> (I see underflows too).
>=20
> Sorry, but I can't use more time on this today, and I'm leaving for
> vacation today. I hope Laurent can help during my absence.
>=20
> We could try reverting the patch you mention, but I think it doesn't
> cause the problem.
>=20
> Did you have CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled earlier when
> things worked? If you didn't, and the dts did not contain display
> aliases, I think the omapdrm may have started without TV. So maybe the
> TV side is the culprit, somehow (I couldn't find anything when I looked
> at that side either).

Just curious if any progress has been made on this issue. It's still
happening with 4.13-rc1, and it doesn't look like any of the suspect
patches were reverted.

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwg7UY5aqqncO8SLrI6MNptQGs1UFAllxWLsACgkQI6MNptQG
s1U8QBAAlgp2hgJemV5d5OqpQGoLns4e/VQmv3sV0RHS/8D/iS6QG4qeF9Xj4MND
45GwQaTMKlmIoP5VsGqHHq9omoUJIR1Gk8lbis4bRLBWsOhqeKivBqcxRQx1jfng
uA/N/29DFt/q8WxYrVqw2gtfSknziNkeH4f7hEBl5WAXw8Rgll5he24HIs2ZD3Ta
GyS7rSGdw+dKEODOffe4lTUW+A10257DUYrz5/FHGZZ47BE1MVUqhAa20rz2S4pT
ncCY5kc9R75/e7KpT12y9G+zS+N5RKHregQP4+MSLEOxaqXKXczY1gqwwZxnVvq5
Cn/5IpC9jjmQwz5fSS4B/cUWbNStmVa0lVeX4uUaacEvqi/u3Mi7OXA8BCj2g9fX
gOeyjo8ZQL9bHOuIY0eUN93P8RZko6/gVhoB1oCD00t9F7jbdq86TSbt+W2wyWFp
fV/0n18fp59RXi56mZlQfbqg07eZA3TuuPjsRtFa5Vb1a1wye3aZcloAC6uIHnbN
noKjWqufOzFihNXlXoFkO8MAOcPPtucUtfKugie7QMH+BlcK/gYOJgAUn/T+v3nn
/dOe2Y7meO/dq0FqBvqgaMSWY4C+AczAiBl7iAA2+hrckzcJLTl8N8yn1uXETQtd
4sBHYfuZZAWQA8HtjPjkdQaujaGOP8YERFT69rm76c6zdUJUEdM=
=H5r3
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--
