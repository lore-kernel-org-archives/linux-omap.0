From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: [PATCH 0/5] ARM: am43xx: enable VPFE
Date: Thu, 18 Dec 2014 21:54:09 +0530
Message-ID: <1418919854-16164-1-git-send-email-prabhakar.csengg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61511 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaLRQY3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2014 11:24:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, LAK <linux-arm-kernel@lists.infradead.org>, OMAP <linux-omap@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Benoit Parrot <bparrot@ti.com>

This patch series adds hwmods and VPFE DT node entries
for am43xx devices.
The sensor driver is not allowed to release so the remote
endpoint for vpfe dt nodes are commented at the moment.

Benoit Parrot (4):
  ARM: AM43xx: hwmod: add VPFE hwmod entries
  ARM: dts: am4372: add VPFE DT node entries
  ARM: dts: am43x-epos-evm: add VPFE device tree data
  ARM: dts: am437x-gp-evm: add VPFE device tree data

Darren Etheridge (1):
  ARM: dts: am437x-sk-evm: add VPFE device tree data

 arch/arm/boot/dts/am4372.dtsi              |  16 +++++
 arch/arm/boot/dts/am437x-gp-evm.dts        | 106 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts        |  58 ++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts       |  53 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  56 +++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |   3 +-
 6 files changed, 291 insertions(+), 1 deletion(-)

-- 
1.9.1

