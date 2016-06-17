From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v10 00/14] USB OTG/dual-role framework
Date: Fri, 17 Jun 2016 10:31:52 +0300
Message-ID: <5763A768.4020608@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <5762887A.4060606@ti.com> <87a8ikz3kw.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pjNOi9TgVaosvfDJvdAj1GGSCLE6x6v9s"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a8ikz3kw.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: peter.chen@freescale.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--pjNOi9TgVaosvfDJvdAj1GGSCLE6x6v9s
Content-Type: multipart/mixed; boundary="6NgrdsWgjL2AchWJdf6CI0XokMFojSJO7"
From: Roger Quadros <rogerq@ti.com>
To: Felipe Balbi <balbi@kernel.org>
Cc: peter.chen@freescale.com, tony@atomide.com, gregkh@linuxfoundation.org,
 dan.j.williams@intel.com, mathias.nyman@linux.intel.com,
 Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com,
 jun.li@freescale.com, grygorii.strashko@ti.com,
 yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com,
 b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <5763A768.4020608@ti.com>
Subject: Re: [PATCH v10 00/14] USB OTG/dual-role framework
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <5762887A.4060606@ti.com> <87a8ikz3kw.fsf@linux.intel.com>
In-Reply-To: <87a8ikz3kw.fsf@linux.intel.com>

--6NgrdsWgjL2AchWJdf6CI0XokMFojSJO7
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17/06/16 10:17, Felipe Balbi wrote:
>=20
> Hi Roger,
>=20
> Roger Quadros <rogerq@ti.com> writes:
>>> This series centralizes OTG/Dual-role functionality in the kernel.
>>> As of now I've got Dual-role functionality working pretty reliably on=

>>> dra7-evm and am437x-gp-evm.
>>
>> Do you have any comments on this series? If yes I can include them
>> before sending v11 with Acks from Peter and Alan. Thanks.
>=20
> I'll need some more time to look at this, have been real busy with some=

> internal tasks. Frankly, though, I still think this is way more complex=

> than what it needs to be and that's actually quite scary IMO.
>=20
> I'll try to dedicate some time today to review these patches, hopefully=

> I'll find a few minutes. I know that I also owe you a look at the IRQ
> cleanup for dwc3, I'll see if I can get to that as well.
>=20

Thanks Felipe. I'm definitely open to improve this in whatever way
we can so that individual controller drivers prefer to use it than
do their own thing. A bit earlier review would have helped to avoid unnec=
essary
rework but let's do it now than never. :)

cheers,
-roger


--6NgrdsWgjL2AchWJdf6CI0XokMFojSJO7--

--pjNOi9TgVaosvfDJvdAj1GGSCLE6x6v9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXY6drAAoJENJaa9O+djCT6XYP/3YA8SMS/fh30o4PAcV+HW3W
MY+znN+OZ7fvkG6IplEcomt5M06rvC+mcGyrMY4KY6m9d80yYofsnlsx8j8xbbls
C/KRAZo/zQva6DnVo4pfd+0KKsUOpPreUpseEDwJX2ElIA1yIxNzFbLZjRvpOlld
FgFNH9j7AjaVbWXW8jTjKU1bKkAPrnjzx0rg+y3QYQQbQLctjnEb2mKnoq2jgYmj
C68PdRqpdjsXrQG+wHPjRAetYSbo2PFCsADX6mWe4aZitvyO2J2DL6R2NsjVqm92
oTMn5Pj29YZaikQfHRUaTH7jpOn9ykxN/hMrmIpovKSTxiwcBInjlo4dxjXgrvN6
HalpGGD9KUYyc2l2kZ6pHf/FSk4vR8TN1G+GI74fIGd26Z/ylT6qAe3T3UugfSIt
XzQr7jnuulJdDHCGKV3jxUcHKNsDVLYGNKr7gGJ8H5HCKiX4o4W2RG3h2d1ff68D
o5YuZLFoDUVlTXVnjuecndABFRtCHRraBuUDotpc8GYf/LHVocqwyhSSFoSHdg3X
JXX7NzUmHMevz3bAWa/NtK9YH2jyKGi7W+NhgkWt3LcixrwwtCRcE7GWO6jIPEpb
cJlEgWW2OuuUTdW6wO7s0ZSyrhjmW8kF+nECQRjFHnJ+jG9xq0LZxIaMJgOaAqHf
r30s6KU901Ju5IdR8z0O
=PKGY
-----END PGP SIGNATURE-----

--pjNOi9TgVaosvfDJvdAj1GGSCLE6x6v9s--
