From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH v2 1/4] Input: matrix_keypad: Device driver interfaces
Date: Thu, 13 May 2010 15:50:00 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E113BF7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Add omap device driver interfaces to enable hwmod framework

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 include/linux/input/matrix_keypad.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index c964cd7..552e11d 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -66,6 +66,13 @@ struct matrix_keypad_platform_data {
 	bool		active_low;
 	bool		wakeup;
 	bool		no_autorepeat;
+
+	void __iomem *base;
+	u16 irq;
+
+	int (*device_enable) (struct platform_device *pdev);
+	int (*device_shutdown) (struct platform_device *pdev);
+	int (*device_idle) (struct platform_device *pdev);
 };
 
 /**
-- 
1.5.4.3

