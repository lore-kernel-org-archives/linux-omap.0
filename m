From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Implement set_rate for FAPLL on dm816x
Date: Sun, 22 Mar 2015 15:35:23 -0700
Message-ID: <1427063726-4248-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ar-005-i178.relay.mailchannels.net ([162.253.144.63]:27985 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751895AbbCVWkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Mar 2015 18:40:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi all,

Here are few patches to implement set_rate for the FAPLL found
on dm816x.

Regards,

Tony


Tony Lindgren (3):
  clk: ti: Fix FAPLL recalc_rate for rounding errors
  clk: ti: Implement FAPLL set_rate for the synthesizer
  clk: ti: Implement FAPLL set_rate for the PLL

 drivers/clk/ti/fapll.c | 270 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 262 insertions(+), 8 deletions(-)

-- 
2.1.4

