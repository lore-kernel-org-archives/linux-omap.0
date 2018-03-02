From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: Enable OTG and MUSB as loadable
 modules
Date: Fri,  2 Mar 2018 09:32:17 -0800
Message-ID: <20180302173219.46112-2-tony@atomide.com>
References: <20180302173219.46112-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180302173219.46112-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can support USB OTG with MUSB driver on many ARM SoCs. Let's
enable all the SoCs with MUSB as loadable modules. And let's enable
their related DMA hardware.

And as MUSB is an USB OTG controller, let's enable OTG support too.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -683,6 +683,7 @@ CONFIG_SND_SOC_STI=m
 CONFIG_SND_SOC_STI_SAS=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_USB=y
+CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
 CONFIG_USB_XHCI_RCAR=m
@@ -704,6 +705,15 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=m
 CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_SUNXI=m
+CONFIG_USB_MUSB_TUSB6010=m
+CONFIG_USB_MUSB_OMAP2PLUS=m
+CONFIG_USB_MUSB_AM35X=m
+CONFIG_USB_MUSB_DSPS=m
+CONFIG_USB_MUSB_UX500=m
+CONFIG_USB_UX500_DMA=y
+CONFIG_USB_INVENTRA_DMA=y
+CONFIG_USB_TI_CPPI41_DMA=y
+CONFIG_USB_TUSB_OMAP_DMA=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_HSIC_USB3503=y
-- 
2.16.2
