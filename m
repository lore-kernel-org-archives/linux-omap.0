From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 27/36] musb_hdrc: Search and replace wRelMajor with rev_major
Date: Thu, 16 Aug 2007 02:40:50 -0700
Message-ID: <11872573222937-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872573202855-git-send-email-tony@atomide.com>
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

Search and replace wRelMajor with rev_major

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/plat_uds.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index be53a57..ceddd3b 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1251,7 +1251,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 #endif
 	u8 reg;
 	char *type;
-	u16 hwvers, wRelMajor, wRelMinor;
+	u16 hwvers, rev_major, wRelMinor;
 	char aInfo[78], aRevision[32], aDate[12];
 	void __iomem	*mbase = musb->mregs;
 	int		status = 0;
@@ -1327,9 +1327,9 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 
 	/* log release info */
 	hwvers = musb_readw(mbase, MUSB_HWVERS);
-	wRelMajor = (hwvers >> 10) & 0x1f;
+	rev_major = (hwvers >> 10) & 0x1f;
 	wRelMinor = hwvers & 0x3ff;
-	snprintf(aRevision, 32, "%d.%d%s", wRelMajor,
+	snprintf(aRevision, 32, "%d.%d%s", rev_major,
 		wRelMinor, (hwvers & 0x8000) ? "RC" : "");
 	printk(KERN_DEBUG "%s: %sHDRC RTL version %s %s\n",
 			musb_driver_name, type, aRevision, aDate);
-- 
1.5.2.3
