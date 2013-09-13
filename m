From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/7] omapdss: HDMI: Fix register definitions and reg dump functions
Date: Fri, 13 Sep 2013 15:59:31 +0530
Message-ID: <1379068178-17312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57016 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533Ab3IMKab (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Sep 2013 06:30:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

These patches complete the OMAP4 HDMI register definitions for HDMI submodules
and make sure all the corresponding regdump functions dump all the registers.

Ricardo Neri (7):
  OMAPDSS: HDMI: OMAP4: Complete register definitions for wrapper
  OMAPDSS: HDMI: OMAP4: Complete dumping of wrapper registers
  OMAPDSS: HDMI: OMAP4: Complete register definitions for DPLL
  OMAPDSS: HDMI: OMAP4: Complete dumping of DPLL registers
  OMAPDSS: HDMI: OMAP4: Rename the HDMI_CORE_CTRL1 register
  OMAPDSS: HDMI: OMAP4: Complete register definitions for core
  OMAPDSS: HDMI: OMAP4: Complete dumping of core registers

 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | 70 ++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | 65 ++++++++++++++++++++++++----
 2 files changed, 118 insertions(+), 17 deletions(-)

-- 
1.8.1.2

