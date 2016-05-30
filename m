From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 3/7] ARM: OMAP3: McBSP: New callback for
	McBSP2/3 ICLK idle configuration
Date: Mon, 30 May 2016 11:23:46 +0300
Message-ID: <20160530082350.24285-4-peter.ujfalusi@ti.com>
References: <20160530082350.24285-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160530082350.24285-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

McBSP2/3 module's sidetone module operates using the module's ICLK clock.
When the Sidetone is in use the interface clock of the module must not
idle. The new callback expects to receive the *clk of the module's ick and
not the id number of the McBSP. This will allow us more cleanups and going
to simplify the ICLK handling.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c                 | 12 ++++++++++++
 include/linux/platform_data/asoc-ti-mcbsp.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index b4ac3af1160c..959cb4cb1062 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -48,6 +48,17 @@ static int omap3_enable_st_clock(unsigned int id, bool enable)
 		return omap2_clk_allow_idle(mcbsp_iclks[id]);
 }
 
+static int omap3_mcbsp_force_ick_on(struct clk *clk, bool force_on)
+{
+	if (!clk)
+		return 0;
+
+	if (force_on)
+		return omap2_clk_deny_idle(clk);
+	else
+		return omap2_clk_allow_idle(clk);
+}
+
 static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 {
 	int id, count = 1;
@@ -97,6 +108,7 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		oh_device[1] = omap_hwmod_lookup((
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
 		pdata->enable_st_clock = omap3_enable_st_clock;
+		pdata->force_ick_on = omap3_mcbsp_force_ick_on;
 		sprintf(clk_name, "mcbsp%d_ick", id);
 		mcbsp_iclks[id] = clk_get(NULL, clk_name);
 		count++;
diff --git a/include/linux/platform_data/asoc-ti-mcbsp.h b/include/linux/platform_data/asoc-ti-mcbsp.h
index 3c73c045f8da..73e5e832fa23 100644
--- a/include/linux/platform_data/asoc-ti-mcbsp.h
+++ b/include/linux/platform_data/asoc-ti-mcbsp.h
@@ -45,6 +45,7 @@ struct omap_mcbsp_platform_data {
 	bool has_wakeup; /* Wakeup capability */
 	bool has_ccr; /* Transceiver has configuration control registers */
 	int (*enable_st_clock)(unsigned int, bool);
+	int (*force_ick_on)(struct clk *clk, bool force_on);
 };
 
 /**
-- 
2.8.3
