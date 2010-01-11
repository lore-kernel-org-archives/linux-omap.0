From: hvaibhav@ti.com
Subject: [PATCH 0/3-V1] Add base addr & bit defination for AM35xx IPSS modules
Date: Mon, 11 Jan 2010 11:36:18 +0530
Message-ID: <1263189981-717-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50786 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab0AKGG2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 01:06:28 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

AM35xx (AM3517/05) has few additional modules under IPSS (IP SubSystem), like
VPFE, CPGMAC and USBOTG.
This patch adds/updates the corresponding base addresses, interrupt number, and
control module bit definations for the same.

Please note that the OMAP34xx IVA2 memory space is being used for
AM35xx IPSS modules.

Changes from last submission -
	- As per Kevin's comment moved am35xx.h file from plat-omap to
	mach-omap2
	- Added information about memory space being re-used from IVA2 in
	comment description

Vaibhav Hiremath (3):
  AM35xx: Introduce am35xx.h file
  AM35xx: Add AM35xx intr_clr & sw_rst cntrl reg bit defination
  AM35xx: Update irq.h for AM35xx IPSS module interrupts

 arch/arm/mach-omap2/board-am3517evm.c     |    1 +
 arch/arm/mach-omap2/include/mach/am35xx.h |   26 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/control.h |   17 +++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h    |   10 ++++++++++
 4 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/am35xx.h

