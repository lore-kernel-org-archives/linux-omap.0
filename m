From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/18] omap2: Add OHCI USB platform init for 2430 SDP
Date: Wed, 05 May 2010 12:32:46 -0700
Message-ID: <20100505193246.21568.16641.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Viral Mehta <viral.mehta@lntinfotech.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Viral Mehta <viral.mehta@lntinfotech.com>

Add platform init code for OHCI USB on OMAP2430 SDP

Signed-off-by: Viral Mehta <viral.mehta@lntinfotech.com>
[tony@atomide.com: Updated subject to mention the board name]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 85f5f33..a11a575 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -207,6 +207,15 @@ static struct omap_musb_board_data musb_board_data = {
 	.mode			= MUSB_OTG,
 	.power			= 100,
 };
+static struct omap_usb_config sdp2430_usb_config __initdata = {
+	.otg		= 1,
+#ifdef  CONFIG_USB_GADGET_OMAP
+	.hmc_mode	= 0x0,
+#elif   defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+	.hmc_mode	= 0x1,
+#endif
+	.pins[0]	= 3,
+};
 
 static void __init omap_2430sdp_init(void)
 {
@@ -217,6 +226,7 @@ static void __init omap_2430sdp_init(void)
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
 	omap2_hsmmc_init(mmc);
+	omap_usb_init(&sdp2430_usb_config);
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
