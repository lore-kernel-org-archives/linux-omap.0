From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 10:55:42 +0300
Message-ID: <20120607075541.GF16342@arwen.pp.htv.fi>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk>
 <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
 <20120607075158.GZ12766@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:40725 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754843Ab2FGH5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 03:57:34 -0400
Received: by lbon10 with SMTP id n10so342495lbo.41
        for <linux-omap@vger.kernel.org>; Thu, 07 Jun 2012 00:57:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120607075158.GZ12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2012 at 12:51:58AM -0700, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [120607 00:44]:
> > On Thu, 7 Jun 2012, Tony Lindgren wrote:
> >=20
> > > Here too I think driver like features like this should live in the
> > > driver init for omap OHCI driver. In the likely case that FS OHCI is
> > > not in use on the board, the OHCI glue can just reset it.
> >=20
> > What if the driver is not compiled into the kernel, but instead is buil=
t=20
> > as a loadable module?
>=20
> You can still have a core piece of the driver that's always built in, such
> as omap-ohci-common. But it should live under drivers, not in the bus lev=
el
> code. Or you can insmod/rmmod it to reset things properly.

that's such a hack... both solutions are quite hacky. The only problem
here is because some bootloaders are leaving controller in an unknown
state and I guess to be completely safe, resets should be done before
any driver kicks in.

But, driver will probably reset again the IP block during probe...

--=20
balbi

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0F59AAoJEIaOsuA1yqREnC8P/1pfnlHJeoi8VabkEfYRRReJ
IQH6aeZDLV9hMiSUAuMueLl3nkDXRfx7CFUBaHiXCuUNmVf2Rr+4qluicsBePAta
5NrOCVhujVEx6PtQV5xHB7EW639AAn9D7ie0zIG2XSqgKqE9ROVAqJZB/TDy7WUF
zwTrJqTdPql8YXguFk78EhVxNuYNS3rLzVUGd9HTZvfqCBUubW9hD83LsCV8UiTx
d47l8Y/pNTiEZ1wCa8cyMyTTxSdFG4MK2ZdBs0M8u8Q+ynYcHg8q+N7HUl3pSWRK
hZN4Yd/yZQucXWIbxvSHay4m627grac3k1PZhCwh/ZdCrlYTkaTsqHYRxGbUO57G
Gb39JNjyuFDJEcsmMqjmq46reujJXKQegg1oJtiqFf45atNdY+QprHc3pa5KBWAu
j9yPx9VNXvsIV6FZSyJidvDm1M8ntmTF6jTjTGTD5G6JyTxvlTZ5u7QJnKNhpMSx
c6wVdrw/n8DCAVNpqc/qi0xBH3i4rfP6gfJYmtUT+92A2CQYHWi6T6GJelhEUKLG
xQbpdz4h03um9YOA23oofUzbpVo5zY2XmrluXPIM8uWjGayIXm20/MN6xYtKt8Br
UrRFbiONY4ODGvWqQqqcu+QgIRwEEyB+gVsKbizpc3Q8CnUpWM+Sp8zbJY8m3gLd
3DliH5pMsLkBhTNIUZOU
=lO8Y
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
