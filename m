From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 3/5] staging: tidspbridge: Lindent to drv_interface.c
Date: Mon, 23 Jan 2012 22:09:46 +0200
Message-ID: <7103a353d393f9b8366b141a608a4370e4392c7b.1327348286.git.vjaquez@igalia.com>
References: <cover.1327348286.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1327348286.git.vjaquez@igalia.com>
In-Reply-To: <cover.1327348286.git.vjaquez@igalia.com>
References: <cover.1327348286.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>
List-Id: linux-omap@vger.kernel.org

No functional changes.

According to Lindent, the file drv_internface.c had some lines with bad
indentation.

This commit is the output of Lindent.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |   22 +++++++++++---=
--------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers=
/staging/tidspbridge/rmgr/drv_interface.c
index 5ea753c..c7015f5 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -147,7 +147,7 @@ static int bridge_open(struct inode *ip, struct fil=
e *filp)
 #ifdef CONFIG_TIDSPBRIDGE_RECOVERY
 	if (recover) {
 		if (filp->f_flags & O_NONBLOCK ||
-			wait_for_completion_interruptible(&bridge_open_comp))
+		    wait_for_completion_interruptible(&bridge_open_comp))
 			return -EBUSY;
 	}
 #endif
@@ -245,7 +245,7 @@ static long bridge_ioctl(struct file *filp, unsigne=
d int code,
=20
 	if (!status) {
 		status =3D api_call_dev_ioctl(code, &buf_in, &retval,
-					     filp->private_data);
+					    filp->private_data);
=20
 		if (!status) {
 			status =3D retval;
@@ -342,9 +342,10 @@ static void bridge_recover(struct work_struct *wor=
k)
 	if (atomic_read(&bridge_cref)) {
 		INIT_COMPLETION(bridge_comp);
 		while (!wait_for_completion_timeout(&bridge_comp,
-						msecs_to_jiffies(REC_TIMEOUT)))
-			pr_info("%s:%d handle(s) still opened\n",
-					__func__, atomic_read(&bridge_cref));
+						    msecs_to_jiffies
+						    (REC_TIMEOUT)))
+			pr_info("%s:%d handle(s) still opened\n", __func__,
+				atomic_read(&bridge_cref));
 	}
 	dev =3D dev_get_first();
 	dev_get_dev_node(dev, &dev_node);
@@ -363,10 +364,10 @@ void bridge_recover_schedule(void)
 #endif
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 static int dspbridge_scale_notification(struct notifier_block *op,
-		unsigned long val, void *ptr)
+					unsigned long val, void *ptr)
 {
 	struct omap_dsp_platform_data *pdata =3D
-		omap_dspbridge_dev->dev.platform_data;
+	    omap_dspbridge_dev->dev.platform_data;
=20
 	if (CPUFREQ_POSTCHANGE =3D=3D val && pdata->dsp_get_opp)
 		pwr_pm_post_scale(PRCM_VDD1, pdata->dsp_get_opp());
@@ -413,7 +414,7 @@ static int omap3_bridge_startup(struct platform_dev=
ice *pdev)
 					CPUFREQ_TRANSITION_NOTIFIER);
 	if (err)
 		pr_err("%s: clk_notifier_register failed for iva2_ck\n",
-								__func__);
+		       __func__);
 #endif
 #endif
=20
@@ -471,7 +472,7 @@ err2:
 err1:
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 	cpufreq_unregister_notifier(&iva_clk_notifier,
-					CPUFREQ_TRANSITION_NOTIFIER);
+				    CPUFREQ_TRANSITION_NOTIFIER);
 #endif
 	dsp_clk_exit();
=20
@@ -547,10 +548,9 @@ static int __devexit omap34_xx_bridge_remove(struc=
t platform_device *pdev)
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
 		goto func_cont;
 	}
-
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 	if (cpufreq_unregister_notifier(&iva_clk_notifier,
-						CPUFREQ_TRANSITION_NOTIFIER))
+					CPUFREQ_TRANSITION_NOTIFIER))
 		pr_err("%s: cpufreq_unregister_notifier failed for iva2_ck\n",
 		       __func__);
 #endif /* #ifdef CONFIG_TIDSPBRIDGE_DVFS */
--=20
1.7.8.3
