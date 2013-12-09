From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v3 14/15] mfd: menelaus: IRQ is a requirement
Date: Mon, 9 Dec 2013 10:21:24 -0600
Message-ID: <1386606085-26838-14-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386606085-26838-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

This driver needs IRQ to work, if client->irq isn't set properly, we
won't work. Remove check around request_threaded_irq().

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/menelaus.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index c0219b7..bffe978 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1271,14 +1271,12 @@ static int menelaus_probe(struct i2c_client *client,
 	/* Set output buffer strengths */
 	menelaus_write_reg(m, MENELAUS_MCT_CTRL1, 0x73);
 
-	if (client->irq > 0) {
-		err = request_threaded_irq(client->irq, NULL, menelaus_irq,
-				IRQF_ONESHOT, DRIVER_NAME, m);
-		if (err) {
-			dev_dbg(&client->dev,  "can't get IRQ %d, err %d\n",
-					client->irq, err);
-			goto fail_free_descs;
-		}
+	err = request_threaded_irq(client->irq, NULL, menelaus_irq,
+			IRQF_ONESHOT, DRIVER_NAME, m);
+	if (err) {
+		dev_dbg(&client->dev,  "can't get IRQ %d, err %d\n",
+				client->irq, err);
+		goto fail_free_descs;
 	}
 
 	pr_info("Menelaus rev %d.%d\n", rev >> 4, rev & 0x0f);
-- 
1.8.4.GIT
