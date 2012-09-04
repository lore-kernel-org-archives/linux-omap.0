From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v9 01/13] usb: musb: dsps: add phy control logic to glue
Date: Tue, 4 Sep 2012 17:35:07 +0300
Message-ID: <20120904143505.GH14348@arwen.pp.htv.fi>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
 <1346411399-23964-2-git-send-email-ravibabu@ti.com>
 <20120831122342.GC24861@arwen.pp.htv.fi>
 <CAAe_U6LaCiEPB9ET26j2xjLtumKzJGu+CtW=fK_02d30Z-3BgQ@mail.gmail.com>
 <20120831131915.GA25341@arwen.pp.htv.fi>
 <6C6B28D4DC342643927BEAFCE8707BF63E9F56A7@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55106 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757064Ab2IDOjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 10:39:33 -0400
Received: by lagy9 with SMTP id y9so4209584lag.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 07:39:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6C6B28D4DC342643927BEAFCE8707BF63E9F56A7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "B, Ravi" <ravibabu@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 04, 2012 at 02:04:15PM +0000, B, Ravi wrote:
> > On Fri, Aug 31, 2012 at 06:51:04PM +0530, ABRAHAM, KISHON VIJAY wrote:
> > > Hi,
> > >=20
> > > On Fri, Aug 31, 2012 at 5:53 PM, Felipe Balbi <balbi@ti.com> wrote:
> > > > Hi,
> > > >
> > > > On Fri, Aug 31, 2012 at 04:39:47PM +0530, Ravi Babu wrote:
> > > >> From: Santhapuri, Damodar <damodar.santhapuri@ti.com>
> > > >>
> > > >> AM335x uses NOP transceiver driver and need to enable=20
> > builtin PHY=20
> > > >> by writing into usb_ctrl register available in system control=20
> > > >> module register space. This is being added at musb glue driver=20
> > > >> layer untill a separate system control module driver is=20
> > available.
> > > >>
> > > >> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > > >> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
> > > >> Signed-off-by: Ravi Babu <ravibabu@ti.com>
> > > >
> > > > Kishon, you were adding a real phy driver for OMAP's internal phy=
=20
> > > > logic on one of your patches and I believe this will=20
> > conflict with=20
> > > > your changes, right ?
> > >=20
> > > Indeed. My final patch of that series removes some of the functions=
=20
> > > from omap_phy_internal.c (which was taken care in the phy driver).
> > > >
> > > > How does this look to you ? Is this at least correct ? I=20
> > suppose the=20
> > > > correct way would be to actually have the system control module=20
> > > > driver which we have been waiting, right ?
> > >=20
> > > Correct. I think once we have the system control module driver in=20
> > > place, we'll have everything wrt control module register writes=20
> > > implemented in correct way.
> >=20
> > So $SUBJECT will pretty much be thrown away once we have SCM=20
> > driver, in that case it's best to wait a bit longer and apply=20
> > this series once SCM driver is available and after your=20
> > series too... you agree ?
> >=20
>=20
> Felipe, I am sure there are patches in this series[0/13], which are
> not dependent on this patch or control module, Can we pull in those
> patches (all dual instances support patches)? So that I can re-work
> and submit again?=20

sure, will do, don't worry :-)

--=20
balbi

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQRhGZAAoJEIaOsuA1yqREDxEP/0dCr0DyZsHWO4B2kPDuQ1l9
/WmwJYzPmc+dPNg60TILi98PUhikPuirGuL5MW3G5rQdI+vAZDs7Ix0wqPBLHdZA
nW0LdWPznHY2wYu2FGEYZT1SRx42+pdsiFyySJdhchgeiftMnXzHu/UwU0sjVdOM
NzeDdKkzgtyx7AHodYazfUNLleZdScOxTwU9ZC3e8jMZ6eSeprwEvc9KTHp6CPLZ
Zh5KlLyYJMadaRugcyb3lxvtNPg7XPXjvuk7swwr/M3GMe9ldT+6N7ZUJ0gZ3kZD
NMVWLtn1ScUPl8O1KphuDEH8gI59OifHo2Jb+5fnJmJvsMxj9rOa76Pvg2T7dEFn
q8Lb7RXCFdeoqJ7hNxRJpO1PZjOT68apIukVWdhx58NFN9aOVkx8L+34LYLiOyR7
JqbQqBFbtMaaXm6dskk85ZqRo+2mlOIbBSClvIQ0/dOVk9CJavK4A0FB4mUsH4co
K8CkmKMUPNrmedDoEoI5qL70EqBYu71H9sDJReqWJo4RVFE6UY5eSop+RxkoABFX
cjfpgjQIChy/DBA9OyKsrc+Hrd4Hhrim0xn3kQk+iI3aYIbySwh4ZJ20xq7oV3KC
ze77yK6WJLK/dYPOWgTexSECakTV3k3viPxSLyHVnOXp3B3CUicfVQkKfeKSmwtE
sMxlwAuLK2w4vGP+ex9u
=pin2
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--
