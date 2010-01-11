From: hvaibhav@ti.com
Subject: [PATCH 0/4-V1] Add support for I2C based devices to AM3517EVM
Date: Mon, 11 Jan 2010 11:49:58 +0530
Message-ID: <1263190802-1101-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40123 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab0AKGUJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 01:20:09 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

This series of patchset adds platform hook-up interface for I2C based
devices to AM3517 -
        - Real Time Clock (S35390A)
	- TouchScreen (TSC2004)
	- I2C GPIO Expander (TCA6416)

Changes from last submission -
	- As per Kevin's comment, added more description in
	patch-series/change-log/commit

Vaibhav Hiremath (4):
  AM3517: Enable basic I2C Support
  AM3517: Enable TSC2004 driver support for AM3517EVM
  AM3517: Enable RTC driver support for AM3517EVM
  AM3517: Enable I2C-GPIO Expander driver support for AM3517EVM

 arch/arm/mach-omap2/board-am3517evm.c |  126 +++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)

