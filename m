From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 0/4] OMAP: DSS: porting old drivers to DSS2 (driver part)
Date: Mon, 12 Sep 2011 14:21:30 +0300
Message-ID: <1315826494-27993-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55142 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755147Ab1ILLVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:21:44 -0400
Received: by bkbzs2 with SMTP id zs2so1492406bkb.28
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:21:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch set cleans up some unused drivers under the old omapfb, and ports
the used OMAP2/3 drivers to DSS2. All OMAP2/3 panels are ported, except N800
panel driver which will be handled separately.

 Tomi

Tomi Valkeinen (4):
  OMAP: OMAPFB: Remove unused lcd drivers
  OMAP: 2420SDP: Port the display driver to new DSS2
  OMAP: H4: Port the display driver to new DSS2
  OMAP: Apollon: Port the display driver to new DSS2

 drivers/video/omap/Kconfig                       |   29 ---
 drivers/video/omap/Makefile                      |    8 -
 drivers/video/omap/lcd_2430sdp.c                 |  203 ----------------------
 drivers/video/omap/lcd_apollon.c                 |  136 ---------------
 drivers/video/omap/lcd_h4.c                      |  117 -------------
 drivers/video/omap/lcd_ldp.c                     |  201 ---------------------
 drivers/video/omap/lcd_omap3beagle.c             |  130 --------------
 drivers/video/omap/lcd_omap3evm.c                |  193 --------------------
 drivers/video/omap/lcd_overo.c                   |  180 -------------------
 drivers/video/omap2/displays/panel-generic-dpi.c |   64 +++++++
 10 files changed, 64 insertions(+), 1197 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_2430sdp.c
 delete mode 100644 drivers/video/omap/lcd_apollon.c
 delete mode 100644 drivers/video/omap/lcd_h4.c
 delete mode 100644 drivers/video/omap/lcd_ldp.c
 delete mode 100644 drivers/video/omap/lcd_omap3beagle.c
 delete mode 100644 drivers/video/omap/lcd_omap3evm.c
 delete mode 100644 drivers/video/omap/lcd_overo.c

-- 
1.7.4.1

