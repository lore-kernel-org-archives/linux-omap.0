From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Thu, 5 Dec 2013 11:41:42 +0200
Message-ID: <52A04A56.60403@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <20131204160119.GA9433@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KOm2V4lC9DbrrglNhH0QlkDxdvPgKJ9NJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50850 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189Ab3LEJmG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 04:42:06 -0500
In-Reply-To: <20131204160119.GA9433@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

--KOm2V4lC9DbrrglNhH0QlkDxdvPgKJ9NJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-04 18:01, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Dec 04, 2013 at 02:28:27PM +0200, Tomi Valkeinen wrote:
>> Here's a new version for DT support to OMAP Display Subsystem. See
>> http://article.gmane.org/gmane.linux.ports.arm.omap/102689 for the int=
ro of the
>> previous version, which contains thoughts about the related problems.
>>
>> The major change in this version is the use of V4L2 and CDF style port=
/endpoint
>> style in the DT data. However, note that even if the DT data contains =
proper
>> port & endpoint data, the drivers only use the first endpoint. This is=
 to
>> simplify the patches, as adding full support for the ports and endpoin=
ts to the
>> drivers will be a big task. This approach still works with more or les=
s all the
>> boards, as the only cases where the simpler model is an issue are the =
boards
>> with multiple display devices connected to a single output.
>>
>> Laurent, I'd appreciate if you could have a look at the .dts changes, =
to see if
>> there's anything that's clearly not CDF compatible.
>>
>> The patches can also be found from:
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss=
-dt
>=20
> Will this be ready for 3.14? Depending on that I would handle

That is my hope. We have been missing DSS DT bindings for too long, and
maintaining and adding new mixed DT/non-DT panels, as done for omap4
now, is just a big headache.

The bindings in my series are probably not perfect, but I believe they
should be fine enough. I didn't get any NACKs for the previous versions
of this series, and the only reason I haven't been pushing these to
mainline is that I haven't been satisfied with the bindings.

Laurent promised to have a look at the bindings to see if he notices
anything that would conflict with Common Display Framework bindings. If
he's ok with the bindings, I think we can decide next week if these will
be merged for 3.14.

> omapdss support for the N900 differently. If this code gets merged
> into 3.14 I will update the N900 patches [0] accordingly. Otherwise
> I would suggest to take the N900 patches as is for 3.14 and I will
> take care of adding the omapdss DT support to the panel (and the
> N900.dts) separately.

I really would not like to add any more hacks for DSS.

 Tomi



--KOm2V4lC9DbrrglNhH0QlkDxdvPgKJ9NJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSoEpaAAoJEPo9qoy8lh71aCwP/1ph95nrvAQw/DJYMTldtKAm
ST0eOCSmRB4EV8CL53GZUQH6tv+HWmHArXtqYf0zr1xJSbURbXoJYLdPgEvDbJIX
1nokSWo5aHdZtPgJOC347y8j8XW9if4/GMWXZbH/Dgtr9PJEQ5TkHgrjOSo5jMM9
nAzvHWmbXYbbU/ISakm5yUZkSbda0fseSYGrwxQILSFkwIQ2SxLUtfQQCiIGncPc
MsdRn5fh8z/xdj/JYT5gDQSN4nqiDWyaabC4qHSuY1eVgEIRk1KpW1rtsrE++/WX
HqYXFMlMihsJdri5L2jSbJkU6ELEPCSmw6r2iEBYFYj+BE8aFeckl2WqgtMjnmit
gTidqOzpHkRG2N1X+GZs13bDwIH8LrApn4RPLpHVQbMxzFSZtx/JiKsCTCmT7zJ4
ex4haHzTUjqHG3NYHfYKtW52Vd7ECmHlz32F3Yz263mDy7F4XuF59cF/Riynl0Oz
F3JX/I9ESHdcDI5Gh/F/ZnZR/NZIwyid/87FgFPHEemTIHszi8lOkvGlCx1BNfIp
Ixzo8869GQgLv0Y4o5/Py5uecX4cIug2i7DZF98ZVFkj8IkkXOxaT93LPwZRjMWn
wlEh+5eI0CWN42yfJhSbR6X6fCXXKhzSRoz/Fbd0wr+SkPlQOr8C7VZUYikG5R6m
nKqRemSd2ajhHuIR3hK8
=H8Dw
-----END PGP SIGNATURE-----

--KOm2V4lC9DbrrglNhH0QlkDxdvPgKJ9NJ--
