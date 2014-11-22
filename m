From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] input: touchscreen: edt-ft5x06: fix driver autoprobing
Date: Sat, 22 Nov 2014 10:06:14 +0100
Message-ID: <20141122090614.GA1285@katana>
References: <20141118192112.GM6179@saruman>
 <1416338862-8240-1-git-send-email-balbi@ti.com>
 <20141118195902.GF3003@dtor-ws>
 <20141118200340.GP6179@saruman>
 <20141118201421.GH3003@dtor-ws>
 <20141118201907.GQ6179@saruman>
 <20141122010524.GA26751@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141122010524.GA26751@saruman>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Can you comment on this ? As of today i2c-based drivers will probe with
> DT-based boot if DT's compatible is set to the same id as in struct
> i2c_device_id. No i2c driver with of_device_id can autoprobe using OF
> ids.

Long standing problem. Last one to tackle this was Lee Jones:

https://lkml.org/lkml/2014/8/28/283


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcFIGAAoJEBQN5MwUoCm2KYEP/RvtV+VqPLd5fSrrvxn9pM2q
kwaZi0smXvAj6Xxrqn5kL4IVxU8zuZKfTEU2r3arNCVyaJRcJzd0mlV/8VWw6pRa
ZuJeSKoEYGw4z9dfGPTwtD1tmpCUV748RmbKpzvIV1X1jgTSKTILO9bSCefkac9c
r3Dh2IWXyfeZcQueyias6p0Ob1xxR9M/LgND/hY/XxgU7424UUnUwjXO2M8sTVCy
+UW6c24c83U1Hyl51JojF+LqGhmUKLUcUilVWEHN74M37wEZJ8hDFez+ZwXu5Tnn
ejDb1OvXqRUGcHpIG3oylshv0YUwodafb9MCeQNqNz6BoMpm/zuP2eO4Z3FNVuTP
BGf+zMCwF6PChRuDRbXBGpkkdJctp0HvOt5wLnRXLh8IC//dsYeDRsQYmnjzdEGg
7ZVXNrrhJ47XWB/MUyJ56Dirv7geac2cic47jfP/fchgGJMXL56RHUMOAz1PkDeW
935lcv1arfGCEyO+1PSfTcoMfh+yMrn3gKuNvgtTTe94hZ6eZ1RGI7sDqzSrtSmR
j/ZnqIJcCyMVRytTmYdPdKeri1B/+flpNwzfsCqQbjn+jn97yYJtHBo+oc1RbfNo
nNHZsXDy5JKNcxIDxb8j1GyhaBnrq9k3scUwo/bFnHHj7Ylfqy2J3/BFM2HM5GjI
rgHWMWN1iyaswOuP5W1G
=R7fZ
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
