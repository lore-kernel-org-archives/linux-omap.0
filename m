From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: clock cleanup for 3.17
Date: Thu, 17 Jul 2014 18:18:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407171817440.22427@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33910 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaGQSSf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2014 14:18:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17/omap-clock-a

for you to fetch changes up to acd052bb8119dd9117e0af48ff0ac6e56e61b6b4:

  ARM: OMAP2+: clock/interface: remove some headers from clkt_iclk.c file (2014-07-15 14:09:24 -0600)

- ----------------------------------------------------------------
An OMAP clock cleanup series for 3.17 from Tero Kristo.
This is in preparation for moving this code into drivers/clk/ti.

Basic build, boot, and PM test logs are here:

http://www.pwsan.com/omap/testlogs/clock-a-v3.17/20140717034329/

- ----------------------------------------------------------------
Tero Kristo (12):
      ARM: OMAP4+: clock: remove DEFINE_CLK_OMAP_HSDIVIDER macro
      ARM: OMAP4+: dpll: remove cpu_is_omap44xx checks
      ARM: OMAP4+: dpll44xx: remove cm-regbits-44xx.h and clock44xx.h includes
      ARM: OMAP2+: clock: introduce ti_clk_features flags
      ARM: OMAP2+: clock: add fint values to the ti_clk_features struct
      ARM: OMAP2+: clock/dpll: add private API for checking if DPLL is in bypass
      ARM: OMAP2+: clock/dpll: convert bypass check to use clk_features
      ARM: OMAP2+: clock/dpll: add jitter correction behind clk_features
      ARM: OMAP2+: clock/interface: add a clk_features definition for idlest value
      ARM: OMAP2+: clock/dpll: remove unused header includes from clkt_dpll.c
      ARM: OMAP2+: clock/dpll: remove unused header includes from dpll3xxx.c
      ARM: OMAP2+: clock/interface: remove some headers from clkt_iclk.c file

 arch/arm/mach-omap2/clkt_dpll.c | 98 +++++++++++++++++++----------------------
 arch/arm/mach-omap2/clkt_iclk.c |  8 ++--
 arch/arm/mach-omap2/clock.c     | 76 +++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/clock.h     | 44 ++++++++----------
 arch/arm/mach-omap2/dpll3xxx.c  |  7 +--
 arch/arm/mach-omap2/dpll44xx.c  | 19 +++++---
 arch/arm/mach-omap2/io.c        |  2 +
 7 files changed, 154 insertions(+), 100 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyBMxAAoJEMePsQ0LvSpLiIAQAJl7wHt44ZVVOwdeabNQppl3
PjqUjgQaT60Kpz4utPg0lOd6pJzzmLQ2cHtbV39U4ZCyMnTFi7wArmOR5htir0gh
zBDSBEXNJh4ZFyBBNTdlxhJcVjRnO+ar3HuuqdtQLEP19795IxY8Rk9X3ric+35W
1oeFj9EcCs9Reet4l8FnY5GKcLJvL5KiKD8BIsBa8U1AlHu3Cw8RtfpdQX6zdNMO
1THNKFsIt5PdTmbTuWA9c161DciNeN0QuXQVdqWYzepyOP1rS3zwKyZDEC3mE5Bl
TEOuANaJy2IqLJVTSal0hounMPmOUOp/wXr06s2chZ/bGLKZ/riTZm746cSFUTuZ
d8sGMxVJ2X9D2MexBzlO/3blg6503WCT1slIZwhEoiqQoDiWG6E/29ZrP752rFWy
c/Sa5Ro10pL0wAmjaU4hNxIE7ekksJKXROiqcOiqNeI0egTRu5wn/dNArPAewj25
K6T5sVes9getq98LfgCFdI+9QVr75gGkP7tWjuLhMnp+DSSdVfWlp3XPdazDFPdO
qkN7LByiHPTQUsbM7yCUfnlRVPpZdPUDkTJ3VHmbw/VhzCs90kirMywtheXJMWwT
carzv/FzdkZAhy1gfnH+GR/JaTm2JizUvA3xEb+V43JvPvgIzxiNhCM4eTYi7ElE
svIdX6E2JPB4JeP3DTwo
=z9Eq
-----END PGP SIGNATURE-----
