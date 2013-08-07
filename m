From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] drop unused omap defines for v3.12 merge window
Date: Wed, 7 Aug 2013 04:08:12 -0700
Message-ID: <20130807110812.GK7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23486 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757303Ab3HGLIS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 07:08:18 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/cleanup-unused-defines

for you to fetch changes up to dc46c79043a85624c78993919615abf743565ff5:

  Merge tag 'for-v3.11-rc/omap-fixes-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.12/cleanup (2013-07-31 01:12:49 -0700)

----------------------------------------------------------------

Removal of unused omap defines via Paul Walmsley <paul@pwsan.com>:

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

----------------------------------------------------------------
Rajendra Nayak (4):
      ARM: OMAP2: PRM/CM: Cleanup unused header
      ARM: OMAP3: PRM/CM: Cleanup unused header
      ARM: OMAP4: PRM/CM: Cleanup unused header
      ARM: OMAP5: PRM/CM: Cleanup unused header

Tony Lindgren (1):
      Merge tag 'for-v3.11-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.12/cleanup

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
