From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1 compilation
	problem
Date: Tue, 2 Nov 2010 15:50:32 +0100
Message-ID: <201011021550.34885.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Paul Walmsley <paul@pwsan.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, e3-hacking@earth.li, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

In the new code introduced with commit cf4c87abe238ec17cd0255b4e21abd949d7f811e,
"OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c",
the way omap1 build is supposed to bypass omap2 specific functionality doesn't 
optimize out all omap2 specific stuff. This breaks linking phase for omap1 
machines, giving "undefined reference to `omap2_mcbsp1_mux_clkr_src'" 
and "undefined reference to `omap2_mcbsp1_mux_fsr_src'" errors. Fix it.

Created and tested against linux-2.6.37-rc1.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---

 sound/soc/omap/omap-mcbsp.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.37-rc1/sound/soc/omap/omap-mcbsp.c.orig	2010-11-01 22:43:16.000000000 +0100
+++ linux-2.6.37-rc1/sound/soc/omap/omap-mcbsp.c	2010-11-02 15:41:42.000000000 +0100
@@ -644,15 +644,23 @@ static int omap_mcbsp_dai_set_dai_sysclk
 
 
 	case OMAP_MCBSP_CLKR_SRC_CLKR:
+		if (cpu_class_is_omap1())
+			break;
 		omap2_mcbsp1_mux_clkr_src(CLKR_SRC_CLKR);
 		break;
 	case OMAP_MCBSP_CLKR_SRC_CLKX:
+		if (cpu_class_is_omap1())
+			break;
 		omap2_mcbsp1_mux_clkr_src(CLKR_SRC_CLKX);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSR:
+		if (cpu_class_is_omap1())
+			break;
 		omap2_mcbsp1_mux_fsr_src(FSR_SRC_FSR);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSX:
+		if (cpu_class_is_omap1())
+			break;
 		omap2_mcbsp1_mux_fsr_src(FSR_SRC_FSX);
 		break;
 	default:
