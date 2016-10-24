From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to 24MHz
Date: Mon, 24 Oct 2016 11:32:26 +0530
Message-ID: <20161024060226.4170-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-iio@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@kernel.org>, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, John Syne <john3909@gmail.com>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

Increase ADC reference clock from 3MHz to 24MHz so that the
sampling rates goes up from 100K samples per second to 800K
samples per second on AM335x and AM437x SoC.

Also increase opendelay for touchscreen configuration to
equalize the increase in ADC reference clock frequency,
which results in the same amount touch events reported via
evtest on AM335x GP EVM.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---

This patch depends on ADC DMA patch series [1]

Without DMA support, when ADC ref clock is set at 24MHz, I am
seeing fifo overflow as CPU is not able to pull the ADC samples.
This answers that DMA support is must for ADC to consume the
samples generated at 24MHz with no open, step delay or
averaging with patch [2].

Measured the performance with the iio_generic_buffer with the
patch [3] applied

[1] - http://www.spinics.net/lists/devicetree/msg145045.html
[2] - http://pastebin.ubuntu.com/23357935/
[3] - http://pastebin.ubuntu.com/23357939/

---
 include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index b9a53e0..96c4207 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -90,7 +90,7 @@
 /* Delay register */
 #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
 #define STEPDELAY_OPEN(val)	((val) << 0)
-#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
+#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x500)
 #define STEPDELAY_SAMPLE_MASK	(0xFF << 24)
 #define STEPDELAY_SAMPLE(val)	((val) << 24)
 #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
@@ -137,7 +137,7 @@
 #define SEQ_STATUS BIT(5)
 #define CHARGE_STEP		0x11
 
-#define ADC_CLK			3000000
+#define ADC_CLK			24000000
 #define TOTAL_STEPS		16
 #define TOTAL_CHANNELS		8
 #define FIFO1_THRESHOLD		19
-- 
2.10.1.502.g6598894
