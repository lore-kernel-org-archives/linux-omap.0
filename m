From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH v1 0/3] OMAP: DSS2: Fix for DISPC core functional clock divider
Date: Thu,  3 Mar 2011 15:25:27 +0530
Message-ID: <1299146130-8269-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43406 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931Ab1CCJzM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 04:55:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomba@iki.fi
Cc: linux-omap@vger.kernel.org

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

Base
----
url = git://gitorious.org/linux-omap-dss2/linux.git
branch "master"
commit 1e0f79f1066aba3cfcaa45a0298bb24ba7bf864d 

-----------------------------------------------------
Raghuveer Murthy (3):
  OMAP: DSS2: Adding dss_features for independent core clk divider
  OMAP: DSS2: Renaming register macro DISPC_DIVISOR(ch)
  OMAP4: DSS2: Using dss_features to set independent core clock divider

 drivers/video/omap2/dss/dispc.c        |   51 +++++++++++++++++++++++--------
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/dss_features.h |    2 +
 3 files changed, 41 insertions(+), 14 deletions(-)

