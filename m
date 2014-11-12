From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap gpmc changes for v3.19
Date: Wed, 12 Nov 2014 10:05:12 -0800
Message-ID: <15985.8783511028$1415815612@news.gmane.org>
References: <pull-1415814409-868361>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56634 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751685AbaKLSGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 13:06:43 -0500
In-Reply-To: <pull-1415814409-868361>
In-Reply-To: <pull-1415814409-868361>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 24f284af1a64a1a073b064428cafb447aff19a21:

  ARM: dts: Fix missing GPMC NAND device width for omap3 boards (2014-11-03 17:42:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/gpmc-timings

for you to fetch changes up to 6f8782a7a1c826e1c013d6b7d5504af6bcc079e6:

  ARM: OMAP2+: Remove unnecesary include in GPMC driver (2014-11-06 10:51:06 -0800)

----------------------------------------------------------------
GPMC (General Purpose Memory Controller) changes for omaps. These
changes allow us to drop dependencies to bootloader timings now
that the known device tree entries have been fixed. So we can now
require proper timings to be configured and get rid of the legacy
smsc91x code.

Note that this branch has a dependency to the related device tree
branch sent in a separate pull request as timings are now required.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: OMAP2+: Remove unnecesary include in GPMC driver

Roger Quadros (5):
      ARM: OMAP2+: gpmc: Print error message in set_gpmc_timing_reg()
      ARM: OMAP2+: gpmc: Error out if timings fail in gpmc_probe_generic_child()
      ARM: OMAP2+: gpmc: Always enable A26-A11 for non NAND devices
      ARM: OMAP2+: gpmc: Keep Chip Select disabled while configuring it
      ARM: OMAP2+: gpmc: Sanity check GPMC fck on probe

Tony Lindgren (5):
      ARM: OMAP2+: Fix support for multiple devices on a GPMC chip select
      ARM: OMAP2+: Show bootloader GPMC timings to allow configuring the .dts file
      ARM: OMAP2+: Require proper GPMC timings for devices
      ARM: OMAP2+: Drop legacy code for gpmc-smc91x.c
      Merge branch 'for-v3.19/gpmc-omap' of github.com:rogerq/linux into omap-for-v3.19/gpmc

 arch/arm/mach-omap2/Makefile                 |   3 -
 arch/arm/mach-omap2/board-3430sdp.c          |  28 ---
 arch/arm/mach-omap2/board-rx51-peripherals.c |  29 ---
 arch/arm/mach-omap2/gpmc-smc91x.c            | 186 -----------------
 arch/arm/mach-omap2/gpmc-smc91x.h            |  42 ----
 arch/arm/mach-omap2/gpmc.c                   | 295 +++++++++++++++++++++------
 6 files changed, 237 insertions(+), 346 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.h
