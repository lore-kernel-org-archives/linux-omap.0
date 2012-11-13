From: Jon Hunter <jon-hunter@ti.com>
Subject: [GIT PULL] ARM: OMAP: DMTIMER fixes
Date: Tue, 13 Nov 2012 11:16:54 -0600
Message-ID: <50A28086.6050500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55427 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab2KMRRC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 12:17:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

The following changes since commit d308ba50a1234b299a00e63a95e61fdeb2f1a2df:

  Merge branch 'omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3' into omap-for-v3.8/dt (2012-11-09 14:58:34 -0800)

are available in the git repository at:


  git@github.com:jonhunter/linux.git fixes-timer

for you to fetch changes up to b1538832191d59e29b1077e64cf416a7617b45bc:

  ARM: OMAP: Remove __omap_dm_timer_set_source function (2012-11-12 16:23:57 -0600)

----------------------------------------------------------------
Several fixes for the OMAP DMTIMER driver including ...
1. Adding workaround for OMAP3+ errata i103/i767
2. Fixing posted mode support
3. Spurious interrupts when using match interrupt
4. HWMOD fixes for timers
5. Unnecessary restoration of read-only registers
6. Adds function for disabling timer interrupts
7. Fixing timer1 reset for OMAP1

----------------------------------------------------------------
Jon Hunter (13):
      ARM: OMAP: Add DMTIMER definitions for posted mode
      ARM: OMAP3+: Implement timer workaround for errata i103 and i767
      ARM: OMAP: Fix timer posted mode support
      ARM: OMAP3: Correct HWMOD DMTIMER SYSC register declarations
      ARM: OMAP2/3: Define HWMOD software reset status for DMTIMERs
      ARM: OMAP2+: Don't use __omap_dm_timer_reset()
      ARM: OMAP: Fix dmtimer reset for timer1
      ARM: OMAP: Don't restore of DMTIMER TISTAT register
      ARM: OMAP: Don't restore DMTIMER interrupt status register
      ARM: OMAP: Fix spurious interrupts when using timer match feature
      ARM: OMAP: Add dmtimer interrupt disable function
      ARM: OMAP: Remove unnecessary call to clk_get()
      ARM: OMAP: Remove __omap_dm_timer_set_source function

 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   15 +++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   41 +++++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    4 +
 arch/arm/mach-omap2/timer.c                        |   70 +++++++++++++-----
 arch/arm/plat-omap/dmtimer.c                       |   77 ++++++++++++--------
 arch/arm/plat-omap/include/plat/dmtimer.h          |   72 +++++++++++++-----
 6 files changed, 188 insertions(+), 91 deletions(-)
