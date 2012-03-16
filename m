From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] input: keypad: move platform_data to
 <linux/platform_data>
Date: Fri, 16 Mar 2012 23:08:43 +0200
Message-ID: <20120316210841.GA19797@arwen.pp.htv.fi>
References: <1331907989-11891-1-git-send-email-sourav.poddar@ti.com>
 <1331907989-11891-2-git-send-email-sourav.poddar@ti.com>
 <1357514.ox9yZWgqO9@dtor-d630.eng.vmware.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:34845 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751684Ab2CPVI4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 17:08:56 -0400
Received: by mail-lb0-f180.google.com with SMTP id n10so3987048lbo.39
        for <linux-omap@vger.kernel.org>; Fri, 16 Mar 2012 14:08:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1357514.ox9yZWgqO9@dtor-d630.eng.vmware.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 16, 2012 at 09:36:19AM -0700, Dmitry Torokhov wrote:
> On Friday, March 16, 2012 07:56:28 PM Sourav Poddar wrote:
> > From: Felipe Balbi <balbi@ti.com>
> >=20
> > This patch allows us to drop the OMAP depencendy
> > from the OMAP4 keypad driver.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c            |    1 +
> >  arch/arm/mach-omap2/devices.c                  |    1 +
> >  arch/arm/plat-omap/include/plat/omap4-keypad.h |    9 ---------
> >  drivers/input/keyboard/Kconfig                 |    1 -
> >  drivers/input/keyboard/omap4-keypad.c          |    2 +-
> >  include/linux/platform_data/omap4-keypad.h     |   13 +++++++++++++
>=20
> Instead of creating platform_data directory why not move to
> include/linux/input/omap4-keypad.h?

look closer, that directory already exists. But if you prefer placing
that header on <linux/input> that's doable too.

--=20
balbi

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY6vZAAoJEIaOsuA1yqREi+kP/2NZ/KBkZc6CF4CUevEFkx+D
KJkaip9xHWUgEER9PCcoKw5ITJ5hndYXddBwoxT0sqHDZkoMad1GlYqgUequakKl
LTPMyQfgy5pk3R3wbUJe5Q8c0rSufW5EY4dO6pPsBICU/Wp2/DGsrm8ZP89TpOZj
F+kFbe55lLpfft743m58E7oW0A887bWa9MVne4gRjyZlpdIGxaj8AojldpqJPA6h
X4a+de9/6Ys7o2S1xsBvLnQxlza8ylHe4U4UTepR4hKi3cLpVBG4PvX3gh3EcmKv
x1czIj7LeTa6AWgdB2jT2Yvp7xzNoD7As+PjMhZWVbGZFF+D6HBRyM2js7BXW4vH
XtsOaXrn5bmJeEANuvErSQlDyJqxUPnfWc+6ZEmqjY+vPYdnHVLPEjC89YTU14uZ
LuTUadVW8u38zOZ4OpSKS6r3OyL2q69T7Nldg8UGQqJA1t0WOeb+Aq491Trz8VDv
7xbD0LP0sYx+a/pycKPWmYKco0VWoDbGJ8hyF6PfL8AYvub8Y/kJ0zXd+MtwQwbu
cYLVgAmpD22jAP5QyUoKEHBcN+XAgne/7Nt+jwixvUJqjWi+i0DWHYudl/0T1txT
gzODhAGdwNJzlcek4JABFvIatEKhidOmgZ9Tq/mBzolR1k9eR8mCLbMlCxipgr0l
D7dIr2LbTLYju9aFdSnx
=XUdQ
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
