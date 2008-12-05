From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] ARM: OMAP3: LDP: Add Ethernet device support to make ldp
	boot succeess
Date: Fri, 05 Dec 2008 12:03:52 -0800
Message-ID: <20081205200352.31125.15007.stgit@localhost>
References: <20081205195846.31125.21080.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51666 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbYLEUDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 15:03:55 -0500
In-Reply-To: <20081205195846.31125.21080.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

From: Stanley.Miao <stanley.miao@windriver.com>

Add Ethernet device support in board-ldp.c to make ldp can boot and mount
nfs successfully.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/configs/omap_ldp_defconfig         |  148 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-ldp.c             |   57 ++++++++++
 arch/arm/plat-omap/include/mach/board-ldp.h |    5 +
 3 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index 948a212..b77d054 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -316,7 +316,82 @@ CONFIG_BINFMT_MISC=y
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
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+CONFIG_XFRM_USER=y
+# CONFIG_XFRM_SUB_POLICY is not set
+CONFIG_XFRM_MIGRATE=y
+# CONFIG_XFRM_STATISTICS is not set
+CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
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
+# CONFIG_NET_DSA is not set
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
+# CONFIG_PHONET is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -332,6 +407,8 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
+CONFIG_CONNECTOR=y
+CONFIG_PROC_EVENTS=y
 # CONFIG_MTD is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
@@ -390,6 +467,54 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_DH is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
+CONFIG_NETDEVICES=y
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
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
 
 #
 # Input device support
@@ -816,6 +941,27 @@ CONFIG_TMPFS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_REGISTER_V4 is not set
+CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
 
 #
 # Partition Types
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 1ea5998..43c7ac4 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -38,11 +38,67 @@
 #include <asm/delay.h>
 #include <mach/control.h>
 
+#define SDP3430_SMC91X_CS	3
+
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
+static struct platform_device *ldp_devices[] __initdata = {
+	&ldp_smc911x_device,
+};
+
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
+				eth_gpio);
+		return;
+	}
+	gpio_direction_input(eth_gpio);
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
@@ -64,6 +120,7 @@ static int __init omap_i2c_init(void)
 static void __init omap_ldp_init(void)
 {
 	omap_i2c_init();
+	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	omap_serial_init();
diff --git a/arch/arm/plat-omap/include/mach/board-ldp.h b/arch/arm/plat-omap/include/mach/board-ldp.h
index 66e2746..f233996 100644
--- a/arch/arm/plat-omap/include/mach/board-ldp.h
+++ b/arch/arm/plat-omap/include/mach/board-ldp.h
@@ -32,5 +32,8 @@
 extern void twl4030_bci_battery_init(void);
 
 #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
-
+#define LDP_SMC911X_CS         1
+#define LDP_SMC911X_GPIO       152
+#define DEBUG_BASE             0x08000000
+#define OMAP34XX_ETHR_START    DEBUG_BASE
 #endif /* __ASM_ARCH_OMAP_LDP_H */

