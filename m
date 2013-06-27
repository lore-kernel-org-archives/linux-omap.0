From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Request for OMAPDSS testing
Date: Thu, 27 Jun 2013 09:41:48 +0300
Message-ID: <51CBDEAC.1050408@ti.com>
References: <51AD99F5.7060506@ti.com> <51B9EA7B.8070906@compulab.co.il> <51B9ECBE.3010401@ti.com> <51BDAF6A.1020102@compulab.co.il> <51BEB5DD.4000605@ti.com> <51BECB6B.7010409@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2MXCLBBXHMIXEOXEQQNSF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57333 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab3F0GmJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 02:42:09 -0400
In-Reply-To: <51BECB6B.7010409@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

------enig2MXCLBBXHMIXEOXEQQNSF
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17/06/13 11:40, Igor Grinberg wrote:

> Yes, the reason for this is the sb-t35 (the baseboard) which has the TF=
P410
> in 3.3V domain, but the cm-t3530/3730 are in 1.8V domain.
> This means that the line must be shifted.
> Now for some reason hardware guys used an inverter as the level shifter=

> instead of a simple buffer. So now it is shifted and inverted...

Sigh =3D).

>> There seems to be OF_GPIO_ACTIVE_LOW, but I'm not sure how it should b=
e
>> used, as I don't see anyone setting that flag... And supporting that
>> would mean, in principle, that every driver should support inverting t=
he
>> gpio with every gpio they have.
>=20
> Might be worth to consider adding this functionality to the GPIOLIB?
> Meanwhile, I think the simplest way would be to add a boolean
> like OF_GPIO_ACTIVE_LOW, as we have hardware that needs it.
>=20
> If you think the patches are conceptually fine,
> I can rebase them on top of your tree with the new drivers and
> submit properly.

Yes, the patches look conceptually fine. I don't like it that the TFP410
driver has to have extra functionality to handle board oddities, but
then again, it's just a few lines of code and I don't have any better
idea how to solve it. A gpiochip driver that handles the inversion
sounds a bit overkill...

The 3.11 kernel will have two versions of tfp410 driver, the old one and
the one using the new dss device model. If possible, I'd like to have
the modifications only for the new one.

 Tomi


------enig2MXCLBBXHMIXEOXEQQNSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRy96sAAoJEPo9qoy8lh713wsP/R073+YH0Za6KTEA1R2UKqG/
Wv0DnCtZwGkRKJBE3FJYvru1EI1xIChUzYhzGUQxF3V3LwCHl8hRJpA3mpCKTCqw
bC8uiDfsaTmBdHzyCkgCdhRuJHPNoZM3LmLEcPoZ2M/GPMmleYI76mB58QTWusfd
R4ewsbqBrg8NYD/1V+VDrRu1/kxtRI3yZ0zFjog8S9AUeECvWgMj28QfDn31Dbty
Wx5SL2qEntZojcnTcJOmo/J9BAqKVFC9q3hmGMs0rwtG1uOADHTTp2e2+h6J6l9p
PTSleD+9PXaBs51loEKChcjFKde4fX5rKCW4gT6fCD90dmWndtnsRkIxtkO5kmCv
tuNwYRz0AMn1txReMFh8ZB/jX6oFpqRkvH0OimxobeWOOCAxbR7sETOoopkG41nT
HE6RKT4NnuUlwVy/cz7kfGPY8YN/p/H0GQworCrDIHHDtgoG1fHq7XJHfFh7wUNv
m99foJahFQqW3vkcIeMBeRCLSSRhWMwBYPEegsrodIBTSLB4nAZmWWgYPGIer5LR
qsDT5wtBLuFW/HDb8FKxa+Wmi3v0YUnS5Cc33EpKwuMAizSbm7WgEm3naAVdDLCG
hxJlYa1NT9rTZnL+jiVOSF4z4SkVyG3YB0IDsbLuQssjTL6KGYWMqj2wcN06HEHu
RT2Dk0M6NqQ6CGIOPDbv
=j4bb
-----END PGP SIGNATURE-----

------enig2MXCLBBXHMIXEOXEQQNSF--
