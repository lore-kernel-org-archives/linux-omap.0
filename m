From: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] ARM: omap3: beagleboard-xm: dt: Add ethernet to the
 device tree
Date: Thu, 1 Dec 2016 16:33:59 -0500
Message-ID: <20161201213359.GG2546@bill-the-cat>
References: <1480528685-26259-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161201211234.GA3703@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d54Gil03pmneYXDB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161201211234.GA3703-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--d54Gil03pmneYXDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2016 at 01:12:34PM -0800, Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161130 09:58]:
> > The Beagleboard-xM has a LAN9514 USB hub and ethernet controller,
> > connected to port 2 of the OMAP EHCI controller. The board however has
> > no EEPROM to store the ethernet MAC address, which is programmed by the
> > boot loader.
> >=20
> > To allow Linux to use the same MAC address as the boot loader (or for
> > that matter any fixed MAC address), we need a node in the device tree
> > for the ethernet controller that the boot loader can update at runtime
> > with a local-mac-address property. Add it, along with an alias for the
> > ethernet controller to let the boot loader locate it easily.
>=20
> Does not seem to work here.. Do I need to set something in u-boot?
> I'm using U-Boot 2016.09-00004-g26bb688.

Yes, it seems like something else must be going on as well as
"usbethaddr" which U-Boot will populate with a MAC based on the OMAP DIE
ID doesn't get populated into the DT only ethaddr.  And the follow-up is
that it would be nice if someone would go and patch the last driver in
U-Boot that uses usbethaddr to use ethaddr like all of the rest do.

--=20
Tom

--d54Gil03pmneYXDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYQJdHAAoJEIf59jXTHXZShfcP/AqS0psIVMDgVZFe1kYYVHdS
oPk3z12rszBh68IGnYvHWCOMOnC/TslolS+QLjfPFN4d7C2KCGfoNbF3RXjqFY9t
qPK2pQA8IvEd1d3Tq4MX4ZKE2MIN2qOiaBSofBAm+iL6xiWxPkq3PTkU+5Th+Fc6
RZ49LSbao57Er+6A88N6qEYVWuts5cZPplTF9y1sptyMLgh1+ylpNR3rKHcSntQU
AHVO64aV4jGRhOPCvf/vYgTRUorcZ/+YQ6p0czxre2aod+8ot6kl/WEK9UUS1EtG
MPD2kcW5s0v9SrtfIukey4q7VaQRHA9ts0t9JPy7vEoZOeLo0PxUapdbXMs/r9XW
AEto3VdBdkULMTpL+Df7D8M6+Bjojt5P2ET5b8kdgH+/OKB99RhOVcQiA1hso9yq
iz6N4rZ1Xr+TCk8nZdrGOt0FNLB7cw8ny/IYXM5ASdKs2hjt8Wj4wNGpXlt83eVm
klWPs47QBbsWceRJ855JGHLMTXKe+PSMf24XhYvdM4d5kvtX9VhEUfl/rBKMdBh7
PPZENsC3TAWWJ9x7Uz3XxFQSkuYgTOzqCIMQnduEVqkhkD0Oap7DUv6mLgc0dRf3
Imyy/9K2GFqkNsfxK8wA9b7Z9YyLjPNigGMb5EPRSYlpDNE5ztvkbKdOKFlNvz3h
/U6ZeM9e78DqQv6s/wJ2
=PDdI
-----END PGP SIGNATURE-----

--d54Gil03pmneYXDB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
