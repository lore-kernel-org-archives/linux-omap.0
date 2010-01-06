From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] OMAP clock/OPP/SDRC fixes for 2.6.33-rc
Date: Wed, 06 Jan 2010 13:44:15 -0700
Message-ID: <20100106204346.15002.89343.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42615 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab0AFUpy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 15:45:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series contains OMAP clock/OPP/SDRC fixes for 2.6.33-rc.  It
applies against the last set of fixes sent to Tony, which in turn
applies against 2.6.33-rc3.

The most important patch here is Cory's OMAP1 clock fix; the
others are relatively minor.


- Paul

---

Cory Maccarrone (1):
      OMAP1 clock: remove __initdata from struct clk_functions to prevent crash

Felipe Balbi (1):
      OMAP2xxx clock: clk2xxx.c doesn't compile if CPUFREQ is enabled

Paul Walmsley (3):
      OMAP2xxx OPP: clean up comments in OPP data
      OMAP2 clock: dynamically allocate CPUFreq frequency table
      OMAP clock/CPUFreq: avoid leaking the CPUFreq frequency table


 arch/arm/mach-omap1/clock_data.c        |    2 +
 arch/arm/mach-omap2/clock2xxx.c         |   57 ++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/opp2420_data.c      |   38 +++++++++++----------
 arch/arm/mach-omap2/opp2430_data.c      |   30 ++++++++--------
 arch/arm/plat-omap/clock.c              |   10 +++++
 arch/arm/plat-omap/cpu-omap.c           |    1 +
 arch/arm/plat-omap/include/plat/clock.h |    2 +
 7 files changed, 97 insertions(+), 43 deletions(-)

