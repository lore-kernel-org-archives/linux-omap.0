From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Wed, 12 Mar 2014 12:26:35 +0200
Message-ID: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59106 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbaCLK11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 06:27:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This patch adds hwmod data for omap5 display subsystem. I have tested this on
omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet, as the
mainline is missing omap5 HDMI driver.

I do see this when booting:

  omap_hwmod: dss_dispc: cannot be enabled for reset (3)
  omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
  omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
  omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
  omap_hwmod: dss_rfbi: cannot be enabled for reset (3)

But at least DSI works just fine.

 Tomi

Archit Taneja (1):
  ARM: OMAP5: Add omap5 DSS related hwmod data

 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 283 +++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

-- 
1.8.3.2

