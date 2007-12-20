From: Bryan Wu <bryan.wu@analog.com>
Subject: [PATCH] [MUSB] musb_hdrc: disable sending PING packet in host mode.
Date: Thu, 20 Dec 2007 22:10:45 +0800
Message-ID: <1198159845.6319.1.camel@roc-laptop>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Bryan Wu <bryan.wu@analog.com>
Date: Thu, 20 Dec 2007 15:25:34 +0800
Subject: [PATCH] [MUSB] musb_hdrc: disable sending PING packet in host
mode.

Some High Speed USB stick does not answer PING pakcet correctly, so
the USB enumeration will fail in MUSB host mode.

Disable using PING packet in host mode, almost all the USB stick
enumeration is OK on Blackfin BF54x/BF52x platform. I hope this is
a common problem in other MUSB platform.

This bug is tracked here:
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3778

Signed-off-by: Bryan Wu <bryan.wu@analog.com>
---
 drivers/usb/musb/musb_host.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 2ad2ed9..34a2991 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1112,6 +1112,8 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
                                csr = MUSB_CSR0_H_STATUSPKT
                                        | MUSB_CSR0_TXPKTRDY;
 
+                       csr |= MUSB_CSR0_H_DIS_PING;
+
                        /* flag status stage */
                        musb->ep0_stage = MUSB_EP0_STATUS;
 
-- 
1.5.3
