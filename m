From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8 3/8] can: c_can: Add RAMINIT register information to driver data
Date: Fri, 14 Nov 2014 19:09:46 +0100
Message-ID: <1415988591-6032-4-git-send-email-mkl@pengutronix.de>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, rogerq@ti.com, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

Some platforms (e.g. TI) need special RAMINIT register handling.
Provide a way to store RAMINIT register description in driver data.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 26c975d914e3..3f111f4f0f6e 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -169,8 +169,18 @@ enum c_can_dev_id {
 	BOSCH_D_CAN,
 };
 
+struct raminit_bits {
+	u8 start;
+	u8 done;
+};
+
 struct c_can_driver_data {
 	enum c_can_dev_id id;
+
+	/* RAMINIT register description. Optional. */
+	const struct raminit_bits *raminit_bits; /* Array of START/DONE bit positions */
+	u8 raminit_num;		/* Number of CAN instances on the SoC */
+	bool raminit_pulse;	/* If set, sets and clears START bit (pulse) */
 };
 
 /* c_can private data structure */
-- 
2.1.1

