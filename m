From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/14] bus: ti-sysc: Pass clockactivity quirk to platform functions
Date: Mon, 25 Mar 2019 14:58:47 -0700
Message-ID: <20190325215849.13182-13-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We already have the clockactivity quirk set for some modules like i2c,
timers and smartreflex. But we're not passing it to the platform functions
yet. Let's start doing that in preparation of dropping interconnect target
module platform data in favor of device tree based data.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3681,6 +3681,8 @@ int omap_hwmod_init_module(struct device *dev,
 		oh->flags |= HWMOD_INIT_NO_IDLE;
 	if (data->cfg->quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
 		oh->flags |= HWMOD_INIT_NO_RESET;
+	if (data->cfg->quirks & SYSC_QUIRK_USE_CLOCKACT)
+		oh->flags |= HWMOD_SET_DEFAULT_CLOCKACT;
 
 	error = omap_hwmod_check_module(dev, oh, data, sysc_fields,
 					rev_offs, sysc_offs, syss_offs,
-- 
2.21.0
