From: hvaibhav@ti.com
Subject: [PATCH 0/2-V3] Add support for I2C based devices to AM3517EVM
Date: Sat, 13 Feb 2010 17:17:55 +0530
Message-ID: <1266061677-12681-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47237 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808Ab0BMLsG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Feb 2010 06:48:06 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

This series of patchset adds platform hook-up interface for I2C based
devices to AM3517 -
        - Real Time Clock (S35390A)
        - I2C GPIO Expander (TCA6416)

Changes from last submission (V2) -
	- Added seperate function for RTC init, to handle error return
	properly (comment provided by Tony).

Vaibhav Hiremath (2):
  AM3517: Enable RTC driver support for AM3517EVM
  AM3517: Enable I2C-GPIO Expander driver support for AM3517EVM

 arch/arm/mach-omap2/board-am3517evm.c |   79 ++++++++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 2 deletions(-)

