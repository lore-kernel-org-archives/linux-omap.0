From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/6] OMAPDSS: HDMI PHY burnout fix
Date: Tue, 17 Jan 2012 14:48:56 +0200
Message-ID: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:38732 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752767Ab2AQMtU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 07:49:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com
Cc: archit@ti.com, x0132446@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The main patch in this set is the last one, which implements a fix for the HW
bug on OMAP4 which causes physical damage to the board if the HDMI cable is not
connected but HDMI output is enabled.

The preceding patches are small cleanups/fixes for HDMI GPIOs so that the fix
can be implemented.

Note that I haven't gotten a confirmation that using LDO_ON for the HDMI PHY
power fixes the issue. So whether the fix works or not is unclear.

 Tomi

Tomi Valkeinen (6):
  OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
  OMAP: 4430SDP/Panda: rename HPD GPIO to CT_CP_HPD
  OMAPDSS: remove wrong HDMI HPD muxing
  OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
  OMAP: 4430SDP/Panda: add HDMI HPD gpio
  OMAPDSS: HDMI: PHY burnout fix

 arch/arm/mach-omap2/board-4430sdp.c       |   18 ++++++--
 arch/arm/mach-omap2/board-omap4panda.c    |   18 ++++++--
 arch/arm/mach-omap2/display.c             |    4 --
 drivers/video/omap2/dss/hdmi.c            |    3 +
 drivers/video/omap2/dss/ti_hdmi.h         |    4 ++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   68 +++++++++++++++++++++++++++--
 include/video/omapdss.h                   |    5 ++
 7 files changed, 104 insertions(+), 16 deletions(-)

-- 
1.7.4.1

