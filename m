From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4/5] usb: musb: omap: add usb_phy_init in omap2430_musb_init
Date: Wed, 13 Mar 2013 14:17:09 +0530
Message-ID: <1363164430-19118-5-git-send-email-kishon@ti.com>
References: <1363164430-19118-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363164430-19118-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, notasas@gmail.com, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Some PHYs load too early (twl4030) making omap glue to miss cable connect events
if the board is booted with cable connected. So adding usb_phy_init in
omap2430_musb_init lets PHYs to report events once glue is ready.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/musb/omap2430.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 28a0220..0786495 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -386,6 +386,8 @@ static int omap2430_musb_init(struct musb *musb)
 	if (glue->status != OMAP_MUSB_UNKNOWN)
 		omap_musb_set_mailbox(glue);
 
+	usb_phy_init(musb->xceiv);
+
 	pm_runtime_put_noidle(musb->controller);
 	return 0;
 
-- 
1.7.10.4
