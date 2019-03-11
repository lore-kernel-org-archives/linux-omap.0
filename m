From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 4/8] ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized
Date: Mon, 11 Mar 2019 15:59:34 -0400
Message-ID: <20190311195938.139603-4-sashal@kernel.org>
References: <20190311195938.139603-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190311195938.139603-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Yizhuo <yzhai003@ucr.edu>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Yizhuo <yzhai003@ucr.edu>

[ Upstream commit dc30e70391376ba3987aeb856ae6d9c0706534f1 ]

In function omap4_dsi_mux_pads(), local variable "reg" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the later context, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 6ab13d18c636..cde86d1199cf 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -115,6 +115,7 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	u32 enable_mask, enable_shift;
 	u32 pipd_mask, pipd_shift;
 	u32 reg;
+	int ret;
 
 	if (dsi_id == 0) {
 		enable_mask = OMAP4_DSI1_LANEENABLE_MASK;
@@ -130,7 +131,11 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 		return -ENODEV;
 	}
 
-	regmap_read(omap4_dsi_mux_syscon, OMAP4_DSIPHY_SYSCON_OFFSET, &reg);
+	ret = regmap_read(omap4_dsi_mux_syscon,
+					  OMAP4_DSIPHY_SYSCON_OFFSET,
+					  &reg);
+	if (ret)
+		return ret;
 
 	reg &= ~enable_mask;
 	reg &= ~pipd_mask;
-- 
2.19.1
