From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH] ARM: OMAP2+: Add support for thumb mode on DT booted N900
Date: Wed, 5 Feb 2014 18:17:29 +0100
Message-ID: <20140205171729.GA17974@earth.universe>
References: <1391603582-11371-1-git-send-email-sre@debian.org>
 <CAHYPw2Ep9VP6Tem979ewcztdxkHkG8eR_U31U=f5ibsVa5AS4Q@mail.gmail.com>
 <20140205163117.GA15996@earth.universe>
 <CAHYPw2HX478ZZPfDTKCKSGhVdFc1-G5DszUR4vG+WRgZx=8+dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHYPw2HX478ZZPfDTKCKSGhVdFc1-G5DszUR4vG+WRgZx=8+dQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 05, 2014 at 05:38:54PM +0100, Pali Roh=E1r wrote:
> > I assumed, that the workaround is not needed for this device type.
>=20
> That rx51 secure call must not be called on non secure devices (e.g.
> qemu), because it cause kernel crash. So I thought that kernel should
> write something like secure call is disabled on that device types.
> Kernel code for errata 430973 will update ibe bit for non secure
> devices.

Do you see any advantage in having that message?

> > I just added the warning for missing CONFIG_ARM_ERRATA_430973,
> > because its very likely a misconfigured kernel.
>=20
> Yes, it can be misconfigured kernel, but if you do not have any thumb
> binary (like stock Maemo 5 system), then it is safe and OK.

I think running this kernel may also be a potential security
problem. If I understand it right the ARM core is left in an
unstable state when you run Thumb code, so this may result in
funny effects in the kernel?

-- Sebastian

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS8nIpAAoJENju1/PIO/qaDoEP/jUxpjyjriZBkOhRFXKglNJH
mmBfeMYeBkFuNOvmjrqd8kmAEZauYMcWxIWaRRKY0ckvTp0ZDHWLPYYrZpf3cXa8
4nNKgl4pQZHKawxyniq0Nq6bQkaN3ozMIqrVDYvMQ78ZUElUOwUR6WGnwlqKYEUl
wiLBWtJJjGumsYDmkRh2LOpK8B2cXztgvsECfuiv4P+3jS3vIi1dtpK/an65dju1
9aCDTYCWsAXISetOowGHuoMA3M3bcUPwYdZTM4DGn9eEFAxfEnnjK5HvUcLxrMxL
WdZkbdkFg2LM8JDxO8Xuqt4pUmKpeTC0Mhini/xTnZl0NwFrxvVUQapgFy8QuRfX
zHAJd81e5JsZbaKrv/zCrSPycJkmD8Sx/F4R33KxKvFhsGhwkMBrHP8rwtUPlm4b
qTHmZWt4jJvBZRRT89NJIBh6kTibH7t0qKbUBdxg4gpIuyqijJkTTj5YxXi62nbm
5IMuHexJM7NBHSiNQesyZJJcQ+FuvQyTXabaeJe0u2Vad41eOjvLFjvHcbp7JmQ7
6Z3uCJ4etevXD6xh8hnvVdXcSilltifqtcBFOhEXGyj8y32uWSmGmyC+PItBIwra
EnwKsQ/wpsrMgjxRP3OHkegE3i1EMqzmIomBUgheOyKyKOdmw4CBDdzEnF2FuhwW
NxRJEqsZBWlYBKGBq5EQ
=/oK1
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
