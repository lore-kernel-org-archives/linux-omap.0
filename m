From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/10] usb: phy: mv-u3d: switch over to writel/readl
Date: Mon, 21 Apr 2014 10:56:45 -0500
Message-ID: <1398095812-14222-4-git-send-email-balbi@ti.com>
References: <1398095812-14222-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398095812-14222-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, leigh-0TD6cqJ6btAqdlJmJB21zg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

by removing the _relaxed suffix, we can build
this driver in other architectures.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/phy/phy-mv-u3d-usb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/phy/phy-mv-u3d-usb.c b/drivers/usb/phy/phy-mv-u3d-usb.c
index d317903..d342175 100644
--- a/drivers/usb/phy/phy-mv-u3d-usb.c
+++ b/drivers/usb/phy/phy-mv-u3d-usb.c
@@ -39,8 +39,8 @@ static u32 mv_u3d_phy_read(void __iomem *base, u32 reg)
 	addr = base;
 	data = base + 0x4;
 
-	writel_relaxed(reg, addr);
-	return readl_relaxed(data);
+	writel(reg, addr);
+	return readl(data);
 }
 
 static void mv_u3d_phy_set(void __iomem *base, u32 reg, u32 value)
@@ -51,10 +51,10 @@ static void mv_u3d_phy_set(void __iomem *base, u32 reg, u32 value)
 	addr = base;
 	data = base + 0x4;
 
-	writel_relaxed(reg, addr);
-	tmp = readl_relaxed(data);
+	writel(reg, addr);
+	tmp = readl(data);
 	tmp |= value;
-	writel_relaxed(tmp, data);
+	writel(tmp, data);
 }
 
 static void mv_u3d_phy_clear(void __iomem *base, u32 reg, u32 value)
@@ -65,10 +65,10 @@ static void mv_u3d_phy_clear(void __iomem *base, u32 reg, u32 value)
 	addr = base;
 	data = base + 0x4;
 
-	writel_relaxed(reg, addr);
-	tmp = readl_relaxed(data);
+	writel(reg, addr);
+	tmp = readl(data);
 	tmp &= ~value;
-	writel_relaxed(tmp, data);
+	writel(tmp, data);
 }
 
 static void mv_u3d_phy_write(void __iomem *base, u32 reg, u32 value)
@@ -78,8 +78,8 @@ static void mv_u3d_phy_write(void __iomem *base, u32 reg, u32 value)
 	addr = base;
 	data = base + 0x4;
 
-	writel_relaxed(reg, addr);
-	writel_relaxed(value, data);
+	writel(reg, addr);
+	writel(value, data);
 }
 
 static void mv_u3d_phy_shutdown(struct usb_phy *phy)
-- 
1.9.2.459.g68773ac

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
