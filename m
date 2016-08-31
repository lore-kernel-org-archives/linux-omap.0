From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Wed, 31 Aug 2016 09:59:59 -0700
Message-ID: <20160831165959.3sldcjxaci3kdx6z@atomide.com>
References: <20160829182746.53vrgbxadqodzzug@atomide.com>
 <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
 <20160831141340.h24szdqjnicmt2ew@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20160831141340.h24szdqjnicmt2ew@atomide.com>
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

* Tony Lindgren <tony@atomide.com> [160831 07:14]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160831 04:38]:
> > If we have McBSP w/o FIFO there is no need for the qos AFAIK.
> > I'm fine with the 30ms, if you have done the testing on OMAP3.McBSP2, probably
> > setting 30ms for McBSP with 1280 FIFO, 3ms for 128 FIFO and no qos for McBSP
> > w/o FIFO might be better. Or:
> > 
> > latency = mcbsp->pdata->buffer_size * 23; /* 29.44ms on omap3's mcbsp2 */
> > 
> > if (latency)
> > 	pm_qos_add_request(&mcbsp->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
> > 			   latency);
> 
> OK let me run some tests with that and mcbsp2 fifo set to 128. My guess
> is that things already work for that case with no patches with the existing
> fifo based  snd_pcm_hw_constraint_step() setting limits low enough so
> we never enter deeper idle states, but let's see :)

Well not quite so :) The fixed limit of 30 ms also works with fifo
set to 128, but we still have audio fail without any patches.

So basically anything blocking off idle for cpuidle is enough. Retention
idle is OK to allow. With your calculation retention idle never happens
when FIFO size is 128. It seems the latency value should eventually be SoC
and cpuidle policy specific that we can probably do with dev_pm_qos once
we have set_latency_tolerance implemented.

I've also confirmed that we're hitting retention idle while playing
a wav or mp3 file on omap3 even with FIFO limited to 128 and updated
the patch description accordingly.

Updated version of the patch below.

Regards,

Tony

8< -----------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 29 Aug 2016 11:27:46 -0700
Subject: [PATCHv3] ASoC: omap-mcbsp: Add PM QoS support for McBSP to prevent
 glitches

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

The value for the latency should eventually come from SoC specific
configured value for dev_pm_qos, but we can use the measured value
for now.

I've confirmed that we are hitting core retention on omap3 while
playing a wav and mp3 file even with mcbsp2 FIFO set to 128 bytes.
If somebody needs to hit off idle while playing and gets it somehow
working, we can set the latency requirements accordingly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v1 & 2:

- Configure the latency during init in case we need to set
  SoC and cpuidle specific values later on

- Update description and comments for latency requirements

 sound/soc/omap/mcbsp.c | 21 +++++++++++++++++++++
 sound/soc/omap/mcbsp.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
@@ -643,6 +644,11 @@ void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
 	int enable_srg = 0;
 	u16 w;
 
+	/* Prevent omap hardware from hitting off between fifo fills */
+	if (mcbsp->latency)
+		pm_qos_add_request(&mcbsp->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
+				   mcbsp->latency);
+
 	if (mcbsp->st_data)
 		omap_st_start(mcbsp);
 
@@ -731,6 +737,8 @@ void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx)
 
 	if (mcbsp->st_data)
 		omap_st_stop(mcbsp);
+
+	pm_qos_remove_request(&mcbsp->pm_qos_req);
 }
 
 int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
@@ -1064,6 +1072,16 @@ int omap_mcbsp_init(struct platform_device *pdev)
 		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
 		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
 
+		/*
+		 * Prevent device from hitting deeper idle states between
+		 * DMA fifo loads. On omap3 mcbsp2 we have a larger FIFO of
+		 * 1280 bytes instead of the usual 128 bytes, and the measured
+		 * max latency we can tolerate is somewhere below 40 ms. To be
+		 * safe, use a fixed value of 30 ms to block off idle on omap3
+		 * while still allowing retention idle.
+		 */
+		mcbsp->latency = 30 * 1000;
+
 		ret = sysfs_create_group(&mcbsp->dev->kobj,
 					 &additional_attr_group);
 		if (ret) {
@@ -1098,6 +1116,9 @@ err_thres:
 
 void omap_mcbsp_cleanup(struct omap_mcbsp *mcbsp)
 {
+	if (pm_qos_request_active(&mcbsp->pm_qos_req))
+		pm_qos_remove_request(&mcbsp->pm_qos_req);
+
 	if (mcbsp->pdata->buffer_size)
 		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
 
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -325,6 +325,9 @@ struct omap_mcbsp {
 	unsigned int in_freq;
 	int clk_div;
 	int wlen;
+
+	s32 latency;
+	struct pm_qos_request pm_qos_req;
 };
 
 void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
-- 
2.9.3
