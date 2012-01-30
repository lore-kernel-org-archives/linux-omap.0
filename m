From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 3/8] staging: tidspbridge: Lindent to drv_interface.c
Date: Tue, 31 Jan 2012 00:12:19 +0100
Message-ID: <509e5ceb082a6530095218d5d2734b884c0627e5.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

No functional changes.

According to Lindent, the file drv_internface.c had some lines with bad
indentation.

This commit is the output of Lindent.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers=
/staging/tidspbridge/rmgr/drv_interface.c
index 5ea753c..4316f4e 100644
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
@@ -363,10 +363,10 @@ void bridge_recover_schedule(void)
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
@@ -471,7 +471,7 @@ err2:
 err1:
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 	cpufreq_unregister_notifier(&iva_clk_notifier,
-					CPUFREQ_TRANSITION_NOTIFIER);
+				    CPUFREQ_TRANSITION_NOTIFIER);
 #endif
 	dsp_clk_exit();
=20
@@ -550,7 +550,7 @@ static int __devexit omap34_xx_bridge_remove(struct=
 platform_device *pdev)
=20
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 	if (cpufreq_unregister_notifier(&iva_clk_notifier,
-						CPUFREQ_TRANSITION_NOTIFIER))
+					CPUFREQ_TRANSITION_NOTIFIER))
 		pr_err("%s: cpufreq_unregister_notifier failed for iva2_ck\n",
 		       __func__);
 #endif /* #ifdef CONFIG_TIDSPBRIDGE_DVFS */
--=20
1.7.8.3
