From: David Lambert <dlambert@ti.com>
Subject: [PATCH v2 4/4] OMAP4: DMIC: Add DMIC codec platform
	devices
Date: Thu,  6 Jan 2011 08:00:39 -0600
Message-ID: <1294322439-16305-5-git-send-email-dlambert@ti.com>
References: <1294322439-16305-1-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1294322439-16305-1-git-send-email-dlambert@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Lambert <dlambert@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

This creates the DMIC codec platform devices.

The platform devices create an instance of the driver during boot up.

Signed-off-by: David Lambert <dlambert@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index df5a425..e7745cf 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -505,6 +505,16 @@ static void __init omap_sfh7741prox_init(void)
 	}
 }
 
+static struct platform_device codec_dmic0 = {
+	.name   = "dmic-codec",
+	.id     = -1,
+};
+
+static inline void omap_dmic_init(void)
+{
+	platform_device_register(&codec_dmic0);
+}
+
 static void __init omap_4430sdp_init(void)
 {
 	int status;
@@ -528,6 +538,7 @@ static void __init omap_4430sdp_init(void)
 		spi_register_board_info(sdp4430_spi_board_info,
 				ARRAY_SIZE(sdp4430_spi_board_info));
 	}
+	omap_dmic_init();
 }
 
 static void __init omap_4430sdp_map_io(void)
-- 
1.7.0.4
