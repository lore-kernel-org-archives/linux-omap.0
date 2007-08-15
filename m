From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/8] musb_hdrc: Search and replace MGC_XXX_OFFSET with
	MUSB_XXX_OFFSET
Date: Wed, 15 Aug 2007 07:21:43 -0700
Message-ID: <11871877241489-git-send-email-tony@atomide.com>
References: <11871877051923-git-send-email-tony@atomide.com>
	<11871877071348-git-send-email-tony@atomide.com>
	<1187187711983-git-send-email-tony@atomide.com>
	<1187187715940-git-send-email-tony@atomide.com>
	<11871877193281-git-send-email-tony@atomide.com>
	<11871877214142-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11871877214142-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace MGC_XXX_OFFSET with MUSB_XXX_OFFSET

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c   |    6 +++---
 drivers/usb/musb/musb_procfs.c |   12 ++++++------
 drivers/usb/musb/musbdefs.h    |    6 +++---
 drivers/usb/musb/musbhdrc.h    |    8 ++++----
 drivers/usb/musb/plat_uds.c    |    2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index ea6db02..99e3dce 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -722,13 +722,13 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		/* target addr and (for multipoint) hub addr/port */
 		if (musb->is_multipoint) {
 			musb_writeb(mbase,
-				MGC_BUSCTL_OFFSET(epnum, MUSB_TXFUNCADDR),
+				MUSB_BUSCTL_OFFSET(epnum, MUSB_TXFUNCADDR),
 				qh->addr_reg);
 			musb_writeb(mbase,
-				MGC_BUSCTL_OFFSET(epnum, MUSB_TXHUBADDR),
+				MUSB_BUSCTL_OFFSET(epnum, MUSB_TXHUBADDR),
 				qh->h_addr_reg);
 			musb_writeb(mbase,
-				MGC_BUSCTL_OFFSET(epnum, MUSB_TXHUBPORT),
+				MUSB_BUSCTL_OFFSET(epnum, MUSB_TXHUBPORT),
 				qh->h_port_reg);
 /* FIXME if !epnum, do the same for RX ... */
 		} else
diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index 1dbacf4..dc77420 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -285,13 +285,13 @@ dump_end_info(struct musb *musb, u8 epnum, char *aBuffer, unsigned max)
 					musb_readb(regs, MUSB_RXTYPE),
 					/* FIXME:  assumes multipoint */
 					musb_readb(musb->mregs,
-						MGC_BUSCTL_OFFSET(epnum,
+						MUSB_BUSCTL_OFFSET(epnum,
 						MUSB_RXFUNCADDR)),
 					musb_readb(musb->mregs,
-						MGC_BUSCTL_OFFSET(epnum,
+						MUSB_BUSCTL_OFFSET(epnum,
 						MUSB_RXHUBADDR)),
 					musb_readb(musb->mregs,
-						MGC_BUSCTL_OFFSET(epnum,
+						MUSB_BUSCTL_OFFSET(epnum,
 						MUSB_RXHUBPORT))
 					);
 				if (code <= 0)
@@ -373,13 +373,13 @@ dump_end_info(struct musb *musb, u8 epnum, char *aBuffer, unsigned max)
 					musb_readb(regs, MUSB_TXTYPE),
 					/* FIXME:  assumes multipoint */
 					musb_readb(musb->mregs,
-						MGC_BUSCTL_OFFSET(epnum,
+						MUSB_BUSCTL_OFFSET(epnum,
 						MUSB_TXFUNCADDR)),
 					musb_readb(musb->mregs,
-						MGC_BUSCTL_OFFSET(epnum,
+						MUSB_BUSCTL_OFFSET(epnum,
 						MUSB_TXHUBADDR)),
 					musb_readb(musb->mregs,
-						MGC_BUSCTL_OFFSET(epnum,
+						MUSB_BUSCTL_OFFSET(epnum,
 						MUSB_TXHUBPORT))
 					);
 				if (code <= 0)
diff --git a/drivers/usb/musb/musbdefs.h b/drivers/usb/musb/musbdefs.h
index 5ce0505..eb09ea2 100644
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -220,18 +220,18 @@ enum musb_g_ep0_state {
 #if	defined(CONFIG_USB_TUSB6010)
 #define musb_ep_select(_mbase, _epnum) \
 	musb_writeb((_mbase), MUSB_INDEX, (_epnum))
-#define	MGC_END_OFFSET			MGC_TUSB_OFFSET
+#define	MGC_END_OFFSET			MUSB_TUSB_OFFSET
 
 /* "flat" mapping: each endpoint has its own i/o address */
 #elif	defined(MUSB_FLAT_REG)
 #define musb_ep_select(_mbase, _epnum)	(((void)(_mbase)),((void)(_epnum)))
-#define	MGC_END_OFFSET			MGC_FLAT_OFFSET
+#define	MGC_END_OFFSET			MUSB_FLAT_OFFSET
 
 /* "indexed" mapping: INDEX register controls register bank select */
 #else
 #define musb_ep_select(_mbase, _epnum) \
 	musb_writeb((_mbase), MUSB_INDEX, (_epnum))
-#define	MGC_END_OFFSET			MGC_INDEXED_OFFSET
+#define	MGC_END_OFFSET			MUSB_INDEXED_OFFSET
 #endif
 
 /****************************** FUNCTIONS ********************************/
diff --git a/drivers/usb/musb/musbhdrc.h b/drivers/usb/musb/musbhdrc.h
index c862e65..9646bb6 100644
--- a/drivers/usb/musb/musbhdrc.h
+++ b/drivers/usb/musb/musbhdrc.h
@@ -105,16 +105,16 @@
 #define MUSB_CONFIGDATA	MUSB_FIFOSIZE	/* re-used for EP0 */
 
 /* offsets to endpoint registers in indexed model (using INDEX register) */
-#define MGC_INDEXED_OFFSET(_epnum, _offset)	\
+#define MUSB_INDEXED_OFFSET(_epnum, _offset)	\
 	(0x10                   + (_offset))
 
 /* offsets to endpoint registers in flat models */
-#define MGC_FLAT_OFFSET(_epnum, _offset)	\
+#define MUSB_FLAT_OFFSET(_epnum, _offset)	\
 	(0x100 + (0x10*(_epnum)) + (_offset))
 
 #ifdef CONFIG_USB_TUSB6010
 /* TUSB6010 EP0 configuration register is special */
-#define MGC_TUSB_OFFSET(_epnum, _offset)	\
+#define MUSB_TUSB_OFFSET(_epnum, _offset)	\
 	(0x10 + _offset)
 #include "tusb6010.h"		/* needed "only" for TUSB_EP0_CONF */
 #endif
@@ -128,7 +128,7 @@
 #define MUSB_RXHUBADDR	0x06
 #define MUSB_RXHUBPORT	0x07
 
-#define MGC_BUSCTL_OFFSET(_epnum, _offset) \
+#define MUSB_BUSCTL_OFFSET(_epnum, _offset) \
 	(0x80 + (8*(_epnum)) + (_offset))
 
 /*
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 71e89d8..348c246 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1380,7 +1380,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 
 		hw_ep->regs = MGC_END_OFFSET(i, 0) + mbase;
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
-		hw_ep->target_regs = MGC_BUSCTL_OFFSET(i, 0) + mbase;
+		hw_ep->target_regs = MUSB_BUSCTL_OFFSET(i, 0) + mbase;
 		hw_ep->rx_reinit = 1;
 		hw_ep->tx_reinit = 1;
 #endif
-- 
1.5.2.3
