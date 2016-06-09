From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 1/6] ARM: omap2plus_defconfig: Enable OMAP GPMC
Date: Thu,  9 Jun 2016 12:02:52 -0500
Message-ID: <1465491777-20033-2-git-send-email-fcooper@ti.com>
References: <1465491777-20033-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465491777-20033-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, boris.brezillon@free-electrons.com, computersforpeace@gmail.com, linux-arm-kernel@lists.infradead, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP_GPMC will soon not be forcibly enabled by ARCH_OMAP2PLUS. It needs
to be manually selected by the config. Enable it by default so features
like NAND boot will work.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ac717cc..c0c3bcd 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -117,6 +117,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_OMAP_OCP2SCP=y
 CONFIG_CONNECTOR=m
+CONFIG_OMAP_GPMC=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-- 
2.7.0
