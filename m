From: Paul Walmsley <paul@booyaka.com>
Subject: [GIT PULL] OMAP clock/OPP fixes for 2.6.33-rc
Date: Thu, 7 Jan 2010 15:04:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001071503310.6759@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46136 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab0AGWEf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 17:04:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org


Hi Tony,

The following changes since commit 6201a1542003f3e617e53003a780aab835c0f9d5:
  Cory Maccarrone (1):
        OMAP1 clock: Add missing clocks for OMAP 7xx

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 for_2.6.33rc_b

Cory Maccarrone (1):
      OMAP1 clock: remove __initdata from struct clk_functions to prevent crash

Felipe Balbi (1):
      OMAP2xxx clock: clk2xxx.c doesn't compile if CPUFREQ is enabled

Paul Walmsley (3):
      OMAP2xxx OPP: clean up comments in OPP data
      OMAP clock/CPUFreq: add clk_exit_cpufreq_table()
      OMAP2 clock: dynamically allocate CPUFreq frequency table

 arch/arm/mach-omap1/clock_data.c        |    2 +-
 arch/arm/mach-omap2/clock2xxx.c         |   57 ++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/opp2420_data.c      |   38 +++++++++++----------
 arch/arm/mach-omap2/opp2430_data.c      |   30 ++++++++--------
 arch/arm/plat-omap/clock.c              |   10 +++++
 arch/arm/plat-omap/cpu-omap.c           |    1 +
 arch/arm/plat-omap/include/plat/clock.h |    2 +
 7 files changed, 97 insertions(+), 43 deletions(-)


- Paul
