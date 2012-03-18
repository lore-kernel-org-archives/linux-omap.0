From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sun, 18 Mar 2012 10:22:41 +0100
Message-ID: <20120318092241.GA23839@avionic-0098.mockup.avionic-design.de>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <201203150922.06379.arnd@arndb.de>
 <20120315102736.GA25371@avionic-0098.adnet.avionic-design.de>
 <20120317104751.4F00E3E0910@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49649 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab2CRJWr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Mar 2012 05:22:47 -0400
Content-Disposition: inline
In-Reply-To: <20120317104751.4F00E3E0910@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Grant Likely wrote:
> On Thu, 15 Mar 2012 11:27:36 +0100, Thierry Reding <thierry.reding@avioni=
c-design.de> wrote:
> > So if we decide to explicitly allow specifying names, then we can alway=
s add
> > a pwm-names property (or <name>-pwm-names respectively) to use as label=
 and
> > fallback to the user OF device node name if that property is not presen=
t.
>=20
> After implementing both schemes (ie. interrupts+interrupt-names && [*-]gp=
ios)
> I definitely prefer the fixed property name plus a separate names propert=
y.
> It is easier to use common code with that scheme, and easier to statically
> check for correctness.

Okay. Would everyone be happy with "pwms" and "pwm-names"?

Thierry

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9lqWEACgkQZ+BJyKLjJp+iaACffjrLDo8Nhrn3ykiYv0JSH92f
gQoAn2sJ6ZVCxnpPdYohrQiFppzUvpvC
=Dm/X
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
