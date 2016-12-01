From: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] ARM: omap3: beagleboard-xm: dt: Add ethernet to the
 device tree
Date: Thu, 1 Dec 2016 16:41:11 -0500
Message-ID: <20161201214111.GH2546@bill-the-cat>
References: <1480528685-26259-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161201211234.GA3703@atomide.com>
 <20161201213515.GB3703@atomide.com>
 <2270015.ToMLQLZcVX@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="faQnCbRvEv19yW2P"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2270015.ToMLQLZcVX@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--faQnCbRvEv19yW2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2016 at 11:37:53PM +0200, Laurent Pinchart wrote:
> On Thursday 01 Dec 2016 13:35:16 Tony Lindgren wrote:
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161201 13:14]:
> > > * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161130 09:58]:
> > > > The Beagleboard-xM has a LAN9514 USB hub and ethernet controller,
> > > > connected to port 2 of the OMAP EHCI controller. The board however =
has
> > > > no EEPROM to store the ethernet MAC address, which is programmed by=
 the
> > > > boot loader.
> > > >=20
> > > > To allow Linux to use the same MAC address as the boot loader (or f=
or
> > > > that matter any fixed MAC address), we need a node in the device tr=
ee
> > > > for the ethernet controller that the boot loader can update at runt=
ime
> > > > with a local-mac-address property. Add it, along with an alias for =
the
> > > > ethernet controller to let the boot loader locate it easily.
> > >=20
> > > Does not seem to work here.. Do I need to set something in u-boot?
> > > I'm using U-Boot 2016.09-00004-g26bb688.
> >=20
> > Looks like my u-boot only has usbethaddr in the environment. After doing
> > setenv ethaddr it's now working :)
>=20
> Nice to know, thanks for the tip :-)

To tag onto my other email, it should be just a little work to get this
to work for everyone out of the box :)

--=20
Tom

--faQnCbRvEv19yW2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYQJj3AAoJEIf59jXTHXZSv+MP/RMyncgT26T1KUx0G386TCCW
HK6DPVgM6SAZoRV1bVuMZ1mz0QXY3EsW2feV2/ESOBcfNkqvqrblI3KrMLilcNBH
Td4bk/1VjIoorRc7Q/ugYucMCzah7VA4x4veUYbRnNjh0Vw4hn5q9OuA10ia/KP7
BB3nsoa0J+4KO7pZMc4hLP/p74h09RHeQiYC+VMSqOS7gOEqWEPxz3aEPFBxtNH0
s5DCI70IxBUVqkki+uHM/SXYqweTcf4v1eYexo6nBZ+FVq8/G47XRkhjEK3elI8h
hnSJdAUKo07TlBxFjAjp1X8iCgaCGSfuDjdDJB3RWYnzrbhGs//4FGc/9ykDj5dp
7eCbWJey8RW7rIWDkXKZv1bHLZP4WDrA27cJ9/wV1iHtR/xq730i64yzkaSdtWT+
7QdEeQ7OXwS/RR5Hyer4k8ACpx03DdkyZx+qUdVC1PA/H/Sl+cnBdo6Fx9MMkVTX
Fws9QGu00sWU2m4XYH1SpNvLZgb/R5LH0FC+W9Y0din4GqNSBFqsLBxvohrkd5ht
kRquOuvylx4EC4eX58WVRls57h8eeF+I+8BsUJZKGR/pCRc2PYN1w1j+8o5uo+SL
HpfgeQYxNCcEe85zS3XIxqyKpPcla2gqvH68ZngJPVB+lRFEqk1EI55HicMNcxAq
XT7Q8Oa/6Af9kicQ+Tix
=BShh
-----END PGP SIGNATURE-----

--faQnCbRvEv19yW2P--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
