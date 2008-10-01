From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/3] debobs support for OMAP3430.
Date: Wed,  1 Oct 2008 18:11:10 +0300
Message-ID: <1222873873-31760-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36112 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbYJAPLg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 11:11:36 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m91FBKKg015698
	for <linux-omap@vger.kernel.org>; Wed, 1 Oct 2008 18:11:34 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch adds support for debug observability on OMAP3430 using the ETK lines. A new interface for using debug GPIOs is provided. This interface makes sure the debobs subsystem is initialized before actual gpiolib calls are made. 

Peter 'p2' De Schrijver (3):
  Add definitions for ETK pads and debobs registers
  Debobs and ETK padconf implementation
  Add debobs Kconfig item

 arch/arm/mach-omap2/Makefile              |    3 +
 arch/arm/mach-omap2/debobs.c              |  239 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig                |    7 +
 arch/arm/plat-omap/include/mach/control.h |   34 ++++
 arch/arm/plat-omap/include/mach/debobs.h  |    7 +
 5 files changed, 290 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/debobs.c
 create mode 100644 arch/arm/plat-omap/include/mach/debobs.h

