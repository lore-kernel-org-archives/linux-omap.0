From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 03/10] usb: phy: convert EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
Date: Thu, 7 Mar 2013 11:36:02 +0200
Message-ID: <1362648969-13737-4-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36489 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755726Ab3CGJgc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 04:36:32 -0500
In-Reply-To: <1362648969-13737-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, swarren@wwwdotorg.org, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

we only want GPL users for our generic functions,
so let's switch over to EXPORT_SYMBOL_GPL.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/phy/phy.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index bc1970c..f52c006 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -109,7 +109,7 @@ struct usb_phy *devm_usb_get_phy(struct device *dev, enum usb_phy_type type)
 
 	return phy;
 }
-EXPORT_SYMBOL(devm_usb_get_phy);
+EXPORT_SYMBOL_GPL(devm_usb_get_phy);
 
 /**
  * usb_get_phy - find the USB PHY
@@ -142,7 +142,7 @@ err0:
 
 	return phy;
 }
-EXPORT_SYMBOL(usb_get_phy);
+EXPORT_SYMBOL_GPL(usb_get_phy);
 
  /**
  * devm_usb_get_phy_by_phandle - find the USB PHY by phandle
@@ -206,7 +206,7 @@ err0:
 
 	return phy;
 }
-EXPORT_SYMBOL(devm_usb_get_phy_by_phandle);
+EXPORT_SYMBOL_GPL(devm_usb_get_phy_by_phandle);
 
 /**
  * usb_get_phy_dev - find the USB PHY
@@ -239,7 +239,7 @@ err0:
 
 	return phy;
 }
-EXPORT_SYMBOL(usb_get_phy_dev);
+EXPORT_SYMBOL_GPL(usb_get_phy_dev);
 
 /**
  * devm_usb_get_phy_dev - find the USB PHY using device ptr and index
@@ -269,7 +269,7 @@ struct usb_phy *devm_usb_get_phy_dev(struct device *dev, u8 index)
 
 	return phy;
 }
-EXPORT_SYMBOL(devm_usb_get_phy_dev);
+EXPORT_SYMBOL_GPL(devm_usb_get_phy_dev);
 
 /**
  * devm_usb_put_phy - release the USB PHY
@@ -288,7 +288,7 @@ void devm_usb_put_phy(struct device *dev, struct usb_phy *phy)
 	r = devres_destroy(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
-EXPORT_SYMBOL(devm_usb_put_phy);
+EXPORT_SYMBOL_GPL(devm_usb_put_phy);
 
 /**
  * usb_put_phy - release the USB PHY
@@ -307,7 +307,7 @@ void usb_put_phy(struct usb_phy *x)
 		module_put(owner);
 	}
 }
-EXPORT_SYMBOL(usb_put_phy);
+EXPORT_SYMBOL_GPL(usb_put_phy);
 
 /**
  * usb_add_phy - declare the USB PHY
@@ -347,7 +347,7 @@ out:
 	spin_unlock_irqrestore(&phy_lock, flags);
 	return ret;
 }
-EXPORT_SYMBOL(usb_add_phy);
+EXPORT_SYMBOL_GPL(usb_add_phy);
 
 /**
  * usb_add_phy_dev - declare the USB PHY
@@ -377,7 +377,7 @@ int usb_add_phy_dev(struct usb_phy *x)
 	spin_unlock_irqrestore(&phy_lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL(usb_add_phy_dev);
+EXPORT_SYMBOL_GPL(usb_add_phy_dev);
 
 /**
  * usb_remove_phy - remove the OTG PHY
@@ -399,7 +399,7 @@ void usb_remove_phy(struct usb_phy *x)
 	}
 	spin_unlock_irqrestore(&phy_lock, flags);
 }
-EXPORT_SYMBOL(usb_remove_phy);
+EXPORT_SYMBOL_GPL(usb_remove_phy);
 
 /**
  * usb_bind_phy - bind the phy and the controller that uses the phy
-- 
1.8.1.rc1.5.g7e0651a

