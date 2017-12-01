From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 06/11] net: ethernet: ti: ale: use proper io apis
Date: Thu, 30 Nov 2017 18:21:15 -0600
Message-ID: <20171201002120.13483-7-grygorii.strashko@ti.com>
References: <20171201002120.13483-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171201002120.13483-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Switch to use writel_relaxed/readl_relaxed() IO API instead of raw version
as it is recommended.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index b432a75..fca5c29 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -150,11 +150,11 @@ static int cpsw_ale_read(struct cpsw_ale *ale, int idx, u32 *ale_entry)
 
 	WARN_ON(idx > ale->params.ale_entries);
 
-	__raw_writel(idx, ale->params.ale_regs + ALE_TABLE_CONTROL);
+	writel_relaxed(idx, ale->params.ale_regs + ALE_TABLE_CONTROL);
 
 	for (i = 0; i < ALE_ENTRY_WORDS; i++)
-		ale_entry[i] = __raw_readl(ale->params.ale_regs +
-					   ALE_TABLE + 4 * i);
+		ale_entry[i] = readl_relaxed(ale->params.ale_regs +
+					     ALE_TABLE + 4 * i);
 
 	return idx;
 }
@@ -166,11 +166,11 @@ static int cpsw_ale_write(struct cpsw_ale *ale, int idx, u32 *ale_entry)
 	WARN_ON(idx > ale->params.ale_entries);
 
 	for (i = 0; i < ALE_ENTRY_WORDS; i++)
-		__raw_writel(ale_entry[i], ale->params.ale_regs +
-			     ALE_TABLE + 4 * i);
+		writel_relaxed(ale_entry[i], ale->params.ale_regs +
+			       ALE_TABLE + 4 * i);
 
-	__raw_writel(idx | ALE_TABLE_WRITE, ale->params.ale_regs +
-		     ALE_TABLE_CONTROL);
+	writel_relaxed(idx | ALE_TABLE_WRITE, ale->params.ale_regs +
+		       ALE_TABLE_CONTROL);
 
 	return idx;
 }
@@ -733,9 +733,9 @@ int cpsw_ale_control_set(struct cpsw_ale *ale, int port, int control,
 	offset = info->offset + (port * info->port_offset);
 	shift  = info->shift  + (port * info->port_shift);
 
-	tmp = __raw_readl(ale->params.ale_regs + offset);
+	tmp = readl_relaxed(ale->params.ale_regs + offset);
 	tmp = (tmp & ~(mask << shift)) | (value << shift);
-	__raw_writel(tmp, ale->params.ale_regs + offset);
+	writel_relaxed(tmp, ale->params.ale_regs + offset);
 
 	return 0;
 }
@@ -760,7 +760,7 @@ int cpsw_ale_control_get(struct cpsw_ale *ale, int port, int control)
 	offset = info->offset + (port * info->port_offset);
 	shift  = info->shift  + (port * info->port_shift);
 
-	tmp = __raw_readl(ale->params.ale_regs + offset) >> shift;
+	tmp = readl_relaxed(ale->params.ale_regs + offset) >> shift;
 	return tmp & BITMASK(info->bits);
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_control_get);
@@ -781,7 +781,7 @@ void cpsw_ale_start(struct cpsw_ale *ale)
 {
 	u32 rev, ale_entries;
 
-	rev = __raw_readl(ale->params.ale_regs + ALE_IDVER);
+	rev = readl_relaxed(ale->params.ale_regs + ALE_IDVER);
 	if (!ale->params.major_ver_mask)
 		ale->params.major_ver_mask = 0xff;
 	ale->version =
@@ -793,8 +793,8 @@ void cpsw_ale_start(struct cpsw_ale *ale)
 
 	if (!ale->params.ale_entries) {
 		ale_entries =
-			__raw_readl(ale->params.ale_regs + ALE_STATUS) &
-				    ALE_STATUS_SIZE_MASK;
+			readl_relaxed(ale->params.ale_regs + ALE_STATUS) &
+			ALE_STATUS_SIZE_MASK;
 		/* ALE available on newer NetCP switches has introduced
 		 * a register, ALE_STATUS, to indicate the size of ALE
 		 * table which shows the size as a multiple of 1024 entries.
-- 
2.10.5
