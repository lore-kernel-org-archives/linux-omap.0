From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH 0/4] OMAP4: DSS2: Adding fclk support for DPI interface
Date: Thu,  3 Feb 2011 19:26:55 +0530
Message-ID: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36321 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756419Ab1BCOC0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 09:02:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomba@iki.fi
Cc: linux-omap@vger.kernel.org

- Adding dss_feature for DPLL fclk
- Enabling pixel clock generation for DPI interface

-----------------------------------------------------
Base
----
url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
branch "master"
commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5
tag 2.6.38-rc2

Applies over:
-------------
1.
Patch mentioned in http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42384.html
[PATCH] OMAP: counter_32k: init clocksource as part of machine timer init
(This patch is required for OMAP bootup)

2.
v10 of OMAP2,3 DSS2 HWMOD
https://patchwork.kernel.org/patch/500191/

3.
v3 of DSS2: Generalize clock names
https://patchwork.kernel.org/patch/520191/

4.
v3 of DSS2: OMAP4 DSS HWMOD :
https://patchwork.kernel.org/patch/511211/

5.
OMAP: DSS2: Common IRQ handler for all OMAPs
https://patchwork.kernel.org/patch/526241/
---------------------------------------------------------

Raghuveer Murthy (4):
  OMAP: DSS2: Add dss_feature for variable DPLL fclk
  OMAP: DSS: Renaming the dpll clk pointer in struct dss
  OMAP: DSS2: Using dss_features to clean cpu checks for clocks
  OMAP: DSS2: Get OMAP4 DPLL fclk for DPI interface

 drivers/video/omap2/dss/dss.c          |   85 +++++++++++++++++--------------
 drivers/video/omap2/dss/dss_features.c |    9 ++-
 drivers/video/omap2/dss/dss_features.h |    3 +
 3 files changed, 56 insertions(+), 41 deletions(-)

