From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2 0/4] Convert all btwilink users to hci_ll and drop
 btwilink
Date: Sun, 20 Oct 2019 22:33:52 +0200
Message-ID: <20191020203352.rh3n6qpagiyift7d@earth.universe>
References: <20191003134147.9458-1-sre@kernel.org>
 <20191008143116.GF5610@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm5ahi5a3wy7vwrr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191008143116.GF5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Adam Ford <aford173@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--sm5ahi5a3wy7vwrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Tue, Oct 08, 2019 at 07:31:16AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [191003 06:42]:
> > This moves the remaining users of btwilink to the "new" serdev based hc=
i_ll
> > driver and drops the btwilink driver afterwards. The patches were only =
compile
> > tested by me, but Enric tested the IGEP platform and Adam will test the=
 LogicPD
> > platform.
> >=20
> > I kept the TI_ST driver for now, since I plan to send a second patchset=
 for the
> > FM radio driver. Once the FM driver has been converted to also use hci_=
ll, we
> > can remove TI_ST completly.
> >=20
> > My suggestion is for the patch handling is, that everything simply goes=
 through
> > Tony's tree.
>=20
> Sounds good to me, good to see kim gone with patch 3/4 :)
>=20
> Marcel, care to ack the old driver removal patch?

Looks like Marcel missed the extra messages and merged the 4th
patch, so I guess you can just merge patches 1-3. Technically that
might lead to temporarily missing BT support on those two devices
when the BT tree is merged before ARM tree during the merge window.
Not a big issue I guess.

-- Sebastian

--sm5ahi5a3wy7vwrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sxK0ACgkQ2O7X88g7
+prIog//SHiTMzn4T99dMKj3MWuzk7SikJRKPSRc4rnLfbXHvx0WAXEADzr/fabi
8Ek3V2rGN7RUAQmXvkqI2+cUVs/9+EwGjW2NfVvDECrhaitscUuX9IJ7+lQ3Mw4j
eptrRQkRQtdmlP1ppPL5m8zBqomcGSMZnOwmYMuUA/Sh8968iQkECsqvUKsC5A08
QpBNlLw+ZQgA8/C7/87ZiBnyQNr/EG+KSQCoKxVg8mt390DA3gMLCwLrbzqznDVB
Q7ZZpxcRovyuVxDPHqzvHLcCKPWCbPIQ1mToXIGWaAkkzbRBON28UhRed8nvXT5Y
ctZffUovpG3iXfpg7WmxMqZIf7X7wAHVbDakDIrrqgxn+WCOAUqKQ/kzFwi1P8fE
sY4TwCTxZDpvGuTVNov+Rt1RMgEesNWT/wCVaLIA3xDSGzbz2hY9xImVrZ7WfFaA
NelFzGcuNsdok3witPD+pf/kyULA0FE3bjS4yP1vrxqvB4TFkjAayPaTsZmteevA
DZTKOEToREcx23/D6eXQtL5u+Y0tYlWAqXxGKSqj5NeDnykaRvXHEpyAjENCSza4
mCAMNGeBLy+EAYhRztWADLKbxqogKNMnvYFmuiXO/GNwHKGOnAW8Dt7njbkipXrx
k//UTEB3wKEz3zlrnbbfNg01YQP+9DiaBqXsOq1YgMLtVo4A354=
=xq8e
-----END PGP SIGNATURE-----

--sm5ahi5a3wy7vwrr--
