From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for McBSP
 to prevent glitches
Date: Mon, 29 Aug 2016 11:27:46 -0700
Message-ID: <20160829182746.53vrgbxadqodzzug@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machel <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We can get audio errors if hitting deeper idle states on omaps:

[alsa.c:230] error: Fatal problem with alsa output, error -5.
[audio.c:614] error: Error in writing audio (Input/output error?)!

This seems to happen with off mode idle enabled as power for the
whole SoC may get cut off between filling the McBSP fifo using DMA.
While active DMA blocks deeper idle states in hardware, McBSP
activity does not seem to do so.

Let's fix the issue by adding PM QoS latency requirement for McBSP.
Based on my experiments a working latency value is somewhere
around 35 ms with 40 ms breaking. So let's use a safer value of 30 ms.

Note that this is different from snd_pcm_hw_constraint_step() as
that can configure things based on the buffer and period size.
However, that does not help to block idle between the fifo fills.

Note that in theory some omaps are capable of playing audio while
hitting deeper idle states. If somebody needs that and gets it
working, we can set the latency requirements accordingly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 sound/soc/omap/mcbsp.c | 10 ++++++++++
 sound/soc/omap/mcbsp.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
@@ -643,6 +644,10 @@ void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
 	int enable_srg = 0;
 	u16 w;
 
+	/* Prevent omap hardware from hitting off between fifo fills */
+	pm_qos_add_request(&mcbsp->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
+			   30 * 1000);
+
 	if (mcbsp->st_data)
 		omap_st_start(mcbsp);
 
@@ -731,6 +736,8 @@ void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx)
 
 	if (mcbsp->st_data)
 		omap_st_stop(mcbsp);
+
+	pm_qos_remove_request(&mcbsp->pm_qos_req);
 }
 
 int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
@@ -1098,6 +1105,9 @@ err_thres:
 
 void omap_mcbsp_cleanup(struct omap_mcbsp *mcbsp)
 {
+	if (dev_pm_qos_request_active(&mcbsp->pm_qos_req))
+		pm_qos_remove_request(&mcbsp->pm_qos_req);
+
 	if (mcbsp->pdata->buffer_size)
 		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
 
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 61e93b1..e603f33 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -325,6 +325,8 @@ struct omap_mcbsp {
 	unsigned int in_freq;
 	int clk_div;
 	int wlen;
+
+	struct pm_qos_request pm_qos_req;
 };
 
 void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
-- 
2.9.3
