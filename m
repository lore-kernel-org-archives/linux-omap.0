From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v3 0/4] OMAP2PLUS: DSS: Generalize clock names
Date: Mon, 31 Jan 2011 21:57:42 +0530
Message-ID: <1296491266-6949-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48936 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab1AaQ2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 11:28:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: Sumit Semwal <sumit.semwal@ti.com>

This patch series changes dss clock names to generic role names for all DSS
clocks across clk APIs, hwmod data, dss driver. 

It also changes the enums used within DSS framework to refer to the clocks
to make them generic and related to functionality than value.
eg.	DSS_CLK_TVFCK replaces DSS_CLK_54M,
	dss_tv_fck replaces dss_54m_fck

This serves as the base for common hwmod DSS opt-clock roles across all OMAP
platforms, and increases extendability.

In addition, since ick doesn't exist on OMAP4, the last patch adds a dummy clk
for the same in clock44xx_data.c.

===
Note: This is interim change set to enable DSS on OMAP2/3/4 platforms; there is an
ongoing design discussion for de-centralizing the DSS clock framework handling
in favour of using pm_runtime APIs directly in each DSS IP.

Once a consensus is reached on that, much of this code will become cleaner, as
each DSS IP block handles its own clocks using the common clocks framework.

Patch Base:
===========
Patch-set rebased and tested w/ Zoom3 (OMAP3630) on top of:
url = git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
branch "master"
commit	e8883f8057c0f7c9950fa9f20568f37bfa62f34a
Description: Add linux-next specific files for 20110115
+
Patch mentioned in http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42384.html
[PATCH] OMAP: counter_32k: init clocksource as part of machine timer init
(This patch is required for OMAP bootup w/ 20110115 linux-next)
+
DSS hwmod patch series: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42914.html
+
hwmod opt-clock change: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43264.html

Change log:
===========
changes since v2:
-----------------
Per comments from Rajendra, removed 'work-around' code for adding opt-clocks
in the clock framework in <NULL,clk-name> format; now the opt-clocks are same
as <dev,clk-role>.
[http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43205.html].

Hwmod patch mentioned above is required for the same.

changes since v1:
-----------------
added dummy clk patch for OMAP4.

--------------------------------------------------------------------------- 

Archit Taneja (2):
  OMAP2PLUS: DSS2: Generalize naming of PRCM related clock enums in DSS
    driver
  OMAP2PLUS: DSS2: Generalize external clock names in struct dss of
    dss.c

Sumit Semwal (2):
  OMAP2PLUS: clocks: Align DSS clock names and roles
  OMAP4: DSS2: clocks: Add ick as dummy clock

 arch/arm/mach-omap2/clock2420_data.c       |    6 +-
 arch/arm/mach-omap2/clock2430_data.c       |    6 +-
 arch/arm/mach-omap2/clock3xxx_data.c       |   10 +-
 arch/arm/mach-omap2/clock44xx_data.c       |   15 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 drivers/video/omap2/dss/core.c             |    4 +-
 drivers/video/omap2/dss/dispc.c            |   10 +-
 drivers/video/omap2/dss/dpi.c              |   16 ++--
 drivers/video/omap2/dss/dsi.c              |   18 ++--
 drivers/video/omap2/dss/dss.c              |  144 ++++++++++++++--------------
 drivers/video/omap2/dss/dss.h              |   10 +-
 drivers/video/omap2/dss/manager.c          |    4 +-
 drivers/video/omap2/dss/overlay.c          |    4 +-
 drivers/video/omap2/dss/rfbi.c             |   10 +-
 drivers/video/omap2/dss/sdi.c              |    8 +-
 drivers/video/omap2/dss/venc.c             |    8 +-
 16 files changed, 140 insertions(+), 135 deletions(-)

