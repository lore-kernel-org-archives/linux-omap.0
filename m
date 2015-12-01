From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] reset: Introduce static inline dummy function when
 CONFIG_RESET_CONTROLLER
Date: Tue, 1 Dec 2015 09:34:48 -0600
Message-ID: <1448984088-31904-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When CONFIG_RESET_CONTROLLER is not defined (example COMPILE_TEST),
provide a dummy static inline implementation.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 include/linux/reset-controller.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index ce6b962ffed4..4badecb2619e 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -48,7 +48,16 @@ struct reset_controller_dev {
 	unsigned int nr_resets;
 };
 
+#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
 int reset_controller_register(struct reset_controller_dev *rcdev);
 void reset_controller_unregister(struct reset_controller_dev *rcdev);
+#else
+static inline int reset_controller_register(struct reset_controller_dev *r)
+{
+	return -EINVAL;
+}
 
+static inline void reset_controller_unregister(struct reset_controller_dev *r)
+{
+}
 #endif
-- 
2.6.2.402.g2635c2b
