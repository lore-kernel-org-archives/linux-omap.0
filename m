From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: ARM: OMAP2+: omap2plus_defconfig: enable omap1 rtc
Date: Tue, 29 Jan 2013 15:03:35 +0000
Message-ID: <5107E4C7.6000008@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:55643 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756642Ab3A2PDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jan 2013 10:03:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The BeagleBone dev kit uses the built-in RTC module, so
it would be nice to have this built by default in the
omap2plus defconfig.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 82ce8d7..d852775 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -199,6 +199,7 @@ CONFIG_MMC_OMAP_HS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
+CONFIG_RTC_DRV_OMAP=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_OMAP=y
 CONFIG_EXT2_FS=y
