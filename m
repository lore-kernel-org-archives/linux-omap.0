From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [PATCH] dtc: parser: Add label while overriding nodes
Date: Thu, 29 Jan 2015 21:13:43 +1100
Message-ID: <20150129101343.GD10150@voom.fritz.box>
References: <1422456611-15447-1-git-send-email-nikhil.nd@ti.com>
 <20150129100731.GC10150@voom.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Return-path: <devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150129100731.GC10150-RXTfZT5YzpxwFLYp8hBm2A@public.gmane.org>
Sender: devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
Cc: jdl-CYoMK+44s/E@public.gmane.org, devicetree-compiler-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 09:07:31PM +1100, David Gibson wrote:
> On Wed, Jan 28, 2015 at 08:20:11PM +0530, Nikhil Devshatwar wrote:
> > This patch changes the dtc grammar to allow following syntax
> >=20
> > i2cexp: &i2c2 {
> >     ...
> > };
> >=20
> > Current device tree compiler allows to define multiple labels when defi=
ning
> > the device node the first time. Typically device nodes are defined in
> > DTSI files. Now these nodes can be overwritten for updating some of the
> > properties. Typically, device nodes are overridden in DTS files.
> >=20
> > When working with adapter boards, most of the time adapter board can fi=
t to
> > multiple base boards. But depending on which base board it is connected=
 to,
> > the devices on the adapter board would be children of different devices.
> >=20
> > e.g. On dra7-evm.dts, i2c2 is exported for expansion connector whereas
> > on dra72-evm.dts, i2c5 is exported for expansion connector.
> > This causes a problem when writing a generic device tree file for
> > the adapter board. Because, you cannot know whether all the devices on
> > adapter board are present on i2c or i2c5.
> >=20
> > The problem can be solved by adding a common label (e.g. i2cexp) in both
> > of the DTS files when overriding the device nodes for i2c2 or i2c5.
> > This way, generic adapter board file would override the i2cexp. And
> > depending on which base board you use the adapter board, all the devices
> > are automatically added for correct device nodes.
> >=20
> > Signed-off-by: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
>=20
> Hi, sorry I didn't get around to responding to your earlier posting of
> this.
>=20
> The concept is good, and the implementation looks fine.
>=20
> Only 2 things before I'm ready to merge:
>   1) It wants a testcase
>   2) I need to stare at the syntax for a while and convince myself
>      it's as good as we can reasonably do.

=2E.and.. #2 is now done.  Give me a testcase, and I'll merge.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUygfWAAoJEGw4ysog2bOSzdcQAKaHXMkp+vsGAMZp3b88H/Go
xkAmWap5TtnLF8Zt1evr3OqRM1ytc1CysRuG+PxxZtvqocvwRB1h41SizX2wtkGC
hWnORZmFm00ZiBCnBnSxZDVx4VTlJxsnQ5iFXr+YZ1LVufhTqCWSkm/nsSboI4ey
6fSKq3CuHTr60ZBqP/WmCLZvmho6cVyksxzZnqwRqxSqmoK+0q6x/haiooFzEkzL
mg4EeTkBWS3MROo8f3NbT+Q/vnDTstKYXRycgzVsGql9K7wPlZ7EuI7y4Jrttzg9
ncHwAWYENSiUy9IqxJBG7Dcz9teCet0gYjJA2YMbP4Ynglm66mH30OeT/zyOIwut
Fg1YqCN09l5+yiopjg51Zu5FPGcKKjc1uEJL6k5fU4dyvvjlb2OoPnE/st5VODUm
D4Zo9imy/tqRJP83dL3K9jZCt43+Cfn6FlRlB2+HnPM//ZKXwcVD24u2Ghw1aczc
nS/bS/3qJ7DkHxQG2g4zCuDC2GB0a2dob/MTM2RrFhgAM1+1p1pMp5Z8xgfNTZf3
h7EUqDPe1xZUe8OehSx0tY4BB6Mot5R18LWZvUuJ0mRydz5GPgidGeM+qK2fIUeb
QlyEsSeOi/OXHf9f5wgidbTbKOU6DV0K9DqFXTalmVh2luS+KeyiBiHk879pwrmN
E/aj8Rz+iBhzkSMuaVeH
=YhWn
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
--
To unsubscribe from this list: send the line "unsubscribe devicetree-compiler" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
