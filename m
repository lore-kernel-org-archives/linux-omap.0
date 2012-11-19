From: Igor Mazanov <i.mazanov@gmail.com>
Subject: [PATCH] OMAP2+: enable TPS65217 support in omap2plus_defconfig
Date: Mon, 19 Nov 2012 15:45:25 +0400
Message-ID: <50AA1BD5.1000002@gmail.com>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47854 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459Ab2KSLoz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 06:44:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1TaPmh-0007dO-IV
	for linux-omap@vger.kernel.org; Mon, 19 Nov 2012 12:45:03 +0100
Received: from 77.232.56.122 ([77.232.56.122])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 19 Nov 2012 12:45:03 +0100
Received: from i.mazanov by 77.232.56.122 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 19 Nov 2012 12:45:03 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

TPS65217 is described in arch/arm/boot/dts/am335x-bone.dts
but doesn't enabled in arch/arm/configs/omap2plus_defconfig.

Enable TPS65217 support in omap2plus_defconfig.

Signed-off-by: Igor Mazanov <i.mazanov@gmail.com>
---
  arch/arm/configs/omap2plus_defconfig |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig 
b/arch/arm/configs/omap2plus_defconfig
index 6230304..00f2ce3 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -240,3 +240,6 @@ CONFIG_CRC_ITU_T=y
  CONFIG_CRC7=y
  CONFIG_LIBCRC32C=y
  CONFIG_SOC_OMAP5=y
+CONFIG_MFD_CORE=y
+CONFIG_MFD_TPS65217=y
+CONFIG_REGULATOR_TPS65217=y
--
1.7.4.4

