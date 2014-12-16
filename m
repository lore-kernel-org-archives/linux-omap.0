From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/11] ARM: OMAP3: legacy clock data move under clk driver
Date: Tue, 16 Dec 2014 18:20:45 +0200
Message-ID: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42226 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbaLPQT6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2014 11:19:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

These patches move the legacy clock data for omap3 under drivers/clk/ti.
After these patches are applied, it should be possible to get rid of
clk-private.h (long pending project for Mike.)

Testing done (on top of 3.18-rc1):

omap3-beagle: boot / suspend-resume (ret/off) / cpuidle (ret/off)
omap3-beagle-xm: boot upto fs mount (see note below)
sdp3430: boot
n900: boot

Note: beagle-xm failed with FS mount on the board I have access to, but
      this happens with clean 3.18-rc1 and linux-next also at the moment.
      The board has probably corrupted filesystem image but I am unable
      to fix this atm (remote board.)

Test branch:
tree: https://github.com/t-kristo/linux-pm.git
branch: 3.18-rc1-omap3-clk-rework

-Tero

