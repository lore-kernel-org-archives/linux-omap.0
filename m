From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI5: Change DDC timings
Date: Thu, 21 Apr 2016 17:38:43 +0300
Message-ID: <5718E5F3.2080504@ti.com>
References: <1461196973-20370-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Eemnq6RU76DwXVqwWr1F9JLokd1eFm5JE"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461196973-20370-1-git-send-email-Linux.HWI@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J.D. Schroeder" <Linux.HWI@garmin.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, misael.lopez@ti.com
Cc: "Lodes, Jim" <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

--Eemnq6RU76DwXVqwWr1F9JLokd1eFm5JE
Content-Type: multipart/mixed; boundary="R2xNsBciho4NH0oce1PooBUemmlPBABB9"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: "J.D. Schroeder" <Linux.HWI@garmin.com>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, misael.lopez@ti.com
Cc: "Lodes, Jim" <jim.lodes@garmin.com>,
 "J.D. Schroeder" <jay.schroeder@garmin.com>
Message-ID: <5718E5F3.2080504@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI5: Change DDC timings
References: <1461196973-20370-1-git-send-email-Linux.HWI@garmin.com>
In-Reply-To: <1461196973-20370-1-git-send-email-Linux.HWI@garmin.com>

--R2xNsBciho4NH0oce1PooBUemmlPBABB9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 21/04/16 03:02, J.D. Schroeder wrote:
> From: "Lodes, Jim" <jim.lodes@garmin.com>
>=20
> The DDC scl high and low times were set to the minimum values
> from the i2c specification, but the i2c specification takes into
> account the rise time and fall time to calculate the frequency.
> To pass HDMI certification DDC can not exceed 100kHz therefore in
> a system where the rise times and fall times are negligible the high
> and low times for scl need to be 10us.

Thanks, makes sense. Did you measure the rise & fall times? Do you get
more or less exactly 100kHz with the new times?

> Signed-off-by: Lodes, Jim <jim.lodes@garmin.com>

The email format should be

Firstname Lastname <firstname.lastname@foo.bar>

Or something similar, but not "Lastname, Firstname"

 Tomi


--R2xNsBciho4NH0oce1PooBUemmlPBABB9--

--Eemnq6RU76DwXVqwWr1F9JLokd1eFm5JE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXGOXzAAoJEPo9qoy8lh714VoP/jsFpf1R8g3Wrsi5whDVu743
PEvPpJUmUl3ATPhGiRBDMW2QvG1dbcQFA7yGSZkVnyePYln7vAIhCHxdup+d69fj
7tw3iMNQZyyoY4WXbXKTod1re3sP/dp+0Q8K9EcXV3HE6VVxtaQ0U1JZsEVcl59q
Wd8v7VKOxk5mPeF4nPnVqUn+XStNG+vnxcNm8v7z0dv+TJjs2iZEGl/KcLadkPe+
Hx6Niw3jptO5599y8Ug8pYMFcLy2Ivid4wr3nl6Z2iLSwLsvRa4/RjGWlXawWOne
5mh94EZoSnqxig4ToNEDDYi9Bcr0h5juCmz0JAVZJbqcrS+xx+4Lb9BsgQcsW9AC
iOX+mZKyHU35b/nRUHXrBQoj3NsxAlwB9IsprW/sY6CjrEv6NcwJ22DbVgwYx3I3
RpgrfCNYziV9PqnPh40JnlOepBSAhDEWKX9zs83GtHM+eeuY4Q7/aA46bpkt0yLe
q6qd2VnHuQAYd9uvEHovDIxa/6w5AV7JUmPkIEDsgUgkMkeSdO1GTgJNogUzKCw3
A4nqQTeAZu+/wsBGetO4QzXJj7ZeJAvBu1ogKqKtvEMYQhwItk1STz/WKwYAZtv/
28Z7JBxspikpIvubrXoW2Fj0oWfX8dIeMYB196qUbFtDgJEnqU7iVs9JGgaf3IVz
R8zPfqs1nDdknfwtavgM
=i65R
-----END PGP SIGNATURE-----

--Eemnq6RU76DwXVqwWr1F9JLokd1eFm5JE--
