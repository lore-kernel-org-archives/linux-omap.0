From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/3] debobs support for OMAP3430.
Date: Tue, 16 Sep 2008 14:24:37 +0300
Message-ID: <1221564280-7647-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64675 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYIPLY7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 07:24:59 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8GBOjr4017383
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 14:24:57 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch adds support for debug observability on OMAP3430 using the ETK lines. Resent due to missing sequence numbers.

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

