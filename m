From: Adam Ford <aford173@gmail.com>
Subject: [PATCH] MAINTAINERS: Add logicpd-som-lv and logicpd-torpedo to OMAP TREE
Date: Mon, 23 Sep 2019 08:59:07 -0500
Message-ID: <20190923135908.23080-2-aford173@gmail.com>
References: <20190923135908.23080-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190923135908.23080-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>
List-Id: linux-omap@vger.kernel.org

The OMAP DEVICE TREE SUPPORT lists a bunch of device tree files
with wildcard names using am3*, am4*, am5*, dra7*, and *omap*.
Unfortunately, the LogicPD boards do not follow this convention
so changes to these boards don't get automatically flagged to
route to the omap mailing list.  After consulting with Tony
Lindgren, he agreed it made sense to add these boards to the
list.

This patch adds the omap based boards to the omap device tree
maintainer list.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index a50e97a63bc8..0ee89575699c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11645,6 +11645,8 @@ F:	arch/arm/boot/dts/*am3*
 F:	arch/arm/boot/dts/*am4*
 F:	arch/arm/boot/dts/*am5*
 F:	arch/arm/boot/dts/*dra7*
+F:	arch/arm/boot/dts/logicpd-som-lv*
+F:	arch/arm/boot/dts/logicpd-torpedo*
 
 OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
 L:	linux-omap@vger.kernel.org
-- 
2.17.1
