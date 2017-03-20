From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v4 1/3] phy: qcom-usb: Remove unused ulpi phy header
Date: Mon, 20 Mar 2017 18:49:55 +0530
Message-ID: <1490015997-12956-2-git-send-email-vivek.gautam@codeaurora.org>
References: <1490015997-12956-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1490015997-12956-1-git-send-email-vivek.gautam@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kishon@ti.com
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, Vivek Gautam <vivek.gautam@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Ulpi phy header is not used for anything. Remove the same
from qcom-hs and qcom-hsic phy drivers.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Suggested-by: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
---

 - New patch added in the series.
   Removing headers as per Stephen's suggestion.

 drivers/phy/phy-qcom-usb-hs.c   | 2 --
 drivers/phy/phy-qcom-usb-hsic.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/phy/phy-qcom-usb-hs.c b/drivers/phy/phy-qcom-usb-hs.c
index 94dfbfd739c3..43704f4f23e9 100644
--- a/drivers/phy/phy-qcom-usb-hs.c
+++ b/drivers/phy/phy-qcom-usb-hs.c
@@ -15,8 +15,6 @@
 #include <linux/extcon.h>
 #include <linux/notifier.h>
 
-#include "ulpi_phy.h"
-
 #define ULPI_PWR_CLK_MNG_REG		0x88
 # define ULPI_PWR_OTG_COMP_DISABLE	BIT(0)
 
diff --git a/drivers/phy/phy-qcom-usb-hsic.c b/drivers/phy/phy-qcom-usb-hsic.c
index 47690f9945b9..6dcaf04fa367 100644
--- a/drivers/phy/phy-qcom-usb-hsic.c
+++ b/drivers/phy/phy-qcom-usb-hsic.c
@@ -13,8 +13,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 
-#include "ulpi_phy.h"
-
 #define ULPI_HSIC_CFG		0x30
 #define ULPI_HSIC_IO_CAL	0x33
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
