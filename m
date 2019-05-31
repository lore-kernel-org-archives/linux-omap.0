From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/3] hwspinlock/omap: Add a trace during probe
Date: Thu, 30 May 2019 21:13:21 -0500
Message-ID: <20190531021321.14025-4-s-anna@ti.com>
References: <20190531021321.14025-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190531021321.14025-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add a debug level trace statement in the OMAP HwSpinlock driver
probe function to print the number of hwlocks on a successful
registration.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index a4d7a7bc863a..14e1a532ebb5 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -140,6 +140,9 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (ret)
 		goto reg_fail;
 
+	dev_dbg(&pdev->dev, "Registered %d locks with HwSpinlock core\n",
+		num_locks);
+
 	return 0;
 
 reg_fail:
-- 
2.21.0
