From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for
 v3.4
Date: Sun, 11 Mar 2012 20:42:33 +0000
Message-ID: <20120311204232.GC3171@opensource.wolfsonmicro.com>
References: <877gywjhht.fsf@ti.com>
 <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com>
 <20120309003217.GB12083@atomide.com>
 <20120309114731.GA3273@opensource.wolfsonmicro.com>
 <87zkbp4wtj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41097 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751557Ab2CKUmg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Mar 2012 16:42:36 -0400
Content-Disposition: inline
In-Reply-To: <87zkbp4wtj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 07:29:28AM -0800, Kevin Hilman wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> > Absolutely not, the for-next branch is rebuilt frequently especially
> > since it includes stuff sent to Linus and he complained about bugfixes
> > merged up into development code.  What is the actual dependency here?

> The stuff is in your topic/drivers branch.  Specifically:

> ed5da2a mfd: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS
> 77a3915 regulator: twl-regulator: Add fixed LDO for V1V8, V2V1 supply
> d64214b regulator: twl: adapt twl-regulator driver to dt
> 3e1ff1f regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators
> 1a4a805 regulator: twl4030: add support for external voltage get/set

Oh, ick.  That really is quite buried and probably depends on some of
the earlier changes too.

> > The topic branches are more or less static, though some more than
> > others.

> Is topic/drivers something stable?  If not, these are a ways back in
> that branch, maybe you make a topic/drivers-stable for us?

The branch itself is essentially stable but I'm not enthused about the
idea of merging the whole thing via the OMAP tree.  However, as Linus
has released an -rc7 I should pull some stuff out of there and send
fixes to him so I've created a topic/twl so let's just rebase.

> > In general you should warn people if you've got a dependency on their
> > tree, it makes life easier.

> Yeah, I should've raised this when the original series were posted.  The
> arch stuff and drivers/regulator stuff were posted all together, but you
> picked out the regulator stuff and I picked up the rest. =20

Actually IIRC by the time I applied this the ARM changes had been
totally deteched from the regulator stuff - Tero was sending just the
regulator patch by itself and I actually applied the patch it was part
of a twl regulator series Rajendra put together after I got fed up with
the number of people sending me incompatible changes without talking to
each other.  I'd completely forgotten about any arch/arm stuff.

This sort of issue is becoming far too common with the OMAP stuff, there
needs to be a much greater awareness of the need to coordinate both
between trees and with multiple people working on the same code.

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/=
topic/twl

for you to fetch changes up to 46eda3e96a65b378041c79c51ff2e02009f7e2d0:

  mfd: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS (2012-=
03-11 20:09:26 +0000)

----------------------------------------------------------------
TWL specific changes, cross-merged with OMAP due to arch/arm wanting to
use the new ability to override the voltage set and get operations to
support the in-CPU voltage management.  The other changes are minor
fixes, the addition of a few new regulators and device tree support.

----------------------------------------------------------------
Laxman Dewangan (1):
      regulator: twl6030: Fix voltage selection logic

Peter Ujfalusi (2):
      regulator: twl-regulator: Add fixed LDO for V1V8, V2V1 supply
      mfd: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS

Rajendra Nayak (1):
      regulator: twl: adapt twl-regulator driver to dt

Tero Kristo (2):
      regulator: twl4030: add support for external voltage get/set
      regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators

 .../bindings/regulator/twl-regulator.txt           |   68 ++++
 drivers/mfd/twl-core.c                             |   41 +++-
 drivers/regulator/twl-regulator.c                  |  327 +++++++++++++++-=
----
 include/linux/i2c/twl.h                            |   14 +-
 4 files changed, 366 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulat=
or.txt

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXQ4gAAoJEBus8iNuMP3dCZ8P/3p0AFZYkGlsBTu7zVYepYQD
Tx4jqFTCCxC0yKOGjHqsedWDhZtScP/Dga5XwpKxJfmbjRXeF+IFC2fBz6ZC8Rxl
w1DM0MhoLbkml7wyb1lNyo9kKdosU/E9ichkzQaV5IyqRSGDciz94S+maCkrd4Ab
AxVwmeXeHwbmqtNmRNise/qIxWjtkiDYKw6yz5EYnJ0z4xaU9IHp0qtMpGnWQI9r
ZYmer4pxCUr0SgGwYwhgo+FoDcqnyaeP/cN3EJojAcmAs8UausSAmkGKMpbcIYKh
5mxdngxOKrhtn1QWFnkDfF7MP7HHADmTPQyH7FL1HIu0QYYFCJnJCA7thPg37bqy
9/HOpDYCIQMCfhZYQ7YeirxG8ZQaxbIGuqR8ulS5IbLJQNg0DDXCe3DFnBgAZaxM
WO0D5G97EA2tdzKtRsTKJ8Xkr8XhVLFwOq1Trrbqotriu1IcxMD2ZJiBOBVqN7WK
H8uAta5pbLTsOQt3Mh/zhiZz4FmR26y72Vbbk9MQz1jbjDNzOZcszhNFb8rmBYGs
6CFqX5IctEBJAymSYFpydWoQ2iWyj7imt9ad2WSpgV77pGW23atyjL82AfVI/yWx
AGlUJ8SHb4AnJMPRw45vFTQ5/M1lX1da/Bz/2dYnhrU335Wg5nuOGKxBRxBigThR
ckvCamfkpL9tDLDGsb4s
=vXaq
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
