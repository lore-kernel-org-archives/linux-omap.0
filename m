From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 1/7] drivers: usb: phy: add a new driver for omap usb2
 phy
Date: Thu, 6 Sep 2012 16:16:24 +0300
Message-ID: <20120906131623.GI29202@arwen.pp.htv.fi>
References: <1344258480-4304-1-git-send-email-kishon@ti.com>
 <1344258480-4304-2-git-send-email-kishon@ti.com>
 <CAAe_U6KBNZpT03xATmPTNTgxm5hj+wJdsShdnm08EmF4Q=hTCw@mail.gmail.com>
 <201209061303.02454.arnd@arndb.de>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v2/QI0iRXglpx0hK"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201209061303.02454.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--v2/QI0iRXglpx0hK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2012 at 01:03:02PM +0000, Arnd Bergmann wrote:
> On Thursday 06 September 2012, ABRAHAM, KISHON VIJAY wrote:
> > > diff --git a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt b=
/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> > > index d2fe064..bb0c7f4 100644
> > > --- a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> > > +++ b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> > > @@ -8,3 +8,6 @@ properties:
> > >
> > >  Sub-nodes:
> > >  All the devices connected to ocp2scp are described using sub-node to=
 ocp2scp
> > > +- usb2phy :
> > > +   The binding details of usb2phy can be found in:
> > > +   Documentation/devicetree/bindings/usb/omap-usb.txt
> >=20
> > The above two lines should be added in omap-ocp2scp.txt (this file was
> > added as part of omap: add ocp2scp as a bus driver and is in
> > linux-next). However this file is still not in Felipe's xceiv branch.
> > So I'm not sure how I can get this patch merged in Felipe's tree
> > without conflict.
> >=20
>=20
> There are three possible ways to do that:
>=20
> * Not add that text. Is is actually required? The ocp2scp bus driver=20
> doesn't actually care what is connected to it, does it?
>=20
> * Ask Felipe to merge the drivers/ocp2scp branch from arm-soc into
> his branch, then apply your patch on top. The branch is scheduled
> for merging in 3.7 and is stable, so there is no harm merging it
> into his tree, as long as Olof and I are aware of this.
>=20
> * Split out this change and apply the patch to add this documentation
> change on top of the drivers/ocp2scp branch in the arm-soc tree.
> There is no strict dependency between this change and the others
> you want to merge, so it does not matter which tree it is merged through.

I'd be more comfortable with option 3 or 1, whatever you guys decide is
fine ;-)

--=20
balbi

--v2/QI0iRXglpx0hK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSKImAAoJEIaOsuA1yqRErvoQAIHOaI8o8Vb2SJGsU6htjYAs
VxH/u/Vc8v0uMcmfYEm9zagUhzabUCzTbMF74/wVI1W00rBs3d152vRTHQqPaFkw
ZS8ftJ7GYmI3xKPSOdZjzaCRIH9cvt4R6n+2GaQ/pjZZFJSoLilTgfDPO+x6a2sf
nea8jsprmaxIfe52lV0tRXvpGLH9NBgzQLRskPKZf6YFw2ag89Bc0ajqNJY/zl5v
f0vzNpTXPatb2/I7WcYt2YIqpWqRJLZ/+kwgR9GTUydkeyt7mWB2MrR/Ljvyqd4e
X495xpSkG+ejdxV5YN0arSc9g0yjiIRoBbpbuzfbcSPFj1JKOBUbEWyRHztGsGQs
4PaQ9tgLheLEDAt0ab6u1ftpdo3kF9vc8Oeq3EEr0ihvZexrR5MQLf/yH3EzJTq6
ZU36cLXpDTF+mOKP9DXWvmFQEfN5fpFPO1MxqoCq0pCZzhKGx/6riOwxIBIRFEmV
qmMJlMTkSDKeb366b+1GiNPy/vPU+CBO9nSOMz/LiYeLZgGiIlhnilW2gQPnbd/s
Fd+tC2elKJ8ck5qIgm8kVtZKz4RhDjanupkN8a/cJfSdiwgf7nG/CCOER+3ydDmD
wyVhiTj7hj5opMIuFHXoi5WJbHFhrSXvBbK+Qv9UtXHMk7wamQ1brj4ZCFypmHFf
JUdZcjMRFkASmJPj07XC
=H4Yx
-----END PGP SIGNATURE-----

--v2/QI0iRXglpx0hK--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
