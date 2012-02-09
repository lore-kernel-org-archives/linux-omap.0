From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap: be more aggressive with pm_runtime
Date: Thu, 9 Feb 2012 08:09:40 +0200
Message-ID: <20120209060939.GB1121@legolas.emea.dhcp.ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
 <877gzwyivt.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40578 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819Ab2BIGJo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 01:09:44 -0500
Received: by mail-lpp01m020-f179.google.com with SMTP id ge1so646218lbb.38
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 22:09:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <877gzwyivt.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, linus.walleij@stericsson.com, tarun.kanti@ti.com


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 08, 2012 at 04:01:42PM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > try to keep gpio block suspended as much as possible.
> >
> > Tested with pandaboard and a sysfs exported gpio.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
>=20
> Looks like you need a few more get/puts around other places where
> registers are accessed.  It currently causes a boot crash on OMAP3 in
> _set_gpio_triggering().

it was a missing get/put on gpio_irq_set_type(). Fixed.

> Did you test GPIO wakeups?  both IO ring wakeups and GPIO module-level
> wakeups?

how can I test that easily with panda ?

--=20
balbi

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPM2MjAAoJEIaOsuA1yqRE4gwQAJYzEaAy8WaPnkM/6K5GaPI5
GXhnf4PWXQ1DBFD9db4LSEekpaoFum7+aITFpUE8fMHIedCJ6wUayQspYXdehsPE
ZZW0KXU6hy6PIMikgBxawMm/xD3mHAnyK1r7/gsTqVf+b8Aeb3nW/rfnKXyQeJ/u
vqale44d4VmVDKsZx52AGvbmaceccGkHg092ZKdNpRh7IWkAuD2iGMH9ogLhwpuX
u+c8azbcyckakrtvOwLKhI/+Jvn22i0LZgVaabJsebqFtI2CJznlKUbwxAS4GiCH
ZOKEyi8fi9TGV4wZsUyvBU7DwpDHmopESf7OEpBQzRwhQ40miWEq8GoZUwh/c7DJ
ibPvjJnEg+dK/O6RtAnPNG92Cy1dmnmO2otuQi1G7pH435rIiqG7Zk6gb0UgQNY2
soIQ452K88G2PWk8k6NOyFTEVLuEG0OTK1ikKuH8LNj/V0ogloLt1zQMhG38aWMi
6F5xXUG2RP5JzvcLRrn1EzoIW7RlpMea/D9KyjQSbxEsefN5mb1KehljX6yy14CJ
FZahHVTRSg4gdXEr+oiBmOobWdn23cbiblPH36Sk0hR6fBT67LWAFOMh9cC1BI3P
dvkeGRqxWKMoIgeihWI8rZLlxcmfhLWxBQQep13v89fKcsdBoXo56cXymchOdf2O
9QzSyk/UZXpzXXMVzVsC
=buXg
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
