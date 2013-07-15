From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: multi_v7: Enabled omap4430 sdp nfsroot
Date: Mon, 15 Jul 2013 00:58:17 -0700
Message-ID: <20130715075816.GN7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56025 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab3GOH6U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 03:58:20 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Jul 15 00:39:41 2013 -0700

    ARM: multi_v7: Enabled omap4430 sdp nfsroot
    
    By adding support for OCP2SCP, SPI and KS8851 I can also boot test
    multi_v7_defconfig easily.
    
    Note that if using an older u-boot, CONFIG_ARM_ATAG_DTB_COMPAT=y
    may also be needed for the appended DTB based booting.
    
    Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -53,6 +53,7 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_OMAP_OCP2SCP=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI_PLATFORM=y
@@ -61,6 +62,7 @@ CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_SUN4I_EMAC=y
 CONFIG_NET_CALXEDA_XGMAC=y
+CONFIG_KS8851=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
 CONFIG_MDIO_SUN4I=y
@@ -89,6 +91,7 @@ CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
+CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_SIRF=y
 CONFIG_SPI_TEGRA114=y
