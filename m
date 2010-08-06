From: HEMA HK <hemahk@ti.com>
Subject: [PATCH 0/8]usb: musb:USB driver changes to use hwmod+ omap-device apis
Date: Fri,  6 Aug 2010 21:24:12 +0530
Message-ID: <1281110052-28990-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48073 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab0HFPyY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 11:54:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Hema HK  <hemahk@ti.com>

Series of patches to port musb driver to use hwmod and runtime pm 
APIs for OMAP4 and OMAP3.These patches are tested on OMAP4430SDP and 
OMAP3630-ZOOM3 boards.

The patch 1 and 2 are are the prerequisites for the hwmod changes.
Patch 6 is the OMAP3 offmode support patch.

This patch series is generated on "origin/pm-wip/hwmods-omap4".

Offmode is tested with origin/pm on omap3630 zoom3 board.


Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
