From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP2+: Add rtc hwmod configuration for ti81xx
Date: Mon, 22 Feb 2016 15:04:03 -0800
Message-ID: <1456182245-1843-3-git-send-email-tony@atomide.com>
References: <1456182245-1843-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456182245-1843-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This allows RTC to work properly with the related DTS
changes.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index f8cc400..39736ad 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -228,6 +228,42 @@ static struct omap_hwmod_ocp_if dm816x_mpu__alwon_l3_med = {
 	.user	= OCP_USER_MPU,
 };
 
+/* RTC */
+static struct omap_hwmod_class_sysconfig ti81xx_rtc_sysc = {
+	.rev_offs	= 0x74,
+	.sysc_offs	= 0x78,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO |
+			  SIDLE_SMART | SIDLE_SMART_WKUP,
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class ti81xx_rtc_hwmod_class = {
+	.name		= "rtc",
+	.sysc		= &ti81xx_rtc_sysc,
+};
+
+struct omap_hwmod ti81xx_rtc_hwmod = {
+	.name		= "rtc",
+	.class		= &ti81xx_rtc_hwmod_class,
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.flags		= HWMOD_NO_IDLEST,
+	.main_clk	= "sysclk18_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = DM81XX_CM_ALWON_RTC_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_ocp_if ti81xx_l4_ls__rtc = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &ti81xx_rtc_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
 /* UART common */
 static struct omap_hwmod_class_sysconfig uart_sysc = {
 	.rev_offs	= 0x50,
@@ -1381,6 +1417,7 @@ static struct omap_hwmod_ocp_if *dm814x_hwmod_ocp_ifs[] __initdata = {
 	&dm81xx_l4_ls__mcspi1,
 	&dm814x_l4_ls__mmc1,
 	&dm814x_l4_ls__mmc2,
+	&ti81xx_l4_ls__rtc,
 	&dm81xx_alwon_l3_fast__tpcc,
 	&dm81xx_alwon_l3_fast__tptc0,
 	&dm81xx_alwon_l3_fast__tptc1,
@@ -1420,6 +1457,7 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm81xx_l4_ls__gpio1,
 	&dm81xx_l4_ls__gpio2,
 	&dm81xx_l4_ls__elm,
+	&ti81xx_l4_ls__rtc,
 	&dm816x_l4_ls__mmc1,
 	&dm816x_l4_ls__timer1,
 	&dm816x_l4_ls__timer2,
-- 
2.7.0
