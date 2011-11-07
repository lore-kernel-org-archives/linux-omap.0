From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-tahvo: Add tahvo_write_reg locking
Date: Mon, 7 Nov 2011 11:27:32 +0200
Message-ID: <20111107092731.GE4265@legolas.emea.dhcp.ti.com>
References: <20111105171954.230d12fb@milhouse>
 <20111107061044.GB4265@legolas.emea.dhcp.ti.com>
 <20111107091836.61377657@Nokia-N900>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:41347 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751734Ab1KGJ1j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 04:27:39 -0500
Received: by bkbzs2 with SMTP id zs2so195712bkb.6
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 01:27:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111107091836.61377657@Nokia-N900>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 07, 2011 at 09:18:36AM +0000, Michael B=FCsch wrote:
> > On Sat, Nov 05, 2011 at 05:19:54PM +0100, Michael B=FCsch wrote:
> > > tahvo_write_reg() needs to take the mutex to avoid a race
> > > condition with tahvo_set_clear_reg_bits:
> > >=20
> > > tahvo_set_clear_reg_bits():   |  tahvo_write_reg():
> > >     __tahvo_read_reg()        |
> > >                               |      __tahvo_write_reg() <-- race here
> > >     __tahvo_write_reg()       |
> > >=20
> > > Signed-off-by: Michael Buesch <m@bues.ch>
> > >=20
> > > ---
> > >=20
> > > Index: linux-3.1/drivers/cbus/tahvo.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-3.1.orig/drivers/cbus/tahvo.c	2011-11-05 17:03:39.598846119=
 +0100
> > > +++ linux-3.1/drivers/cbus/tahvo.c	2011-11-05 17:04:36.274768324 +0100
> > > @@ -104,7 +104,9 @@ void tahvo_write_reg(struct device *chil
> > >  {
> > >  	struct tahvo		*tahvo =3D dev_get_drvdata(child->parent);
> > > =20
> > > +	mutex_lock(&tahvo->mutex);
> > >  	__tahvo_write_reg(tahvo, reg, val);
> > > +	mutex_unlock(&tahvo->mutex);
> >=20
> > yeah, my bad. The same should be done with tahvo_read_reg(). Care to
> > resend this patch adding the change to tahvo_read_reg() too...
>=20
> I think tahvo_read_reg is fine without a lock.
> read vs write is already atomic due to the cbus lock.
>=20
> it's the same situation as for retu. where we also don't need the lock
> in retu_read_reg.

ok then, makes sense.

FWIW:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOt6SDAAoJEIaOsuA1yqREPckP/3pENS7v9rIC7r4Y+TnCmTYQ
K/yPJI1e2YW6rtB5hsH5uKN5jyXYBEDdeTVr3jR4peY9jDpiqYV1d82vBwyV8ybl
44DyJeJ0/6GPKx1Oc35bHCk2wN2hI4co06TFNW2fARRS36Y4RlMua7HPQRG3cfG9
GXDQCr0sz3p9CLhTRxpkFztHTzWxZXokWUPiF+xnpmlzSFgUdzqjAOQBSoFFQ1oo
PE0z0abrPpAHbAkOAOTrouSetRBnErxbK0ljHqwkj2cSEWtR1OQPL2PLu5ZZlkAA
w6D/Htp3ai17kBA2nEDTh6TN2JZuGOb2pR2W1a1OxHisAjPCSrY3+ySDIFelRR72
M2BOsPumC7be2BFw+RxprsTPLYUKWsKXdsY85Uh7blClivCKMLbQGtfnHH+4NRuq
Gn1c3ZEBQryTqX9C42GbmGEXXhIny62b1pGf9cna45p4IN1NcSqYRztd/9KO0DbW
0cARvff2vYaiebprbksCeOvBinU06wNdgHeZuGo95Sv5ZGDWH8u7c95u7lC2pK8S
cb2ZPQ6oDsOLgZAPjUd5/uPyG9AEXFUljhbXq8h/BQrMO3LTPU6uSdLb0s+/Uhki
VmRV74r/hoEV4DE22ZThFW7s3h1/FVmEkwH1dFwy2rqNn1Bx2Spir9kJKHG3VKJ2
CvrrXv0g4ZOXnGZ+pi9y
=x5tN
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
