From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] debobs support for OMAP3430
Date: Tue, 16 Sep 2008 12:51:39 +0300
Message-ID: <1221558702-6888-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61025 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbYIPJwB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 05:52:01 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8G9pteI008108
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 04:51:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch adds support for debug observability on OMAP3430 using the ETK lines.

Peter 'p2' De Schrijver (3):
  Add definitions for ETK pads and debobs registers
  Debobs and ETK padconf implementation
  Add debobs Kconfig item

 arch/arm/mach-omap2/Kconfig               |   10 ++-
 arch/arm/mach-omap2/Makefile              |    3 +
 arch/arm/mach-omap2/debobs.c              |  214 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/control.h |   33 +++++
 4 files changed, 259 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/debobs.c

