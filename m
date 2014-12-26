From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 09:26:20 -0600
Message-ID: <20141226152620.GF17430@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
 <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
 <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <549BE333.9060709@compulab.co.il>
 <549D5CC0.2090408@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56795 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbaLZP1H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Dec 2014 10:27:07 -0500
Content-Disposition: inline
In-Reply-To: <549D5CC0.2090408@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 26, 2014 at 03:04:00PM +0200, Grygorii.Strashko@linaro.org wrot=
e:
> >>>
> >>> Tony, your call
>=20
> May be it will be good thing to split this patch. That way more
> information will be stored in commit log about which set of options
> gives us what benefits.  And also, It will allow to continue with
> agreed changes.  ?

can be done, but then again, it's just a defconfig change. Tony, your
call.

> >> I think we should move omap2plus_defconfig to be mostly modular and
> >> usable for distros as a base. Most distros prefer to build almost
> >> everything as loadable modules. And my preference is that we should
> >> only keep the minimum rootfs for devices and serial support as
> >> built-in and rely on initramfs for most drivers. And slowly move
> >> also the remaining built-in drivers to be loadable modules.
> >>
> >> The reasons for having drivers as loadable modules are many. It
> >> allows distros to use the same kernel for all the devices without
> >> bloating the kernel. It makes developing drivers easier as just the
> >> module needs to be reloaded. And loadable modules protect us from
> >> cross-framework spaghetti calls in the kernel as the interfaces are
> >> clearly defined.
> >>
> >> Are there people really using SATA as rootfs right now on omaps?
> >=20
> > Yes. That is exactly my point.
> >=20
>=20
> From my side I'd like to note that I know about few ongoing projects
> on DRA7x EVM where SATA is used as rootfs - now It is the fast
> possible way to start Android.

now this is something different. This is evidence that there are people
relying on SATA on rootfs. I'll leave to Tony again.

--=20
balbi

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnX4cAAoJEIaOsuA1yqREB9YP/2LFFI2iRH+YPGYjVmgalzzq
6xwscyVv2qH84LbvjpBVmmjnUmNCDkYOzlO0wd4QtgKxaiXjWd4ZAAaYwGDVXx/U
A8+yKWvzomXOFgurdyPnU8/nl4oVgVlRnlHtGS3UiNJ/E7BIWeLradlEEsF2Sft+
GklujkFPyrDazOyM4AunJXrfY1rQIJYoq475RtugcmVye1W9VNstnQ0yOSJ+LV3A
sXkSBmHu3NrKrmMJxyB++7XGp2dmiCMx1VMeWkNS6TxtfKf6PseL9sziQqYbAq45
OGa1/I+AsDk8YO6+RAsdCcENGzlymRiJNXMHfMkQMZhoh6lfZeg1+Qjhw2Ijp4Jf
AZAhFhCiWn0rTgneXdhDYkT3rCZ8rb7YngHKhhh7v47p/VNlQaMPLkEVw0sbbBBL
4HK3FZyogxVkOnvbMcOt1vvR/1IV/T2xmLG5QlA/IdjOn/9n6DrY5qixDk1P6qAu
9xfrH1r+qISatrQxUQ78bBpt3v+wfy6826FeYeJ/iTioIOgHfX4SLohguhcgzI3S
c5P5v/ReAF4cAP8Q+XQy1XG9fesYkes2IzRpesvYDHmm1a4cKyEwuPMsDSr0Nmh1
oMQYcxRXVg9ZRS7EqIQhVoUQ6uOflc1+9QuSXbIhRWM7gatIMfm1IsIXdR4g7a8E
QmBNN+bfiRdEa2yh1ClX
=3llH
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
