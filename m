From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH 0/4] OMAP: DSS2: Fix for DISPC core functional clock divider
Date: Thu,  3 Feb 2011 19:39:17 +0530
Message-ID: <1296742161-9395-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34558 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932156Ab1BCOOq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 09:14:46 -0500
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

6.
OMAP4: DSS2: Adding fclk support for DPI interface
https://patchwork.kernel.org/patch/529381/
---------------------------------------------------------

Raghuveer Murthy (4):
  OMAP: DSS2: Adding dss_features for independent core clk divider
  OMAP: DSS2: Renaming register macro DISPC_DIVISOR(ch)
  OMAP: DSS2: Adding macro for DISPC_DIVISOR register
  OMAP4: DSS2: Using dss_features to set independent core clock divider

 drivers/video/omap2/dss/dispc.c        |   57 ++++++++++++++++++++++++-------
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/dss_features.h |    2 +
 3 files changed, 47 insertions(+), 14 deletions(-)

