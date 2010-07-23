From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 10/11] wip: ARM: omap: move omap_board_config_kernel to .init.data
Date: Fri, 23 Jul 2010 21:58:33 +0200
Message-ID: <1279915120-4373-10-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Probably this works ...
---
 arch/arm/plat-omap/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 3737dae..fb9d5c2 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -44,7 +44,7 @@
 
 #define NO_LENGTH_CHECK 0xffffffff
 
-struct omap_board_config_kernel *omap_board_config;
+struct omap_board_config_kernel *omap_board_config __initdata;
 int omap_board_config_size;
 
 static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
-- 
1.7.1
