From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH v3 0/3] OMAP: DSS2: Fix for DISPC core functional clock divider
Date: Thu,  3 Mar 2011 20:57:57 +0530
Message-ID: <1299166080-15380-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48817 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758261Ab1CCP1k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 10:27:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

OMAP4 has 2 LCD channels and corresponding DISPC_DIVISOR1 and DISPC_DIVISOR2
registers to configure the pixel clock frequency, for the respective LCD
displays.

There is also DISPC_DIVISOR register, which by default has the ENABLE bit
set to zero, for backward compatibility mode. Hence the logical clock divider of
DISPC_DIVISOR1.LCD, gets used for core func clk configuration. The default value
of DISPC_DIVISOR1.LCD is 4.

If only the secondary LCD is enabled, at high pixel resolutions the core clk 
lags behind the pixel clock, causing stair-step effect (diagonal lines with
tearing) on the display.

Hence DISPC_DIVISOR.ENABLE is set to 1, and the core functional clock is set 
independently and exclusively in DISPC_DIVISOR.LCD.

- Added the above as dss_features

-----------------------------------------------------
History
-------
Changes from previous version (v1)
- Fixed comments from Tomi Valkeinen <tomi.valkeinen@ti.com>

Changes from previous version (v2)
- Rebased against the DSS2 master to avoid conflicts 

Base
----
url = git://gitorious.org/linux-omap-dss2/linux.git
branch "master"
commit a2792bb44d45ef97963e67565ad1e1dd5bf0cbd7

-----------------------------------------------------
Raghuveer Murthy (3):
  OMAP: DSS2: Adding dss_features for independent core clk divider
  OMAP: DSS2: Renaming register macro DISPC_DIVISOR(ch)
  OMAP4: DSS2: Using dss_features to set independent core clock divider

 drivers/video/omap2/dss/dispc.c        |   51 +++++++++++++++++++++++--------
 drivers/video/omap2/dss/dss_features.c |    3 +-
 drivers/video/omap2/dss/dss_features.h |    2 +
 3 files changed, 42 insertions(+), 14 deletions(-)

