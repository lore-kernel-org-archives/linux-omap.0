From: Felipe Balbi <balbi@ti.com>
Subject: Re: linux 3.6-rc2, undefined reference to omap_musb_mailbox
Date: Mon, 20 Aug 2012 14:36:25 +0300
Message-ID: <20120820113624.GP17455@arwen.pp.htv.fi>
References: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net>
 <CAAe_U6+dFuX9fSX_epnPzX_3Zx3XBWAxE6kHDCTeuPwtn-ZQNw@mail.gmail.com>
 <20120820095421.GL17455@arwen.pp.htv.fi>
 <CAAe_U6+x+gxp2PMzuTyT=2Ox=HJtYw3DXGZLmaczi+q2oTM6TQ@mail.gmail.com>
 <20120820102641.GM17455@arwen.pp.htv.fi>
 <CAAe_U6JsPJ0b3HszOuCcu1LqEkXnC=LTQG00qwQzdB6pBnpryA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kERJ49nCKmnv470N"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:58995 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752600Ab2HTLkX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 07:40:23 -0400
Received: by lagy9 with SMTP id y9so3580538lag.5
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 04:40:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAe_U6JsPJ0b3HszOuCcu1LqEkXnC=LTQG00qwQzdB6pBnpryA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: balbi@ti.com, Peter Meerwald <pmeerw@pmeerw.net>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org


--kERJ49nCKmnv470N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2012 at 04:37:28PM +0530, ABRAHAM, KISHON VIJAY wrote:
> Hi,
>=20
> On Mon, Aug 20, 2012 at 3:56 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Mon, Aug 20, 2012 at 03:46:07PM +0530, ABRAHAM, KISHON VIJAY wrote:
> >> Hi,
> >>
> >> On Mon, Aug 20, 2012 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> >> > On Mon, Aug 20, 2012 at 11:06:34AM +0530, ABRAHAM, KISHON VIJAY wrot=
e:
> >> >> Hi,
> >> >>
> >> >> On Sat, Aug 18, 2012 at 9:34 PM, Peter Meerwald <pmeerw@pmeerw.net>=
 wrote:
> >> >> >
> >> >> > 3.6-rc2 fails to compile with
> >> >> > CONFIG_USB_MUSB_HDRC=3Dm
> >> >> > CONFIG_USB_MUSB_OMAP2PLUS=3Dm
> >> >> >
> >> >> >   LD      init/built-in.o
> >> >> > drivers/built-in.o: In function `twl4030_usb_irq':
> >> >> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518: und=
efined reference to `omap_musb_mailbox'
> >> >> > drivers/built-in.o: In function `twl4030_usb_phy_init':
> >> >> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540: und=
efined reference to `omap_musb_mailbox'
> >> >>
> >> >> Having TWL4030_USB as a module will get rid of this.
> >> >> I'll see how this can be resolved when some modules are *built-in* =
and
> >> >> some are made as *modules*.
> >> >
> >> > EXPORT_SYMBOL_GPL() should sort that out, right ?
> >>
> >> No :-( I already have EXPORT_SYMBOL_GPL() in omap2430.c.
> >
> > I see you're missing an "extern" on the function prototype (on the
> > header). Not sure how modules.dep is generated, but maybe it needs the
> > "extern" there. Can you check it out ?
>=20
> That isn't helping either.

oh, ok... twl4030-usb is built-in... now that makes sense. Since
twl4030-usb uses a symbol from omap2430, then it should depend on it,
otherwise this will always happen.

--=20
balbi

--kERJ49nCKmnv470N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMiE4AAoJEIaOsuA1yqREP64P/25b1gQ8FCpm67pKLvfG9An4
uRd9bUvK7vwpSH+KTCT1O2w2i+qosWB4oZx9Lga0+FyJxHnyGhhxZU+2KVkg4j94
Yg+wniL+Lcvg0Xk76XIizMvLZ+ZBrxy3iLx/xyfSPwp73GFvKelGkIwJzV01dl6N
DvP94FFdBJD5xMUL5kzWqNxd41SdJdFHaJABe1d8mSM3b0fQ3IEnSti1qFQ076IE
zDlq4lVeDIVWE77woA+aaLGw7FC+UnxO8Gza1u7upQI6vqe8iQWPEiBPu0wzihlh
2mrIw7v/HGed0Rshw+mZJnF8I+jFoV5rI3LeUFkCLqfdwRqbBk+BiIsc5f3o0R0c
Df6Mri6ps3ZgHzGXV0etayGheJLnlnYKTXm1lWDjX69SlSk3pXjmA6ZTR4rL4LX9
kxfaatj61IyPqYqbfPPqk8PfB1YW/09e5PYiQor+ApQ4DhxNKzJpz0Xxai2XBPz+
WoHaOSandos09JJiYYEoxsyOkn9C35jhYCEPrskM3NURt6Izj7CGDNiCvf30gHGv
13JrKyEg/Y/SD+ncFjr4yO2CWNAK9SODgQ/ziNYvPLTm7oDm2mVYyWB8uWJk6WkL
j5L8/pl58Abhs7FKBgkxi2NNcpjBknY48M2ZQ0Ow+hx/AWt9mI5W8auXCul5Aa4+
yKDVkEoNdguDBe0dMgdZ
=OAmL
-----END PGP SIGNATURE-----

--kERJ49nCKmnv470N--
