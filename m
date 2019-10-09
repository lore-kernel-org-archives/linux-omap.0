From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 16/68] ARM: OMAP2+: Add missing LCDC midlemode for am335x
Date: Wed,  9 Oct 2019 13:04:55 -0400
Message-ID: <20191009170547.32204-16-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>, Keerthy <j-keerthy@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Suman Anna <s-anna@ti.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 17529d43b21c72466e9109d602c6f5c360a1a9e8 ]

TRM "Table 13-34. SYSCONFIG Register Field Descriptions" lists both
standbymode and idlemode that should be just the sidle and midle
registers where midle is currently unconfigured for lcdc_sysc. As
the dts data has been generated based on lcdc_sysc, we now have an
empty "ti,sysc-midle" property.

And so we currently get a warning for lcdc because of a difference
with dts provided configuration compared to the legacy platform
data. This is because lcdc has SYSC_HAS_MIDLEMODE configured in
the platform data without configuring the modes.

Let's fix the issue by adding the missing midlemode to lcdc_sysc,
and configuring the "ti,sysc-midle" property based on the TRM
values.

Fixes: f711c575cfec ("ARM: dts: am335x: Add l4 interconnect hierarchy and ti-sysc data")
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am33xx-l4.dtsi           | 4 +++-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 1515f4f914999..3287cf695b5a4 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -2038,7 +2038,9 @@
 			reg = <0xe000 0x4>,
 			      <0xe054 0x4>;
 			reg-names = "rev", "sysc";
-			ti,sysc-midle ;
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
 			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index c965af275e341..81d9912f17c85 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -231,8 +231,9 @@ static struct omap_hwmod am33xx_control_hwmod = {
 static struct omap_hwmod_class_sysconfig lcdc_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x54,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			  MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART,
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
 
-- 
2.20.1
