From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] OMAP gptimer capability changes
Date: Wed, 17 Apr 2013 18:23:01 -0500
Message-ID: <1366240981-53504-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41123 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779Ab3DQX15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Apr 2013 19:27:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, Suman Anna <s-anna@ti.com>

Hi,

This series includes patches for fixing/enhancing the timer capabilities
on OMAP4+ devices. The patches are created on top of Tony's DT branch for
3.10 [1], but they apply just fine on 3.9-rc7 as well. The patches are
independent of each other functionality-wise.

[1] http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.10/dt

Suman Anna (2):
  ARM: dts: OMAP5: add PWM capability to timer nodes missing it
  ARM: OMAP4+: Add a timer attribute for timers that can interrupt IPU

 Documentation/devicetree/bindings/arm/omap/timer.txt |  3 +++
 arch/arm/boot/dts/omap4.dtsi                         |  4 ++++
 arch/arm/boot/dts/omap5.dtsi                         |  7 +++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c           | 16 ++++++++++++++--
 arch/arm/plat-omap/dmtimer.c                         |  2 ++
 arch/arm/plat-omap/include/plat/dmtimer.h            |  1 +
 6 files changed, 31 insertions(+), 2 deletions(-)

-- 
1.8.2

