From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 00/31] CLK: OMAP conversion to DT
Date: Fri, 2 Aug 2013 19:25:19 +0300
Message-ID: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50332 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162Ab3HBQ0a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:26:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi,

This set mainly fixes comments received from Nishanth Menon for v4.
AM43xx + AM35xx clock data was added as new feature, also OMAP3
platforms use either the old style kernel clock data or DT data,
based on boot type.

Testing done:

omap3 beagle : boot, suspend / resume
omap4 panda es: boot, suspend / resume
omap5 sevm: boot
am335x bone: boot

Branch available here:
git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.11-rc3-omap-dt-clks-v5

-Tero

