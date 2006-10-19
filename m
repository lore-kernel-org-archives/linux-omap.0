From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH] MMC support for Palm Tungsten|T
Date: Thu, 19 Oct 2006 18:28:26 +0200
Message-ID: <200610191828.26833.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qe6NFQhx83Q8fMx"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_qe6NFQhx83Q8fMx
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
this patch adds mmc support for palmTT. It has to be applied to the previou=
s=20
one (basic palmtt support). It changes palmtt_defconfig too, so mmc is=20
enabled by default.

br
Marek Vasut

Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>

--Boundary-00=_qe6NFQhx83Q8fMx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="palmtt-mmc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="palmtt-mmc.patch"

diff -Naur linux-omap-current/arch/arm/configs/palmtt_defconfig linux-omap/=
arch/arm/configs/palmtt_defconfig
=2D-- linux-omap-current/arch/arm/configs/palmtt_defconfig	2006-10-19 13:50=
:26.000000000 +0200
+++ linux-omap/arch/arm/configs/palmtt_defconfig	2006-10-19 18:02:36.000000=
000 +0200
@@ -1,7 +1,7 @@
 #

 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.18-omap1
=2D# Thu Oct 19 11:55:31 2006
+# Thu Oct 19 15:32:16 2006
 #
 CONFIG_ARM=3Dy
 CONFIG_MMU=3Dy
@@ -28,8 +28,11 @@
 CONFIG_LOCALVERSION_AUTO=3Dy
 CONFIG_SWAP=3Dy
 CONFIG_SYSVIPC=3Dy
+# CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=3Dy
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=3D""
@@ -252,7 +255,82 @@
 #
 # Networking
 #
=2D# CONFIG_NET is not set
+CONFIG_NET=3Dy
+
+#
+# Networking options
+#
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=3Dy
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=3Dy
+CONFIG_XFRM=3Dy
+# CONFIG_XFRM_USER is not set
+CONFIG_NET_KEY=3Dy
+CONFIG_INET=3Dy
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=3Dy
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=3Dy
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
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
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
=20
 #
 # Device Drivers
@@ -269,6 +347,7 @@
 #
 # Connector - unified userspace <-> kernelspace linker
 #
+# CONFIG_CONNECTOR is not set
=20
 #
 # Memory Technology Devices (MTD)
@@ -289,9 +368,11 @@
 #
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
=20
 #
 # SCSI device support
@@ -318,8 +399,41 @@
 #
=20
 #
+# Network device support
+#
+# CONFIG_NETDEVICES is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# PHY device support
+#
+
+#
+# Ethernet (10 or 100Mbit)
+#
+# CONFIG_NET_ETHERNET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
 # ISDN subsystem
 #
+# CONFIG_ISDN is not set
=20
 #
 # Input device support
@@ -468,6 +582,7 @@
 #
 # Digital Video Broadcasting Devices
 #
+# CONFIG_DVB is not set
=20
 #
 # Graphics support
@@ -541,7 +656,11 @@
 #
 # MMC/SD Card support
 #
=2D# CONFIG_MMC is not set
+CONFIG_MMC=3Dy
+# CONFIG_MMC_DEBUG is not set
+CONFIG_MMC_BLOCK=3Dy
+# CONFIG_MMC_OMAP is not set
+CONFIG_MMC_PALMTT=3Dy
=20
 #
 # Real Time Clock
@@ -571,6 +690,7 @@
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 # CONFIG_INOTIFY is not set
@@ -621,6 +741,18 @@
 # CONFIG_UFS_FS is not set
=20
 #
+# Network File Systems
+#
+# CONFIG_NFS_FS is not set
+# CONFIG_NFSD is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
 # Partition Types
 #
 # CONFIG_PARTITION_ADVANCED is not set
diff -Naur linux-omap-current/drivers/mmc/Kconfig linux-omap/drivers/mmc/Kc=
onfig
=2D-- linux-omap-current/drivers/mmc/Kconfig	2006-10-19 13:50:44.000000000 =
+0200
+++ linux-omap/drivers/mmc/Kconfig	2006-10-19 14:40:53.000000000 +0200
@@ -71,6 +71,16 @@
=20
 	  If unsure, say N.
=20
+config MMC_PALMTT
+	tristate "Palm Tungsten|T Multimedia Card Interface support"
+	depends on ARCH_OMAP && MMC
+	help
+	  This selects the Multimedia card Interface on Palm Tungsten|T.
+	  This driver works with MMC card in SPI mode connected to OMAP
+	  McBSP. If you have such PDA, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_WBSD
 	tristate "Winbond W83L51xD SD/MMC Card Interface support"
 	depends on MMC && ISA_DMA_API
diff -Naur linux-omap-current/drivers/mmc/Makefile linux-omap/drivers/mmc/M=
akefile
=2D-- linux-omap-current/drivers/mmc/Makefile	2006-10-19 13:50:44.000000000=
 +0200
+++ linux-omap/drivers/mmc/Makefile	2006-10-19 14:41:24.000000000 +0200
@@ -22,6 +22,7 @@
 obj-$(CONFIG_MMC_WBSD)		+=3D wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+=3D au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+=3D omap.o
+obj-$(CONFIG_MMC_PALMTT)	+=3D palmtt.o
 obj-$(CONFIG_MMC_AT91RM9200)	+=3D at91_mci.o
=20
 mmc_core-y :=3D mmc.o mmc_queue.o mmc_sysfs.o
diff -Naur linux-omap-current/drivers/mmc/palmtt.c linux-omap/drivers/mmc/p=
almtt.c
=2D-- linux-omap-current/drivers/mmc/palmtt.c	1970-01-01 01:00:00.000000000=
 +0100
