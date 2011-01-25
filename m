From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/5] Clockdomain split series
Date: Tue, 25 Jan 2011 17:21:43 +0530
Message-ID: <1295956308-23860-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54330 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab1AYLwC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 06:52:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

This patch series is an effort to split the clockdomain
framework into platform independent and platform specific parts
as was done for the powerdomain framework.

This certainlly helps remove the various cpu_is_* checks
which exist today in the framework and makes
the code more maintainable and readable.

The series is boot tested on OMAP2430/3430/4430SDP platforms.
Also on OMAP3430SDP, OFF mode in suspend path is validated
using the omap3_pm_defconfig.

This series is based on mainline 2.6.38-rc2 and
can be found here
git://gitorious.org/omap-pm/linux.git clockdomain-split-v2-rc2

Version History
---------------
v2
-1- removed wrongly populated sleepdep support for OMAP2
-2- Fixed error handling in apis

For a wider review, posting this series with
linux-arm-kernel list copied.
This version has no functional diff with the
earlier one posted here
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42570.html

Rajendra Nayak (5):
  OMAP: clockdomain: Infrastructure to put arch specific code
  OMAP: clockdomain: Arch specific funcs to handle deps
  OMAP: clockdomain: Arch specific funcs for sleep/wakeup of clkdm
  OMAP: clockdomain: Arch specific funcs for hwsup control of clkdm
  OMAP: clockdomain: Arch specific funcs for clkdm_clk_enable/disable

 arch/arm/mach-omap2/Makefile                     |    3 +
 arch/arm/mach-omap2/clock.c                      |    6 +-
 arch/arm/mach-omap2/clockdomain.c                |  410 +++++++---------------
 arch/arm/mach-omap2/clockdomain.h                |   58 +++-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |  270 ++++++++++++++
 arch/arm/mach-omap2/clockdomain44xx.c            |   77 ++++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    9 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c                |    4 +-
 arch/arm/mach-omap2/io.c                         |    6 +-
 arch/arm/mach-omap2/pm.c                         |    6 +-
 arch/arm/mach-omap2/pm24xx.c                     |    8 +-
 arch/arm/mach-omap2/pm34xx.c                     |    6 +-
 13 files changed, 557 insertions(+), 308 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/clockdomain44xx.c

