From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] MAINTAINERS: net: add entry for TI Ethernet Switch drivers
Date: Wed, 20 Apr 2016 14:25:09 +0300
Message-ID: <1461151509-2368-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Mugunthan V N <mugunthanvnm@ti.com>, Richard Cochran <richardcochran@gmail.com>
List-Id: linux-omap@vger.kernel.org

Add record for TI Ethernet Switch Driver CPSW/CPDMA/MDIO HW
(am33/am43/am57/dr7/davinci) to ensure that related patches
will go through dedicated linux-omap list.

Also add Mugunthan as maintainer and myself as the reviewer.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d5b4be..aca864d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11071,6 +11071,14 @@ S:	Maintained
 F:	drivers/clk/ti/
 F:	include/linux/clk/ti.h
 
+TI ETHERNET SWITCH DRIVER (CPSW)
+M:	Mugunthan V N <mugunthanvnm@ti.com>
+R:	Grygorii Strashko <grygorii.strashko@ti.com>
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/ti/cpsw*
+F:	drivers/net/ethernet/ti/davinci*
+
 TI FLASH MEDIA INTERFACE DRIVER
 M:	Alex Dubov <oakad@yahoo.com>
 S:	Maintained
-- 
2.8.1
