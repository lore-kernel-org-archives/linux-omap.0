From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] clk: ti: OMAP3: McBSP clock fixes
Date: Mon, 16 Mar 2015 12:40:56 +0200
Message-ID: <1426502458-6124-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41180 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbbCPKlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2015 06:41:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, mturquette@linaro.org, sboyd@codeaurora.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

This series will fix the following error during boot (both DT and legacy boot):
[    0.307739] omap_hwmod: mcbsp2: _wait_target_ready failed: -16
[    0.307769] omap_hwmod: mcbsp2: cannot be enabled for reset (3)

The clock definitions/aliases for McBSP ports were not correct.

In case of DT boot we still have the following warning printed from hwmod:
[    0.222900] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.225311] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp

These are there because mcbsp is using two hwmods in the DT and hwmod prints
out a warning for these. In legacy mode we also have 2 hwmods for McBSP2/3.
One for the McBSP itself and the other for the sidetone block attached to them.
I'll try to look into this one next.

Since this series fixes the _wait_target_ready issue, can this be sent for 4.0?

Regards,
Peter
---
Peter Ujfalusi (2):
  clk: ti: clk-3xxx: Correct McBSP related DT clock definitions
  clk: ti: clk-3xxx-legacy: Correct McBSP related clock aliases

 drivers/clk/ti/clk-3xxx-legacy.c | 16 +++++++++-------
 drivers/clk/ti/clk-3xxx.c        | 19 +++++++------------
 2 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.3.0

