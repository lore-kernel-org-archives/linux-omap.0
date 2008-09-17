From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] debobs support for OMAP3430.
Date: Wed, 17 Sep 2008 18:02:26 +0300
Message-ID: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25780 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbYIQPHE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 11:07:04 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8HF6pJF012722
	for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 18:07:01 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch adds support for debug observability on OMAP3430 using the ETK lines. Fixes some potential issues with the OMAP343X_CONTROL_DEBOBS, OMAP343X_PADCONF_ETK and OMAP343X_CONTROL_WKUP_DEBOBSMUX macros.

Peter 'p2' De Schrijver (3):
  Add definitions for ETK pads and debobs registers
  Debobs and ETK padconf implementation
  Add debobs Kconfig item

 arch/arm/mach-omap2/Kconfig               |   10 ++-
 arch/arm/mach-omap2/Makefile              |    3 +
 arch/arm/mach-omap2/debobs.c              |  214 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/control.h |   34 +++++
 4 files changed, 260 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/debobs.c

