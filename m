From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 2/3] ARM: configs: omap2plus_defconfig: Enable support for
 micrell phys
Date: Thu, 19 Jan 2017 14:07:49 +0100
Message-ID: <1484831270-7251-2-git-send-email-t.remmet@phytec.de>
References: <1484831270-7251-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484831270-7251-1-git-send-email-t.remmet@phytec.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Wadim Egorov <w.egorov@phytec.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

The phyCORE-AM335x SoM with PCM-953 carrierboard has a
KSZ9021 phy mounted. To add support for this we need to enable
the micrell phy driver in the config.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 195c98b..0c2bf2d 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -168,6 +168,7 @@ CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
+CONFIG_MICREL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_SMSC75XX=m
-- 
1.9.1
