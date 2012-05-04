From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/3] ARM: OMAP4: add support for TPS62361 PMIC
Date: Fri, 4 May 2012 16:57:19 +0300
Message-ID: <1336139842-845-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48435 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab2EDN5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 09:57:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This set adds support for TPS62361 PMIC, which is used to power
MPU voltagedomain on OMAP4460 boards. These patches apply on top
of 3.4 + my voltagedomain fixes set to avoid adding redundant code.
Working tree available here for interested parties:

git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.4-voltdm-tps-v1

Tree has been tested with:
- omap3beagle board
- omap4panda es board (OMAP4460)
- omap4blaze board (OMAP4430)

Tested modifying the voltage levels on all core regulators (vdd1...vdd3)
and measuring that the voltages do actually change.

Patch #1 was needed before the voltages could be modified on a panda
board es device, otherwise the timing for the I2C channel was so bogus
it usually failed. The values used were taken from an android tree and
are based on TI analysis.

-Tero

