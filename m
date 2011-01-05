From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH 0/3] OMAP2PLUS: DSS: Generalize clock names
Date: Wed,  5 Jan 2011 23:07:41 +0530
Message-ID: <1294249064-11491-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46124 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130Ab1AERiF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 12:38:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>

This patch series changes dss clock names to generic role names for all DSS
clocks across clk APIs, hwmod data, dss driver. 

It also changes the enums used within DSS framework to refer to the clocks
to make them generic and related to functionality than value.
eg.	DSS_CLK_TVFCK replaces DSS_CLK_54M,
	dss_tv_fck replaces dss_54m_fck

This serves as the base for common hwmod DSS opt-clock roles across all OMAP
platforms, and increases extendability.

===
Note: This is interim change set to enable DSS on OMAP2/3/4 platforms; there is an
ongoing design discussion for de-centralizing the DSS clock framework handling
in favour of using pm_runtime APIs directly in each DSS IP.

Once a consensus is reached on that, much of this code will become cleaner, as
each DSS IP block handles its own clocks using the common clocks framework.

Patch Base:
===========
url = git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
branch "master"
Commit id: fa3b4e23ec20cfc944db7cc2b30b0d82c20e4472
Description:  cbus: Fix retu_rtc_do_reset
+
hwmod patches under discussion: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41534.html

Archit Taneja (2):
  OMAP2PLUS: DSS2: Generalize naming of PRCM related clock enums in DSS
    driver
  OMAP2PLUS: DSS2: Generalize external clock names in struct dss of
    dss.c

Sumit Semwal (1):
  OMAP2PLUS: opt-clocks: align dss clock roles and names

 arch/arm/mach-omap2/clock2420_data.c       |   10 +-
 arch/arm/mach-omap2/clock2430_data.c       |   10 +-
 arch/arm/mach-omap2/clock3xxx_data.c       |   22 +++-
 arch/arm/mach-omap2/clock44xx_data.c       |    7 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 drivers/video/omap2/dss/core.c             |    4 +-
 drivers/video/omap2/dss/dispc.c            |   10 +-
 drivers/video/omap2/dss/dpi.c              |   16 ++--
 drivers/video/omap2/dss/dsi.c              |   18 ++--
 drivers/video/omap2/dss/dss.c              |  170 ++++++++++++++--------------
 drivers/video/omap2/dss/dss.h              |   10 +-
 drivers/video/omap2/dss/manager.c          |    4 +-
 drivers/video/omap2/dss/overlay.c          |    4 +-
 drivers/video/omap2/dss/rfbi.c             |   10 +-
 drivers/video/omap2/dss/sdi.c              |    8 +-
 drivers/video/omap2/dss/venc.c             |    8 +-
 16 files changed, 167 insertions(+), 146 deletions(-)

