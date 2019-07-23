From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/8] ARM: OMAP2+: Remove unconfigured midlemode for am3 lcdc
Date: Tue, 23 Jul 2019 04:28:05 -0700
Message-ID: <20190723112811.44381-3-tony@atomide.com>
References: <20190723112811.44381-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723112811.44381-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We currently get a warning for lcdc because of a difference
with dts provided configuration compared to the legacy platform
data. This is because lcdc has SYSC_HAS_MIDLEMODE configured in
the platform data without configuring the modes.

Let's fix the warning by removing SYSC_HAS_MIDLEMODE. Note that
the am335x TRM lists SYSC_HAS_MIDLEMODE, but it is unused.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -231,7 +231,7 @@ static struct omap_hwmod am33xx_control_hwmod = {
 static struct omap_hwmod_class_sysconfig lcdc_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x54,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
-- 
2.21.0
