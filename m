From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 29/33] bus: ti-sysc: Fix missing force mstandby quirk handling
Date: Thu, 23 Jan 2020 20:17:04 -0500
Message-ID: <20200124011708.18232-29-sashal@kernel.org>
References: <20200124011708.18232-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200124011708.18232-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 93c60483b5feefced92b869d5f97769495bc6313 ]

Commit 03856e928b0e ("bus: ti-sysc: Handle mstandby quirk and use it for
musb") added quirk handling for mstandby quirk but did not consider that
we also need a quirk variant for SYSC_QUIRK_FORCE_MSTANDBY.

We need to use forced idle mode for both SYSC_QUIRK_SWSUP_MSTANDBY and
SYSC_QUIRK_FORCE_MSTANDBY, but SYSC_QUIRK_SWSUP_MSTANDBY also need to
additionally also configure no-idle mode when enabled.

Fixes: 03856e928b0e ("bus: ti-sysc: Handle mstandby quirk and use it for musb")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c                 | 3 ++-
 include/linux/platform_data/ti-sysc.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 6dc9d460e3065..52c2485498109 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -981,7 +981,8 @@ static int sysc_disable_module(struct device *dev)
 		return ret;
 	}
 
-	if (ddata->cfg.quirks & SYSC_QUIRK_SWSUP_MSTANDBY)
+	if (ddata->cfg.quirks & (SYSC_QUIRK_SWSUP_MSTANDBY) ||
+	    ddata->cfg.quirks & (SYSC_QUIRK_FORCE_MSTANDBY))
 		best_mode = SYSC_IDLE_FORCE;
 
 	reg &= ~(SYSC_IDLE_MASK << regbits->midle_shift);
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
index 0b93804751444..8cfe570fdece6 100644
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -49,6 +49,7 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_FORCE_MSTANDBY	BIT(20)
 #define SYSC_MODULE_QUIRK_AESS		BIT(19)
 #define SYSC_MODULE_QUIRK_SGX		BIT(18)
 #define SYSC_MODULE_QUIRK_HDQ1W		BIT(17)
-- 
2.20.1
