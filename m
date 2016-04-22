From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Fix warning due invalid RXKAD symbol value
Date: Fri, 22 Apr 2016 13:53:19 -0400
Message-ID: <1461347599-32440-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Commit 648af7fca159 ("rxrpc: Absorb the rxkad security module") changed
the RXKAD Kconfig symbol from tristate to boolean but the commit didn't
update the omap2plus_defconfig that was enabling CONFIG_RXKAD as module.

This leads to the following warning when using the omap2plus_defconfig:

arch/arm/configs/omap2plus_defconfig:112:warning: symbol value 'm' invalid for RXKAD

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/configs/omap2plus_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9edf8a493f07..c48cbd78e08f 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -109,7 +109,7 @@ CONFIG_BT_HCIVHCI=m
 CONFIG_BT_MRVL=m
 CONFIG_BT_MRVL_SDIO=m
 CONFIG_AF_RXRPC=m
-CONFIG_RXKAD=m
+CONFIG_RXKAD=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_DEVTMPFS=y
-- 
2.5.5
