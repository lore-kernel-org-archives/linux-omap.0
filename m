From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 09/11] net: ethernet: ti: ale: move static initialization in cpsw_ale_create()
Date: Wed, 22 Nov 2017 15:25:55 -0600
Message-ID: <20171122212557.9998-10-grygorii.strashko@ti.com>
References: <20171122212557.9998-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122212557.9998-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Move static initialization from cpsw_ale_start() to cpsw_ale_create() as it
does not make much sence to perform static initializtion in
cpsw_ale_start() which is called everytime netif[s] is opened.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 57 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 34f97c1..d542859 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -779,8 +779,36 @@ static void cpsw_ale_timer(unsigned long arg)
 
 void cpsw_ale_start(struct cpsw_ale *ale)
 {
+	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 1);
+	cpsw_ale_control_set(ale, 0, ALE_CLEAR, 1);
+
+	setup_timer(&ale->timer, cpsw_ale_timer, (unsigned long)ale);
+	if (ale->ageout) {
+		ale->timer.expires = jiffies + ale->ageout;
+		add_timer(&ale->timer);
+	}
+}
+EXPORT_SYMBOL_GPL(cpsw_ale_start);
+
+void cpsw_ale_stop(struct cpsw_ale *ale)
+{
+	del_timer_sync(&ale->timer);
+	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 0);
+}
+EXPORT_SYMBOL_GPL(cpsw_ale_stop);
+
+struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
+{
+	struct cpsw_ale *ale;
 	u32 rev, ale_entries;
 
+	ale = kzalloc(sizeof(*ale), GFP_KERNEL);
+	if (!ale)
+		return NULL;
+
+	ale->params = *params;
+	ale->ageout = ale->params.ale_ageout * HZ;
+
 	rev = readl_relaxed(ale->params.ale_regs + ALE_IDVER);
 	if (!ale->params.major_ver_mask)
 		ale->params.major_ver_mask = 0xff;
@@ -849,35 +877,6 @@ void cpsw_ale_start(struct cpsw_ale *ale)
 					ALE_UNKNOWNVLAN_FORCE_UNTAG_EGRESS;
 	}
 
-	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 1);
-	cpsw_ale_control_set(ale, 0, ALE_CLEAR, 1);
-
-	setup_timer(&ale->timer, cpsw_ale_timer, (unsigned long)ale);
-	if (ale->ageout) {
-		ale->timer.expires = jiffies + ale->ageout;
-		add_timer(&ale->timer);
-	}
-}
-EXPORT_SYMBOL_GPL(cpsw_ale_start);
-
-void cpsw_ale_stop(struct cpsw_ale *ale)
-{
-	del_timer_sync(&ale->timer);
-	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 0);
-}
-EXPORT_SYMBOL_GPL(cpsw_ale_stop);
-
-struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
-{
-	struct cpsw_ale *ale;
-
-	ale = kzalloc(sizeof(*ale), GFP_KERNEL);
-	if (!ale)
-		return NULL;
-
-	ale->params = *params;
-	ale->ageout = ale->params.ale_ageout * HZ;
-
 	return ale;
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_create);
-- 
2.10.5
