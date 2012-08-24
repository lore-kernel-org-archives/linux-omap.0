From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: linux 3.6-rc2, undefined reference to omap_musb_mailbox
Date: Fri, 24 Aug 2012 10:27:04 +0300
Message-ID: <20120824072702.GD3334@arwen.pp.htv.fi>
References: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net>
 <CAAe_U6+dFuX9fSX_epnPzX_3Zx3XBWAxE6kHDCTeuPwtn-ZQNw@mail.gmail.com>
 <20120820095421.GL17455@arwen.pp.htv.fi>
 <CAAe_U6+x+gxp2PMzuTyT=2Ox=HJtYw3DXGZLmaczi+q2oTM6TQ@mail.gmail.com>
 <20120820102641.GM17455@arwen.pp.htv.fi>
 <CAAe_U6JsPJ0b3HszOuCcu1LqEkXnC=LTQG00qwQzdB6pBnpryA@mail.gmail.com>
 <20120820113624.GP17455@arwen.pp.htv.fi>
 <alpine.DEB.2.01.1208232235200.15831@pmeerw.net>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.01.1208232235200.15831-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2012 at 10:38:59PM +0200, Peter Meerwald wrote:
> On Mon, 20 Aug 2012, Felipe Balbi wrote:
>=20
> > On Mon, Aug 20, 2012 at 04:37:28PM +0530, ABRAHAM, KISHON VIJAY wrote:
> > > Hi,
> > >=20
> > > On Mon, Aug 20, 2012 at 3:56 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > > > On Mon, Aug 20, 2012 at 03:46:07PM +0530, ABRAHAM, KISHON VIJAY wro=
te:
> > > >> Hi,
> > > >>
> > > >> On Mon, Aug 20, 2012 at 3:24 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > > >> > On Mon, Aug 20, 2012 at 11:06:34AM +0530, ABRAHAM, KISHON VIJAY =
wrote:
> > > >> >> Hi,
> > > >> >>
> > > >> >> On Sat, Aug 18, 2012 at 9:34 PM, Peter Meerwald <pmeerw@pmeerw.=
net> wrote:
> > > >> >> >
> > > >> >> > 3.6-rc2 fails to compile with
> > > >> >> > CONFIG_USB_MUSB_HDRC=3Dm
> > > >> >> > CONFIG_USB_MUSB_OMAP2PLUS=3Dm
> > > >> >> >
> > > >> >> >   LD      init/built-in.o
> > > >> >> > drivers/built-in.o: In function `twl4030_usb_irq':
> > > >> >> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518:=
 undefined reference to `omap_musb_mailbox'
> > > >> >> > drivers/built-in.o: In function `twl4030_usb_phy_init':
> > > >> >> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540:=
 undefined reference to `omap_musb_mailbox'
> > > >> >>
> > > >> >> Having TWL4030_USB as a module will get rid of this.
> > > >> >> I'll see how this can be resolved when some modules are *built-=
in* and
> > > >> >> some are made as *modules*.
> > > >> >
> > > >> > EXPORT_SYMBOL_GPL() should sort that out, right ?
> > > >>
> > > >> No :-( I already have EXPORT_SYMBOL_GPL() in omap2430.c.
> > > >
> > > > I see you're missing an "extern" on the function prototype (on the
> > > > header). Not sure how modules.dep is generated, but maybe it needs =
the
> > > > "extern" there. Can you check it out ?
> > >=20
> > > That isn't helping either.
> >=20
> > oh, ok... twl4030-usb is built-in... now that makes sense. Since
> > twl4030-usb uses a symbol from omap2430, then it should depend on it,
> > otherwise this will always happen.
>=20
> so add USB_MUSB_OMAP2PLUS to the depends of TWL4030_USB in=20
> drivers/usb/otg/Kconfig?

correct ;-)

--=20
balbi

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNyzGAAoJEIaOsuA1yqREgLQQAJyS3PefzgSIXVep/Tol2fcs
ubx9QQsrnEnidkQkahFLzukEUO/VPJ5UU2txy1uQKYSZjBrrd56TnbOeWxojM86L
OdtPPTKydOtzZ/uSKWIw/6xn5EtF8AIqTXMPaWtqNi/RWCXrMy/iLC7nlMKxrwYF
V/VQGM0ZbV3YKNcN+6yds0efeiolw/ctung1U+n0R3WDA/4G9/2OUqylMgVjMRvV
oq+NYAfPiMiywuTkDwqvHz67QI+kXH3zYugS3ApIipq09zSe2+qWyXA6n+wJOE+P
QkBjOmPX33TSuxbw8QL0bHN2h4KfzRq6oDW08XNqdqyh5guJuA13o2jZ95j1X05a
sWPRiJGBVz4SzW/IDzUwpoUrxVObeISacz7PPWOtatS0CmOGST+3A0R6M/HnODfb
00R45HezVashG6cm7IcvkQgv6hAKOqBlGJ7LsJfSuQv59G8UriNjBpSEr4Tfpe6H
3GaUK5y/+nMUMtg88oBGxqeI2JX6TRjOsI8PCz4SgquwblN4FTyajjgWXtxIQHsH
1pMPZseEUr7QI41MklU19QQqh/IMMJiYWDk8KPW9KvehjS1ueQ3FeBF4wyTxvQ9s
6MSCgUIWcZFq9bzn1wFu2IFS2lNWr9hjqhdCfOQ1km8FfhZ5teKkWzxozSindGTs
vMBInM6jNE88NVirpeeW
=PVwd
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
