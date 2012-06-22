From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Fix MUSB ifdefs for platform init code
Date: Fri, 22 Jun 2012 13:15:34 +0300
Message-ID: <20120622101533.GC28472@arwen.pp.htv.fi>
References: <20120613101303.18645.83320.stgit@muffinssi.local>
 <20120613101506.18645.98406.stgit@muffinssi.local>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7486507704914567924=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120613101506.18645.98406.stgit@muffinssi.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-usb@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============7486507704914567924==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2012 at 03:15:06AM -0700, Tony Lindgren wrote:
> Commit 62285963 (usb: musb: drop a gigantic amount of ifdeferry)
> got rid of a bunch of ifdefs in the MUSB code. Looks like the
> platform init code is still using these dropped defines though,
> which in many cases results the board defaulting always to host
> mode.
>=20
> Currently the situation is that USB_MUSB_HDRC is the main
> Kconfig option with additional USB_GADGET_MUSB_HDRC so only
> these two should be used to select between host and OTG mode.
>=20
> Fix the situation for omaps. The following users should fix the
> platform init code in a similar way:
>=20
> Dropped Kconfig option          Current users
>=20
> USB_MUSB_OTG                    blackfin, davinci, not in Kconfigs
> USB_MUSB_PERIPHERAL             davinci, not in Kconfigs
> USB_MUSB_HOST                   davinci, not in Kconfigs
> USB_MUSB_HDRC_HCD               blackfin, not in Kconfigs
> USB_MUSB_OTG                    blackfin, not in Kconfigs
>=20
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: linux-usb@vger.kernel.org
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Looks ok, though I would stick to things boards are wired to do. e.g.:

all development boards are wired for OTG (with a few exceptions),
n800 is peripheral only
n810 is OTG

and so on. That way you remove all the clutter.

--=20
balbi

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5EXFAAoJEIaOsuA1yqREM48QALO3oO4y6tYnQpxmfS62dnys
JwxIH6yHIFevypkAXf6W0AH/WV2RKHZexSQ23OJ0JTvZiwhBsJHx07WTTjMpaFHp
Liri11k2UyhbQNdW+lOTPro0Zo/qjQMoqd4c9tX03a6T/YsbjEufqOCODfrNwo53
WdzJ26sbrwlegiX3kMK1yYb88khUyu6laZOzLmg37HdCR2mDLciQj8/BYFcuWjYC
B7EI06YZbIWENh3W1XbwBeWCPCSQAvWCskplxL2FQ6Kc2/djMc96gtwPfbjQdqSj
OqHZOwQ9RioUUDJKEQh7uVMbRW7gezlS5X2Y6qVYp6YQhxjNgmKiD0849zant8gK
CocBmxVlqyRpN2el/NaaJhrihqO9RdIoJUiyJoR/R9VMzrWE3NRSVfbN+F+YxBex
XrdNL3/MYWRNjBx38JtCdlP4NyCM6GRKx5mBCSeejYKTvdWq2i7L2vTWkt4XWNha
MjZIKvZnnEvgRzuBjVQpUWXZmyz/kMTP9YSenwJ8QtkxAjxQDUkQZSetPWTFmzT6
XtbKWZA8w63P54WODcqSps/9SxPYUr1iMiJf9jZ+hHileEDPlawEOVSm7J6MLhCz
4sglzWPKQ3ly0WrPBC4dlM8lNKAFItbVFn7uNQ1Y7nRbiE60W97WegejCTwa0E3Z
8bY+rtOKckt85daOJgPJ
=Epxg
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--


--===============7486507704914567924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7486507704914567924==--
