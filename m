From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 07 Mar 2012 14:05:28 +0200
Message-ID: <1331121928.4348.28.camel@deskari>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	 <1331040371.2059.113.camel@deskari>
	 <CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
	 <1331044544.2059.150.camel@deskari>
	 <CABT81PhtXsuy_XL0i+4TV=BScYV9-0nfzys5Gi_-=iiSso0bSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-AEF/+eZdfIzk6q+SW/Ih"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:60217 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752115Ab2CGMFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:05:33 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id r15so13653313lag.16
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:05:31 -0800 (PST)
In-Reply-To: <CABT81PhtXsuy_XL0i+4TV=BScYV9-0nfzys5Gi_-=iiSso0bSQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gross, Andy" <andy.gross@ti.com>
Cc: Rob Clark <rob.clark@linaro.org>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>


--=-AEF/+eZdfIzk6q+SW/Ih
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-06 at 09:50 -0600, Gross, Andy wrote:
>=20
>=20
> On Tue, Mar 6, 2012 at 8:35 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>
> wrote:
>        =20
>        =20
>         I have to say I don't know much about DMM, but my
>         understanding is that
>         DMM is a bigger entity, of which TILER is only a small part,
>         and DMM
>         manages all memory accesses.
>        =20
>         Can there be other users for the DMM than DRM? I know there
>         could be
>         other users for the TILER, and I know you want to combine that
>         with the
>         DRM driver, but I'm wondering about the other parts of DMM
>         than the
>         TILER.
>        =20
>         Somehow having a DMM driver inside omapdrm sounds strange.
>=20
>=20
> The DMM does indeed contain a number of entities.  However, the TILER
> portion is the only part that requires a driver.  All other register
> modifications (LISA map settings, EMIF, etc) are done statically in
> the loader or u-boot and never changed again.  As such, DMM has become
> synonymous with TILER.

Ok. Well, as I said, I don't know much about that, just sounds rather
strange to me =3D).

Does this "DMM has become synonymous" mean that people just started
calling TILER DMM, and thus the name has stuck, or are there technical
reasons to handle it as DMM in the kernel? If the former, and if TILER
is the technically exact name for it, perhaps it would make sense to
call it TILER, as that's what (at least I) would be looking for if I
read the TRM and try to find the code for the TILER.

 Tomi



--=-AEF/+eZdfIzk6q+SW/Ih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPV08IAAoJEPo9qoy8lh71HfMP/0dF35k6tew95amZTP5LsAAu
M6Ivvhva/He13lt6nV8EZKHZOFjbjpykBzO0r/LTNNODM3w7oJogaY+HhBLSwihc
DmAfM240PnHV3lLLpyqQf/QK9McgigqqoCBiJHgYQx/ZRGmhKpqthkVxqfB0b4Fw
mzza0X5GsYas6L74mMelQM72mDyeAFpToYtrJNIbR5ZvKDUJdI0QiPmWh7OcC4Qy
C156uCKC9c0LkQPbq2zbSbBOuZ3ODh13zrJhEj6Ol6VsJOjFsQNpMhVPctJ8fjFO
ap3l47mDWE1ORDIvWEDRh8sMwmnsrNgF2pvtE9w9AEtLFSyaxiGvmOczclV0vpnY
QVi56KeQaXddfNBD6lgbi7yOg947Nlwi1XRC/71l/DNvQXVrXRxYAZ1yJdI8rOU8
ZMV095qB5lZ1cBL8Unl0/cZzihYWtoSyGj3/FvhbsuTlF9ZIZ4Kc0JysotqnlXE6
aWxGhJ2N3jEuJ/1WK3RUfqd3tBZr1OWSSHRLJFANKYFintLVSBCC4iyQLMAOirhb
xCPap8VnAiDxY+5eiNejy6PGYlOw32HSs3j6Gdep6ktwaCuahxN0DHuE5le3fXd9
JXaZzNZQTVEZr4kGe03h8z+gXTh57JL86kCzgBt3OCvrHeY7M0o9oFw1s0Q1Pzvq
4EkDKKoZDN6fXQ/RY1H5
=YW+6
-----END PGP SIGNATURE-----

--=-AEF/+eZdfIzk6q+SW/Ih--

