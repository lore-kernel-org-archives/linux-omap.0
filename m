From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Mon, 19 Mar 2012 15:02:43 +0200
Message-ID: <1332162163.2144.77.camel@deskari>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk>
	 <20120317004706.GF7276@atomide.com>
	 <20120317211505.GA4720@n2100.arm.linux.org.uk>
	 <1332149601.2144.15.camel@deskari>
	 <20120319123006.GC16389@n2100.arm.linux.org.uk>
	 <1332160864.2144.66.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Sl8GtHBJ7kh7EZ/LhUlp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:46105 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751292Ab2CSNCt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 09:02:49 -0400
Received: by lagy4 with SMTP id y4so5742831lag.8
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 06:02:45 -0700 (PDT)
In-Reply-To: <1332160864.2144.66.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>


--=-Sl8GtHBJ7kh7EZ/LhUlp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 14:41 +0200, Tomi Valkeinen wrote:
> On Mon, 2012-03-19 at 12:30 +0000, Russell King - ARM Linux wrote:

> > It is _very_ important that we discover what has caused this regression
> > and prevent it going upstream until the problem is resolved.  Until we
> > know that, I suggest that _no_ OMAP changes go upstream during this
> > merge window until we understand what's caused this.
>=20
> I didn't try yet, but it could be this:
>=20
> commit 3ec2decbb6dfcdbbb6e6a8ddf5adc7edbc429ed7
> Author: Kevin Hilman <khilman@ti.com>
> Date:   Wed Feb 15 11:47:45 2012 -0800
>=20
>     ARM: OMAP: omap_device: remove omap_device_parent

Reverting that patch makes dss work again. I don't know all the details
of device/driver registration, but I guess the problem is this:

"omapdss" device is a platform_device, and there's no hwmod for it. The
dss subdrivers (which have a corresponding hwmod) are being registered
in omapdss-driver's probe. Previously the dss subdrivers had
"omap_device_parent" device as their parent, and this avoided the
deadlock between omapdss and the subdrivers.

Now, with that patch, both omapdss and dss subdrivers have
platform_driver as parent, causing the deadlock.

The patch does make sense, though. I hope nothing else than omapdss is
using the device framework in similar braindead way.

I'll see if I can make a single patch that fixes the issue. The patch
series I mentioned earlier does lots of things, but I think just moving
the driver registration out of the probe function should be enough to
avoid the problem.

 Tomi


--=-Sl8GtHBJ7kh7EZ/LhUlp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPZy5zAAoJEPo9qoy8lh71718P+wU0nauqT1KNm6SLWefPFAV5
qhVzxxKmeCUO+ix2NF0a/y5UeA3TVov7/6MHSgbXw3clklX00ILiVK+leLPnna5t
06njZjSHju2ibVkf/WmQHClIu2mYRFE/phyekiL3pBHVFh8srnGYDMJsaySmtj9A
O9rgaWVsjK++TrHC015oTCVJkphIHVSsRPp6/XUvbNK9JK4KLIiVS3K6Jx2Sfvfg
pacfuQs2R1wTv234al7ajYCfM9+CpGNDFtt64XYdf4cE8LrXJdqq8GRuHpBFnbsO
bQPk7fkcgxIGdu6pfTDxXm/zrfCBbwiT0O1g1+MrvzQtLF55ANJdf+E7RF5DciLc
gT03TPK30I+ku0Eg2JTbGM8OvySCn4BJaZt4i8UMRmptzpYZM9o9KhpGdTgF4CJ+
JZqQP9zHoJdr9WtN9AJVCVr6PfYOontcJU944x3V5A+MJkdh7TymjlEeY19mNirE
FVeI4fDbWh9niJ/KKho7bZOfaEsmAuD3wyBgoZnqiD8/a7b7EwAbC6vFNNwHnW7i
/+qBJe3iNOnpdENmV2DXQxlaFWuV2zJnSFFTXh5BtEza2xts0AJDRPdWMkULUVqi
wdvegRFMScobbVyCNO0ElwMrpAd9xWeobx7X6cM0T92DnB83xCWIE06xImKuVHt7
KzeAwQvsOPQ/1i+Du1cZ
=5Grt
-----END PGP SIGNATURE-----

--=-Sl8GtHBJ7kh7EZ/LhUlp--

