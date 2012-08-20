From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: linux 3.6-rc2, undefined reference to omap_musb_mailbox
Date: Mon, 20 Aug 2012 12:54:22 +0300
Message-ID: <20120820095421.GL17455@arwen.pp.htv.fi>
References: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net>
 <CAAe_U6+dFuX9fSX_epnPzX_3Zx3XBWAxE6kHDCTeuPwtn-ZQNw@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="37cJpJlYZwAfNbm5"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAe_U6+dFuX9fSX_epnPzX_3Zx3XBWAxE6kHDCTeuPwtn-ZQNw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--37cJpJlYZwAfNbm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2012 at 11:06:34AM +0530, ABRAHAM, KISHON VIJAY wrote:
> Hi,
>=20
> On Sat, Aug 18, 2012 at 9:34 PM, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org> wrote:
> >
> > 3.6-rc2 fails to compile with
> > CONFIG_USB_MUSB_HDRC=3Dm
> > CONFIG_USB_MUSB_OMAP2PLUS=3Dm
> >
> >   LD      init/built-in.o
> > drivers/built-in.o: In function `twl4030_usb_irq':
> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518: undefined=
 reference to `omap_musb_mailbox'
> > drivers/built-in.o: In function `twl4030_usb_phy_init':
> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540: undefined=
 reference to `omap_musb_mailbox'
>=20
> Having TWL4030_USB as a module will get rid of this.
> I'll see how this can be resolved when some modules are *built-in* and
> some are made as *modules*.

EXPORT_SYMBOL_GPL() should sort that out, right ?

--=20
balbi

--37cJpJlYZwAfNbm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMglNAAoJEIaOsuA1yqRECL0QAIu1k6lCsBLxoXuPjAjvXvIa
Ow+KKHRDFoA0tp55IfHX1ci1m/OcATpGwPw6m6GLftid4VkfE/KDLZEfEgrHA8IK
cMsC5OIChji4WNsPFtfbNKdaSwbOwM2yrD4K1vRX3M7rBdoveazKpynSt0UjRTUK
we53+uF1gtzcDJXAfLOlRvF7yFvamWym1REQRF7Nx8XXLx+bZK0BbXfonI2FlQb2
AlPwDPO0XKHhKXtDguPeqASX4/cPtNo4+AiO1dnCsSDMgAu0TLmTc8oktjaHLDR1
TSQMWzkZKQSP+qHPVqA5pFkXVQCeWknT12GYFEY19Zv50zMc17rutez09+PloqfE
sf4x5CBJw/PPIAwQaq32h2Ir0kk3QowaeB2xQcM+qqWv+6SCGviGeIcdAuBvZU3+
PgPkfH9d8Dh0SZVHBIu0JV0mqBUHIgbjvBuGzVSu9Eh4BIGRQQsG7cqWChlzjZBf
FBEPhLusSdidUQRuCe6GMqU7nl+ABn6Y1BBdB0uPPFh3F1xW7nPKIAM683IHDyoq
4EA75EVaxSNi5YZ3EeNgmhAYep/B0FV4ZIYOc7r11c5Bjdo9s9S0WaLQrmcrSXpA
FOSIL7qZbqvZO2uj5G/lWdPe3suD9Hr1+A29FV3gU7c+CwAIYq4k71Q01NGYfNr8
Dv/6nO/VeYwNH+pxYJG5
=hKK2
-----END PGP SIGNATURE-----

--37cJpJlYZwAfNbm5--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
