From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 17/17] remoteproc/omap: fix auto-suspend failure warning during crashed state
Date: Mon, 28 Oct 2019 14:42:38 +0200
Message-ID: <20191028124238.19224-18-t-kristo@ti.com>
References: <20191028124238.19224-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191028124238.19224-1-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The runtime autosuspend on a OMAP remoteproc device is attempted when
the suspend timer expires (autosuspend delay elapsed since the last
time the device is busy). This is the normal autosuspend scenario
for a device functioning normally. This timer can also expire during
the debugging of a remoteproc crash when the remoteproc recovery is
disabled. This is an invalid pre-condition though, so check for the
RPROC_CRASHED state and bail out before the actual check for the
RPROC_RUNNING state. The auto-suspend is also not re-attempted until
the remoteproc is recovered and restored to normal functional state.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/remoteproc/omap_remoteproc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 2eb05d7a4dec..1dfac82224f7 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -945,6 +945,11 @@ static int omap_rproc_runtime_suspend(struct device *dev)
 	struct omap_rproc *oproc = rproc->priv;
 	int ret;
 
+	if (rproc->state == RPROC_CRASHED) {
+		dev_dbg(dev, "rproc cannot be runtime suspended when crashed!\n");
+		return -EBUSY;
+	}
+
 	if (WARN_ON(rproc->state != RPROC_RUNNING)) {
 		dev_err(dev, "rproc cannot be runtime suspended when not running!\n");
 		return -EBUSY;
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
