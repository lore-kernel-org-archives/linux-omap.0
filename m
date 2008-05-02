From: Nishant Kamat <nskamat@ti.com>
Subject: [PATCH 7/7] ARM: OMAP: Add ethernet support for OMAP LDP
Date: Fri,  2 May 2008 06:24:01 -0500
Message-ID: <1209727441-4312-8-git-send-email-nskamat@ti.com>
References: <1209727441-4312-1-git-send-email-nskamat@ti.com>
 <1209727441-4312-2-git-send-email-nskamat@ti.com>
 <1209727441-4312-3-git-send-email-nskamat@ti.com>
 <1209727441-4312-4-git-send-email-nskamat@ti.com>
 <1209727441-4312-5-git-send-email-nskamat@ti.com>
 <1209727441-4312-6-git-send-email-nskamat@ti.com>
 <1209727441-4312-7-git-send-email-nskamat@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:54398 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762679AbYEBLYJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 May 2008 07:24:09 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m42BO4PX019410
	for <linux-omap@vger.kernel.org>; Fri, 2 May 2008 06:24:09 -0500
In-Reply-To: <1209727441-4312-7-git-send-email-nskamat@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishant Kamat <nskamat@ti.com>

This patch adds ethernet support (smc911x) for OMAP LDP platform.

Signed-off-by: Nishant Kamat <nskamat@ti.com>
---
 arch/arm/configs/omap_ldp_defconfig   |  155 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/board-ldp.c       |   51 +++++++++++
 include/asm-arm/arch-omap/board-ldp.h |    6 ++
 3 files changed, 209 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index 1c04221..7d4ff7b 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-omap1
-# Mon Apr 28 19:52:04 2008
+# Tue Apr 29 19:51:36 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -37,8 +37,11 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
@@ -317,7 +320,86 @@ CONFIG_ARCH_SUSPEND_POSSIBLE=y
 #
 # Networking
 #
-# CONFIG_NET is not set
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -333,6 +415,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 CONFIG_MTD_CONCAT=y
@@ -423,11 +506,13 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=16384
 # CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
 CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_93CX6 is not set
 # CONFIG_OMAP_STI is not set
@@ -468,12 +553,52 @@ CONFIG_SCSI_WAIT_SCAN=m
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
 # CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
+# CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+# CONFIG_SMC91X is not set
+# CONFIG_DM9000 is not set
+# CONFIG_ENC28J60 is not set
+CONFIG_SMC911X=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_E1000E_ENABLED is not set
+CONFIG_NETDEV_10000=y
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
 
 #
 # Input device support
@@ -685,6 +810,7 @@ CONFIG_SSB_POSSIBLE=y
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
 CONFIG_DAB=y
 
 #
@@ -856,12 +982,14 @@ CONFIG_EXT3_FS=y
 CONFIG_JBD=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 CONFIG_QUOTA=y
+# CONFIG_QUOTA_NETLINK_INTERFACE is not set
 CONFIG_PRINT_QUOTA_WARNING=y
 # CONFIG_QFMT_V1 is not set
 CONFIG_QFMT_V2=y
@@ -926,6 +1054,26 @@ CONFIG_JFFS2_RTIME=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
 
 #
 # Partition Types
@@ -988,6 +1136,7 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 6a4339a..747bd8f 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -45,6 +45,26 @@
 
 #define TWL4030_MSECURE_GPIO	22
 
+static struct resource ldp_smc911x_resources[] = {
+	[0] = {
+		.start	= OMAP34XX_ETHR_START,
+		.end	= OMAP34XX_ETHR_START + SZ_4K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 0,
+		.end	= 0,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
+	},
+};
+
+static struct platform_device ldp_smc911x_device = {
+	.name		= "smc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ldp_smc911x_resources),
+	.resource	= ldp_smc911x_resources,
+};
+
 static int ts_gpio;
 
 #ifdef CONFIG_RTC_DRV_TWL4030
@@ -183,16 +203,47 @@ static struct spi_board_info ldp_spi_board_info[] __initdata = {
 };
 
 static struct platform_device *ldp_devices[] __initdata = {
+	&ldp_smc911x_device,
 #ifdef CONFIG_RTC_DRV_TWL4030
 	&ldp_twl4030rtc_device,
 #endif
 };
 
+static inline void __init ldp_init_smc911x(void)
+{
+	int eth_cs;
+	unsigned long cs_mem_base;
+	int eth_gpio = 0;
+
+	eth_cs = LDP_SMC911X_CS;
+
+	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
+		printk(KERN_ERR "Failed to request GPMC mem for smc911x\n");
+		return;
+	}
+
+	ldp_smc911x_resources[0].start = cs_mem_base + 0x0;
+	ldp_smc911x_resources[0].end   = cs_mem_base + 0xf;
+	udelay(100);
+
+	eth_gpio = LDP_SMC911X_GPIO;
+
+	ldp_smc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
+
+	if (omap_request_gpio(eth_gpio) < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
+			eth_gpio);
+		return;
+	}
+	omap_set_gpio_direction(eth_gpio, 1);
+}
+
 static void __init omap_ldp_init_irq(void)
 {
 	omap2_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
+	ldp_init_smc911x();
 }
 
 static struct omap_uart_config ldp_uart_config __initdata = {
diff --git a/include/asm-arm/arch-omap/board-ldp.h b/include/asm-arm/arch-omap/board-ldp.h
index 88b02a8..8f96e25 100644
--- a/include/asm-arm/arch-omap/board-ldp.h
+++ b/include/asm-arm/arch-omap/board-ldp.h
@@ -31,6 +31,12 @@
 
 extern void ldp_flash_init(void);
 
+#define DEBUG_BASE		0x08000000
+
+#define OMAP34XX_ETHR_START	DEBUG_BASE
+#define LDP_SMC911X_CS		1
+#define LDP_SMC911X_GPIO	152
+
 #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
 
 #endif /* __ASM_ARCH_OMAP_LDP_H */
-- 
1.5.3.2

