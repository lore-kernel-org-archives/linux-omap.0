From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Tue, 25 Sep 2012 11:04:21 +0300
Message-ID: <20120925080420.GH9137@arwen.pp.htv.fi>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
 <20120924121538.GH2892@arwen.pp.htv.fi>
 <CAPsFW+RTLpgXFOOh9fD=K1wCPMpBe4MummhWoqEBEEYYzMay=Q@mail.gmail.com>
 <20120924130216.GA5603@arwen.pp.htv.fi>
 <20120924160914.GB28835@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:49462 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753545Ab2IYIJR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 04:09:17 -0400
Received: by lbbgj3 with SMTP id gj3so7935958lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 01:09:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120924160914.GB28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Philippe De Swert <philippedeswert@gmail.com>, Philippe De Swert <philippe.deswert@jollamobile.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, heikki.krogerus@linux.intel.com, kishon@ti.com, marek.vasut@gmail.com, leoli@freescale.com, s.hauer@pengutronix.de, shubhrajyoti@ti.com, nsekhar@ti.com, notasas@gmail.com, vikram.pandita@ti.com, ravibabu@ti.com, mina86@mina86.com, praveen.nadahally@stericsson.com, mian.yousaf.kaukab@stericsson.com


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 24, 2012 at 09:09:14AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [120924 06:08]:
> > Hi,
> >=20
> > On Mon, Sep 24, 2012 at 03:54:22PM +0300, Philippe De Swert wrote:
> > > Hi,
> > >=20
> > > On 24/09/2012, Felipe Balbi <balbi@ti.com> wrote:
> > > > SoB's mail doesn't From mail.
> > >=20
> > > Well still in the progress of migrating of my personal to work laptop.
> > > Since the patch does not seem correct the replacement will have
> > > matching addresses.
> > >=20
> > > >> /*----------------------------------------------------------------=
---------*/
> > > >>
> > > >>  #if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430) =
|| \
> > > >> -	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500)
> > > >> +	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500) || \
> > > >> +	defined(CONFIG_ARCH_OMAP2PLUS)
> > > >
> > > > Weird, how can you build OMAP2PLUS without SOC_OMAPXXXX ??
> > >=20
> > > It seems entirely possible. I quickly tried to look if it got defined
> > > somewhere and it does not seem to be set anywhere.  That is why I got
> > > the impression it was replaced by CONFIG_ARCH_OMAP2PLUS. I'll dig
> > > deeper to find out why SOC_OMAPXXXX is not set if it should be.
> > >=20
> > > From the .config I got (used menuconfig)
> > >=20
> > > #
> > > # TI OMAP2/3/4 Specific Features
> > > #
> > > CONFIG_ARCH_OMAP2PLUS_TYPICAL=3Dy
> > > CONFIG_SOC_HAS_OMAP2_SDRC=3Dy
> > > # CONFIG_ARCH_OMAP2 is not set
> > > CONFIG_ARCH_OMAP3=3Dy
> > > # CONFIG_ARCH_OMAP4 is not set
> > > # CONFIG_SOC_OMAP5 is not set
> > > # CONFIG_SOC_OMAP3430 is not set
> > > # CONFIG_SOC_TI81XX is not set
> > > # CONFIG_SOC_AM33XX is not set
> > > CONFIG_OMAP_PACKAGE_CBB=3Dy
> > >=20
> > > Not a mention of CONFIG_SOC_OMAP2430 and  CONFIG_SOC_OMAP3430 did not
> > > get set (while it is not a 3430 but a 3630 I am using). Maybe
> > > CONFIG_ARCH_OMAP3 would have been a better choice then?
> >=20
> > that's quite f**ked up. Tony, why doesn't SOC_OMAP3430 get set for all
> > OMAP3 boards ? And another question: why don't we have a matching
> > SOC_OMAP3530, SOC_OMAP3630 and so on ?
>=20
> ARCH_OMAP3 will probably eventually just disappear and
> be replaced with ARCH_OMAP2PLUS + SOC_XXXX. But there's
> no need to do it right now as most of that should be
> internal to arch/arm/mach-omap2 anyways. I would just
> set the driver to depend on ARCH_OMAP2PLUS, and rely on
> the platform_data and DT to do something if specified.
> That means that on 2420 musb should not probe unless
> tusb6010 in specified.
>=20
> It seems that things like fifo_mode and generic_interrupt
> can all be set during the probe based on the platform_data
> or DT passed information?

Then maybe it's best to just remove the ifdefs and always provide
generic_interrupt() ?

Anyone against it ?

--=20
balbi

--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQYWWEAAoJEIaOsuA1yqREqgoP/3elzpkZfKV/rkF9VLl1U+Wm
KYuUz8TT/G8+RXdh5EPo7UZK98xSRhyggQDdtA/FenYhCikSUk5fSayF6VbVNJJx
Em1e/xd6++t2ViaoAkkbUQheeyPPSj5UfnmkWNz7mNswOql+Xxso2XiNJERhVUYy
l54in6ml9wmuX9uOKFvpZ4Bckrl/8esB4mFNIGzRcYB40rDWxNFsUGGwFZJuNIfc
U37hrrkuEwWTWc9zv40kvYg7xTvGP2FRCJuH4gh31+FbraIN+TA3I8pwFAxiupm9
jOWYR+XNmOniSLpm7rghbMKGLAKdWzBS3SDxkQHU6gUbQ1cWt40iKfFG/bRpzjyk
VyMj1ACsFwbWt3hlVZj3bdqx3pOG7AT81CtYW5Bk3JC1ZaqTPVFCR6aU+GiPVVJM
COuzM7Scl9oF671f5HGiBeF2CKDR2mqBJNKISdSwkwLRicRMVo2o0JHn63dswd1Y
SCBftNGn1407fcsAQnEBZQfXc/ZGJWDMYZ3euRqvJwsk3LGQUsOzijExcRTfqDvM
9Zkx2lJbOiYDYD/7bescBM9crI5wEb1/HH0sUSmySVycjtRgrMgXO+FsD04FrxT+
JO12/lG3EG7kZnXf+n9aR8kEADHGNK+6dATCbDusP/L9yDz7FoH53iJjbJOI9K0T
bB9Tw4qflL37082r4yOm
=1SXT
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
