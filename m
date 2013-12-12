From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] usb: musb: omap2430: fix occasional musb breakage on boot
Date: Thu, 12 Dec 2013 02:20:59 +0200
Message-ID: <1386807659-5505-1-git-send-email-notasas@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Andreas Naumann <anaumann@ultratronik.de>, Grazvydas Ignotas <notasas@gmail.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is a hard to reproduce problem which leads to non-functional
USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
e25bec160158abe86c "omap2+: save and restore OTG_INTERFSEL",
which introduces save/restore of OTG_INTERFSEL over suspend.

Since the resume function is also called early in driver init, it uses a
non-initialized value (which is 0 and a non-supported setting in DM37xx
for INTERFSEL). Shortly after the correct value is set. Apparently this
works most time, but not always.

Fix it by not writing the value on runtime resume if it is 0
(0 should never be saved in the context as it's invalid value,
so we use it as an indicator that context hasn't been saved yet).

This issue was originally found by Andreas Naumann:
http://marc.info/?l=linux-usb&m=138562574719654&w=2

Reported-and-bisected-by: Andreas Naumann <anaumann@ultratronik.de>
Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Cc: <stable@vger.kernel.org>
---
This is a regression from 3.2, so should go to -rc and stable, IMO.
It's really annoying issue if you want to have a stable OTG behavior,
I've burned quite a lot of time on it myself over a year ago and gave up
eventually. Good thing Andreas finally found it, many thanks to him!

 drivers/usb/musb/omap2430.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 2a408cd..737b3da 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -672,7 +672,8 @@ static int omap2430_runtime_resume(struct device *dev)
 
 	if (musb) {
 		omap2430_low_level_init(musb);
-		musb_writel(musb->mregs, OTG_INTERFSEL,
+		if (musb->context.otg_interfsel != 0)
+			musb_writel(musb->mregs, OTG_INTERFSEL,
 				musb->context.otg_interfsel);
 		phy_power_on(musb->phy);
 	}
-- 
1.7.9.5
