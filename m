From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 0/3] add parallel NAND support for TI's new OMAPx and AMxx platforms (Part-2)
Date: Wed, 12 Mar 2014 16:19:17 +0530
Message-ID: <1394621360-2457-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbaCLKuS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 06:50:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Pekon Gupta <pekon@ti.com>

This patch-set adds parallel NAND support on following TI platforms
 - AM335x (am335x-bone LT, am335x-boneblack): <disabled by default>
 - AM43xx (am437x-gp-evm)


Pekon Gupta (3):
  ARM: dts: am335x-bone: add support for beaglebone NAND cape
  ARM: dts: am335x-boneblack: add support for beaglebone NAND cape
  ARM: dts: am437x-gp-evm: add support for parallel NAND flash

 arch/arm/boot/dts/am335x-bone.dts      | 123 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-boneblack.dts | 120 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts    | 107 ++++++++++++++++++++++++++++
 3 files changed, 350 insertions(+)

-- 
1.8.5.1.163.gd7aced9

