From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 11:26:22 +0300
Message-ID: <1333095982.1932.21.camel@deskari>
References: <1333094862.1932.15.camel@deskari>
	 <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175dd944aa9d2204bc7198ba
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59692 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759605Ab2C3I02 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 04:26:28 -0400
Received: by bkcjm19 with SMTP id jm19so417818bkc.39
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 01:26:25 -0700 (PDT)
In-Reply-To: <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>

--0015175dd944aa9d2204bc7198ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-03-30 at 13:51 +0530, Shilimkar, Santosh wrote:
> On Fri, Mar 30, 2012 at 1:37 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:

> > All OMAP4 versions seem to be affected. I couldn't find a mention about
> > this in the mainline kernel. Any ideas how and where this should be
> > fixed?
> >
> It's not patched for mainline. Generally clock-domain code
> is abstracted from drivers but considering the errata and affected
> modules, I guees it should be handled by DSS driver
> since that is where the state of DSS or ISS will be known. Note
> ISS will be automatically taken care since it will always use disaplay.
>=20
> In internal tree's this was handled as part of DSS early suspend/resume

That version doesn't work as it uses functions that are not exported to
drivers.

I don't know much about the clock domain code, but I hope there's a way
to handle it there. Otherwise I guess I need to add a new set of
platform callback functions, so that the dss driver can call
arch/arm/mach-omap2 code to enable and disable the work-around. I
dislike that because I'm currently trying to remove those kinds of hacks
to make dss work better with DT =3D).

 Tomi


--0015175dd944aa9d2204bc7198ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPdW4uAAoJEPo9qoy8lh71hvEP+wSyEiwJua57/WVLCvdsWGxc
JoXk7tmcFHc+/W32Tf+iz1MRFZ/RH5ftXjyKdOlKXVIMRQRRvXrjUSyGDrsidxDO
NTGWhE85VCCnsA4HWXRS5iHmpZbZAkIRehjccyxGTUwhqAK/br/7giJYLvziDIBQ
dStcRdXIp5kM67TsPwUntQLtgNK0+leyDC4bNizaZ0W3JATOCWf0zIvoaBZYle1x
8Aw+fUkI/WaAgQwkCfb72aA6ohles3g/K0El6IAIRRLIwB3JL10vtuWMw2IYyGzd
dTkS/s3zoR7x30EWq+euawDvOJU15zB7dB7vH3sZ/4iG4N/aSrBh26AIjSnw0HXI
qlT9kzxtrXb6Ud0bRrVLOyug4nkAZcjDpccZ3MOHd5zse+Om4gSZI283zN64MV6v
WarUYj0W6D3Xv5abEg/clQ+EDa/iiCLA30biDK5vqa86ax4w2x9LD+9jTR1NE7Cn
Pct6NyIMLR8KLn0mr5H9on1g2j3ZAwq9SKLGtv31Gdf3EAQUKDPMxn/C3CvyOGui
K31364RUeUjqKTRlXKOTjC+gIkC1KwUR8hv+mipkI8dIABraZoqSQwBi+54jchtr
sRPFR2+y4Y4vMiKDpHrlVzW6/DFEsxY3kMs08SPb1DFyVGMtR01gx2zbBkObHyYl
CB0RomAl9oOlnuU1Wa8I
=V1Qf
-----END PGP SIGNATURE-----

--0015175dd944aa9d2204bc7198ba--
