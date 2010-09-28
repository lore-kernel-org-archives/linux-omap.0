From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP2+: defconfig: disable CPUfreq
Date: Tue, 28 Sep 2010 12:07:28 -0700
Message-ID: <1285700849-10000-2-git-send-email-khilman@deeprootsystems.com>
References: <1285700849-10000-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:59387 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806Ab0I1THr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 15:07:47 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1789948pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 12:07:47 -0700 (PDT)
In-Reply-To: <1285700849-10000-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Disable CPUfreq since

1) is not yet supported in mainline, and
2) the current driver fails to suspend properly

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/configs/omap2plus_defconfig |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9ca8df0..a3db92b 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -65,10 +65,6 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyS2,115200"
 CONFIG_KEXEC=y
-CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_STAT_DETAILS=y
-CONFIG_CPU_FREQ_GOV_USERSPACE=y
-CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
1.7.2.1

