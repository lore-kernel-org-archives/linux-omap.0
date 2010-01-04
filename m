From: hvaibhav@ti.com
Subject: [PATCH 0/3] Add support for AM35xx IPSS modules
Date: Mon,  4 Jan 2010 19:21:53 +0530
Message-ID: <1262613116-20185-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42879 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0ADNwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 08:52:05 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

AM35xx (AM3517/05) has few additions modules under IPSS (IP SubSystem), like
VPFE, CPGMAC and USBOTG.

This patch adds/updates the corresponding base addresses, interrupt number, and
control module bit definations for the same.

Vaibhav Hiremath (3):
  AM35xx: Add AM35xx intr_clr & sw_rst cntrl reg bit defination
  AM35xx: Introduce am35xx.h file
  AM35xx: Update irq.h for AM35xx IPSS module interrupts

 arch/arm/plat-omap/include/plat/am35xx.h   |   25 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/control.h  |   17 +++++++++++++++++
 arch/arm/plat-omap/include/plat/hardware.h |    1 +
 arch/arm/plat-omap/include/plat/irqs.h     |   10 ++++++++++
 4 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/am35xx.h

