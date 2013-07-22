From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH 0/2] Add DSS nodes for AM43x
Date: Mon, 22 Jul 2013 11:33:15 +0530
Message-ID: <1374472997-9653-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53132 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab3GVGET (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 02:04:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, benoit.cousson@linaro.org, a-kishore@ti.com, devicetree-discuss@lists.ozlabs.org
Cc: afzal@ti.com, Sathya Prakash M R <sathyap@ti.com>

DSS support for AM437x is added in this patch series.
Patch #1 adds the hwmod entries and
patch #2 adds the DT entry.

Sathya Prakash M R (2):
  ARM: OMAP2+: AM43x - Add DSS hwmod
  ARM: DTS: AM43x: Add DSS node

 arch/arm/boot/dts/am4372.dtsi              |   27 +++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   85 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 3 files changed, 113 insertions(+)

-- 
1.7.9.5

