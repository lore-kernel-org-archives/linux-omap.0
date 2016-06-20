From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/9] regulator: of: setup initial suspend state
Date: Mon, 20 Jun 2016 14:13:31 +0530
Message-ID: <1466412218-5906-3-git-send-email-j-keerthy@ti.com>
References: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, j-keerthy@ti.com, linux@armlinux.org.uk, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Setup initial suspend state to mem, if suspend state is defined for
mem state. This makes sure that the regulators are in proper mode
already from boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/of_regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index cd828db..4f613ec 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -163,6 +163,9 @@ static void of_get_regulation_constraints(struct device_node *np,
 					"regulator-suspend-microvolt", &pval))
 			suspend_state->uV = pval;
 
+		if (i == PM_SUSPEND_MEM)
+			constraints->initial_state = PM_SUSPEND_MEM;
+
 		of_node_put(suspend_np);
 		suspend_state = NULL;
 		suspend_np = NULL;
-- 
1.9.1
