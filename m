From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP-USB: Fix possible memory leak
Date: Fri, 3 May 2013 09:25:35 +0300
Message-ID: <20130503062535.GD27451@arwen.pp.htv.fi>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
 <20130502162433.GA10016@kahuna>
 <1367512124.978518915@f372.mail.ru>
 <20130502164058.GC8577@arwen.pp.htv.fi>
 <20130502231353.GF21614@n2100.arm.linux.org.uk>
 <20130503061931.GB27451@arwen.pp.htv.fi>
 <20130503062506.GC27451@arwen.pp.htv.fi>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130503062506.GC27451-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2013 at 09:25:06AM +0300, Felipe Balbi wrote:
> > > This is exactly why we have platform_device_alloc(),
> > > platform_device_register_full() and friends - so that people don't ha=
ve to
> > > fsck around with kzalloc themselves and get it wrong like the above d=
oes.
> > >=20
> > > Would you like me to pass your details to gregkh for another one of h=
is
> > > public humilation exercises over basic kernel programming stuff? :)
> >=20
> > How about we pass yours for not reading the patch before flaming ? Note
> > that $SUBJECT is *not* touching at all that line which kzallocs a
> > platform_device. Wrong as it is, it's not part of $SUBJECT.
>=20
> that line was added by Roger on commit
> 5ecd52e563f1e14f9cfe06130fbf9fdb73f227e8 (ARM: OMAP2+: omap-usb-host: Add
> usbhs_init_phys()).

forgot to add him to Cc, now done.

--=20
balbi

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRg1hfAAoJEIaOsuA1yqREXCgP/ilMOhSGbXB/K0QUHBP800AT
PG7pPZMljSSKszaU147k9VYVYW0TTU+seRWthZ1RhsxxV0AT1TVdvXV7R/A7M49B
F2QOKtUHXSvWch3WJxi0oIKznaB8vz4/YYZhRoshxL7hhRWVVnzn0sm3QdP1C+qW
6zA5/mjq4Cpar4XSzZW2RUaIW1TeIdUMGVlCDs9V9bX4RRP7AkIdaaoXcOF5uk2z
FBvYBD4d8kvtzKrUA2QQaNUkrKyfDpPe8B7aBWsDDEzCp7kWiBbANcallx5gavgn
km4y6Nfs8U1yDZl2TWN8becS7/5NrYBREeFBRa5xxiJmNvCACKjw5zj96t9Y62Db
UMUOhFn+Bbs5LTSad7y80Yvk3WH0etDhWFwiIKV6HYOc7leUdaRLkZdJpMnLglgH
ZsPAnBMhjt8cTCEsO2ByblAUIzZ8amGWdnfUQqLO4oRROwXdNzoVBYt7ghLkr4W+
/4vdLplx+V2RoUN3+OoEz/lIb9i5aChZDVPNvgjG2tRUiX7wBIy0Dz6SrRlEG9vW
skHK+mDR5mdXlwoRwBHgOtRteRB+oFkR0lkfdPEUM5v/trrlMqltCOrhYka0rtvI
aTepZ3/R9f8VyHZpU8ENeSQ9i2GrKpTKUcs/UJAdITMcQOBZRd5/u3kMoNtT8CTr
Dx3Bn//E8Xrnt1z2Okfe
=MWMY
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
