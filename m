From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 10:33:24 +0300
Message-ID: <20120607073323.GD16342@arwen.pp.htv.fi>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk>
 <20120607073112.GX12766@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:33767 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752730Ab2FGHfR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 03:35:17 -0400
Received: by lbgc1 with SMTP id c1so304949lbg.15
        for <linux-omap@vger.kernel.org>; Thu, 07 Jun 2012 00:35:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120607073112.GX12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 07, 2012 at 12:31:13AM -0700, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [120606 23:26]:
> > From: Tero Kristo <t-kristo@ti.com>
> >=20
> > Add a custom reset function for the usb_host_fs/fsusb IP block, and
> > connect it to the OMAP4 FSUSB block.
> >=20
> > This is the first of two fixes required to get rid of the boot
> > warning:
> >=20
> > omap_hwmod: usb_host_fs: _wait_target_disable failed
> >=20
> > and to allow the module to idle.
> >=20
> > It may be necessary to use this reset method for OMAP2xxx SoCs as
> > well; this is left for a future patch.
>=20
> Here too I think driver like features like this should live in the
> driver init for omap OHCI driver. In the likely case that FS OHCI is
> not in use on the board, the OHCI glue can just reset it.

this I don't agree. It means we will have to add some OHCI code even
when OHCI is disabled.

> > +/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS registe=
r */
> > +#define HCCOMMANDSTATUS			0x0008
> > +
> > +/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag =
*/
> > +#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)
>=20
> I don't think the bus layer code should need to know anything about driver
> specific registers.
>=20
> > +	omap_hwmod_write(HCCOMMANDSTATUS_HCR_MASK, oh, HCCOMMANDSTATUS);
> > +
> > +	omap_test_timeout(!(omap_hwmod_read(oh, HCCOMMANDSTATUS)
> > +			    & HCCOMMANDSTATUS_HCR_MASK),
> > +			  MAX_MODULE_SOFTRESET_WAIT, c);
> > +
>=20
> These should be accessed by the driver in a standard way after ioremapping
> the device.

agree.

--=20
balbi

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0FlDAAoJEIaOsuA1yqRE8P0P/RdU8d2w7cIcPm4H6t6P8JK7
lpMFs6BKhbglOYewpjSKJLj5O5nlZRWj5vtmC3R4GQ59Oxw3mXd5Divmpy9aePLs
IyXqGjOyx1BaW20bq6/hwpiP2/EcSjI0lYvoY5DKfBz65sxLGyDGysk88JlgprRa
NkO0SxMnS4w3nUx3/sXftAarsnX9uNT0KyofkEWnaXzVRA999P6AZdWhTz7WYQB8
hWqHLdaFows8JLNj3YcYkoDYgcgH/RhEfoNtbeK6EB2jLN2DyCtkPXMbZ8eVCBvq
LoisCyIoVFv7yj0p94RzjhcAI5BK+0lxhHhInYRZaRJVPTTsLBRP4qbO5mCg/LY3
ZwKPlA0eGpD+9BpSTSmzRaI0/Q7ez2PQETNgCRzWVtOHFYtTtQBJemmI6AEfNN7g
1FwFnRG1Di1K5ME+fiicR8uWX6zfVL/Z414KvdoxnXZtKuK8uOscYJzM39VNBgvQ
td2vIVeTLEZT2riD7wNHZGqc05qE9r1L4pv9k3RXTsv1j3MTQ90O+ayd7QG9plvB
rXWI8Y+7UTJxYbrSxr5tA96LhZwq8vOuhL7nGCdaDp5coRx19f0yzSRbUizsmQGD
E+7oY7AEjavkGlYpAIHIsNyuKI5j0GvuxT9nbR6dwNW9sKURiBCHjenPl+3XrGJF
shk2f4pwUfxCNlRxi3CQ
=v4bS
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
