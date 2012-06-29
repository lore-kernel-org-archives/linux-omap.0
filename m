From: Andy Green <andy.green@linaro.org>
Subject: [PATCH 3/3] OMAP4 PANDA register ethernet and wlan for automatic
 mac allocation
Date: Fri, 29 Jun 2012 13:55:26 +0800
Message-ID: <20120629055524.11091.57217.stgit@build.warmcat.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:41565 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab2F2Fza (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 01:55:30 -0400
In-Reply-To: <20120629054404.11091.31289.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.pitre@linaro.org, s-jan@ti.com, arnd@arndb.de, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org

From: Andy Green <andy@warmcat.com>

This provides the board-specific device paths needed to get
the panda boardfile working with the MAC address fixup api.

On Pandaboard / ES, neither the onboard Ethernet or onboard WLAN
module have onboard arrangements for MAC storage, without this
series yielding randomized MAC per-boot and consequent DHCP problems,
or in the case of wlan0 a MAC set by a firmware file in the rootfs
which unless customized yields a MAC of 00:00:00:00:00:00.  No
official MAC is reserved for either network device even if you do
take the approach to customize the firmware file.

This gets sane, consistent MAC addresses on both devices which
should stand a good probability of differing between PandaBoards.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 arch/arm/mach-omap2/board-omap4panda.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 982fb26..07a17b0 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -486,6 +486,15 @@ static void omap4_panda_init_rev(void)
 	}
 }
 
+/*
+ * These device paths represent onboard network devices which have
+ * no MAC address set at boot, and need synthetic ones assigning
+ */
+static const char * const panda_fixup_mac_device_paths[] = {
+	"usb1/1-1/1-1.1/1-1.1:1.0",	/* smsc USB <-> Ethernet bridge */
+	"wl12xx",			/* wlan0 module */
+};
+
 static void __init omap4_panda_init(void)
 {
 	int package = OMAP_PACKAGE_CBS;
@@ -496,6 +505,10 @@ static void __init omap4_panda_init(void)
 	omap4_mux_init(board_mux, NULL, package);
 
 	omap_panda_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
+
+	omap_register_mac_device_fixup_paths(panda_fixup_mac_device_paths,
+				     ARRAY_SIZE(panda_fixup_mac_device_paths));
+
 	ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
 	if (ret)
 		pr_err("error setting wl12xx data: %d\n", ret);

