From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 31/36] musb_hdrc: Search and replace wType with musb_type
Date: Thu, 16 Aug 2007 02:40:54 -0700
Message-ID: <118725733255-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
	<11872572803477-git-send-email-tony@atomide.com>
	<1187257282941-git-send-email-tony@atomide.com>
	<11872572842479-git-send-email-tony@atomide.com>
	<11872572872790-git-send-email-tony@atomide.com>
	<11872572893163-git-send-email-tony@atomide.com>
	<1187257291525-git-send-email-tony@atomide.com>
	<1187257294890-git-send-email-tony@atomide.com>
	<11872572962771-git-send-email-tony@atomide.com>
	<11872572981150-git-send-email-tony@atomide.com>
	<1187257301587-git-send-email-tony@atomide.com>
	<1187257303715-git-send-email-tony@atomide.com>
	<11872573062287-git-send-email-tony@atomide.com>
	<11872573092269-git-send-email-tony@atomide.com>
	<1187257311394-git-send-email-tony@atomide.com>
	<11872573133142-git-send-email-tony@atomide.com>
	<11872573161558-git-send-email-tony@atomide.com>
	<1187257318333-git-send-email-tony@atomide.com>
	<11872573202855-git-send-email-tony@atomide.com>
	<11872573222937-git-send-email-tony@atomide.com>
	<1187257324463-git-send-email-tony@atomide.com>
	<11872573273963-git-send-email-tony@atomide.com>
	<1187257329166-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1187257329166-git-send-email-tony@atomide.com>
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

Search and replace wType with musb_type

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/plat_uds.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 358d0a5..b8d586f 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1244,7 +1244,7 @@ enum { MUSB_CONTROLLER_MHDRC, MUSB_CONTROLLER_HDRC, };
 /* Initialize MUSB (M)HDRC part of the USB hardware subsystem;
  * configure endpoints, or take their config from silicon
  */
-static int __init musb_core_init(u16 wType, struct musb *musb)
+static int __init musb_core_init(u16 musb_type, struct musb *musb)
 {
 #ifdef MUSB_AHB_ID
 	u32 data;
@@ -1306,11 +1306,11 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	data = musb_readl(mbase, 0x40c);
 	printk("ID3=%lx\n", (long unsigned)data);
 	reg = musb_readb(mbase, 0x400);
-	wType = ('M' == reg) ? MUSB_CONTROLLER_MHDRC : MUSB_CONTROLLER_HDRC;
+	musb_type = ('M' == reg) ? MUSB_CONTROLLER_MHDRC : MUSB_CONTROLLER_HDRC;
 #else
 	aDate[0] = 0;
 #endif
-	if (MUSB_CONTROLLER_MHDRC == wType) {
+	if (MUSB_CONTROLLER_MHDRC == musb_type) {
 		musb->is_multipoint = 1;
 		type = "M";
 	} else {
-- 
1.5.2.3
