From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
Date: Tue, 08 Nov 2011 14:14:49 +0200
Message-ID: <1320754489.1907.50.camel@deskari>
References: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
	 <20111105003550.GM31337@atomide.com>
	 <alpine.DEB.2.00.1111080049470.12394@utopia.booyaka.com>
	 <1320746911.1907.47.camel@deskari>
	 <alpine.DEB.2.00.1111080329300.8313@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-SWbV3Uor0Ddb0wQ6l4LF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:48902 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751680Ab1KHMOy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 07:14:54 -0500
Received: by mail-bw0-f47.google.com with SMTP id zs2so357768bkb.20
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 04:14:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1111080329300.8313@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-SWbV3Uor0Ddb0wQ6l4LF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-11-08 at 03:33 -0700, Paul Walmsley wrote:
> On Tue, 8 Nov 2011, Tomi Valkeinen wrote:
>=20
> > On Tue, 2011-11-08 at 00:50 -0700, Paul Walmsley wrote:
> > > On Fri, 4 Nov 2011, Tony Lindgren wrote:
> > >=20
> > > > * Paul Walmsley <paul@pwsan.com> [111006 16:33]:
> > > > > The following changes since commit be73246058737beec52ae232bcab77=
76332a9e06:
> > > > >=20
> > > > >   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-=
09-26 17:50:37 -0700)
> > > > >=20
> > > > > are available in the git repository at:
> > > > >   git://git.pwsan.com/linux-2.6 hwmod_dss_fixes_3.2
> > > >=20
> > > > Looks like you should take a look at the merge conflicts with
> > > > this one, maybe rebase it on 994c0e992522c123298b4a91b72f5e67ba2d11=
23.
> > >=20
> > > Do you want this series for 3.2-rc or 3.3 at this point?
> >=20
> > Seems that at least HDMI output is broken due to this series missing.
>=20
> OK thanks, 3.2-rc it is.
>=20
> The merge conflicts have been fixed, they were trivial.  Tomi, care to=
=20
> do a quick test boot with the updated branch
>=20
> git://git.pwsan.com/linux-2.6 hwmod_dss_fixes_3.2rc
>=20

Thanks, the patches in your branch look ok and work ok for me.

 Tomi


--=-SWbV3Uor0Ddb0wQ6l4LF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOuR05AAoJEPo9qoy8lh71aXYP/j99wal8cBKK3N6s06STfYpL
33h44DMJK1GlbcXrgisNcVnjjWiw+8PJZtBeHQpv0hoqSHLgdPQqJ6dOMqtF2ZBv
rGHCrPTyxcsnj9EqWrqnrhW+0w5Gax+KcXeVOS49xHK9TnWUcPMgKEoUPkaiwyxU
zFJ0X5i3r93khnZSpIuh07UstC/jBQF6NZtRGZfY4aD9dz0uCXHvpyjt7MaNGaFf
yiHICEo0T9ItI6TMKyNWtFhsFlM8xi/iKQ85UwO6x3QhK9TCgqpSRgD7Sf8XIeir
9eenPvfyulnYooAQs9A3hHHSV8C6mVgH4uwCqjTkP0/BzOft6YBicxOSFIKjXefP
CSyl4BZ411WcIAa39aJzSrYehEYIlbXgxxORUu3tcDhsO6eK3zvmGH9/OX+6UJgG
LfQk2OCSsdvPLn0isfznAIrB5qo+q0hDUJDdIPtY0vX5eiTlS29afaTqF/3n8Mfe
Ve/Qyi5Sh1PYXmqO4R+S0sqX22xUuzeZDWkSenqprLFoAffVQLi/TDcXjT8gea2d
/90k8EYnDC3qKGtWruEir7tdGp/EeXF4aoqYTIvzG/DDXntOfbIPdnLUO4fwgjgr
f0cr8w+gjs1YzcsqVWpRdIUYqcOzR0M0EBJxC7d0fTM648uHCDXWXAw8E3BC4qhG
Vh+xox1HRqiB9rvBdQ+i
=pfau
-----END PGP SIGNATURE-----

--=-SWbV3Uor0Ddb0wQ6l4LF--

