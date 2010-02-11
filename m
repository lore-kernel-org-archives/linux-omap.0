From: hvaibhav@ti.com
Subject: [PATCH 0/2-V2] Add support for I2C based devices to AM3517EVM
Date: Thu, 11 Feb 2010 13:42:25 +0530
Message-ID: <1265875947-12306-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56479 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab0BKIMf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 03:12:35 -0500
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

Changes from last submission (V1) -
	- Dropped "Basic I2C support patch" patch, since it has
	  already been merged.
        - Removed TSC2004 support patch, since it will be merged to
	  TSC2007 driver.


Vaibhav Hiremath (2):
  AM3517: Enable RTC driver support for AM3517EVM
  AM3517: Enable I2C-GPIO Expander driver support for AM3517EVM

 arch/arm/mach-omap2/board-am3517evm.c |   62 +++++++++++++++++++++++++++++++-
 1 files changed, 60 insertions(+), 2 deletions(-)

