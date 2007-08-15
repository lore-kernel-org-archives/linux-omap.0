From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/8] musb_hdrc: Remove old unsed MGC_TYPE_SPEED_XXX
Date: Wed, 15 Aug 2007 07:21:44 -0700
Message-ID: <11871877263342-git-send-email-tony@atomide.com>
References: <11871877051923-git-send-email-tony@atomide.com>
	<11871877071348-git-send-email-tony@atomide.com>
	<1187187711983-git-send-email-tony@atomide.com>
	<1187187715940-git-send-email-tony@atomide.com>
	<11871877193281-git-send-email-tony@atomide.com>
	<11871877214142-git-send-email-tony@atomide.com>
	<11871877241489-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11871877241489-git-send-email-tony@atomide.com>
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

Remove old unsed MGC_TYPE_SPEED_XXX

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbhdrc.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musbhdrc.h b/drivers/usb/musb/musbhdrc.h
index 9646bb6..4a84c2a 100644
--- a/drivers/usb/musb/musbhdrc.h
+++ b/drivers/usb/musb/musbhdrc.h
@@ -218,9 +218,6 @@
 /* TxType/RxType */
 #define MUSB_TYPE_SPEED	0xc0
 #define MUSB_TYPE_SPEED_SHIFT	6
-#define MGC_TYPE_SPEED_HIGH	1
-#define MGC_TYPE_SPEED_FULL	2
-#define MGC_TYPE_SPEED_LOW	3
 #define MUSB_TYPE_PROTO	0x30	/* implicitly zero for ep0 */
 #define MUSB_TYPE_PROTO_SHIFT	4
 #define MUSB_TYPE_REMOTE_END	0xf	/* implicitly zero for ep0 */
-- 
1.5.2.3
