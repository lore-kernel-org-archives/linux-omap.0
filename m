From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/14] mfd: twl6040: The chip does not support bulk access
Date: Wed, 18 May 2016 16:46:26 +0300
Message-ID: <1463579196-5484-5-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Bulk access is not working with twl6040, we need to use single register
access. Bulk access would happen when we try to sync the regcache after
power on.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index f3dcf3a85e84..2596546553aa 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -608,6 +608,7 @@ static const struct regmap_config twl6040_regmap_config = {
 	.writeable_reg = twl6040_writeable_reg,
 
 	.cache_type = REGCACHE_RBTREE,
+	.use_single_rw = true,
 };
 
 static const struct regmap_irq twl6040_irqs[] = {
-- 
2.8.2
