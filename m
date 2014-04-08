From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 0/2] ARM: dts: sbc-t54: add support for sbc-t54 with cm-t54
Date: Tue,  8 Apr 2014 16:08:49 +0300
Message-ID: <1396962531-27729-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:55082 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756665AbaDHNKE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Apr 2014 09:10:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

Add support for CompuLab CM-T54 CoM and SBC-T54 board:
    
    http://compulab.co.il/products/computer-on-modules/cm-t54/
    http://compulab.co.il/products/sbcs/sbc-t54/
    
SBC-T54 is a single board computer based on OMAP5432 CPU.
It is implemented with a CM-T54 CoM providing most of the functions,
and SB-T54 carrier board providing connectors and several additional
functions.

Dmitry Lifshitz (2):
  ARM: dts: sbc-t54: add support for sbc-t54 with cm-t54
  ARM: dts: cm-t54: add WiFi/BT support

 arch/arm/boot/dts/Makefile          |    2 +
 arch/arm/boot/dts/omap5-cm-t54.dts  |  390 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5-sbc-t54.dts |   33 +++
 arch/arm/mach-omap2/pdata-quirks.c  |   10 +
 4 files changed, 435 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap5-cm-t54.dts
 create mode 100644 arch/arm/boot/dts/omap5-sbc-t54.dts

-- 
1.7.5.4

