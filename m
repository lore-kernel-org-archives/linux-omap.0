From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V3 0/3] rtc: omap: Add support for regulator supply
Date: Fri, 24 Oct 2014 10:23:42 +0530
Message-ID: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35949 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092AbaJXE4B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2014 00:56:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, a.zummo@towertech.it, johan@kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, akpm@linux-foundation.org, linux@roeck-us.net, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, lokeshvutla@ti.com

This series adds support for regulator supply.

Changes since v2:
 - Rebased on top of Johan Hovold's recent rtc cleanup series[1]
 - Addressed Johan Hovold's comments.

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg748519.html

Lokesh Vutla (2):
  rtc: omap: use module_platform_driver
  rtc: omap: Support regulator supply for RTC

Tero Kristo (1):
  rtc: omap: Update Kconfig for OMAP RTC

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  3 +++
 drivers/rtc/Kconfig                                |  6 ++---
 drivers/rtc/rtc-omap.c                             | 30 +++++++++++++++++++---
 3 files changed, 33 insertions(+), 6 deletions(-)

-- 
1.9.1

