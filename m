From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 0/6] N900 DTS additions for 3.14
Date: Sat, 11 Jan 2014 22:16:57 +0100
Message-ID: <1389475023-11616-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:50990 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbaAKVRd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jan 2014 16:17:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Hi Benoit,

Here are a couple of additions for the Nokia N900 Device Tree Source file. All
related drivers changes are queued for 3.14 (except for the tpa6130a2, which
got merged into 3.13).

I may have some more additions if the driver changes for the accelerometer, the
touchscreen or the wireless lan chip will be queued up.

-- Sebastian

Sebastian Reichel (6):
  DTS: ARM: TWL4030: Add keypad node
  DTS: ARM: OMAP3-N900: Add TWL4030 Keypad Matrix
  DTS: ARM: OMAP3-N900: Add support for tsl2563
  DTS: ARM: OMAP3-N900: Add tpa6130a2 support
  DTS: ARM: OMAP3-N900: Add isp1704 support
  DTS: ARM: OMAP3-N900: Add bq24150a support

 arch/arm/boot/dts/omap3-n900.dts | 90 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi   |  7 ++++
 2 files changed, 97 insertions(+)

-- 
1.8.5.2

