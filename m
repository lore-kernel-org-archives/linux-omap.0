From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/7] OMAPDSS: func clock handling improvements
Date: Mon, 18 Nov 2013 14:38:57 +0200
Message-ID: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52170 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3KRMjQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 07:39:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some of the new TI SoCs using DSS have a dedicated PLL for the DSS functional
clock. This series adds support to omapdss for that kind of clocking scheme.

This series also needs the following commits, which are now in mainline, to
work:

ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers
ARM: OMAP3: use CLK_SET_RATE_PARENT for dss clocks
ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk

 Tomi

Tomi Valkeinen (7):
  OMAPDSS: fix omap2 dss fck handling
  OMAPDSS: remove struct dss_clock_info
  OMAPDSS: simplify dss clk dump
  OMAPDSS: rename parent clk variables
  OMAPDSS: cleanup fck parent handling
  OMAPDSS: pass pck to dss fck clock calc
  OMAPDSS: add dedicated fck PLL support

 drivers/video/omap2/dss/dpi.c |  15 ++--
 drivers/video/omap2/dss/dss.c | 163 ++++++++++++++----------------------------
 drivers/video/omap2/dss/dss.h |  17 ++---
 drivers/video/omap2/dss/sdi.c |  21 +++---
 4 files changed, 76 insertions(+), 140 deletions(-)

-- 
1.8.3.2