+++ linux-omap/drivers/mmc/palmtt.c	2006-10-19 18:07:58.000000000 +0200
@@ -0,0 +1,1541 @@
+/*
+ *  linux/drivers/mmc/palmtt.c
+ *
+ *  Copyright (C) 2004 Nokia Corporation
+ *  Written by Tuukka Tikkanen and Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
+ *  Pin multiplexing and Innovator support by Tony Lindgren <tony@atomide.=
com>
+ *  Changes to make it work on PalmTT2 by Nikolay Petukhov
+ *  Changes to make it work on PalmTT by Marek Vasut <marek.vasut@gmail.co=
m>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/protocol.h>
+#include <linux/mmc/card.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/scatterlist.h>
+#include <asm/mach-types.h>
+
+#include <asm/arch/board.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/fpga.h>
+#include <asm/arch/tps65010.h>
+#include <asm/arch/menelaus.h>
+
+#include <asm/arch/mcbsp.h>
+
+#include <asm/arch/clock.h>
+
+#define DRIVER_NAME "mmci-palmtt"
+
+#undef PALMTT_CONFIG_MMC_DEBUG
+//#define PALMTT_CONFIG_MMC_DEBUG
+
+#ifdef PALMTT_CONFIG_MMC_DEBUG
+//#define DBG(x...)	printk(KERN_DEBUG x)
+#define DBG(x...)	printk(x)
+#else
+#define DBG(x...)	do { } while (0)
+#endif
+
+/* Specifies how often in millisecs to poll for card status changes
+ * when the cover switch is open */
+#define OMAP_MMC_SWITCH_POLL_DELAY     5000
+
+#define MYW 0
+#define MYR 1
+
+struct mmc_palmtt_host {
+	int                     initialized;
+	int			suspended;
+	struct mmc_request *	mrq;
+	struct mmc_command *	cmd;
+	struct mmc_data *	data;
+	struct mmc_host *	mmc;
+	struct device *		dev;
+	unsigned char		id;
+	struct clk *		clk;
+	u32			base;
+//	int irq;
+	unsigned char		bus_mode;
+	unsigned int		dma_len;
+#define OMAP_MMC_DATADIR_NONE	0
+#define OMAP_MMC_DATADIR_READ	1
+#define OMAP_MMC_DATADIR_WRITE	2
+	unsigned char		datadir;
+
+	int                     power_pin;
+	int			switch_pin;
+	struct work_struct	switch_work;
+	struct timer_list	switch_timer;
+	int			switch_last_state;
+	int                     cs_pin;
+
+	struct omap_mcbsp_spi_cfg spi_cfg;
+	long			io_base;
+
+	unsigned		use_dma;
+
+	int                     dma_ch_tx,dma_ch_rx;
+	unsigned char*		write_buffer;
+	unsigned char*		read_buffer;
+	dma_addr_t		p_dma_write;
+	dma_addr_t		p_dma_read;
+	struct completion       dma_completion;
+	struct completion       dma_completion_rx;
+
+	struct clk *		mcbsp_clk;
+	unsigned char*		buffer;
+	u32			bytesleft;
+	int			ocr;
+	int			cid[4];
+	int 			addr;
+	struct completion       pause;
+	unsigned char		bug;
+	unsigned char		tx_bug;
+	unsigned char		undef;
+};
+
+
+static void mmc_palmtt_cs(struct mmc_palmtt_host *host, int on)
+{
+	if (on) {
+	    omap_set_gpio_dataout(host->cs_pin, 1);
+	} else {
+	    omap_set_gpio_dataout(host->cs_pin, 0);
+	}
+}
+
+static void mmc_palmtt_power(struct mmc_palmtt_host *host, int on)
+{
+	if (on) {
+	    omap_set_gpio_dataout(host->power_pin, 0);
+	} else {
+	    omap_set_gpio_dataout(host->power_pin, 1);
+	}
+}
+
+static inline int
+mmc_palmtt_cover_is_open(struct mmc_palmtt_host *host)
+{
+        return omap_get_gpio_datain(host->switch_pin);
+//return 1;
+}
+
+static ssize_t
+mmc_palmtt_show_cover_switch(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct mmc_palmtt_host *host =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", mmc_palmtt_cover_is_open(host) ? "open" : "cl=
osed");
+}
+
+static DEVICE_ATTR(cover_switch, S_IRUGO, mmc_palmtt_show_cover_switch, NU=
LL);
+
+static irqreturn_t mmc_palmtt_switch_irq(int irq, void *dev_id, struct pt_=
regs *regs)
+{
+	struct mmc_palmtt_host *host =3D (struct mmc_palmtt_host *) dev_id;
+
+	DBG("MMC%d cover is now %s\n", host->id,
+	    mmc_palmtt_cover_is_open(host) ? "open" : "closed");
+	schedule_work(&host->switch_work);
+
+	return IRQ_HANDLED;
+}
+
+static void mmc_palmtt_switch_timer(unsigned long arg)
+{
+	struct mmc_palmtt_host *host =3D (struct mmc_palmtt_host *) arg;
+
+	schedule_work(&host->switch_work);
+}
+
+static void mmc_palmtt_switch_handler(void *data)
+{
+	struct mmc_palmtt_host *host =3D (struct mmc_palmtt_host *) data;
+	struct mmc_card *card;
+	static int complained =3D 0;
+	int cards =3D 0, cover_open;
+
+	//printk("MMC cover switch handler started\n");
+
+	cover_open =3D mmc_palmtt_cover_is_open(host);
+
+	if (cover_open !=3D host->switch_last_state) {
+		kobject_uevent(&host->dev->kobj, KOBJ_CHANGE);
+		host->switch_last_state =3D cover_open;
+
+		mmc_detect_change(host->mmc, 0);
+		list_for_each_entry(card, &host->mmc->cards, node) {
+		    if (mmc_card_present(card))
+			cards++;
+		}
+		DBG("MMC%d: %d card(s) present\n", host->id, cards);
+	}
+
+	if (mmc_palmtt_cover_is_open(host)) {
+		if (!complained) {
+			DBG(KERN_INFO "MMC%d: cover is open\n", host->id);
+			complained =3D 1;
+		}
+		mod_timer(&host->switch_timer,
+			  jiffies + OMAP_MMC_SWITCH_POLL_DELAY * HZ / 1000);
+		host->ocr=3D0;
+		host->addr=3D0;
+	} else {
+		complained =3D 0;
+	}
+}
+
+static inline int is_broken_card(struct mmc_card *card)
+{
+	int i;
+	struct mmc_cid *c =3D &card->cid;
+	static const struct broken_card_cid {
+		unsigned int manfid;
+		char prod_name[8];
+		unsigned char hwrev;
+		unsigned char fwrev;
+	} broken_cards[] =3D {
+		{ 0x00150000, "\x30\x30\x30\x30\x30\x30\x15\x00", 0x06, 0x03 },
+	};
+
+	for (i =3D 0; i < sizeof(broken_cards)/sizeof(broken_cards[0]); i++) {
+		const struct broken_card_cid *b =3D broken_cards + i;
+
+		if (b->manfid !=3D c->manfid)
+			continue;
+		if (memcmp(b->prod_name, c->prod_name, sizeof(b->prod_name)) !=3D 0)
+			continue;
+		if (b->hwrev !=3D c->hwrev || b->fwrev !=3D c->fwrev)
+			continue;
+		return 1;
+	}
+	return 0;
+}
+
+static void palmtt_dma_callback_tx(int lch, u16 ch_status, void *data)
+{
+	struct mmc_palmtt_host *host =3D (struct mmc_palmtt_host *) data;
+
+//	DBG("DMA callback TX: 0x%x\n", OMAP_MCBSP_READ(host->io_base, SPCR2));
+
+	/* FIXME: We ignore the possible errors for now. */
+	if (host->dma_ch_tx < 0) {
+		DBG("DMA TX callback while DMA not enabled?\n",
+		       host->id);
+		return;
+	}
+	omap_free_dma(host->dma_ch_tx);
+	host->dma_ch_tx =3D -1;
+
+	complete(&host->dma_completion);
+}
+
+static void palmtt_dma_callback_rx(int lch, u16 ch_status, void *data)
+{
+	struct mmc_palmtt_host *host =3D (struct mmc_palmtt_host *) data;
+        int dma_ch_rx;
+
+//	DBG("DMA callback RX: 0x%x\n", OMAP_MCBSP_READ(host->io_base, SPCR1));
+
+	/* FIXME: We ignore the possible errors for now. */
+	if (host->dma_ch_rx < 0) {
+		DBG("DMA RX callback while DMA not enabled?\n",
+		       host->id);
+		return;
+	}
+	dma_ch_rx =3D host->dma_ch_rx;
+	host->dma_ch_rx =3D -1;
+
+	omap_free_dma(dma_ch_rx);
+	complete(&host->dma_completion_rx);
+}
+
+
+int palmtt_dma_xmit(struct mmc_palmtt_host *host,  dma_addr_t buffer, unsi=
gned int length)
+{
+	int dma_ch_tx,ret;
+	short w;
+
+	if (host->bug)
+	    return 0;
+
+	w =3D OMAP_MCBSP_READ(host->io_base, SPCR2);
+	OMAP_MCBSP_WRITE(host->io_base, SPCR2, w & ~0x01);
+
+	if (omap_request_dma(OMAP_DMA_MCBSP2_TX, "McBSP TX", palmtt_dma_callback_=
tx, host, &dma_ch_tx)) {
+		printk("OMAP-McBSP: Unable to request DMA channel for McBSP2 TX. Trying =
IRQ based TX\n");
+		return -EAGAIN;
+	}
+
+//	DBG("TX DMA on channel %d\n", dma_ch_tx);
+
+	init_completion(&(host->dma_completion));
+
+	omap_set_dma_dest_params(dma_ch_tx,
+				 OMAP_DMA_PORT_TIPB,
+				 OMAP_DMA_AMODE_CONSTANT,
+				 host->io_base + OMAP_MCBSP_REG_DXR1, 0, 0);
+
+	omap_set_dma_src_params(dma_ch_tx,
+				OMAP_DMA_PORT_EMIFF,
+				OMAP_DMA_AMODE_POST_INC,
+				buffer, 0, 0);
+
+	omap_set_dma_transfer_params(dma_ch_tx,
+				     OMAP_DMA_DATA_TYPE_S8,
+				     length, 1,
+				     OMAP_DMA_SYNC_ELEMENT, 0, 0);
+
+
+	host->dma_ch_tx =3D dma_ch_tx;
+
+	w =3D OMAP_MCBSP_READ(host->io_base, SPCR2);
+	OMAP_MCBSP_WRITE(host->io_base, SPCR2, w | 0x1);
+
+	omap_start_dma(dma_ch_tx);
+
+	if ( (ret =3D wait_for_completion_timeout(&host->dma_completion,3))=3D=3D=
0 ) {
+	    if ( host->dma_ch_tx !=3D-1  ) {
+		printk("free\n");
+		omap_free_dma(dma_ch_tx);
+		host->dma_ch_tx =3D -1;
+	    printk("-----------DMA TX BUG-----------\n");
+	    }
+	    else
+		printk("******* DMA TX BUG **********\n");
+	    complete(&host->dma_completion);
+	    host->bug++;
+	}
+
+	return 0;
+}
+
+//int palmtt_recv_buffer(struct mmc_palmtt_host *host, unsigned char* buff=
er,unsigned char* dest_buffer, unsigned int length , unsigned char r)
+unsigned char* palmtt_dma_recv(struct mmc_palmtt_host *host, dma_addr_t bu=
ffer,dma_addr_t dest_buffer, unsigned int length , unsigned char r)
+{
+	int dma_ch_tx,dma_ch_rx,i,ret;
+	short w;
+
+        host->tx_bug=3D0;
+
+	if (host->bug)
+	    return 0;
+
+	w =3D OMAP_MCBSP_READ(host->io_base, SPCR2);
+	OMAP_MCBSP_WRITE(host->io_base, SPCR2, w & ~0x01);
+
+	if (r) {
+	for (i=3D0;i<length+1;i++) {
+	    host->write_buffer[i]=3D0xff;
+	    host->read_buffer[i]=3D0xa;
+	}
+	}
+
+	if (omap_request_dma(OMAP_DMA_MCBSP2_TX, "McBSP TX", palmtt_dma_callback_=
tx, host, &dma_ch_tx)) {
+		printk("OMAP-McBSP: Unable to request DMA channel for McBSP2 TX. Trying =
IRQ based TX\n");
+//		return -EAGAIN;
+		return 0;
+	}
+
+	omap_set_dma_dest_params(dma_ch_tx,
+				 OMAP_DMA_PORT_TIPB,
+				 OMAP_DMA_AMODE_CONSTANT,
+				 host->io_base + OMAP_MCBSP_REG_DXR1, 0, 0);
+
+	omap_set_dma_src_params(dma_ch_tx,
+				OMAP_DMA_PORT_EMIFF,
+				OMAP_DMA_AMODE_POST_INC,
+				buffer, 0, 0);
+
+	omap_set_dma_transfer_params(dma_ch_tx,
+				     OMAP_DMA_DATA_TYPE_S8,
+//				     OMAP_DMA_DATA_TYPE_S16,
+				     length, 1,
+				     OMAP_DMA_SYNC_ELEMENT, 0, 0);
+
+
+	if (omap_request_dma(OMAP_DMA_MCBSP2_RX, "McBSP RX", palmtt_dma_callback_=
rx, host, &dma_ch_rx)) {
+		printk("OMAP-McBSP: Unable to request DMA channel for McBSP2 RX. Trying =
IRQ based TX\n");
+		return 0;
+//		return -EAGAIN;
+	}
+
+	omap_set_dma_dest_params(dma_ch_rx,
+				 OMAP_DMA_PORT_EMIFF,
+				 OMAP_DMA_AMODE_POST_INC,
+				 dest_buffer, 0, 0);
+
+	omap_set_dma_src_params(dma_ch_rx,
+				OMAP_DMA_PORT_TIPB,
+				OMAP_DMA_AMODE_CONSTANT,
+				host->io_base + OMAP_MCBSP_REG_DRR1, 0, 0);
+
+	omap_set_dma_transfer_params(dma_ch_rx,
+				     OMAP_DMA_DATA_TYPE_S8,
+//				     OMAP_DMA_DATA_TYPE_S16,
+				     length, 1,
+				     OMAP_DMA_SYNC_ELEMENT, 0, 0);
+
+	init_completion(&(host->dma_completion));
+	init_completion(&(host->dma_completion_rx));
+
+	host->dma_ch_tx =3D dma_ch_tx;
+	host->dma_ch_rx =3D dma_ch_rx;
+
+	w =3D OMAP_MCBSP_READ(host->io_base, SPCR2);
+	OMAP_MCBSP_WRITE(host->io_base, SPCR2, w | 0x1);
+
+	OMAP_MCBSP_READ(host->io_base, DRR1);
+
+	omap_start_dma(dma_ch_rx);
+
+	omap_start_dma(dma_ch_tx);
+
+	if ( (ret =3D wait_for_completion_timeout(&host->dma_completion,3))=3D=3D=
0 ) {
+	    if ( host->dma_ch_tx !=3D-1  ) {
+		omap_free_dma(dma_ch_tx);
+		host->dma_ch_tx =3D -1;
+	    }
+	    else{
+	        host->tx_bug=3D1;
+	        init_completion(&host->pause);
+	        wait_for_completion_timeout(&host->pause,1);
+	        complete(&host->pause);
+	    }
+	}
+
+	if ( (ret =3D wait_for_completion_timeout(&host->dma_completion_rx,3))=3D=
=3D0 ) {
+	    omap_free_dma(dma_ch_rx);
+	    host->dma_ch_rx =3D -1;
+	    complete(&host->dma_completion_rx);
+	}
+=09
+	if(host->tx_bug)
+	    complete(&host->dma_completion);
+
+	if (host->bug)
+	    return 0;
+
+	return host->read_buffer;
+}
+
+
+int palmtt_irq_xmit(struct mmc_palmtt_host *host, unsigned int length) {
+    int i;
+    for (i=3D0;i<length;i++)
+	omap_mcbsp_xmit_word( 2, host->write_buffer[i]);
+
+    return 0;
+}
+unsigned char * palmtt_irq_recv(struct mmc_palmtt_host *host, unsigned int=
 length ) {
+    int i;
+
+    for (i=3D0;i<length;i++) {
+	omap_mcbsp_xmit_word( 2, host->write_buffer[i]);
+	host->read_buffer[i] =3D ((omap_mcbsp_recv_word( 2 ))&0x0f);
+    }
+
+    return host->read_buffer;
+}
+
+int palmtt_xmit(struct mmc_palmtt_host *host, unsigned int length) {
+    return palmtt_dma_recv(host, host->p_dma_write,  host->p_dma_read, len=
gth , MYW);
+//    return palmtt_dma_xmit(host, host->p_dma_write, length);
+}
+
+
+unsigned char * palmtt_recv(struct mmc_palmtt_host *host, unsigned int len=
gth) {
+    return palmtt_dma_recv(host, host->p_dma_write,  host->p_dma_read, len=
gth , MYR);
+}
+
+
+
+
+static int
+mmc_palmtt_response(struct mmc_palmtt_host *host, int length_xmit, int len=
gth_find,unsigned char find)
+{
+	int i;
+	int ret=3D-1;
+	char *buffer;
+
+	buffer =3D palmtt_recv(host, length_xmit);
+	if (!buffer)
+	    return -1;
+
+#ifdef __PALMTT_CONFIG_MMC_DEBUG
+	if (length_xmit <30) {
+	    printk("ans:");
+	    for (i=3D0; i<length_xmit; i++)
+		printk(" %x",buffer[i]);
+	    printk("\n");
+	}
+#endif
+
+	for (i=3D0;i<length_find;i++) {
+	    if ( buffer[i]=3D=3Dfind ) {
+#ifdef PALMTT_CONFIG_MMC_DEBUG
+		printk("FOUND %x at %i\n",find,i);
+#endif
+		ret=3Di;
+		break;
+	    }
+	}
+	if(ret=3D=3D-1) {
+#ifdef PALMTT_CONFIG_MMC_DEBUG
+		printk("%x NOT FOUND\n",find);
+#endif
+	}
+
+    return ret;
+}
+
+static int
+mmc_palmtt_load_data(struct mmc_palmtt_host *host, int length_xmit)
+{
+	char *buffer;
+
+	buffer =3D palmtt_recv(host, length_xmit);
+	if (!buffer)
+	    return -1;
+
+    return 0;
+}
+
+static int
+mmc_palmtt_read_ocr(struct mmc_palmtt_host *host, struct mmc_command *cmd)
+{
+    int i,ret=3D0;
+    mmc_palmtt_cs(host, 0);
+	=09
+    //cmd
+    host->write_buffer[0]=3D(58|0x40);
+//arg
+    host->write_buffer[1]=3D0x0;
+    host->write_buffer[2]=3D0x0;
+    host->write_buffer[3]=3D0x0;
+    host->write_buffer[4]=3D0x0;
+//crc
+    host->write_buffer[5]=3D0x95;
+
+    palmtt_xmit(host,6);
+
+    if ( (i=3Dmmc_palmtt_response(host, 7, 3, 0) )!=3D-1 ) {
+//	cmd->error =3D MMC_ERR_NONE;
+	ret =3D (host->read_buffer[i+3]) | (host->read_buffer[i+3])<<8 | (host->r=
ead_buffer[i+2])<<16 | (host->read_buffer[i+1])<<24;
+	return ret;
+    }
+
+    cmd->error =3D MMC_ERR_TIMEOUT;
+    ret=3D0;
+    return ret;
+}
+
+/*
+static void
+mmc_palmtt_crc_off(struct mmc_palmtt_host *host, struct mmc_command *cmd)
+{
+//    int i,ret=3D0;
+    mmc_palmtt_cs(host, 0);
+	=09
+    //cmd
+    host->dma_write[0]=3D(59|0x40);
+//arg
+    host->dma_write[1]=3D0x0;
+    host->dma_write[2]=3D0x0;
+    host->dma_write[3]=3D0x0;
+    host->dma_write[4]=3D0x0;
+//crc
+    host->dma_write[5]=3D0x95;
+
+    palmtt_xmit_buffer(host, host->p_dma_write, 6);
+
+    palmtt_recv_buffer(host, host->p_dma_write,host->p_dma_read, 1 , MYR);
+
+
+    if (host->dma_read[0]=3D=3D0)
+	cmd->error =3D MMC_ERR_NONE;
+    else
+	cmd->error =3D MMC_ERR_TIMEOUT;
+
+    return;
+   =20
+//    mmc_palmtt_cs(host, 1);
+
+}
+*/
+static void mmc_palmtt_prepare_data(struct mmc_palmtt_host *host, struct m=
mc_request *req)
+{
+	struct mmc_data *data =3D req->data;
+
+	host->data =3D data;
+	if (data =3D=3D NULL)
+		return;
+
+//	DBG("MMC%d: Data xfer (%s %s), DTO %d cycles + %d ns, %d blocks of %d b=
ytes\n",
+//	    host->id, (data->flags & MMC_DATA_STREAM) ? "stream" : "block",
+//	    (data->flags & MMC_DATA_WRITE) ? "write" : "read",
+//	    data->timeout_clks, data->timeout_ns, data->blocks,
+//	    1 << data->blksz_bits);
+
+	host->datadir =3D (data->flags & MMC_DATA_WRITE) ?
+		OMAP_MMC_DATADIR_WRITE : OMAP_MMC_DATADIR_READ;
+	host->dma_len =3D 0;
+
+	host->dma_len =3D dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+				   host->datadir);
+
+	/* No SG-DMA */
+	if (unlikely(host->dma_len > 1))
+		BUG();
+//	DBG("host->dma_len:%x data->sg_len:%x data->sg->length:%x\n",host->dma_=
len, data->sg_len, data->sg->length);
+=09
+	host->buffer =3D page_address(data->sg->page) + data->sg->offset;
+	host->bytesleft =3D data->blocks * (1 << data->blksz_bits);
+
+}
+
+static void
+mmc_palmtt_cmd_done(struct mmc_palmtt_host *host, struct mmc_command *cmd)
+{
+
+	if (cmd->flags & MMC_RSP_136) {
+		// response type 2=20
+		cmd->resp[3] =3D host->cid[3];
+		cmd->resp[2] =3D host->cid[2];
+		cmd->resp[1] =3D host->cid[1];
+		cmd->resp[0] =3D host->cid[0];
+		DBG("MMC%d: Response %08x %08x %08x %08x\n", host->id,
+		    cmd->resp[0], cmd->resp[1],
+		    cmd->resp[2], cmd->resp[3]);
+	}
+	else {
+
+		    if ( cmd->opcode =3D=3D MMC_SEND_OP_COND && cmd->error =3D=3D MMC_ER=
R_NONE ) {
+			cmd->resp[0] =3D mmc_palmtt_read_ocr(host, cmd);
+//			host->ocr=3Dcmd->resp[0];
+		    }
+		    else if ( cmd->error !=3D MMC_ERR_NONE )
+			cmd->resp[0]=3D0xffff;
+		    else=20
+			cmd->resp[0]=3D0;
+
+		    if ( cmd->opcode =3D=3D MMC_SEND_STATUS && cmd->error =3D=3D MMC_ERR=
_NONE )
+			cmd->resp[0] |=3D R1_READY_FOR_DATA;
+
+		DBG("MMC%d: Response %08x\n", host->id, cmd->resp[0]);
+	}
+
+	if (host->data) {
+	    host->datadir =3D OMAP_MMC_DATADIR_NONE;
+
+	    if (host->data->error =3D=3D MMC_ERR_NONE)
+		host->data->bytes_xfered +=3D host->data->blocks * (1<<host->data->blksz=
_bits);
+
+	    dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
+		     host->datadir);
+	    host->dma_len =3D 0;
+	    host->data =3D NULL;
+	}
+
+
+//	if ( !host->bug && (host->data->error =3D MMC_ERR_NONE) ) {
+		DBG("MMC%d: End request, err %x\n", host->id, cmd->error);
+		host->cmd =3D NULL;
+		host->mrq =3D NULL;
+		mmc_request_done(host->mmc, cmd->mrq);
+//	}
+
+}
+
+
+static int
+mmc_palmtt_analyze_response(char *buffer,int length_find,unsigned char fin=
d, char mask)
+{
+	int i;
+	int ret=3D-1;
+	for (i=3D0;i<length_find;i++) {
+	    if ( (buffer[i]&mask)=3D=3Dfind ) {
+#ifdef PALMTT_CONFIG_MMC_DEBUG
+		printk("FOUND %x at %i\n",find,i);
+#endif
+		ret=3Di;
+		break;
+	    }
+	}
+	if(ret=3D=3D-1) {
+#ifdef PALMTT_CONFIG_MMC_DEBUG
+		printk("%x NOT FOUND\n",find);
+#endif
+	}
+	return ret;
+}
+
+
+static void
+mmc_palmtt_command(struct mmc_palmtt_host *host,unsigned char cmd, unsigne=
d int arg)
+{
+	//cmd
+	host->write_buffer[0]=3D(cmd|0x40);
+=09
+	//arg
+	host->write_buffer[1]=3Darg>>24;
+	host->write_buffer[2]=3Darg>>16;
+	host->write_buffer[3]=3Darg>>8;
+	host->write_buffer[4]=3Darg;
+	//crc
+	host->write_buffer[5]=3D0x95;
+
+	palmtt_xmit(host, 6);
+}
+
+int
+mmc_palmtt_command_response(struct mmc_palmtt_host *host,unsigned char cmd=
, unsigned int arg, int length_find,unsigned char find)
+{
+	int ret=3D-1,i=3D0;
+
+	//cmd
+	host->write_buffer[0]=3D(cmd|0x40);
+=09
+	//arg
+	host->write_buffer[1]=3Darg>>24;
+	host->write_buffer[2]=3Darg>>16;
+	host->write_buffer[3]=3Darg>>8;
+	host->write_buffer[4]=3Darg;
+	//crc
+	host->write_buffer[5]=3D0x95;
+
+	for (i=3D0;i<length_find;i++)
+	    host->write_buffer[i+6]=3D0xff;
+
+	palmtt_xmit(host, 6 + length_find);
+//	if (!buffer)
+//	    return -1;
+
+#ifdef __PALMTT_CONFIG_MMC_DEBUG
+	if (length_find <30) {
+	    printk("ans:");
+	    for (i=3D0; i<length_find; i++)
+		printk(" %x",host->read_buffer[6+i]);
+	    printk("\n");
+	}
+#endif
+
+	for (i=3D0;i<length_find;i++) {
+	    if ( host->read_buffer[6+i]=3D=3Dfind ) {
+#ifdef PALMTT_CONFIG_MMC_DEBUG
+		printk("FOUND %x at %i\n",find,i);
+#endif
+		ret=3Di+6;
+		break;
+	    }
+	}
+	if(ret=3D=3D-1) {
+#ifdef PALMTT_CONFIG_MMC_DEBUG
+		printk("%x NOT FOUND\n",find);
+#endif
+	}
+
+    return ret;
+
+
+}
+
+
+static void
+mmc_palmtt_start_command(struct mmc_palmtt_host *host, struct mmc_command =
*cmd)
+{
+	int i,j;
+	int retry,ret;
+	unsigned int addr;
+	cmd->error =3D MMC_ERR_TIMEOUT;
+	host->cmd =3D cmd;
+
+omap_set_gpio_dataout(3,1);
+
+	switch (cmd->opcode) {
+
+//-------------CMD0---------------
+	    case MMC_GO_IDLE_STATE:
+		mmc_palmtt_cs(host, 1);
+		mmc_palmtt_power(host, 1);
+		host->addr=3D0;
+	=09
+		//80clks
+		for (i =3D 0; i < 10; i++)
+		    host->write_buffer[i]=3D0xff;
+
+		palmtt_xmit(host, 10);
+		mmc_palmtt_cs(host, 0);
+	=09
+		mmc_palmtt_command(host, cmd->opcode , cmd->arg);
+
+		for (i =3D 0; i < 15; i++) {
+
+		    if ( (ret=3Dmmc_palmtt_response(host, 2, 2, 1) )!=3D-1 ) {
+			cmd->error =3D MMC_ERR_NONE;
+			break;
+		    }
+		}
+
+//		mmc_palmtt_cs(host, 1);
+		break;
+
+
+//-------------CMD1---------------
+	    case MMC_SEND_OP_COND:
+
+		mmc_palmtt_cs(host, 0);
+	=09
+		retry=3D0;
+	=09
+		do {
+		   =20
+		    mmc_palmtt_command(host, cmd->opcode , cmd->arg);
+
+		    if ( (ret=3Dmmc_palmtt_response(host, 2, 2, 0) )!=3D-1 ) {
+			cmd->error =3D MMC_ERR_NONE;
+			retry=3D25;
+		    }
+		    retry++;
+
+		} while (retry<24);
+	=09
+//		if (cmd->error =3D=3D MMC_ERR_NONE)
+//		    mmc_palmtt_crc_off(host,cmd);
+
+//		mmc_palmtt_cs(host, 1);
+		break;//CMD1
+
+
+//-------------CMD2---------------
+	    case  MMC_ALL_SEND_CID: //CMD2 not support in SPI mode
+	    case  MMC_SEND_CID: //CMD10
+	    case  MMC_SEND_CSD: //CMD9
+
+		mmc_palmtt_cs(host, 0);
+	=09
+		if (cmd->opcode=3D=3DMMC_ALL_SEND_CID) {
+		    if (host->addr) {
+			DBG("Card add before\n");
+//			cmd->error =3D MMC_ERR_NONE;
+			host->undef=3D1;
+			break;
+		    }
+		    mmc_palmtt_command(host, MMC_SEND_CID , cmd->arg);
+		}
+		else
+		    mmc_palmtt_command(host, cmd->opcode , cmd->arg);
+
+
+		if ( (ret=3Dmmc_palmtt_response(host, 26, 2, 0) )!=3D-1 ) {
+	=09
+//			cmd->error =3D MMC_ERR_NONE;
+
+//		    i =3D mmc_palmtt_response(host, 23, 2, 0xfe);
+		    if (host->read_buffer[ret+1]=3D=3D0xfe)
+			i=3Dret+1;
+		    else if (host->read_buffer[ret+2]=3D=3D0xfe)
+			i=3Dret+2;
+		    else i=3D-1;
+//			i=3D6;
+//		    if (i=3D3)
+		    if (i>0) { //start single block
+		    //Why on my SD CARD CSD_STRUCTURE=3D=3D0=09
+		    if (cmd->opcode=3D=3DMMC_SEND_CSD)
+			host->read_buffer[i+1]|=3D0x8c;
+
+host->cid[0] =3D(host->read_buffer[i+1])<<24|(host->read_buffer[i+2])<<16|=
(host->read_buffer[i+3])<<8|(host->read_buffer[i+4]);
+host->cid[1] =3D(host->read_buffer[i+5])<<24|(host->read_buffer[i+6])<<16|=
(host->read_buffer[i+7])<<8|(host->read_buffer[i+8]);
+host->cid[2] =3D(host->read_buffer[i+9])<<24|(host->read_buffer[i+10])<<16=
|(host->read_buffer[i+11])<<8|(host->read_buffer[i+12]);
+host->cid[3] =3D(host->read_buffer[i+13])<<24|(host->read_buffer[i+14])<<1=
6|(host->read_buffer[i+15])<<8|(host->read_buffer[i+16]);
+
+			cmd->error =3D MMC_ERR_NONE;
+		    }
+		    break;
+		}
+		else {
+		    host->cid[0]=3D0;
+		    host->cid[1]=3D0;
+		    host->cid[2]=3D0;
+		    host->cid[3]=3D0;
+		}
+//		mmc_palmtt_cs(host, 1);
+		break;
+
+
+//-------------CMD3---------------
+	    case  MMC_SET_RELATIVE_ADDR:
+		cmd->error =3D MMC_ERR_NONE;
+		host->addr=3D(cmd->arg)>>16;
+		break;
+
+
+//-------------CMD7---------------
+	    case  MMC_SELECT_CARD:
+		if ( ( host->addr =3D=3D (cmd->arg)>>16 ) || ( (cmd->arg)>>16 ) =3D=3D 0=
 )
+		    cmd->error =3D MMC_ERR_NONE;
+
+		break;
+
+
+//-------------CMD13---------------
+	    case  MMC_SEND_STATUS:
+
+		mmc_palmtt_command(host, cmd->opcode , cmd->arg);
+
+		if ( (ret=3Dmmc_palmtt_response(host, 4, 4, 0) )!=3D-1 ) {
+		    if (host->read_buffer[ret+1]=3D=3D0)
+			cmd->error =3D MMC_ERR_NONE;
+		}
+
+		break;
+
+
+//-------------CMD16---------------
+	    case  MMC_SET_BLOCKLEN:
+/*
+		mmc_palmtt_command(host, cmd->opcode , cmd->arg);
+
+		    if ( (ret=3Dmmc_palmtt_response(host, 2, 2, 0) )!=3D-1 ) {
+			cmd->error =3D MMC_ERR_NONE;
+			break;
+		    }
+*/
+		ret =3D mmc_palmtt_command_response(host, cmd->opcode , cmd->arg, 2, 0);
+	=09
+		    if ( ret !=3D -1 ) {
+			cmd->error =3D MMC_ERR_NONE;
+			break;
+		    }
+
+		break;
+
+
+//-------------CMD17---------------
+	    case  MMC_READ_SINGLE_BLOCK:
+	   =20
+		host->data->error =3D MMC_ERR_TIMEOUT;
+	=09
+		    addr=3Dcmd->arg;
+		   =20
+		    cmd->error =3D MMC_ERR_TIMEOUT;
+
+		    ret =3D mmc_palmtt_command_response(host, MMC_READ_SINGLE_BLOCK, add=
r, 10, 0);
+	=09
+			if ( ret =3D=3D -1 ) {
+			    DBG("ans:%x %x %x %x %x %x %x %x %x %x\n",
+			    host->read_buffer[5], host->read_buffer[6],host->read_buffer[7],hos=
t->read_buffer[8],host->read_buffer[9],
+			    host->read_buffer[10], host->read_buffer[11],host->read_buffer[12],=
host->read_buffer[13],host->read_buffer[14]);
+			    break;
+			}
+		=09
+		    cmd->error =3D MMC_ERR_NONE;
+
+		for (j=3D0;j<host->data->blocks;j++) {
+		    //before read block data, need wait 1ms
+		    init_completion(&host->pause);
+		    wait_for_completion_timeout(&host->pause,1);
+		    complete(&host->pause);
+		    do {
+			mmc_palmtt_load_data(host, 1);
+		    } while (host->read_buffer[0]!=3D0xfe);
+		    mmc_palmtt_load_data(host, 514);
+		    memcpy(host->buffer+512*j,&(host->read_buffer[0]), 512); //?512
+
+		}//for (j=3D0;j<host->data->blocks;j++)
+		=09
+		    if (host->data->error =3D=3D MMC_ERR_TIMEOUT)
+			DBG("ans:%x %x %x %x ... %x %x %x %x\n",
+			host->read_buffer[0], host->read_buffer[1], host->read_buffer[2], host-=
>read_buffer[3],
+			host->read_buffer[511], host->read_buffer[512],host->read_buffer[513],h=
ost->read_buffer[514]);
+
+
+		break;
+
+//-------------CMD18---------------
+	    case  MMC_READ_MULTIPLE_BLOCK:
+	   =20
+		host->data->error =3D MMC_ERR_TIMEOUT;
+		addr=3Dcmd->arg;
+
+//		printk("CMD18:%d blocks\n",host->data->blocks);
+
+		ret =3D mmc_palmtt_command_response(host, MMC_READ_MULTIPLE_BLOCK, cmd->=
arg, 10, 0);
+	=09
+		cmd->error =3D MMC_ERR_TIMEOUT;
+		if ( ret =3D=3D -1 ) {
+		    printk("CMD18 ans:%x %x %x %x %x %x %x %x %x %x\n",
+		    host->read_buffer[5], host->read_buffer[6],host->read_buffer[7],host=
=2D>read_buffer[8],host->read_buffer[9],
+		    host->read_buffer[10], host->read_buffer[11],host->read_buffer[12],h=
ost->read_buffer[13],host->read_buffer[14]);
+		    break;
+		}
+
+		cmd->error =3D MMC_ERR_NONE;
+
+		    //before read block data, need wait 1ms
+		    init_completion(&host->pause);
+		    wait_for_completion_timeout(&host->pause,1);
+		    complete(&host->pause);
+
+		for (j=3D0;j<host->data->blocks;j++) {
+		    do {
+			mmc_palmtt_load_data(host, 1);
+		    } while (host->read_buffer[0]!=3D0xfe);
+		    mmc_palmtt_load_data(host, 514);
+		    memcpy(host->buffer+512*j,&(host->read_buffer[0]), 512); //?512
+
+		}//for (j=3D0;j<host->data->blocks;j++)
+
+		host->data->error =3D MMC_ERR_NONE;
+
+		ret =3D mmc_palmtt_command_response(host, MMC_STOP_TRANSMISSION, 0, 10, =
0);
+	=09
+		if ( ret =3D=3D -1 ) {
+		    DBG("STOP ans:%x %x %x %x %x %x %x %x %x %x\n",
+		    host->read_buffer[5], host->read_buffer[6],host->read_buffer[7],host=
=2D>read_buffer[8],host->read_buffer[9],
+		    host->read_buffer[10], host->read_buffer[11],host->read_buffer[12],h=
ost->read_buffer[13],host->read_buffer[14]);
+		    cmd->error =3D MMC_ERR_TIMEOUT;
+		    break;
+		}
+
+		break;
+
+//-------------CMD24---------------
+	    case  MMC_WRITE_BLOCK:
+//	    	printk("*****************WRITING****************\n");
+		host->data->error =3D MMC_ERR_TIMEOUT;
+		host->data->flags =3D MMC_DATA_WRITE;	=09
+		addr=3Dcmd->arg;
+		   =20
+
+		cmd->error =3D MMC_ERR_TIMEOUT;
+
+		ret =3D mmc_palmtt_command_response(host, MMC_WRITE_BLOCK, addr, 8, 0);
+
+	=09
+		if ( ret =3D=3D -1 ) {
+			break;
+			}
+	ret=3Dmmc_palmtt_analyze_response(&(host->read_buffer[6]), 7, 0, (char)0x=
ff);
+	if (ret>-1)
+	{
+		do
+		{
+			for (i=3D0;i<8;i++)
+			    host->write_buffer[i]=3D0xff;
+			palmtt_xmit(host, 8 );
+			ret=3Dmmc_palmtt_analyze_response(host->read_buffer, 8, 0, (char)0xff);
+		}
+		while (ret>-1);
+	}
+
+		=09
+		cmd->error =3D MMC_ERR_NONE;
+
+
+		//before write block data, need wait 1ms (?) (shameless cut and paste :-=
) gw)
+		init_completion(&host->pause);
+		wait_for_completion_timeout(&host->pause,1);
+		complete(&host->pause);
+
+		ret=3D-1;
+		i=3D0;
+
+		//start block token
+		host->write_buffer[0]=3D(0xfe);
+=09
+
+		memcpy(&(host->write_buffer[1]),host->buffer, 512); //?512
+		//crc
+		host->write_buffer[513]=3D0x0a;
+		host->write_buffer[514]=3D0xa0;
+
+		for (i=3D515;i<525;i++)
+		    host->write_buffer[i]=3D0xff;
+
+		palmtt_xmit(host, 530 );
+
+
+	    cmd->error =3D MMC_ERR_TIMEOUT;
+
+
+	ret=3Dmmc_palmtt_analyze_response(&(host->read_buffer[515]), 10, 0x05, (c=
har)0x1f);
+	if (ret>-1)
+	{
+		host->data->error =3D MMC_ERR_NONE;
+		cmd->error =3D MMC_ERR_NONE;
+		do
+		{
+			for (i=3D0;i<8;i++)
+			    host->write_buffer[i]=3D0xff;
+			palmtt_xmit(host, 8 );
+			ret=3Dmmc_palmtt_analyze_response(host->read_buffer, 8, 0, (char)0xff);
+		}
+		while (ret>-1);
+	}
+
+//		host->data->error =3D MMC_ERR_NONE;
+//		cmd->error =3D MMC_ERR_NONE;
+
+		init_completion(&host->pause);
+		wait_for_completion_timeout(&host->pause,1);
+		complete(&host->pause);
+
+
+	break;
+
+//-------------ACMD41---------------
+	case SD_APP_OP_COND:
+		ret =3D mmc_palmtt_command_response(host, cmd->opcode , cmd->arg, 8, 0);
+	=09
+		if ( ret !=3D -1 )
+		{
+			cmd->resp[0] =3D mmc_palmtt_read_ocr(host, cmd);
+
+			cmd->error =3D MMC_ERR_NONE;
+			host->data->error =3D MMC_ERR_NONE;
+		}
+
+
+cmd->resp[0] =3D mmc_palmtt_read_ocr(host, cmd);
+	break;
+
+//-------------CMD55---------------
+	case MMC_APP_CMD:
+		ret =3D mmc_palmtt_command_response(host, cmd->opcode , cmd->arg, 8, 0);
+	=09
+		if ( ret !=3D -1 )
+		{
+			cmd->error =3D MMC_ERR_NONE;
+			host->data->error =3D MMC_ERR_NONE;
+		}
+
+	break;
+
+	    default :
+		printk("--------------- Undefine CMD%d------------------\n",cmd->opcode);
+		host->undef=3D1;
+		break;
+
+	}
+
+omap_set_gpio_dataout(3,0);
+
+}
+
+static void mmc_palmtt_request(struct mmc_host *mmc, struct mmc_request *r=
eq)
+{
+	struct mmc_palmtt_host *host =3D mmc_priv(mmc);
+	int i;
+
+	WARN_ON(host->mrq !=3D NULL);
+
+	host->mrq =3D req;
+
+	// Some cards (vendor left unnamed to protect the guilty) seem to
+	// require this delay after power-up. Otherwise we'll get mysterious
+	// data timeouts.=20
+
+	if (req->cmd->opcode =3D=3D MMC_SEND_CSD) {
+		struct mmc_card *card;
+		int broken_present =3D 0;
+
+		list_for_each_entry(card, &mmc->cards, node) {
+			if (is_broken_card(card)) {
+				broken_present =3D 1;
+				break;
+			}
+		}
+		if (broken_present) {
+			static int complained =3D 0;
+
+			if (!complained) {
+				printk(KERN_WARNING "MMC%d: Broken card workaround enabled\n",
+				       host->id);
+				complained =3D 1;
+			}
+			if (in_interrupt()) {
+				// This is nasty=20
+				 printk(KERN_ERR "Sleeping in IRQ handler, FIXME please!\n");
+				 dump_stack();
+				 mdelay(100);
+			} else {
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout(100 * HZ / 1000);
+			}
+		}
+	}
+
+	//ignore errors
+	for (i=3D0;i<5;i++) {
+	   =20
+	    host->bug=3D0;
+	    host->undef=3D0;
+	   =20
+	    mmc_palmtt_prepare_data(host, req);
+	    mmc_palmtt_start_command(host, req->cmd);
+	   =20
+		if ( ( !host->bug && (host->cmd->error =3D=3D MMC_ERR_NONE) ) || host->u=
ndef )
+		    break;
+	   =20
+	    DBG("-----------restart command:%d-----------\n", i);
+	}
+
+	mmc_palmtt_cmd_done(host, req->cmd);
+
+}
+
+static void mmc_palmtt_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct mmc_palmtt_host *host =3D mmc_priv(mmc);
+	int dsor;
+	int realclock;
+	unsigned int mcbsp_clk=3Dclk_get_rate(host->mcbsp_clk);
+
+
+	if (ios->power_mode =3D=3D MMC_POWER_UP && ios->clock < 400000) {
+		/* Fix for broken stack */
+		realclock =3D 400000;
+	} else {
+		realclock =3D ios->clock;
+	}
+
+	if (ios->clock =3D=3D 0) {
+		dsor =3D 1;
+	} else {
+		dsor =3D mcbsp_clk / realclock;
+		if (dsor < 1)
+			dsor =3D 1;
+
+		if (mcbsp_clk / dsor > realclock)
+			dsor++;
+
+		if (dsor > 250)
+			dsor =3D 250;
+	}
+
+	DBG("MMC%d: set_ios: clock %dHz busmode %d powermode %d Vdd %d.%02d\n",
+	    host->id, mcbsp_clk / dsor, ios->bus_mode, ios->power_mode,
+	    ios->vdd / 100, ios->vdd % 100);
+
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		mmc_palmtt_power(host, 0);
+		mmc_palmtt_cs(host, 1);
+		break;
+	case MMC_POWER_ON:
+	case MMC_POWER_UP:
+		mmc_palmtt_power(host, 1);
+		dsor |=3D 1<<11;
+		break;
+	}
+
+	host->bus_mode =3D ios->bus_mode;
+
+	host->spi_cfg.clk_div=3Ddsor;
+
+	omap_mcbsp_stop(OMAP_MCBSP2);
+	omap_mcbsp_set_spi_mode(OMAP_MCBSP2, &host->spi_cfg);
+	omap_mcbsp_start(OMAP_MCBSP2);
+
+}
+
+
+static struct mmc_host_ops mmc_palmtt_ops =3D {
+	.request	=3D mmc_palmtt_request,
+	.set_ios	=3D mmc_palmtt_set_ios,
+};
+
+static int mmc_palmtt_probe(struct device *dev)
+{
+	struct mmc_host *mmc;
+	struct mmc_palmtt_host *host =3D NULL;
+	int ret =3D 0;
+
+omap_set_gpio_direction(3,0);
+
+	DBG("mmc_palmtt_probe\n");
+	mmc =3D mmc_alloc_host(sizeof(struct mmc_palmtt_host), dev);
+	if (!mmc) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	host =3D mmc_priv(mmc);
+	host->mmc =3D mmc;
+
+	host->power_pin =3D OMAP_GPIO_IRQ(9);
+	host->switch_pin =3D OMAP_MPUIO(12);
+	host->cs_pin =3D OMAP_MPUIO(6);
+	host->id =3D 1;
+
+	host->use_dma=3D1;
+	host->write_buffer =3D dma_alloc_coherent(NULL,1024,&host->p_dma_write,
+                                GFP_KERNEL | GFP_DMA);
+	if (!host->write_buffer) {
+		printk(KERN_ERR "MMC: Unable to get dma write buffer\n");
+		goto out;
+	}
+
+	host->read_buffer =3D dma_alloc_coherent(NULL,1024,&host->p_dma_read,
+                                GFP_KERNEL | GFP_DMA);
+	if (!host->read_buffer) {
+		printk(KERN_ERR "MMC: Unable to get dma read buffer\n");
+		goto out;
+	}
+
+	mmc->ops =3D &mmc_palmtt_ops;
+	mmc->f_min =3D 400000;
+	mmc->f_max =3D 25000000;
+//	mmc->f_max =3D 10000000;
+	mmc->ocr_avail =3D MMC_VDD_33_34;
+	host->ocr=3D0;
+	host->addr=3D0;
+
+	/* No SG-DMA */
+	mmc->max_phys_segs =3D 1;
+	mmc->max_seg_size =3D PAGE_SIZE;
+
+	omap_mcbsp_set_io_type(OMAP_MCBSP2, OMAP_MCBSP_POLL_IO); // OMAP_MCBSP_IR=
Q_IO
+
+	if ((ret =3D omap_mcbsp_request(OMAP_MCBSP2)) !=3D 0) {
+		printk(KERN_ERR "MMC%d: Unable to get McBSP2\n",
+		       host->id);
+		goto out;
+	}
+    	host->spi_cfg.spi_mode=3DOMAP_MCBSP_SPI_MASTER;
+	host->spi_cfg.rx_clock_polarity=3DOMAP_MCBSP_CLK_FALLING;
+    	host->spi_cfg.tx_clock_polarity=3DOMAP_MCBSP_CLK_FALLING;
+	host->spi_cfg.fsx_polarity=3DOMAP_MCBSP_FS_ACTIVE_LOW;
+	host->spi_cfg.clk_stp_mode=3DOMAP_MCBSP_CLK_STP_MODE_NO_DELAY;
+	host->spi_cfg.clk_div=3D0x45;
+	host->spi_cfg.word_length=3DOMAP_MCBSP_WORD_8;
+	host->io_base=3Dio_p2v(OMAP1510_MCBSP2_BASE);
+
+	omap_mcbsp_stop(OMAP_MCBSP2);
+
+	omap_mcbsp_set_spi_mode(OMAP_MCBSP2, &host->spi_cfg);
+
+//	w =3D OMAP_MCBSP_READ(host->io_base, SPCR2);
+//	OMAP_MCBSP_WRITE(host->io_base, SPCR2, w | 1<<9);
+
+//	w =3D OMAP_MCBSP_READ(host->io_base, SPCR1);
+//	OMAP_MCBSP_WRITE(host->io_base, SPCR1, w | 1<<15);
+
+	omap_mcbsp_start(OMAP_MCBSP2);
+
+	//hm ;-)
+//	OMAP_MCBSP_WRITE(host->io_base, DXR1,0xff);
+
+	host->mcbsp_clk =3D clk_get(0, "api_ck");
+	if (IS_ERR(host->mcbsp_clk)) {
+		printk(KERN_ERR "MMC%d: could not acquire api_ck\n",  host->id);
+		omap_mcbsp_free(OMAP_MCBSP2);
+		goto out;
+	}
+	else
+	    printk("MMC%d: clock:%ld\n", host->id, clk_get_rate(host->mcbsp_clk));
+
+	if ((ret =3D omap_request_gpio(host->power_pin)) !=3D 0) {
+		printk(KERN_ERR "MMC%d: Unable to get GPIO pin for MMC power\n",
+		       host->id);
+		omap_mcbsp_free(OMAP_MCBSP2);
+		goto out;
+	}
+	omap_set_gpio_direction(host->power_pin, 0);
+
+	if ((ret =3D omap_request_gpio(host->cs_pin)) !=3D 0) {
+		printk(KERN_ERR "MMC%d: Unable to get GPIO pin for MMC CS\n",
+		       host->id);
+		omap_free_gpio(host->power_pin);
+		omap_mcbsp_free(OMAP_MCBSP2);
+		goto out;
+	}
+	omap_set_gpio_direction(host->cs_pin, 0);
+
+	host->dev =3D dev;
+	dev_set_drvdata(dev, host);
+
+
+	INIT_WORK(&host->switch_work, mmc_palmtt_switch_handler, host);
+	init_timer(&host->switch_timer);
+	host->switch_timer.function =3D mmc_palmtt_switch_timer;
+	host->switch_timer.data =3D (unsigned long) host;
+
+	if (omap_request_gpio(host->switch_pin) !=3D 0) {
+		printk(KERN_WARNING "MMC%d: Unable to get GPIO pin for MMC cover switch\=
n",
+		       host->id);
+		host->switch_pin =3D -1;
+		omap_free_gpio(host->power_pin);
+		omap_free_gpio(host->cs_pin);
+		omap_mcbsp_free(OMAP_MCBSP2);
+		goto out;
+	}
+
+	omap_set_gpio_direction(host->switch_pin, 1);
+//	omap_set_gpio_edge_ctrl(host->switch_pin, OMAP_GPIO_FALLING_EDGE);
+//	set_irq_type(host->switch_pin, IRQT_FALLING);
+	set_irq_type(host->switch_pin, IRQ_TYPE_EDGE_RISING);
+	ret =3D request_irq(OMAP_GPIO_IRQ(host->switch_pin),
+				  mmc_palmtt_switch_irq, 0, DRIVER_NAME, host);
+
+	if (ret) {
+	    printk(KERN_WARNING "MMC%d: Unable to get IRQ for MMC cover switch\n",
+	           host->id);
+	    omap_free_gpio(host->power_pin);
+	    omap_free_gpio(host->cs_pin);
+	    omap_free_gpio(host->switch_pin);
+	    omap_mcbsp_free(OMAP_MCBSP2);
+	    host->switch_pin =3D -1;
+	    goto out;
+	}
+=09
+	if (device_create_file(dev, &dev_attr_cover_switch) < 0) {
+	    printk(KERN_WARNING "MMC%d: Unable to create sysfs attribute for cove=
r switch\n",=20
+	           host->id);
+	    free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
+	    omap_free_gpio(host->switch_pin);
+	    omap_free_gpio(host->power_pin);
+	    omap_free_gpio(host->cs_pin);
+	    omap_mcbsp_free(OMAP_MCBSP2);
+	    host->switch_pin =3D -1;
+	    goto out;
+	}
+
+	mmc_add_host(mmc);
+
+	if (mmc_palmtt_cover_is_open(host))
+	    schedule_work(&host->switch_work);
+
+	DBG("mmc_palmtt_probe exit\n");
+
+	return 0;
+out:
+	if (host) {
+
+		if (host->write_buffer)
+		    dma_free_coherent(NULL,1024,(void *) host->write_buffer, host->p_dma=
_write);
+		if (host->read_buffer)
+		    dma_free_coherent(NULL,1024,(void *) host->read_buffer, host->p_dma_=
read);
+
+		kfree(host);
+	}
+	return ret;
+}
+
+
+static int mmc_palmtt_remove(struct device *dev)
+{
+	struct mmc_palmtt_host *host =3D dev_get_drvdata(dev);
+
+	dev_set_drvdata(dev, NULL);
+
+	if (host) {
+
+		del_timer_sync(&host->switch_timer);
+		flush_scheduled_work();
+
+		mmc_remove_host(host->mmc);
+
+		omap_mcbsp_free(OMAP_MCBSP2);
+
+		mmc_palmtt_power(host, 0);
+		=09
+		omap_free_gpio(host->power_pin);
+		omap_free_gpio(host->cs_pin);
+
+		free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
+		omap_free_gpio(host->switch_pin);
+
+		host->switch_pin =3D -1;
+
+		if (host->write_buffer)
+		    dma_free_coherent(NULL,1024,(void *) host->write_buffer, host->p_dma=
_write);
+		if (host->read_buffer)
+		    dma_free_coherent(NULL,1024,(void *) host->read_buffer, host->p_dma_=
read);
+		kfree(host);
+	}
+
+	return 0;
+}
+
+
+#define mmc_palmtt_suspend	NULL
+#define mmc_palmtt_resume	NULL
+
+static void palmtt_release(struct device *dev)
+{
+	/* Nothing to release? */
+}
+
+static struct platform_device mmc_palmtt_device =3D {
+	.name		=3D DRIVER_NAME,
+	.id			=3D 1,
+	.dev		=3D {
+		.release =3D palmtt_release,
+	},
+};
+
+static struct device_driver mmc_palmtt_driver =3D {
+	.name		=3D "mmci-palmtt",
+	.bus		=3D &platform_bus_type,
+	.probe		=3D mmc_palmtt_probe,
+	.remove		=3D mmc_palmtt_remove,
+	.suspend	=3D mmc_palmtt_suspend,
+	.resume		=3D mmc_palmtt_resume,
+};
+
+
+static int __init mmc_palmtt_init(void)
+{
+	int ret;
+	DBG("mmc_palmtt_init\n");
+
+	ret =3D driver_register(&mmc_palmtt_driver);
+	if (ret !=3D 0)
+		return -ENODEV;
+
+	ret =3D platform_device_register(&mmc_palmtt_device);
+	if (ret =3D=3D 0)
+		return 0;
+
+	    return -ENODEV;
+
+}
+
+static void __exit mmc_palmtt_exit(void)
+{
+	DBG("mmc_palmtt_exit\n");
+	platform_device_unregister(&mmc_palmtt_device);
+=09
+	driver_unregister(&mmc_palmtt_driver);
+}
+
+module_init(mmc_palmtt_init);
+module_exit(mmc_palmtt_exit);
+
+MODULE_DESCRIPTION("PalmTT MMC driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("marek.vasut@gmail.com");

--Boundary-00=_qe6NFQhx83Q8fMx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_qe6NFQhx83Q8fMx--
