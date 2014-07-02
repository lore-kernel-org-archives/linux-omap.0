From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/6] phy: core: Fix error path in phy_create()
Date: Wed, 2 Jul 2014 15:03:54 +0300
Message-ID: <1404302638-3003-3-git-send-email-rogerq@ti.com>
References: <1404302638-3003-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404302638-3003-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, kishon@ti.com, balbi@ti.com
Cc: nsekhar@ti.com, nm@ti.com, george.cherian@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Prevent resources from being freed twice in case device_add() call
fails within phy_create(). Also use ida_simple_remove() instead of
ida_remove() as we had used ida_simple_get() to allocate the ida.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index c64a2f3..49c4465 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -614,8 +614,9 @@ struct phy *phy_create(struct device *dev, const struct phy_ops *ops,
 	return phy;
 
 put_dev:
-	put_device(&phy->dev);
-	ida_remove(&phy_ida, phy->id);
+	put_device(&phy->dev);  /* calls phy_release() which frees resources */
+	return ERR_PTR(ret);
+
 free_phy:
 	kfree(phy);
 	return ERR_PTR(ret);
@@ -799,7 +800,7 @@ static void phy_release(struct device *dev)
 
 	phy = to_phy(dev);
 	dev_vdbg(dev, "releasing '%s'\n", dev_name(dev));
-	ida_remove(&phy_ida, phy->id);
+	ida_simple_remove(&phy_ida, phy->id);
 	kfree(phy);
 }
 
-- 
1.8.3.2
