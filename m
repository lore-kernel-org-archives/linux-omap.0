From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] reset: Introduce static inline dummy function when CONFIG_RESET_CONTROLLER is not set
Date: Tue, 1 Dec 2015 10:38:33 -0600
Message-ID: <1448987913-17770-1-git-send-email-nm@ti.com>
References: <1448984088-31904-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448984088-31904-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

When CONFIG_RESET_CONTROLLER is not defined (example COMPILE_TEST),
provide a dummy static inline implementation.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

V2: Thanks to kbot, I realized i messed up the patch -> hopefully, this revision
has better luck.

V1: https://patchwork.kernel.org/patch/7738191/

 include/linux/reset-controller.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index ce6b962ffed4..e294565540db 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -48,7 +48,18 @@ struct reset_controller_dev {
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
+
+static inline void reset_controller_unregister(struct reset_controller_dev *r)
+{
+}
+#endif	/* IS_ENABLED(CONFIG_RESET_CONTROLLER) */
 
 #endif
-- 
2.6.2.402.g2635c2b
