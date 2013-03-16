From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 2/8] memory: emif: setup LP settings on freq update
Date: Sat, 16 Mar 2013 11:46:42 +0530
Message-ID: <1363414608-7448-3-git-send-email-lokeshvutla@ti.com>
References: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: Nishanth Menon <nm@ti.com>, lokeshvutla@ti.com, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, Ambresh K <ambresh@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Ambresh K <ambresh@ti.com>

Program the power management shadow register on freq update
Else the concept of threshold frequencies dont really matter
as the system always uses the performance mode timing for LP
which is programmed in at init time.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Changes since V1: No changes

 drivers/memory/emif.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 508763c..5f3b7ed 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -819,6 +819,8 @@ static void setup_registers(struct emif_data *emif, struct emif_regs *regs)
 
 	writel(regs->sdram_tim2_shdw, base + EMIF_SDRAM_TIMING_2_SHDW);
 	writel(regs->phy_ctrl_1_shdw, base + EMIF_DDR_PHY_CTRL_1_SHDW);
+	writel(regs->pwr_mgmt_ctrl_shdw,
+	       base + EMIF_POWER_MANAGEMENT_CTRL_SHDW);
 
 	/* Settings specific for EMIF4D5 */
 	if (emif->plat_data->ip_rev != EMIF_4D5)
-- 
1.7.9.5
