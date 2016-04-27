From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HDMI5: Fix AVI infoframe
Date: Wed, 27 Apr 2016 08:55:38 +0300
Message-ID: <5720545A.2000508@ti.com>
References: <1461246520-26734-1-git-send-email-Linux.HWI@garmin.com>
 <1461260940-6660-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DEfLqawOT5JrvKiX6gVni68Wke5GkPAlf"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461260940-6660-1-git-send-email-Linux.HWI@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J.D. Schroeder" <Linux.HWI@garmin.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, misael.lopez@ti.com, Jim Lodes <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

--DEfLqawOT5JrvKiX6gVni68Wke5GkPAlf
Content-Type: multipart/mixed; boundary="bqBNnh5El6xwMMG5MjpAuDvwQ4JIk3F4W"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: "J.D. Schroeder" <Linux.HWI@garmin.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org, misael.lopez@ti.com,
 Jim Lodes <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
Message-ID: <5720545A.2000508@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HDMI5: Fix AVI infoframe
References: <1461246520-26734-1-git-send-email-Linux.HWI@garmin.com>
 <1461260940-6660-1-git-send-email-Linux.HWI@garmin.com>
In-Reply-To: <1461260940-6660-1-git-send-email-Linux.HWI@garmin.com>

--bqBNnh5El6xwMMG5MjpAuDvwQ4JIk3F4W
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21/04/16 20:49, J.D. Schroeder wrote:
> From: Jim Lodes <jim.lodes@garmin.com>
>=20
> The AVI infoframe R0-R3 in the 2nd data byte represents the
> Active Format Aspect Ratio. It is four bits long not two bits.
> This fixes that mask used to extract the bits before writing the
> bits to the hardware registers.
>=20
> Signed-off-by: Jim Lodes <jim.lodes@garmin.com>
> Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/hdmi5_core.c          | 2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks! Queuing this for 4.7.

 Tomi


--bqBNnh5El6xwMMG5MjpAuDvwQ4JIk3F4W--

--DEfLqawOT5JrvKiX6gVni68Wke5GkPAlf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXIFRaAAoJEPo9qoy8lh71GO4P/0oaeEQ4DYzCIb/hWc0azcvs
OXynC2RDPAVMW6Hj49cCUZeJojrNGQ2Qq6jEOXfTK4spCHjy6boZlCoPlBtVNHrr
yztNYRsU3DOqJjyDiKRtw58avneFmW6EatRBMULOF+I09fc/BEJi8C7H+7ddKiMT
BaU62D6+zQ8Od0FhjY5LNZpsdD06LYuxhaxNunArIsygDo+hvbh5ZmRDCMN8R6Hv
fNmicZOIDzbeYXPN4mMFwjb2cVTFjbf6rdhbRDv0BSWm6iwhmItcthCGMEbZfvUw
UF+mgnEyHMVQYQDEhFkhFXP4yRec64vs/0JgqoNdmyJYmw3zjFcVRBgGOKhi/LVU
xjAN979Entdq94i9isNYb/guk1wJceOlL+WXDaNLQqg/LSp5XdmI2OaWTH6haESu
jGFg7cjzJVR+8NcYJvctxKZ3qMlQWbRyU5KRSd6BWGbcJiiTp89nS3eN8ktkexik
LnFlLQ8R9NDzv7fE5Jsx75nI3Qi9gm/ymX9F7ZiBoJutPVZbtJFD0C3YEs4M6WIq
HPYHG+eHJIAyzOd8405QZ+dz/6wHwJh13xbRfQMeY8SNkwKrGfv/sYUMYX92K2CH
Mw1RYM9g15zk4DXYB8K51E3PodGtxgBNo+z/hIs7ZEn3sK2dSd7nTQr5CJlmjL6T
vl1aMpCpWsfu0AcuEhck
=2pC+
-----END PGP SIGNATURE-----

--DEfLqawOT5JrvKiX6gVni68Wke5GkPAlf--
