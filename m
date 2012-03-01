From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/7] OMAPDSS: HDMI PHY burnout fix for 3.0 stable
Date: Thu,  1 Mar 2012 14:34:39 +0200
Message-ID: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:55171 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759069Ab2CAMe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 07:34:59 -0500
Received: by mail-lpp01m010-f49.google.com with SMTP id y4so1207904lag.22
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 04:34:58 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

This series is for 3.0 stable.

The main patch in this set is the "PHY burnout fix", which implements a fix for
a hardware bug in the OMAP4 HDMI PHY which may cause physical damage to the
board if the HDMI PHY is already enabled when the HDMI cable is plugged in. The
possible damage breaks HDMI output hardware, otherwise the board is unaffected.

The "use default dividers" patch fixes a problem with setting up the HDMI PLL
dividers on Pandaboard. Without the patch the HDMI output does not work at all
on Panda.

The preceding patches are small cleanups/fixes for HDMI GPIOs so that the fix
can be implemented.

 Tomi

Tomi Valkeinen (7):
  OMAP: DSS2: HDMI: use default dividers
  OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
  OMAP: 4430SDP/Panda: rename HPD GPIO to CT_CP_HPD
  OMAPDSS: remove wrong HDMI HPD muxing
  OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
  OMAP: 4430SDP/Panda: add HDMI HPD gpio
  OMAPDSS: HDMI: PHY burnout fix

 arch/arm/mach-omap2/board-4430sdp.c    |   31 +++++------
 arch/arm/mach-omap2/board-omap4panda.c |   22 +++++---
 drivers/video/omap2/dss/hdmi.c         |   86 +++++++++++++++++++++++++++++--
 include/video/omapdss.h                |    5 ++
 4 files changed, 113 insertions(+), 31 deletions(-)

-- 
1.7.4.1

