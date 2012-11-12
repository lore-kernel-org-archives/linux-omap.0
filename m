From: Felipe Balbi <balbi@ti.com>
Subject: Re: Porting board initialization for fdt
Date: Mon, 12 Nov 2012 10:01:34 +0200
Message-ID: <20121112080134.GB25465@arwen.pp.htv.fi>
References: <CAE7jHC-Z9wy=5HPzhZZpupcBVn862ERq1LRF9KQ=Ed7BXiDFBA@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE7jHC-Z9wy=5HPzhZZpupcBVn862ERq1LRF9KQ=Ed7BXiDFBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Constantine Shulyupin <const@makelinux.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tim.bird@am.sony.com, pandaboard@googlegroups.com, Keshava Munegowda <keshava_mgowda@ti.com>
List-Id: linux-omap@vger.kernel.org

--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 12, 2012 at 12:38:37AM +0200, Constantine Shulyupin wrote:
> What is architecture and the best strategy to port board initialization t=
o fdt?
>=20
> Let's see for example omap4_ehci_init and usbhs_bdata @
> arch/arm/mach-omap2/board-omap4panda.c.

before getting rid of platform_data, we need to switch over to proper
frameworks for muxing, clock, etc. In case of EHCI, pinctrl migration is
currently under development by Keshava (in Cc). After that we need to
take a look at platform and see if there are any function pointers in
there, if there are, those need to be removed.

> How to perform board specific initializations?
> Can omap4_ehci_init be converted to probe function of new platform
> driver  omap4_ehci?

yeah, that function is actually wrong. First, that GPIO pin belongs to
the HUB driver, not the EHCI driver.

Second, those clocks belong to the PHY, not EHCI either. Before those
details are cleaned up, we will always have hacky solutions which will
break in one way or another.

When those cleanups are done, conversion to FDT is not a problem at all.

--=20
balbi

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQoKzeAAoJEIaOsuA1yqREVr0P/2t4Asi3h/ntLrVmmWPAYP4M
mXVTtO59w3j+P2MT+qpbPo0Cqr2JJAX++spTI5tRk+aALcoquExtTn3Av80+UfvD
C6cjKqd/MUnJleqqZX+0UmbnK+JHX0H5qrbxOz6XLmPaIoWv9Oe9oF8VnLexR5NB
4TTJdYyqz3zPBmN/dKeeRR6K2sy5Flvq1ufzAPx9JAAAcPz0m3r9vCBevFPQ0P8K
KN+syhq4JiFQ74InUuADYmdf4eU3hI2e+zJMFQtSKuXO0MF0USymrOq4mTMsAf27
msunMpPZ0Yb+DjdIAZGWI2lSwi05shK0TC84m5KIFV1mCAyCWIHNFPp9RuGJ6U6R
w7hThNSc8a2k51QOmEd4VkEdp56/2zeMVHzS+zIF5jvsZv9Q8oAmF8jQ+DgMttnD
H/YFCzaJ+CVgnBmpXJGLmn9eeCjvjbiCxtx6R1bdLcfebjQk2mBetNHzOZUp7RoC
NKU0fija4FR9YMp2nSF/4ur8ezq3XtUkCjpMaq/3bz7yzfuAxg6U0LRUjWl2Iscj
H8BVM5QPgE9humMUekRE4yZVrd6ypX1y8/xVG5BYPU4E4FZrBIy+6hF0sE6IHWLU
jhWqJgk8qUn1/2+K73jrBFjN1d6/uZci5CILeLsmbthXA0/1yoosLrGR2I0My953
dPC/aQLJesRQLAHCNE1i
=tg7Z
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
