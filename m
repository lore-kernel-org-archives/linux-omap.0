From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/3] bus: ti-sysc: re-order reset and main clock controls
Date: Mon, 7 Oct 2019 15:29:29 +0300
Message-ID: <20191007122931.18668-2-t-kristo@ti.com>
References: <20191007122931.18668-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191007122931.18668-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The main clocks and reset controls have a hardware level dependency,
where one can't transition state without the other one transitioning.
Because we don't have the dependency implemented in software, we must
ensure the ordering of these two is done properly; they way this is
handled is that clocks transition on software level without delay,
and the status is only polled on reset side. Because of this, we must
re-order the main clock and reset handling on the ti-sysc driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/bus/ti-sysc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 193d8b23d54d..c9d01e2d3a64 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1032,8 +1032,6 @@ static int __maybe_unused sysc_runtime_resume_legacy(struct device *dev,
 	struct ti_sysc_platform_data *pdata;
 	int error;
 
-	reset_control_deassert(ddata->rsts);
-
 	pdata = dev_get_platdata(ddata->dev);
 	if (!pdata)
 		return 0;
@@ -1046,6 +1044,8 @@ static int __maybe_unused sysc_runtime_resume_legacy(struct device *dev,
 		dev_err(dev, "%s: could not enable: %i\n",
 			__func__, error);
 
+	reset_control_deassert(ddata->rsts);
+
 	return 0;
 }
 
@@ -1099,8 +1099,6 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 
 	sysc_clkdm_deny_idle(ddata);
 
-	reset_control_deassert(ddata->rsts);
-
 	if (sysc_opt_clks_needed(ddata)) {
 		error = sysc_enable_opt_clocks(ddata);
 		if (error)
@@ -1111,6 +1109,8 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 	if (error)
 		goto err_opt_clocks;
 
+	reset_control_deassert(ddata->rsts);
+
 	if (ddata->legacy_mode) {
 		error = sysc_runtime_resume_legacy(dev, ddata);
 		if (error)
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
