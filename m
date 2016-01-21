From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Enable ARM_KERNMEM_PERMS and few
 loadable modules
Date: Thu, 21 Jan 2016 13:01:17 -0800
Message-ID: <1453410077-17024-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

With recent omap assembly fixes for CONFIG_DEBUG_RODATA, we can
now use DEBUG_RODATA. Let's enable ARM_KERNMEM_PERMS so that
DEBUG_RODATA gets selected by default. This way we can make sure
any related issues are caught early.

And while testing things on various devices, I noticed we're
missing few loadable modules to make things more usable:

- USB Ethernet for smsc75xx, we only have smsc97xx right now

- Basic USB serial drivers for things like ftdi and pl2303 ports

- Blinking leds with pca963x

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -50,6 +50,7 @@ CONFIG_SOC_AM33XX=y
 CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
 CONFIG_ARM_THUMBEE=y
+CONFIG_ARM_KERNMEM_PERMS=y
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_ARM_ERRATA_430973=y
 CONFIG_SMP=y
@@ -177,6 +178,7 @@ CONFIG_TI_CPTS=y
 CONFIG_AT803X_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_USB_USBNET=m
+CONFIG_USB_NET_SMSC75XX=m
 CONFIG_USB_NET_SMSC95XX=m
 CONFIG_USB_ALI_M5632=y
 CONFIG_USB_AN2720=y
@@ -354,6 +356,11 @@ CONFIG_USB_MUSB_DSPS=m
 CONFIG_USB_INVENTRA_DMA=y
 CONFIG_USB_TI_CPPI41_DMA=y
 CONFIG_USB_DWC3=m
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_GENERIC=y
+CONFIG_USB_SERIAL_SIMPLE=m
+CONFIG_USB_SERIAL_FTDI_SIO=m
+CONFIG_USB_SERIAL_PL2303=m
 CONFIG_USB_TEST=m
 CONFIG_AM335X_PHY_USB=y
 CONFIG_USB_GADGET=m
@@ -387,6 +394,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_GPIO=m
 CONFIG_LEDS_PWM=m
+CONFIG_LEDS_PCA963X=m
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_ONESHOT=m
-- 
2.7.0.rc3
