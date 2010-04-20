From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] OMAP2+ PRCM: standardize PRCM macros
Date: Tue, 20 Apr 2010 01:45:44 -0600
Message-ID: <20100420074204.3015.56304.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35968 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab0DTHsf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 03:48:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

Hello,

This series standardizes the OMAP2+ PRCM register macro names to end
in _SHIFT for bitshift counts and _MASK for bitmasks.  This is already the
case for many of the macros, but others were unconverted; this series finally
fixes those and their users in mainline.

These patches will cause Kevin some merge pain, which is regrettable,
but there seems to be no good time to do this sort of thing.

This series should not result in any functional change.

Note that at this point, this series has been compile-tested only, not
boot-tested - that will happen shortly.  It's been compile-tested with
n8x0_defconfig, omap3_beagle_defconfig, and omap_4430sdp_defconfig.


- Paul


---

Paul Walmsley (4):
      OMAP2 PRCM: convert OMAP2 PRCM macros to the _SHIFT/_MASK suffixes
      OMAP3 PRCM: convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes
      OMAP2+ PRCM: convert remaining PRCM macros to the _SHIFT/_MASK suffixes
      OMAP3: PM: PM_MPUGRPSEL writes should use GRPSEL macros, not EN macros


 arch/arm/mach-omap2/clkt2xxx_apll.c    |    4 
 arch/arm/mach-omap2/clock2420_data.c   |    4 
 arch/arm/mach-omap2/clockdomain.c      |    4 
 arch/arm/mach-omap2/cm-regbits-24xx.h  |  236 ++++++++++-----------
 arch/arm/mach-omap2/cm-regbits-34xx.h  |  222 ++++++++++----------
 arch/arm/mach-omap2/cm.h               |    5 
 arch/arm/mach-omap2/control.c          |    7 -
 arch/arm/mach-omap2/pm24xx.c           |  126 ++++++-----
 arch/arm/mach-omap2/pm34xx.c           |  202 +++++++++---------
 arch/arm/mach-omap2/powerdomain.c      |   26 +-
 arch/arm/mach-omap2/prcm-common.h      |  146 ++++++-------
 arch/arm/mach-omap2/prcm.c             |    4 
 arch/arm/mach-omap2/prm-regbits-24xx.h |  120 +++++------
 arch/arm/mach-omap2/prm-regbits-34xx.h |  360 ++++++++++++++++----------------
 arch/arm/mach-omap2/prm.h              |   18 +-
 15 files changed, 749 insertions(+), 735 deletions(-)

