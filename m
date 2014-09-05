From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v6 3/3] MAINTAINERS: Add dwc3-st.c file to ARCH/STI architecture
Date: Fri,  5 Sep 2014 16:36:32 +0100
Message-ID: <1409931392-22340-4-git-send-email-peter.griffin@linaro.org>
References: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-omap@vger.kernel.org

This patch adds the new dwc3-st.c glue driver found on
STMicroelectronics stih407 consumer electronics SoC's into the STI
arch section of the maintainers file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf24bb5..55381955 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1398,6 +1398,7 @@ F:	drivers/media/rc/st_rc.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/tty/serial/st-asc.c
 F:	drivers/mmc/host/sdhci-st.c
+F:	drivers/usb/dwc3/dwc3-st.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
