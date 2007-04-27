From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Updating 2430 SDP default config
Date: Fri, 27 Apr 2007 17:54:08 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47C8F1B4@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Updating 2430 SDP default config to build TWLGPIO and Keypad drivers

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

File:
 arch/arm/configs/omap_2430sdp_defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
--- linux-omap/arch/arm/configs/omap_2430sdp_defconfig	2007-04-02 =
02:29:56.000000000 -0500
+++ lin_for_hsi2c/arch/arm/configs/omap_2430sdp_defconfig	2007-04-27 =
16:42:09.000000000 -0500
@@ -1,12 +1,12 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc3-omap1
-# Mon Mar 19 22:43:37 2007
+# Linux kernel version: 2.6.21-rc5-omap1
+# Tue Apr 10 15:23:50 2007
 #
 CONFIG_ARM=3Dy
 CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
 CONFIG_GENERIC_GPIO=3Dy
-# CONFIG_GENERIC_TIME is not set
+CONFIG_GENERIC_TIME=3Dy
 CONFIG_MMU=3Dy
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=3Dy
@@ -181,8 +181,8 @@ CONFIG_ARCH_OMAP2430=3Dy
 #
 # CONFIG_MACH_NOKIA_N800 is not set
 # CONFIG_MACH_OMAP_H4 is not set
-CONFIG_MACH_OMAP_2430SDP=3Dy
 # CONFIG_MACH_OMAP_APOLLON is not set
+CONFIG_MACH_OMAP_2430SDP=3Dy
=20
 #
 # Processor Type
@@ -648,7 +648,8 @@ CONFIG_INPUT_KEYBOARD=3Dy
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
-CONFIG_KEYBOARD_OMAP=3Dy
+# CONFIG_KEYBOARD_OMAP is not set
+CONFIG_KEYBOARD_TWL4030=3Dy
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
@@ -760,6 +761,7 @@ CONFIG_I2C_OMAP=3Dy
 # CONFIG_GPIOEXPANDER_OMAP is not set
 # CONFIG_MENELAUS is not set
 CONFIG_TWL4030_CORE=3Dy
+CONFIG_TWL4030_GPIO=3Dy
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
