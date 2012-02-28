From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] OMAP DSS fixes for 3.3-rc
Date: Tue, 28 Feb 2012 18:08:07 +0200
Message-ID: <1330445287.2123.236.camel@deskari>
References: <1329988974.1820.62.camel@deskari>  <4F4CFAD1.1000301@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-PkRWy3OTXlk5L3T8z7Mf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59673 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964917Ab2B1QIL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 11:08:11 -0500
Received: by mail-ee0-f51.google.com with SMTP id e50so916354eek.38
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 08:08:10 -0800 (PST)
In-Reply-To: <4F4CFAD1.1000301@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-PkRWy3OTXlk5L3T8z7Mf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-28 at 16:03 +0000, Florian Tobias Schandinat wrote:
> On 02/23/2012 09:22 AM, Tomi Valkeinen wrote:
> > Hi Florian,
> >=20
> > Two fixes for OMAP DSS for 3.3:
> >=20
> > First one gets the HDMI output working again. Managing the clocks for
> > OMAP4 is not very simple, and this patch circumvents the problems we
> > have in the clock framework. It's a clean but rather hacky fix, but it
> > shouldn't cause any side-effects. The issue will hopefully be fixed
> > properly with DT when we'll get proper parent-child hierarchy for DSS H=
W
> > submodules.
> >=20
> > The second one is a simple fix for HDMI hotplug detection, which I
> > missed when I wrote the HDMI PHY fix
> > (c49d005b6cc8491fad5b24f82805be2d6bcbd3dd).
>=20
> Merged. You would add
> Cc: stable@vger.kernel.org
> to patches if appropriate?

Thanks. Yes, I have sent a separate mail to stable list, as the patches
needed some tuning to apply.

 Tomi


--=-PkRWy3OTXlk5L3T8z7Mf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPTPvnAAoJEPo9qoy8lh719ysQAKcVVtyLkQfRxcMdM1rYNGEK
izki5y9joXjLVC0yfadTsMUMP0cICDBi7Mh65PkcLnigJylQFRimK/EMfZyQsXYf
hFfU6pVmOkb5udahwvd22+uv0fvUUzBK3mwQyVCqOYdCacbf2fdJBOq1R+6e3g3o
myVrNs0LnYmSERKSzT1tLfKQ4KiSrA2XajvVytPGl53mlA5ExdTP6exmIFQKjdh+
zSwMlI0Yt5LjSt3hyfMF91y1SZqIqfplS+Wb6MRM7F6wf6ClbREtYp+Y83UFcbJG
3ZnQhwT7OBFNFkoVT/wDwRfJ/HpQZU0PN5UTr05trw5gDfjDh/XuZWOwppUXozOK
TgI3wsVu6+cWzYHzfaRs+2j9ypHn1NAcgHn2hcL6NPE5mKscrnFONHHkTzBsZQl1
v/1A5KxRhUi8BvNFsADG+rAv1u2hyeCuh65Lyhm8PzhE9fCrTbNhqNW041lyCHRz
lOCLzkh/W6/hDIrTKR7kIjnpUE+8jjA7x1h1EZbDD6sKA0Ef70Ns5oHtcZ8/lVEK
4OqKJb1q9GY/lViILxO9ZMm3pjTH/AKH5jULiM1bBIotjmu+syXKrrgBuLCqJhjg
nAOtGrL0dv6/jQQSMIaELDPDY0AvQi6aGHpJqjOu0ceDTGsqob5sTDW0rlC3jFeR
OqclZHALCeff3luwqVrT
=oGe8
-----END PGP SIGNATURE-----

--=-PkRWy3OTXlk5L3T8z7Mf--

