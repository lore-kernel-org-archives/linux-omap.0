From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: OMAP3-N900: Fix offset for smc91x ethernet
Date: Fri, 20 Feb 2015 10:52:47 +0100
Message-ID: <201502201052.47515@pali>
References: <1424364590-14603-1-git-send-email-pali.rohar@gmail.com> <7411731.0J5JRAOyMm@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5658895.KpQYHNs31u";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7411731.0J5JRAOyMm@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart5658895.KpQYHNs31u
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 20 February 2015 10:24:35 Arnd Bergmann wrote:
> On Thursday 19 February 2015 17:49:50 Pali Roh=C3=A1r wrote:
> > Offset for smc91x must be zero otherwise smc91x linux kernel
> > driver does not detect smc91x ethernet hardware in qemu
> > N900 machine.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Is that the same offset on real hardware, or could this be a
> mistake in the qemu model?
>=20
> 	Arnd

In original Nokia 2.6.28 kernel is offset also set to 0, see:

https://gitorious.org/linux-n900/linux-n900/source/629fc5ab00cafb31272c478e=
fa2c2b35fabd4c70:arch/arm/mach-omap2/board-rx51-peripherals.c#L42

https://gitorious.org/linux-n900/linux-n900/source/629fc5ab00cafb31272c478e=
fa2c2b35fabd4c70:arch/arm/mach-omap2/board-rx51-peripherals.c#L274

Tony already tested offset 0 on real HW and wrote that it is
working too, just show some warning. But qemu with offset 0x300
does not work.

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart5658895.KpQYHNs31u
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTnA+8ACgkQi/DJPQPkQ1LKTQCfUbUVTg7vL8QR22ZqZ3zpwo57
0YYAn2sEzvvUvoTGTajo0SjxMv7ClOiD
=kFp5
-----END PGP SIGNATURE-----

--nextPart5658895.KpQYHNs31u--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
