From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP3: Make I2C bus 2 configurable for BeagleBoard
Date: Fri, 04 Jul 2008 08:26:55 +0200
Message-ID: <486DC2AF.4010401@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070109020909070409060607"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:34716 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbYGDG1e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 02:27:34 -0400
Received: by wa-out-1112.google.com with SMTP id j37so732381waf.23
        for <linux-omap@vger.kernel.org>; Thu, 03 Jul 2008 23:27:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070109020909070409060607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I2C2 at BeagleBoard is connected to expansion connector, i.e. unused 
if nothing is connected to this connector. As internal OMAP3 pull up 
resistors are not strong enough, enabled but unused I2C2 bus results 
in error messages (e.g. I2C timeouts). I2C2 should be enabled only if 
something is connected to I2C2 at board's expansion connector and this 
extension has additional pull up resistors for I2C2 bus.

- Add configuration option for this
- Use configuration option in board-omap3beagle
- Ensure correct pin mux if I2C2 is enabled, independent of settings 
done by bootloader
- While being there, add OMAP3 to OMAP I2C help text

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

--------------070109020909070409060607
Content-Type: text/plain;
 name="beagle_i2c2_configuration_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="beagle_i2c2_configuration_patch.txt"


Subject: ARM: OMAP3: Make I2C bus 2 configurable for BeagleBoard 

From: Dirk Behme <dirk.behme@gmail.com>

I2C2 at BeagleBoard is connected to expansion connector, i.e. unused if
nothing is connected to this connector. As internal OMAP3 pull up resistors
are not strong enough, enabled but unused I2C2 bus results in error messages
(e.g. I2C timeouts). I2C2 should be enabled only if something is connected to
I2C2 at board's expansion connector and this extension has additional pull up
resistors for I2C2 bus.

- Add configuration option for this
- Use configuration option in board-omap3beagle
- Ensure correct pin mux if I2C2 is enabled, independent of settings done
  by bootloader.
- While being there, add OMAP3 to OMAP I2C help text


Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

---

Index: linux-beagle/arch/arm/mach-omap2/board-omap3beagle.c
===================================================================
--- linux-beagle.orig/arch/arm/mach-omap2/board-omap3beagle.c
+++ linux-beagle/arch/arm/mach-omap2/board-omap3beagle.c
@@ -40,7 +40,9 @@ static struct omap_uart_config omap3_bea
 static int __init omap3_beagle_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2600, NULL, 0);
+#ifdef CONFIG_I2C2_OMAP_BEAGLE
 	omap_register_i2c_bus(2, 400, NULL, 0);
+#endif
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
 }
Index: linux-beagle/arch/arm/mach-omap2/mux.c
===================================================================
--- linux-beagle.orig/arch/arm/mach-omap2/mux.c
+++ linux-beagle/arch/arm/mach-omap2/mux.c
@@ -231,10 +231,12 @@ MUX_CFG_34XX("K21_34XX_I2C1_SCL", 0x1ba,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("J21_34XX_I2C1_SDA", 0x1bc,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+#ifdef CONFIG_I2C2_OMAP_BEAGLE
 MUX_CFG_34XX("AF15_34XX_I2C2_SCL", 0x1be,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("AE15_34XX_I2C2_SDA", 0x1c0,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+#endif
 MUX_CFG_34XX("AF14_34XX_I2C3_SCL", 0x1c2,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("AG14_34XX_I2C3_SDA", 0x1c4,
Index: linux-beagle/drivers/i2c/busses/Kconfig
===================================================================
--- linux-beagle.orig/drivers/i2c/busses/Kconfig
+++ linux-beagle/drivers/i2c/busses/Kconfig
@@ -332,10 +332,27 @@ config I2C_OMAP
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
-	  I2C interface on the Texas Instruments OMAP1/2 family of processors.
-	  Like OMAP1510/1610/1710/5912 and OMAP242x.
+	  I2C interface on the Texas Instruments OMAP1/2/3 family of
+	  processors.
+	  Like OMAP1510/1610/1710/5912, OMAP242x, OMAP34x and OMAP35x.
 	  For details see http://www.ti.com/omap.
 
+config I2C2_OMAP_BEAGLE
+	bool "Enable I2C2 for OMAP3 BeagleBoard"
+	depends on ARCH_OMAP && MACH_OMAP3_BEAGLE
+	select OMAP_MUX
+	default n
+	help
+	  Say Y here if you want to enable I2C bus 2 at OMAP3 based
+	  BeagleBoard.
+	  I2C2 at BeagleBoard is connected to expansion connector, i.e. unused
+	  if nothing is connected to this connector. As internal OMAP3 pull up
+	  resistors are not strong enough, enabled but unused I2C2 bus results
+	  in error messages (e.g. I2C timeouts). Enable this only if you have
+	  something connected to I2C2 at board's expansion connector and this
+	  extension has additional pull up resistors for I2C2 bus.
+
+
 config I2C_PARPORT
 	tristate "Parallel port adapter"
 	depends on PARPORT

--------------070109020909070409060607--
