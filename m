From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 2/3] OMAP_LDP: Add Ethernet device support to make ldp boot succeess.
Date: Fri,  7 Nov 2008 21:41:26 +0800
Message-ID: <1226065287-3066-3-git-send-email-stanley.miao@windriver.com>
References: <1226065287-3066-1-git-send-email-stanley.miao@windriver.com>
 <1226065287-3066-2-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50870 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbYKGNfx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Nov 2008 08:35:53 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mA7DZqUJ021562
	for <linux-omap@vger.kernel.org>; Fri, 7 Nov 2008 05:35:53 -0800 (PST)
In-Reply-To: <1226065287-3066-2-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add Ethernet device support in board-ldp.c to make ldp can boot and mount nfs
successfully.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/configs/omap_ldp_defconfig         |  148 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/board-ldp.c             |   53 ++++++++++
 arch/arm/plat-omap/include/mach/board-ldp.h |    5 +-
 drivers/net/smc911x.c                       |    6 +-
 drivers/net/smc911x.h                       |    2 +
 5 files changed, 210 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index b8135d2..add0b71 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -329,7 +329,82 @@ CONFIG_PM=y
 # CONFIG_SUSPEND is not set
 # CONFIG_APM_EMULATION is not set
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
@@ -345,6 +420,8 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
+CONFIG_CONNECTOR=y
+CONFIG_PROC_EVENTS=y
 # CONFIG_MTD is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
@@ -405,6 +482,54 @@ CONFIG_SCSI_LOWLEVEL=y
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
@@ -1053,6 +1178,27 @@ CONFIG_TMPFS=y
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
index 3ec8264..f319e97 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -44,6 +44,7 @@
 #include "mmc-twl4030.h"
 
 
+#define       SDP3430_SMC91X_CS 	3
 #define CONFIG_DISABLE_HFCLK 1
 
 #define ENABLE_VAUX1_DEDICATED	0x03
@@ -51,6 +52,26 @@
 
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
 
 static int __init msecure_init(void)
@@ -177,14 +198,46 @@ static struct platform_device ldp_lcd_device = {
 };
 
 static struct platform_device *ldp_devices[] __initdata = {
+	&ldp_smc911x_device,
 	&ldp_lcd_device,
 };
 
+static inline void __init ldp_init_smc911x(void)
+{
+       int eth_cs;
+       unsigned long cs_mem_base;
+       int eth_gpio = 0;
+
+       eth_cs = LDP_SMC911X_CS;
+
+       if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
+               printk(KERN_ERR "Failed to request GPMC mem for smc911x\n");
+               return;
+       }
+
+       ldp_smc911x_resources[0].start = cs_mem_base + 0x0;
+       ldp_smc911x_resources[0].end   = cs_mem_base + 0xf;
+       udelay(100);
+
+       eth_gpio = LDP_SMC911X_GPIO;
+
+       ldp_smc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
+
+       if (omap_request_gpio(eth_gpio) < 0) {
+               printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
+                       eth_gpio);
+               return;
+       }
+       omap_set_gpio_direction(eth_gpio, 1);
+}
+
+
 static void __init omap_ldp_init_irq(void)
 {
 	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
+        ldp_init_smc911x();
 }
 
 static struct omap_uart_config ldp_uart_config __initdata = {
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
diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index f59c777..05e7512 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -2063,7 +2063,7 @@ static int smc911x_drv_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto out;
 	}
-
+#ifndef SMC_MEM_RESERVED
 	/*
 	 * Request the regions.
 	 */
@@ -2071,7 +2071,7 @@ static int smc911x_drv_probe(struct platform_device *pdev)
 		 ret = -EBUSY;
 		 goto out;
 	}
-
+#endif
 	ndev = alloc_etherdev(sizeof(struct smc911x_local));
 	if (!ndev) {
 		printk("%s: could not allocate device.\n", CARDNAME);
@@ -2108,7 +2108,9 @@ static int smc911x_drv_probe(struct platform_device *pdev)
 release_both:
 		free_netdev(ndev);
 release_1:
+#ifndef SMC_MEM_RESERVED
 		release_mem_region(res->start, SMC911X_IO_EXTENT);
+#endif
 out:
 		printk("%s: not found (%d).\n", CARDNAME, ret);
 	}
diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
index d1b3b9b..f688b55 100644
--- a/drivers/net/smc911x.h
+++ b/drivers/net/smc911x.h
@@ -682,6 +682,7 @@ smc_pxa_dma_outsl(struct smc911x_local *lp, u_long physaddr,
 #define CHIP_9116	0x0116
 #define CHIP_9117	0x0117
 #define CHIP_9118	0x0118
+#define CHIP_9211	0x9211
 #define CHIP_9215	0x115A
 #define CHIP_9217	0x117A
 #define CHIP_9218	0x118A
@@ -696,6 +697,7 @@ static const struct chip_id chip_ids[] =  {
 	{ CHIP_9116, "LAN9116" },
 	{ CHIP_9117, "LAN9117" },
 	{ CHIP_9118, "LAN9118" },
+	{ CHIP_9211, "LAN9211" },
 	{ CHIP_9215, "LAN9215" },
 	{ CHIP_9217, "LAN9217" },
 	{ CHIP_9218, "LAN9218" },
-- 
1.5.6.3

