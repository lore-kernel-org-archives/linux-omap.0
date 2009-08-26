From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Audio capture not working with AIC23/McBSP1 on
 OMAP3517
Date: Wed, 26 Aug 2009 18:01:41 +0300
Message-ID: <20090826180141.37dca666.jhnikula@gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com>
	<20090826130356.GB29299@sirena.org.uk>
	<20090826164239.a574d4ab.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090826164239.a574d4ab.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 26 Aug 2009 16:42:39 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Those recent patches should not any effect into this since they are
> mostly playing with the McBSP and DMA interfacing. What comes to my
> mind if muxing is correct and if codec is master, this might be related
> to those McBSP1 FSR and CLKR setup.
> 
Anuj: I think the issue is here that by default McBSP1 receiver is
using the CLKR and FSR pins and if those are not connected, then the
capture doesn't work. Can you try a patch below and add following lines
into your machine driver?

snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_CLKX, 0,
SND_SOC_CLOCK_IN);
snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
SND_SOC_CLOCK_IN);

Patch is compile tested only, generated against mainline 2.6.31-rc7 but should
apply to ALSA tree as well.


-- 
Jarkko

==================== CUT HERE ====================
From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: OMAP: Add functionality to set CLKR and FSR sources in McBSP DAI

The McBSP1 port in OMAP3 processors (I believe OMAP2 too but I don't have
specifications to check it) have additional CLKR and FSR pins for McBSP1
receiver. Reset default is that receiver is using bit clock and frame
sync signal from those pins but it is possible to configure to use
also CLKX and FSX pins as well. In fact, other McBSP ports are doing that
internally that transmitter and receiver share the CLKX and FSX.

Add functionaly that machine drivers can set the CLKR and FSR sources by
using the snd_soc_dai_set_sysclk.

Thanks to "Aggarwal, Anuj" <anuj.aggarwal@ti.com> for reporting the issue.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/omap-mcbsp.c |   41 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-mcbsp.h |    4 ++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index a5d46a7..2ea2136 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -462,6 +462,40 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 	return 0;
 }
 
+static int omap_mcbsp_dai_set_rcvr_src(struct omap_mcbsp_data *mcbsp_data,
+				       int clk_id)
+{
+	int sel_bit, set = 0;
+	u16 reg = OMAP2_CONTROL_DEVCONF0;
+
+	if (cpu_class_is_omap1())
+		return -EINVAL; /* TODO: Can this be implemented for OMAP1? */
+	if (mcbsp_data->bus_id != 0)
+		return -EINVAL;
+
+	switch (clk_id) {
+	case OMAP_MCBSP_CLKR_SRC_CLKX:
+		set = 1;
+	case OMAP_MCBSP_CLKR_SRC_CLKR:
+		sel_bit = 3;
+		break;
+	case OMAP_MCBSP_FSR_SRC_FSX:
+		set = 1;
+	case OMAP_MCBSP_FSR_SRC_FSR:
+		sel_bit = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (set)
+		omap_ctrl_writel(omap_ctrl_readl(reg) | (1 << sel_bit), reg);
+	else
+		omap_ctrl_writel(omap_ctrl_readl(reg) & ~(1 << sel_bit), reg);
+
+	return 0;
+}
+
 static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					 int clk_id, unsigned int freq,
 					 int dir)
@@ -484,6 +518,13 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
 		regs->pcr0	|= SCLKME;
 		break;
+
+	case OMAP_MCBSP_CLKR_SRC_CLKR:
+	case OMAP_MCBSP_CLKR_SRC_CLKX:
+	case OMAP_MCBSP_FSR_SRC_FSR:
+	case OMAP_MCBSP_FSR_SRC_FSX:
+		err = omap_mcbsp_dai_set_rcvr_src(mcbsp_data, clk_id);
+		break;
 	default:
 		err = -ENODEV;
 	}
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index c8147aa..647d2f9 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -32,6 +32,10 @@ enum omap_mcbsp_clksrg_clk {
 	OMAP_MCBSP_SYSCLK_CLK,		/* Internal ICLK */
 	OMAP_MCBSP_SYSCLK_CLKX_EXT,	/* External CLKX pin */
 	OMAP_MCBSP_SYSCLK_CLKR_EXT,	/* External CLKR pin */
+	OMAP_MCBSP_CLKR_SRC_CLKR,	/* CLKR from CLKR pin */
+	OMAP_MCBSP_CLKR_SRC_CLKX,	/* CLKR from CLKX pin */
+	OMAP_MCBSP_FSR_SRC_FSR,		/* FSR from FSR pin */
+	OMAP_MCBSP_FSR_SRC_FSX,		/* FSR from FSX pin */
 };
 
 /* McBSP dividers */
-- 
1.6.3.3
