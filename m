From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 0/2] ARM: DRA7: Add RTC hwmod and dt entries
Date: Wed, 9 Jul 2014 14:05:30 +0530
Message-ID: <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
References: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56842 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbaGIIgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 04:36:10 -0400
In-Reply-To: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, rnayak@ti.com, tony@atomide.com, devicetree@vger.kernel.org, nm@ti.com, j-keerthy@ti.com, nsekhar@ti.com, lokeshvutla@ti.com

This series adds hwmod entry and dt node for RTC.

Tested on DRA7: logs can be seen here: http://hastebin.com/jaxogatuta.vhdl

Lokesh Vutla (2):
  ARM: DRA7: hwmod: Add data for RTC
  ARM: dts: DRA7: Add node for RTC

 arch/arm/boot/dts/dra7-evm.dts            |    1 +
 arch/arm/boot/dts/dra7.dtsi               |    9 +++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   41 +++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

-- 
1.7.9.5

