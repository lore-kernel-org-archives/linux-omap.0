From: lukasz.luba@arm.com
Subject: [PATCH 4/4] drm/panfrost: Register to the Energy Model with devfreq device
Date: Thu, 16 Jan 2020 15:20:32 +0000
Message-ID: <20200116152032.11301-5-lukasz.luba@arm.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200116152032.11301-1-lukasz.luba@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com
Cc: Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org, qperret@google.com, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org, matthias.bgg@gmail.com, steven.price@arm.com, tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
List-Id: linux-omap@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Let Panfrost devfreq device use the Energy Model (EM). The EM can be used
in thermal subsystem (devfreq_cooling) for calculating the used power.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbf..8771782f67c6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -105,6 +105,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	}
 	pfdev->devfreq.devfreq = devfreq;
 
+	dev_pm_opp_of_register_em(dev);
+
 	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
 	if (IS_ERR(cooling))
 		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
@@ -118,6 +120,7 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 {
 	if (pfdev->devfreq.cooling)
 		devfreq_cooling_unregister(pfdev->devfreq.cooling);
+	dev_pm_opp_of_unregister_em(&pfdev->pdev->dev);
 	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
 }
 
-- 
2.17.1
