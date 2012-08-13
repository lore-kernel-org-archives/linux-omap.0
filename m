From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/9] ARM: OMAP: board-am3517evm: Configure
	McBSP1 CLKR/FSR signal source
Date: Mon, 13 Aug 2012 17:22:42 +0300
Message-ID: <1344867768-26335-4-git-send-email-peter.ujfalusi@ti.com>
References: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

am3517evm board uses McBSP1 for audio with 4pin configuration.
The CLKR/FSR signals need to be connected to CLKX/FSX pin of the SoC in
this case.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 18f6010..592812a 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -264,6 +264,16 @@ static __init void am3517_evm_musb_init(void)
 	usb_musb_init(&musb_board_data);
 }
 
+static __init void am3517_evm_mcbsp1_init(void)
+{
+	u32 devconf0;
+
+	/* McBSP1 CLKR/FSR signal to be connected to CLKX/FSX pin */
+	devconf0 = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	devconf0 |=  OMAP2_MCBSP1_CLKR_MASK | OMAP2_MCBSP1_FSR_MASK;
+	omap_ctrl_writel(devconf0, OMAP2_CONTROL_DEVCONF0);
+}
+
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
@@ -373,6 +383,9 @@ static void __init am3517_evm_init(void)
 	/* MUSB */
 	am3517_evm_musb_init();
 
+	/* McBSP1 */
+	am3517_evm_mcbsp1_init();
+
 	/* MMC init function */
 	omap_hsmmc_init(mmc);
 }
-- 
1.7.8.6
