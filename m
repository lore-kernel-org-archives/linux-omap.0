From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot
Date: Sat, 7 Dec 2013 14:57:38 +0100
Message-ID: <201312071457.38836@pali>
References: <20131206213613.GA19648@earth.universe> <201312070918.32471@pali> <20131207134818.GA933@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5953588.dK7fkiQxgt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:37436 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab3LGN5m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Dec 2013 08:57:42 -0500
Received: by mail-bk0-f47.google.com with SMTP id mx12so716025bkb.20
        for <linux-omap@vger.kernel.org>; Sat, 07 Dec 2013 05:57:41 -0800 (PST)
In-Reply-To: <20131207134818.GA933@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>

--nextPart5953588.dK7fkiQxgt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 07 December 2013 14:48:20 Sebastian Reichel wrote:
> On Sat, Dec 07, 2013 at 09:18:32AM +0100, Pali Roh=C3=A1r wrote:
> > On Saturday 07 December 2013 01:00:27 Sebastian Reichel=20
wrote:
> > > On Fri, Dec 06, 2013 at 02:27:25PM -0800, Tony Lindgren=20
wrote:
> > > > * Sebastian Reichel <sre@debian.org> [131206 13:37]:
> > > > > Nokia N900 DT boot breaks for me using 3.13-rc3. You
> > > > > can see the relevant kernel output below. Disabling
> > > > > the AES module in the omap3-n900.dts with status =3D
> > > > > "disabled" fixed the boot for me.
> > > >=20
> > > > OK thanks for letting me know. How about the following
> > > > patch to fix it?
> > >=20
> > > That's basically what I did to fix the problem.
> > >=20
> > > I guess the proper fix would be a runtime check if the
> > > device can be accessed (if that's possible). AFAIK it is
> > > possible to use the AES module on the N900 if the
> > > bootloader is slightly patched.
> > >=20
> > > Pali, can you elaborate more about this? I've seen, that
> > > you added a section about this on [0].
> > >=20
> > > [0] http://elinux.org/N900#M-Shield
> > >=20
> > > -- Sebastian
> >=20
> > Yes, if you want to use M-Shield on Nokia N900, you need to
> > use new version of signed Nokia X-Loader which enable
> > M-Shield usage outside secure world.
> >=20
> > Because this updated X-Loader is not official and I think
> > nobody has it in n900, please disable using these M-Shield
> > crypto modules on n900.
>=20
> Is the updated X-Loader available somewhere?
>=20

It was on mediafire server linked from this thread:=20
http://maemo.org/community/maemo-developers/n900_aes_and_sha1-md5_hw_accele=
ration_drivers/

Now it is deleted from that server, but I have copy on my HDD.

> > Without patched updated X-Loader kernel will crash.
>=20
> That's what this thread is about :) It might be better to have
> a runtime check for the crypto hw's accessability by adding
> something like this to the driver's probe function:
>=20
> if (!aes_module_is_accessible()) {
>     dev_err(&pdev->dev, "Usage of OMAP's AES module is
> blocked\n"); return -ENODEV;
> }
>=20
> That would require, that aes_module_is_accessible() can
> actually be implemented.
>=20

You need to ask that question to somebody who has 1) access to=20
secure M-Shield documentation or 2) author who created that M-
Shield driver if your check is possible...

> P.S.: I fixed the mail address of Aaro Koskinen. His nokia
> mail address doesn't work anymore.
>=20
> -- Sebastian

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5953588.dK7fkiQxgt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlKjKVIACgkQi/DJPQPkQ1IuPwCfTewjUTk0RM1Np2twA3MZw4mz
ifAAni0zmMn1ZQ4uwZFbRiZ3ZNZG5mJx
=ykUS
-----END PGP SIGNATURE-----

--nextPart5953588.dK7fkiQxgt--
