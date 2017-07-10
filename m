From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: 4.13-rc0: stopped booting on Nokia N900
Date: Mon, 10 Jul 2017 14:55:47 +0200
Message-ID: <20170710125547.4jkw3yhe5poyjkzs@earth>
References: <20170710074610.GA22846@amd>
 <20170710081334.GA29726@amd>
 <20170710100250.GR3730@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="stiurqu3oynkl2r7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170710100250.GR3730@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--stiurqu3oynkl2r7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 10, 2017 at 03:02:50AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [170710 01:14]:
> > > I tested linux-next relatively recently, and it worked ok.
> > > af3c8d98508d37541d4bf57f13a984a7f73a328c is broken.
> > > 650fc87 worked ok.
> >=20
> > 2b97620 is broken.
> >=20
> > commit a51166ce71844ffbb8f78d63647b44dd69e46cf1
> >     Add linux-next specific files for 20170628
> >=20
> > was ok.
>=20
> Not sure if it's the same issue, but I bisected down an issue with commit
> 46e48e257360 ("genirq: Move irq resource handling out of spinlocked regio=
n"),
> so adding Thomas.

I saw your message too late and also bisected the issue I saw to this:

46e48e257360f0845fe17089713cbad4db611e70 is the first bad commit
commit 46e48e257360f0845fe17089713cbad4db611e70
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu Jun 29 23:33:38 2017 +0200

    genirq: Move irq resource handling out of spinlocked region

-- Sebastian

--stiurqu3oynkl2r7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlljeVAACgkQ2O7X88g7
+ppOuRAAjhxramwcBimZXYYus5uQ+AHh4BZMI8r/yykGSRJbJisy/e3u9sasMybd
sF3SC3wyvdRwGHT+8eYomOhciVO3fl00KmXdYQoISwbvmf3IpfaNPVlEv0EFW9IB
5Oplg9YyUzdSphOvj3oyYbF8xV0ir9soBx7yyNoXTCYprOVCJz8gzfVQlOVIF3b3
AJ8ahAgXY5P9w+FA90MxBGgjVINflipFDu7efIO/gezwCALPaqvVV5hdj0gV0U8Z
KWnwkC7UatVYZf/OzfDBuUofwuPI91TGHrIsCGJnhVTujUrNmhbSEpzMs8KP/SN/
8LLXKfkS1mbAcj+Ailqkv0qiGSDwF4oOQT/BwrAkB5WVuBkHHTI2DAgtntElGqlw
hX0GBCHE2XGVbZ9hGNVhA5r8350sNX1Vu4YVOpgS638YmtSGGWfr6BYnxmhDWbhD
7d9APOZwK/ACpeifrDZYyhCNXH7MeFpU+UZ6ZKg9vLRskWm7ws8O23fPcUrEKbq4
gZhS58s8tPcgYk6FMo9ylPXEKdxfJhapPlFRnSZIk39dF4vSH1g3+EfsqviP7j7/
dL3jRsO69acymLOSvg/feQGR+0OOZDerepu0P+Vcp9V0lJPFMoNNPytmlaaWpDOH
Hkj948/UKiNXa3JshwVnyWJ7lYpt9Qfrkm1neEeV1iAdvhWIJV0=
=0DCC
-----END PGP SIGNATURE-----

--stiurqu3oynkl2r7--
