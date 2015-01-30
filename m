From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: config: omap2plus_defconfig: switch over to LZMA compression
Date: Fri, 30 Jan 2015 11:18:56 -0600
Message-ID: <1422638336-24243-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54487 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbbA3RTX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jan 2015 12:19:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, David Cohen <david.a.cohen@linux.intel.com>, Felipe Balbi <balbi@ti.com>

LZMA compression makes about 33% smaller zImage
with just a slight extra decompression time.

Before this patch, zImage built with o2+_dc
is 4.5MiB and after it's about 3.3MiB.

Suggested-by: David Cohen <david.a.cohen@linux.intel.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b7386524c356..742c62b6d663 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -1,3 +1,4 @@
+CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_FHANDLE=y
-- 
2.3.0-rc1

