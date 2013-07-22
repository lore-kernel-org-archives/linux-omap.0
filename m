From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: PRCM: drop macros not currently in use
Date: Mon, 22 Jul 2013 04:56:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307220454470.4804@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42212 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab3GVE4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 00:56:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

Sorry for the delay on this - wanted to make sure it passed the local
testbed before sending it upstream.

The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.11-rc/omap-fixes-a

for you to fetch changes up to 11dab344053f726fe17ede95aa52c1eea1258a66:

  ARM: OMAP5: PRM/CM: Cleanup unused header (2013-07-21 22:10:25 -0600)

- ----------------------------------------------------------------
This series removes the currently-unused PRCM macros from
arch/arm/mach-omap2.

Basic test logs are available at:

http://www.pwsan.com/omap/testlogs/drop_unused_prcm_macros_v3.11-rc/20130721211401/

Once, years ago, we thought that it would be good to document the PRCM
register bits in the Linux codebase.  Most folks in the broader
community did not have access to the same documentation, so we thought
that they might be able to use these bits to fix bugs and improve the
code.

We were also able to autogenerate most of these macros, so it was
thought that defining them in advance would reduce the risk of error,
inconsistencies, and merge conflicts caused when patch sets
incrementally defined them by hand.

Well, nice thoughts.  But the first rationale was rendered partially
obsolete when TI started to release public TRM documentation PDFs at
some point in the OMAP3 timeframe.  (Despite their weaknesses, TI's
public OMAP TRMs remain the most useful public documentation available
for any ARM Linux SoC -- at least to the extent of my knowledge.)  And
then the current Linux development tropism towards
development-by-negative-diffstat obliterated the remainder of the
above two philosophies.

So, for the few, the masochistic, out there who wish to continue
developing TI PRCM code, I would ask that you resurrect any
additionally-needed macros from these commits, rather than writing
them manually.  Purely for the sake of a pleasant atavism, perhaps; the
way one appreciates a used bookstore, or a video rental store...

And thanks to the upstream maintainers for being patient while we
adjust.

- ----------------------------------------------------------------
Rajendra Nayak (4):
      ARM: OMAP2: PRM/CM: Cleanup unused header
      ARM: OMAP3: PRM/CM: Cleanup unused header
      ARM: OMAP4: PRM/CM: Cleanup unused header
      ARM: OMAP5: PRM/CM: Cleanup unused header

 arch/arm/mach-omap2/cm-regbits-24xx.h       |  318 ----
 arch/arm/mach-omap2/cm-regbits-33xx.h       |  749 --------
 arch/arm/mach-omap2/cm-regbits-34xx.h       |  632 -------
 arch/arm/mach-omap2/cm-regbits-44xx.h       | 1558 ---------------
 arch/arm/mach-omap2/cm-regbits-54xx.h       | 1633 ----------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c  |    1 -
 arch/arm/mach-omap2/powerdomains54xx_data.c |    1 -
 arch/arm/mach-omap2/prm-regbits-24xx.h      |  247 ---
 arch/arm/mach-omap2/prm-regbits-33xx.h      |  306 ---
 arch/arm/mach-omap2/prm-regbits-34xx.h      |  481 -----
 arch/arm/mach-omap2/prm-regbits-44xx.h      | 2226 ----------------------
 arch/arm/mach-omap2/prm-regbits-54xx.h      | 2701 ---------------------------
 12 files changed, 10853 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/prm-regbits-54xx.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR7Lr/AAoJEMePsQ0LvSpLPCwP/1DiY3jzuSubA9N51NwmnROw
1LZS9ZMcaQ6Mr24pC03wDyQ81vSl+voY54VMyu4zvbt+qJyHkVabpXn3pGyEyzub
fap7VyC/Szfx0GtuuAAhXYAPn6qwuKJ122jbgtEe5x4eEOpvY/X+ArYcwgxp3uG0
CmkJb1O5FSyY+AW3isPQPrrKUIdy98s12v0q1xdN0eTRua31D7I1TPutAD4LbWQ4
oUbFqG4hybFLlXLZvJF4BrPVMFld5gPVDFvdp2jdtH5Kcyp2bRXXv5xmKHhMsxWa
iQnEP8SyLyXI1nlBfFXJ0x2k5G0U0/GPAg+CaO/zhjS/GKB1ALysflVoN+z9oEh6
EmOC9uxwnloWHbTyAsbm0rkkrOJeC07vghTYzQZX8y3k89LBg3L4JEBOkZ2T6Pbj
VR6926W+SbQee6s13t3uyYbYievXtLmj5nYRbsZc4IwtXoHvuKxvMUVFALsABiXx
4osgemCNEgnuff1xYBv0LEniHAZwphfSuXw+GFYb2hXbRNjOLMzElZkCmddfpSXy
wO0nPKMAuT3vbHZ9d1ly4x3BFXFFaOJa1R88/RfRhFnmz0Yut3p2AvG0We7a+5zT
us7S8EtZtePqTkBvlF4HpMXKtcN1ZkrM/Nj+OfV3LObyIVNLjuzt3pOZgwEaL8/I
/F87lgCvP2OvTuy3eABF
=NoFh
-----END PGP SIGNATURE-----
