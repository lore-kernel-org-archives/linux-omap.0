From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH] Add more Test Modes
Date: Tue, 29 May 2007 15:02:36 +0300
Message-ID: <11804401741522-git-send-email-felipebalbi@users.sourceforge.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401651954-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401662563-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401722783-git-send-email-felipebalbi@users.sourceforge.net>
	<1180440173922-git-send-email-felipebalbi@users.sourceforge.net>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1180440173922-git-send-email-felipebalbi@users.sourceforge.net>
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

From: Felipe Balbi <felipe.lima@indt.org.br>

	This patch adds missing TestMode to MUSB driver.
	Needed to run USB Certification Tests.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---

diff --git a/drivers/usb/musb/virthub.c b/drivers/usb/musb/virthub.c
index 6a65f4f..b86f034 100644
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -362,7 +362,11 @@ int musb_hub_control(
 				temp = MGC_M_TEST_FORCE_HOST
 					| MGC_M_TEST_FORCE_HS;
 
-				/* FIXME and enable a session too */
+				musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
+				break;
+			case 6:
+				pr_debug("TEST_FIFO_ACCESS\n");
+				temp = MGC_M_TEST_FIFO_ACCESS;
 				break;
 			default:
 				goto error;
-- 
1.5.2.rc3.39.gaf9b
