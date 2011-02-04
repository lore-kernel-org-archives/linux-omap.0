From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] omap: Add CONFIG_AUTO_ZRELADDR and
	CONFIG_ARM_PATCH_PHYS_VIRT to defconfigs
Date: Thu, 03 Feb 2011 17:27:14 -0800
Message-ID: <20110204012714.26410.88783.stgit@baageli.muru.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21022 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab1BDB13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:27:29 -0500
In-Reply-To: <20110204012317.26410.55157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Add CONFIG_AUTO_ZRELADDR and CONFIG_ARM_PATCH_PHYS_VIRT to defconfigs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap1_defconfig     |    2 ++
 arch/arm/configs/omap2plus_defconfig |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 7b63462..261d37a 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -1,3 +1,4 @@
+CONFIG_ARM_PATCH_PHYS_VIRT=y
 CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
@@ -67,6 +68,7 @@ CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
+CONFIG_AUTO_ZRELADDR=y
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ae890ca..8c9d734 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -1,3 +1,4 @@
+CONFIG_ARM_PATCH_PHYS_VIRT=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -65,6 +66,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
 CONFIG_KEXEC=y
+CONFIG_AUTO_ZRELADDR=y
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
 CONFIG_NEON=y

