From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.1 merge window, part 2
Date: Mon, 11 Jul 2011 04:50:33 -0700
Message-ID: <20110711115033.GZ5783@atomide.com>
References: <20110711114736.GX5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:45159 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754388Ab1GKLug (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 07:50:36 -0400
Content-Disposition: inline
In-Reply-To: <20110711114736.GX5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

The following changes since commit e1d62c9bd8779a8e4a335803f0fced9e614d0a9f:
  Tony Lindgren (1):
        Merge branch 'prcm-cleanup-3.1' of git://git.pwsan.com/linux-2.6 into cleanup-part-3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git fixes-part-2

Andy Green (6):
      I2C: OMAP2+: Set hwmod flags to only allow 16-bit accesses to i2c
      I2C: OMAP2+: increase omap_i2c_dev_attr flags from u8 to u32
      I2C: OMAP2+:  Introduce I2C IP versioning constants
      I2C: OMAP1/OMAP2+: create omap I2C functionality flags for each cpu_... test
      I2C: OMAP2+: Tag all OMAP2+ hwmod defintions with I2C IP revision
      I2C: OMAP2+: add correct functionality flags to all omap2plus i2c dev_attr

Avinash.H.M (1):
      OMAP: hwmod: fix the i2c-reset timeout during bootup

Benoit Cousson (1):
      OMAP4: powerdomain data: Fix core mem states and missing cefuse flag

Paul Walmsley (2):
      Merge branches 'powerdomain_fixes_3.1', 'hardware_workarounds_3.1', 'hwmod_dss_fix_3.1' and 'i2c_fixes_3.1' into prcm-fixes-3.1
      ASoC: omap: McBSP: fix build breakage on OMAP1

Rajendra Nayak (1):
      OMAP2+: PM: Initialise sleep_switch to a non-valid value

Santosh Shilimkar (2):
      OMAP4: clock data: Keep GPMC clocks always enabled and hardware managed
      OMAP4: powerdomain data: Remove unsupported MPU powerdomain state

Tomi Valkeinen (2):
      OMAP4: hwmod data: Modify DSS opt clocks
      OMAP4: hwmod data: Change DSS main_clk scheme

Tony Lindgren (1):
      Merge branch 'prcm-fixes-3.1' of git://git.pwsan.com/linux-2.6 into fixes-part-2

 arch/arm/mach-omap2/clock44xx_data.c         |    9 ++-
 arch/arm/mach-omap2/i2c.c                    |   68 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |   27 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    9 +++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    7 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   18 +++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   81 ++++++++++++++++++++------
 arch/arm/mach-omap2/pm.c                     |    2 +-
 arch/arm/mach-omap2/powerdomains44xx_data.c  |    9 ++-
 arch/arm/plat-omap/include/plat/i2c.h        |    6 ++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 arch/arm/plat-omap/mcbsp.c                   |   27 +++++++++
 include/linux/i2c-omap.h                     |   27 +++++++++
 13 files changed, 260 insertions(+), 31 deletions(-)
