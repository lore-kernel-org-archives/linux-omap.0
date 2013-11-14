From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3] ARM: OMAP2+: omap_device: maintain sane runtime pm status
 around suspend/resume
Date: Thu, 14 Nov 2013 11:05:16 -0600
Message-ID: <1384448716-3186-1-git-send-email-nm@ti.com>
References: <1384297710-29694-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384297710-29694-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com
Cc: Nishanth Menon <nm@ti.com>, khilman@linaro.org, rnayak@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

OMAP device hooks around suspend|resume_noirq ensures that hwmod
devices are forced to idle using omap_device_idle/enable as part of
the last stage of suspend activity.

For a device such as i2c who uses autosuspend, it is possible to enter
the suspend path with dev->power.runtime_status = RPM_ACTIVE.

As part of the suspend flow, the generic runtime logic would increment
it's dev->power.disable_depth to 1. This should prevent further
pm_runtime_get_sync from succeeding once the runtime_status has been
set to RPM_SUSPENDED.

Now, as part of the suspend_noirq handler in omap_device, we force the
following: if the device status is !suspended, we force the device
to idle using omap_device_idle (clocks are cut etc..). This ensures
that from a hardware perspective, the device is "suspended". However,
runtime_status is left to be active.

*if* an operation is attempted after this point to
pm_runtime_get_sync, runtime framework depends on runtime_status to
indicate accurately the device status, and since it sees it to be
ACTIVE, it assumes the module is functional and returns a non-error
value. As a result the user will see pm_runtime_get succeed, however a
register access will crash due to the lack of clocks.

To prevent this from happening, we should ensure that runtime_status
exactly indicates the device status. As a result of this change
any further calls to pm_runtime_get* would return -EACCES (since
disable_depth is 1). On resume, we restore the clocks and runtime
status exactly as we suspended with. These operations are not expected
to fail as we update the states after the core runtime framework has
suspended itself and restore before the core runtime framework has
resumed.

Reported-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Kevin Hilman <khilman@linaro.org>
---
Changes in V3:
	- Added WARN in case of unexpected failure of runtime pm status restore
v2: https://patchwork.kernel.org/patch/3176501/
v1: https://patchwork.kernel.org/patch/3154501/

patch baseline: V3.12 tag (also applies on linux-next next-20131107 tag)

 arch/arm/mach-omap2/omap_device.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index b69dd9a..53f0735 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -621,6 +621,7 @@ static int _od_suspend_noirq(struct device *dev)
 
 	if (!ret && !pm_runtime_status_suspended(dev)) {
 		if (pm_generic_runtime_suspend(dev) == 0) {
+			pm_runtime_set_suspended(dev);
 			omap_device_idle(pdev);
 			od->flags |= OMAP_DEVICE_SUSPENDED;
 		}
@@ -634,10 +635,18 @@ static int _od_resume_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od = to_omap_device(pdev);
 
-	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
-	    !pm_runtime_status_suspended(dev)) {
+	if (od->flags & OMAP_DEVICE_SUSPENDED) {
 		od->flags &= ~OMAP_DEVICE_SUSPENDED;
 		omap_device_enable(pdev);
+		/*
+		 * XXX: we run before core runtime pm has resumed itself. At
+		 * this point in time, we just restore the runtime pm state and
+		 * considering symmetric operations in resume, we donot expect
+		 * to fail. If we failed, something changed in core runtime_pm
+		 * framework OR some device driver messed things up, hence, WARN
+		 */
+		WARN(pm_runtime_set_active(dev),
+		     "Could not set %s runtime state active\n", dev_name(dev));
 		pm_generic_runtime_resume(dev);
 	}
 
-- 
1.7.9.5
