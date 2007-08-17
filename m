From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] musb_hdrc: Fix SRP locking
Date: Fri, 17 Aug 2007 04:44:42 -0700
Message-ID: <11873510951742-git-send-email-tony@atomide.com>
References: <118735108469-git-send-email-tony@atomide.com>
	<11873510862981-git-send-email-tony@atomide.com>
	<11873510882998-git-send-email-tony@atomide.com>
	<11873510911954-git-send-email-tony@atomide.com>
	<11873510931624-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11873510931624-git-send-email-tony@atomide.com>
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

Remove unnecessary locking left over from earlier code
as it's done in musb_gadget_wakeup(). Also show debug
information for unhandled wake events to allow debugging
SRP.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |    3 ++-
 drivers/usb/musb/plat_uds.c    |    3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index fa15c59..86a256a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1434,6 +1434,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 		status = 0;
 		goto done;
 	default:
+		DBG(2, "Unhandled wake: %s\n", otg_state_string(musb));
 		goto done;
 	}
 
@@ -1931,7 +1932,7 @@ void musb_g_suspend(struct musb *musb)
 	}
 }
 
-/* Called during SRP. Caller must hold lock */
+/* Called during SRP */
 void musb_g_wakeup(struct musb *musb)
 {
 	musb_gadget_wakeup(&musb->g);
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 8a2bb3e..c6ca9ea 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1710,7 +1710,6 @@ musb_srp_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t n)
 {
 	struct musb	*musb=dev_to_musb(dev);
-	unsigned long	flags;
 	unsigned short	srp;
 
 	if (sscanf(buf, "%hu", &srp) != 1
@@ -1719,10 +1718,8 @@ musb_srp_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&musb->lock, flags);
 	if (srp == 1)
 		musb_g_wakeup(musb);
-	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return n;
 }
-- 
1.5.2.3
