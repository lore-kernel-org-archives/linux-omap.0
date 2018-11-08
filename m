From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for i2c-omap driver
Date: Thu, 8 Nov 2018 14:49:31 +0530
Message-ID: <20181108091931.3342-4-vigneshr@ti.com>
References: <20181108091931.3342-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108091931.3342-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Tony Lindgren <tony@atomide.com>
Cc: Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add separate entry for i2c-omap and add my name as reviewer for this
driver.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d4c874a5d6e..6519eea4813e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10821,6 +10821,14 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-omap2/omap_hwmod.*
 
+OMAP I2C DRIVER
+R:	Vignesh R <vigneshr@ti.com>
+L:	linux-omap@vger.kernel.org
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/i2c-omap.txt
+F:	drivers/i2c/busses/i2c-omap.c
+
 OMAP IMAGING SUBSYSTEM (OMAP3 ISP and OMAP4 ISS)
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
-- 
2.19.1
