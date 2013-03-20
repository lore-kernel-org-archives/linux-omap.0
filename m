From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 0/7] usb: phy: twl4030-usb fixes
Date: Wed, 20 Mar 2013 15:08:40 +0200
Message-ID: <20130320130839.GS29659@arwen.pp.htv.fi>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
 <20130320125425.GQ29659@arwen.pp.htv.fi>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CYcXvPfqKSDi0QhV"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130320125425.GQ29659-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--CYcXvPfqKSDi0QhV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2013 at 02:54:25PM +0200, Felipe Balbi wrote:
> On Sun, Mar 17, 2013 at 08:23:20PM +0200, Grazvydas Ignotas wrote:
> > I have a pandora board which has similar musb setup to beagleboard
> > (OMAP3530 + TWL4030) and musb never worked well on it for me in mainlin=
e.
> > Well it usually works if you plug the cable once, but as soon as you st=
art
> > replugging cables and mixing host adapter into the game it totally brea=
ks
> > and reboot is then needed. Host mode is especially broken, any replugs
> > after musb has been in host mode result in dead port that needs reboot
> > to recover.
> >=20
> > With this series I can switch host/peripheral cables any way I like and
> > even suspend works with cable plugged with musb in peripheral mode!
> > ("ARM: OMAP3: hwmod data: keep MIDLEMODE in force-standby for musb" is
> > needed that was sent separately). This also fixes power drain when cable
> > is plugged an no gadget driver is loaded.
> >=20
> > Changed since v1:
> > - rebased on Felipe's testing branch
> > - added locking for patch 4 to take care of possible races
> >   between work item and IRQ
> > - changed patch 6 to only disable VBUS if not runtime suspended,
> >   otherwise we get data abort on OMAP3
> >=20
> > Grazvydas Ignotas (7):
> >   usb: phy: twl4030-usb: don't enable PHY during init
> >   usb: phy: twl4030-usb: ignore duplicate events
> >   usb: phy: twl4030-usb: don't switch the phy on/off needlessly
> >   usb: phy: twl4030-usb: poll for ID disconnect
> >   usb: phy: twl4030-usb: check if vbus is driven by twl itself
> >   usb: musb: omap2430: turn off vbus on cable disconnect
> >   usb: musb: gadget: use platform callback to enable vbus
>=20
> since this falls into "has never worked before" I will apply them for
> v3.10. If you have any objections, let me know.

I have applied up to 'poll for ID disconnect'. Please rebase the others
against my 'testing' branch once you update based on my comments.

--=20
balbi

--CYcXvPfqKSDi0QhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSbTXAAoJEIaOsuA1yqREAncP+QF/dMNzQZsyT3rFWANn5019
2OMjVWnGvFS0PDGL72kwB39vrkgYsT5pAoyH50Z6XDlX/0/ds5Nq8gWs51LpXJvG
Kv4D4TVH/In9XZpZkbQdftwJw09Upz8vwk2Ph0AIQpWYSovxWolC/as0KU2lxyhf
eN2e5RNAnsSQfdhXI7/rk/pPEx6VSG2nokPTGEqA8JoODB9uZ+Ichi9FTCS7tHI/
tt2bDr2qgQigTVvsDIhevvzGqEG6Wn//TR40JR+agoMmI11n1i9+o8yO8VG3F4QE
r/RGXtYh6/mcogWxMfqYVWEcsCZlvJppsGSdwIkFfeSkLr7u/oscDAv0cU1qUgio
Nrwb8P3wcPXBXYSzGfN6eADrK2x55uEPRQHXimbGrBbTOdbyvCZmBPCaAzicmcEp
5tgD0ltY+YBSSoAvPtys7jfkQVj2DycSqEUB9cc+Ltx9O3YP18njWiPNqYznE18N
cDUT1CqWqu44IBxxtCaw4pKH/he4b2oXUErNRKJS/w1GNHi8gQDjQ2PcViES+5l8
OFrOIBD+qNaYB7TSZWchD/P0GiZe3Fg5jq01jBAQyVf0zvZq3qaqmWEAWCE0z/C4
vJxVaKnsM7/6cpnM244E1rpF4NyUrj3JB3G8EbFiFEy6pQn9g/Q64oqjkBLENo4/
ibAEe6GhCwxlJXSN637a
=caw5
-----END PGP SIGNATURE-----

--CYcXvPfqKSDi0QhV--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
