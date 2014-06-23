From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] regulator: palmas: fix typo in enable_reg calculation
Date: Mon, 23 Jun 2014 14:53:25 -0600
Message-ID: <1403556805-22824-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alex Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

When setting up .enable_reg for an SMPS regulator, presumably we should
call PALMAS_BASE_TO_REG(PALMAS_SMPS_BASE, ...) rather than using
LDO_BASE. This change makes the LCD panel and HDMI work again on the
NVIDIA Dalmore board anyway.

Cc: Alex Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Fixes: 318dbb02b50c ("regulator: palmas: Fix SMPS enable/disable/is_enabled")
Fixes: dbabd624d4eec50b6 ("regulator: palmas: Reemove open coded functions with helper functions")
Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/regulator/palmas-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 3c861d5f9245..93b4ad842901 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -970,7 +970,7 @@ static int palmas_regulators_probe(struct platform_device *pdev)
 					PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
 
 			pmic->desc[id].enable_reg =
-					PALMAS_BASE_TO_REG(PALMAS_LDO_BASE,
+					PALMAS_BASE_TO_REG(PALMAS_SMPS_BASE,
 						palmas_regs_info[id].ctrl_addr);
 			pmic->desc[id].enable_mask =
 					PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
-- 
1.8.1.5
