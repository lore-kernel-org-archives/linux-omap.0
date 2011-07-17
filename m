From: Sergei Trofimovich <slyich@gmail.com>
Subject: [resend PATCH] tusb6010_omap: fix build failure: error: 'musb' undeclared
Date: Sun, 17 Jul 2011 18:28:00 +0300
Message-ID: <1310916480-3477-1-git-send-email-slyich@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sergei Trofimovich <slyfox@gentoo.org>
List-Id: linux-omap@vger.kernel.org

From: Sergei Trofimovich <slyfox@gentoo.org>

  CC      drivers/usb/musb/tusb6010_omap.o
drivers/usb/musb/tusb6010_omap.c: In function 'tusb_omap_use_shared_dmareq':
drivers/usb/musb/tusb6010_omap.c:92: error: 'musb' undeclared (first use in this function)
drivers/usb/musb/tusb6010_omap.c:92: error: (Each undeclared identifier is reported only once
drivers/usb/musb/tusb6010_omap.c:92: error: for each function it appears in.)

Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 drivers/usb/musb/tusb6010_omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index c784e6c..07c8a73 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -89,7 +89,7 @@ static inline int tusb_omap_use_shared_dmareq(struct tusb_omap_dma_ch *chdat)
 	u32		reg = musb_readl(chdat->tbase, TUSB_DMA_EP_MAP);
 
 	if (reg != 0) {
-		dev_dbg(musb->controller, "ep%i dmareq0 is busy for ep%i\n",
+		dev_dbg(chdat->musb->controller, "ep%i dmareq0 is busy for ep%i\n",
 			chdat->epnum, reg & 0xf);
 		return -EAGAIN;
 	}
-- 
1.7.3.4
