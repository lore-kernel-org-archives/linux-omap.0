From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/11] omap2/3/4: Make omap3_defconfig usable on Nokia boards
Date: Fri, 30 Apr 2010 13:34:03 -0700
Message-ID: <20100430203403.25812.64363.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61186 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933189Ab0D3UeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:34:07 -0400
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

The bootloader on Nokia boards does not support updating
the kernel cmdline. For the other boards, the bootloader
provided cmdline will be used instead.

To mount root on n8x0, compile in also the MMC_OMAP.
It seems that the best way to mount root with the
new kernels on Nokia boards is to mount root on mmcblk0p2.

Note that n8x0 current has several issues booting with
omap3_defconfig: The bootloader has a 2MB limit for loading
kernels, so you may want to use kexec. Also ARMv6 does
not currently work with ARMv7 for VFP and TLS.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_defconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index 01e5986..d2ab492 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -391,7 +391,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.168.0.2:192.168.0.1:192.168.0.1:255.255.255.0:tgt:eth0:off rw console=ttyS2,115200n8"
+CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyS2,115200"
 # CONFIG_XIP_KERNEL is not set
 CONFIG_KEXEC=y
 CONFIG_ATAGS_PROC=y
@@ -1687,7 +1687,7 @@ CONFIG_SDIO_UART=y
 # MMC/SD/SDIO Host Controller Drivers
 #
 # CONFIG_MMC_SDHCI is not set
-# CONFIG_MMC_OMAP is not set
+CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
 # CONFIG_MMC_AT91 is not set
 # CONFIG_MMC_ATMELMCI is not set

