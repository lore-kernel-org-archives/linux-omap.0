From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 03/13] twl4030_charger: correctly handle -EPROBE_DEFER
 from devm_usb_get_phy_by_node
Date: Thu, 10 Sep 2015 22:27:59 +0200
Message-ID: <20150910202759.GA4844@earth>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.31980.stgit@noble>
 <CAMAWPa__hFOuz24YBcFiR+m5mOUArSuNpuqh3Ju1H+yj6qadfA@mail.gmail.com>
 <CAMAWPa_s2ELgRBRtWzFucmREMuLXS_V5Akmad5yFU13-GrzBDA@mail.gmail.com>
 <87si6x4a2f.fsf@notabene.neil.brown.name>
 <20150902130724.GQ4215@atomide.com>
 <CAMAWPa8q1BOMvvKqqU88vYq4-_QhuxefVqkM6=4BP4-FGZxRPw@mail.gmail.com>
 <20150908201417.GG4215@atomide.com>
 <20150910080849.GA6164@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150910080849.GA6164@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@kernel.org>, Neil Brown <neil@brown.name>, Samuel Ortiz <sameo@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, lkml <linux-kernel@vger.kernel.org>, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Tyler Baker <tyler.baker@linaro.org>
List-Id: linux-omap@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 10, 2015 at 10:08:50AM +0200, Sebastian Reichel wrote:
> > Probably best that Sebastian does it as there's another fix needed
> > too. It seems the following are needed:
> >=20
> > - Revert $subject patch 3fc3895e4fe1 ("twl4030_charger: correctly
> >   handle -EPROBE_DEFER from devm_usb_get_phy_by_node")
> >=20
> > - Apply compile fix "[PATCH] twl4030_charger: fix another compile
> >   error"

I just added these to my next branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/com=
mit/?h=3Dnext&id=3Daefc574bbbbe74bb891ba392d98f2d59a417c774
https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/com=
mit/?h=3Dnext&id=3De11fc21e756e662e465cac3da6547d438d0b1446

-- Sebastian

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV8efLAAoJENju1/PIO/qa1EIQAKMMyAuckg46bC5mz9cWt1Hz
/+ylOf0K7xD8yXVXthICJupKY+jVJVcw/2Q4jSieXmogQWbtd3mrKHjKCy2vcS2/
wrFGcO075tUSSj4vhsRZhnLV6PKvzgY+c+9v2xAFIDzY9DmJmict3sPaH1mIMAgk
4hBlFu1/0YX7cE1yO8T1XOJfo7aIXbfRY2vUArQlbO4SQS/dNtqmEn2HTc93a6nj
n859JZidccd1KCHGTe3TN9yaAlw39S2KuEvjWUn7QDxbEOliTA23ZLA63IYBu2UP
Gx+4K/SVEHgsINrL8dAtUHyWq9LuNi6G6p90f2DFiunbb5OdSeT4paR/XwQQtpHX
22WsM21oUyO96MvXKdfQv2K0ulCz84B2D66hI0O1yWV7G3QlvDgFcumkIwtO4sVl
D15bVo8XOC1aMGNbDwlNdZzNFFh+yS8m8uRbhIgAexNMeRDXWGAo5kRiGYegix6p
A+CFWOoeOxu8p+Uh7xA2yMWVTQ7XaFDOYHobTQ15EWGl/CSEeXpDPQtU/IfXZfBZ
YjhBIflyNkBUusLKzvxIWkFoh/DDM0OaAe5H3UoAGKhaty6kLMzKdH7MewS5n6h4
krKf4/obdZ37wiGY9k7lKraTcK6wWfMXWfTqmTmaWQDtKJccYndflrpmpsr6JmVE
jf9hEEFTzNJU4Bx6tZvI
=DUPb
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
