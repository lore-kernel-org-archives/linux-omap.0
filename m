From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v9 22/25] gpio/omap: save and restore debounce registers
Date: Thu, 2 Feb 2012 23:00:48 +0530
Message-ID: <1328203851-20435-23-git-send-email-tarun.kanti@ti.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, Nishanth Menon <nm@ti.com>, tony@atomide.com, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

GPIO debounce registers need to be saved and restored for proper functioning
of driver.

Signed-off-by: Nishanth Menon <nm@ti.com>
tarun.kanti@ti.com: Debounce context save is moved to _set_gpio_debounce()
as part of dynamic context save to remove overhead.
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4056d78..560567d 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -44,6 +44,8 @@ struct gpio_regs {
 	u32 risingdetect;
 	u32 fallingdetect;
 	u32 dataout;
+	u32 debounce;
+	u32 debounce_en;
 };
 
 struct gpio_bank {
@@ -229,6 +231,10 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	 * that point. Therefore we have to enable dbck here.
 	 */
 	_gpio_dbck_enable(bank);
+	if (bank->dbck_enable_mask) {
+		bank->context.debounce = debounce;
+		bank->context.debounce_en = val;
+	}
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
@@ -1359,6 +1365,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 	__raw_writel(bank->context.fallingdetect,
 				bank->base + bank->regs->fallingdetect);
 	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
+	if (bank->dbck_enable_mask) {
+		__raw_writel(bank->context.debounce, bank->base +
+					bank->regs->debounce);
+		__raw_writel(bank->context.debounce_en,
+					bank->base + bank->regs->debounce_en);
+	}
 }
 #else
 #define omap_gpio_suspend NULL
-- 
1.7.0.4
