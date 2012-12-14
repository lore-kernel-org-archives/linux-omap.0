From: Felipe Balbi <balbi@ti.com>
Subject: Re: twl4030_charger seems to be broken by switch from 'notifier' to
 'mailbox'.
Date: Fri, 14 Dec 2012 11:36:59 +0200
Message-ID: <20121214093659.GB14997@arwen.pp.htv.fi>
References: <20121214200427.2405f30a@notabene.brown>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44496 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab2LNJow (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 04:44:52 -0500
Content-Disposition: inline
In-Reply-To: <20121214200427.2405f30a@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2012 at 08:04:27PM +1100, NeilBrown wrote:
>  this commit:
>=20
> commit c9721438c009adf8e81d376839ed037c53b9b8d9
> Author: Kishon Vijay Abraham I <kishon@ti.com>
> Date:   Fri Jun 22 17:40:52 2012 +0530
>=20
>     usb: musb: twl: use mailbox API to send VBUS or ID events
>    =20
>     The atomic notifier from twl4030/twl6030 to notifiy VBUS and ID event=
s,
>     is replaced by a direct call to omap musb blue.
>    =20
>     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>     Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
>=20
> Seems to have broken twl4030_charger.c.
> This code relies on the notifier to know when the USB has been plugged in=
 and
> so it should consider enabling the charger.
>=20
> now that the notification has gone, the charger never turns on.
>=20
> If I put the atomic_notifier_call_chain() calls back in, then the charger=
 is
> activated as appropriate.
>=20
> What is the plan here?  Should the calls go back, or is there some way for
> twl4030_charger to hook into the "mailbox"?  Or is there some other way it
> should work?

hmmm, tricky situation. Maybe we add back the notifer calls but keep the
mailbox API ?

--=20
balbi

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQyvM7AAoJEIaOsuA1yqREjtYQAKcKi/M5AvAjPvUhaHRv8t+N
f5WE/PTAcIrG+Y27SVMRNlLan92Lub0w9GQNJXXWnvlBHXR53DxPg7000MSva1Ir
V+IJFuSoiUnAohtd6bR2sCCFHi1l8wlgXn9AgLiqCEICVUgLtpGaZpSuzNU6l5q5
4QKRZw8W7lio7PAphsP2PDv5acaxEENxjn03+u5S1Ph7/a5DGQ5ca+lLzHgZtZcp
6AjRlSv7VpT6xNYszeZAz4Yn7xFTfFXOx1WVQjFj+SaCMKYW8I45jK83JORvHZmP
9dCfk25s395HNhVwf55eGaTq59kWpvjBeQEsN2haXpr8UU0YW8vHl8yPjvYjf9zt
WAyzJaPz9+WNLTcng2Wu6zkWzgT4EaD6LXGUdiwp+fj0p3GO4LrSia0Yw830IrFT
DlcwtXkQvRNYp7ARdNEMESM8/HmZoO5kHXMMMg4HTblVjrAPBqyhcVcc8lrUZ3hl
aYW0mNHEYH51m3RF3KJzQceAvy5whvfKEo05ov4JZE+Hy/kYDkj+5tZU8wLs61DI
dyxR4A5LLk2oBXvGZqoTpK4dgK2M7wD6UPsy5+8GgXTWe1oUMYDIX8pdlQpFY977
6nRxkFcescyfKjtvtbICXGGPJn3+EvPVP0GF59wQ0AGEInsUhAluBDpwHj6vB0sp
xHPHzGmtrr/NBFzmRB/I
=owHu
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
