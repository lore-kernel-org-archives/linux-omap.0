From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] OMAP4: Networking: Defconfig Support
Date: Fri, 14 May 2010 14:28:05 -0700
Message-ID: <20100514212805.25599.77917.stgit@baageli.muru.com>
References: <20100514212506.25599.98073.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63347 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab0ENV2F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:28:05 -0400
In-Reply-To: <20100514212506.25599.98073.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Abraham Arce <x0066660@ti.com>

From: Abraham Arce <x0066660@ti.com>

Enable KS8851 SPI support +

 Networking Support
  - Packet Socket
  - TCP/IP

 Network Filesystems
  - NFS Client
  - Root Filesystem on NFS

Signed-off-by: Abraham Arce <x0066660@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |   57 ++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index a96bca2..d87a349 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -343,7 +343,34 @@ CONFIG_BINFMT_MISC=y
 #
 # CONFIG_PM is not set
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
-# CONFIG_NET is not set
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_XFRM=y
+CONFIG_INET=y
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_LRO=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_IPV6 is not set
+
+#
+# Network testing
+#
+# CONFIG_WIRELESS is not set
+
 
 #
 # Device Drivers
@@ -386,6 +413,13 @@ CONFIG_HAVE_IDE=y
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
 # CONFIG_PHONE is not set
+CONFIG_NETDEVICES=y
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_KS8851=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
 
 #
 # Input device support
@@ -457,7 +491,13 @@ CONFIG_HW_RANDOM=y
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
-# CONFIG_SPI is not set
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_OMAP24XX=y
 
 #
 # PPS support
@@ -634,6 +674,19 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
 
 #
 # Partition Types

