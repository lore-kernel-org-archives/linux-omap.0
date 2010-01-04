From: hvaibhav@ti.com
Subject: [PATCH 0/4] Add I2C support to AM3517EVM
Date: Mon,  4 Jan 2010 19:46:33 +0530
Message-ID: <1262614597-21685-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47907 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab0ADOQo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 09:16:44 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

This series of patchset adds support for I2C bus interface along with
respective slave devices - 
	- RTC-S35390A
	- TSC2004
	- TVP5146 decoder along with VPFE-capture

Vaibhav Hiremath (4):
  AM3517EVM: Enable I2C Support
  AM3517: Add support for TSC2004 driver
  AM3517: Add RTC-S35390A support
  AM3517: Add VPFE Capture driver support

 arch/arm/mach-omap2/board-am3517evm.c |  249 +++++++++++++++++++++++++++++++++
 1 files changed, 249 insertions(+), 0 deletions(-)

