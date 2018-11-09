From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for i2c-omap driver
Date: Fri, 9 Nov 2018 16:44:12 +0530
Message-ID: <20181109111412.24777-4-vigneshr@ti.com>
References: <20181109111412.24777-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109111412.24777-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Add separate entry for i2c-omap and add my name as maintainer for this
driver.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c78aca287970..284ffe907b31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10808,6 +10808,14 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-omap2/omap_hwmod.*
 
+OMAP I2C DRIVER
+M:	Vignesh R <vigneshr@ti.com>
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
