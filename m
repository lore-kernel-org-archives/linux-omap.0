From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 2/5] ARM: dts: OMAP2+: create a DT header for GPIO
Date: Wed, 22 May 2013 16:27:41 +0200
Message-ID: <1369232864-14460-3-git-send-email-florian.vaussard@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:35795 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753397Ab3EVO2Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 May 2013 10:28:16 -0400
In-Reply-To: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Define the OMAP_GPIO macro to conveniently use GPIO inside OMAP DT.
For example:

	gpios = <&gpio6 3 0>;  /* GPIO 163 */

can be replaced by

	gpios = OMAP_GPIO(163, 0);

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 include/dt-bindings/gpio/omap-gpio.h |  289 ++++++++++++++++++++++++++++++++++
 1 files changed, 289 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/gpio/omap-gpio.h

diff --git a/include/dt-bindings/gpio/omap-gpio.h b/include/dt-bindings/gpio/omap-gpio.h
new file mode 100644
index 0000000..64f2686
--- /dev/null
+++ b/include/dt-bindings/gpio/omap-gpio.h
@@ -0,0 +1,289 @@
+/*
+ * This header provides macros and constants for binding ti,omap*-gpio
+ *
+ * Compatible with OMAP2, OMAP3, OMAP4 and OMAP5.
+ */
+
+#ifndef _DT_BINDINGS_GPIO_OMAP_GPIO_H
+#define _DT_BINDINGS_GPIO_OMAP_GPIO_H
+
+#include <dt-bindings/gpio/gpio.h>
+
+#define OMAP_GPIO_0_BANK        gpio1
+#define OMAP_GPIO_1_BANK        gpio1
+#define OMAP_GPIO_2_BANK        gpio1
+#define OMAP_GPIO_3_BANK        gpio1
+#define OMAP_GPIO_4_BANK        gpio1
+#define OMAP_GPIO_5_BANK        gpio1
+#define OMAP_GPIO_6_BANK        gpio1
+#define OMAP_GPIO_7_BANK        gpio1
+#define OMAP_GPIO_8_BANK        gpio1
+#define OMAP_GPIO_9_BANK        gpio1
+#define OMAP_GPIO_10_BANK       gpio1
+#define OMAP_GPIO_11_BANK       gpio1
+#define OMAP_GPIO_12_BANK       gpio1
+#define OMAP_GPIO_13_BANK       gpio1
+#define OMAP_GPIO_14_BANK       gpio1
+#define OMAP_GPIO_15_BANK       gpio1
+#define OMAP_GPIO_16_BANK       gpio1
+#define OMAP_GPIO_17_BANK       gpio1
+#define OMAP_GPIO_18_BANK       gpio1
+#define OMAP_GPIO_19_BANK       gpio1
+#define OMAP_GPIO_20_BANK       gpio1
+#define OMAP_GPIO_21_BANK       gpio1
+#define OMAP_GPIO_22_BANK       gpio1
+#define OMAP_GPIO_23_BANK       gpio1
+#define OMAP_GPIO_24_BANK       gpio1
+#define OMAP_GPIO_25_BANK       gpio1
+#define OMAP_GPIO_26_BANK       gpio1
+#define OMAP_GPIO_27_BANK       gpio1
+#define OMAP_GPIO_28_BANK       gpio1
+#define OMAP_GPIO_29_BANK       gpio1
+#define OMAP_GPIO_30_BANK       gpio1
+#define OMAP_GPIO_31_BANK       gpio1
+
+#define OMAP_GPIO_32_BANK       gpio2
+#define OMAP_GPIO_33_BANK       gpio2
+#define OMAP_GPIO_34_BANK       gpio2
+#define OMAP_GPIO_35_BANK       gpio2
+#define OMAP_GPIO_36_BANK       gpio2
+#define OMAP_GPIO_37_BANK       gpio2
+#define OMAP_GPIO_38_BANK       gpio2
+#define OMAP_GPIO_39_BANK       gpio2
+#define OMAP_GPIO_40_BANK       gpio2
+#define OMAP_GPIO_41_BANK       gpio2
+#define OMAP_GPIO_42_BANK       gpio2
+#define OMAP_GPIO_43_BANK       gpio2
+#define OMAP_GPIO_44_BANK       gpio2
+#define OMAP_GPIO_45_BANK       gpio2
+#define OMAP_GPIO_46_BANK       gpio2
+#define OMAP_GPIO_47_BANK       gpio2
+#define OMAP_GPIO_48_BANK       gpio2
+#define OMAP_GPIO_49_BANK       gpio2
+#define OMAP_GPIO_50_BANK       gpio2
+#define OMAP_GPIO_51_BANK       gpio2
+#define OMAP_GPIO_52_BANK       gpio2
+#define OMAP_GPIO_53_BANK       gpio2
+#define OMAP_GPIO_54_BANK       gpio2
+#define OMAP_GPIO_55_BANK       gpio2
+#define OMAP_GPIO_56_BANK       gpio2
+#define OMAP_GPIO_57_BANK       gpio2
+#define OMAP_GPIO_58_BANK       gpio2
+#define OMAP_GPIO_59_BANK       gpio2
+#define OMAP_GPIO_60_BANK       gpio2
+#define OMAP_GPIO_61_BANK       gpio2
+#define OMAP_GPIO_62_BANK       gpio2
+#define OMAP_GPIO_63_BANK       gpio2
+
+#define OMAP_GPIO_64_BANK       gpio3
+#define OMAP_GPIO_65_BANK       gpio3
+#define OMAP_GPIO_66_BANK       gpio3
+#define OMAP_GPIO_67_BANK       gpio3
+#define OMAP_GPIO_68_BANK       gpio3
+#define OMAP_GPIO_69_BANK       gpio3
+#define OMAP_GPIO_70_BANK       gpio3
+#define OMAP_GPIO_71_BANK       gpio3
+#define OMAP_GPIO_72_BANK       gpio3
+#define OMAP_GPIO_73_BANK       gpio3
+#define OMAP_GPIO_74_BANK       gpio3
+#define OMAP_GPIO_75_BANK       gpio3
+#define OMAP_GPIO_76_BANK       gpio3
+#define OMAP_GPIO_77_BANK       gpio3
+#define OMAP_GPIO_78_BANK       gpio3
+#define OMAP_GPIO_79_BANK       gpio3
+#define OMAP_GPIO_80_BANK       gpio3
+#define OMAP_GPIO_81_BANK       gpio3
+#define OMAP_GPIO_82_BANK       gpio3
+#define OMAP_GPIO_83_BANK       gpio3
+#define OMAP_GPIO_84_BANK       gpio3
+#define OMAP_GPIO_85_BANK       gpio3
+#define OMAP_GPIO_86_BANK       gpio3
+#define OMAP_GPIO_87_BANK       gpio3
+#define OMAP_GPIO_88_BANK       gpio3
+#define OMAP_GPIO_89_BANK       gpio3
+#define OMAP_GPIO_90_BANK       gpio3
+#define OMAP_GPIO_91_BANK       gpio3
+#define OMAP_GPIO_92_BANK       gpio3
+#define OMAP_GPIO_93_BANK       gpio3
+#define OMAP_GPIO_94_BANK       gpio3
+#define OMAP_GPIO_95_BANK       gpio3
+
+#define OMAP_GPIO_96_BANK       gpio4
+#define OMAP_GPIO_97_BANK       gpio4
+#define OMAP_GPIO_98_BANK       gpio4
+#define OMAP_GPIO_99_BANK       gpio4
+#define OMAP_GPIO_100_BANK      gpio4
+#define OMAP_GPIO_101_BANK      gpio4
+#define OMAP_GPIO_102_BANK      gpio4
+#define OMAP_GPIO_103_BANK      gpio4
+#define OMAP_GPIO_104_BANK      gpio4
+#define OMAP_GPIO_105_BANK      gpio4
+#define OMAP_GPIO_106_BANK      gpio4
+#define OMAP_GPIO_107_BANK      gpio4
+#define OMAP_GPIO_108_BANK      gpio4
+#define OMAP_GPIO_109_BANK      gpio4
+#define OMAP_GPIO_110_BANK      gpio4
+#define OMAP_GPIO_111_BANK      gpio4
+#define OMAP_GPIO_112_BANK      gpio4
+#define OMAP_GPIO_113_BANK      gpio4
+#define OMAP_GPIO_114_BANK      gpio4
+#define OMAP_GPIO_115_BANK      gpio4
+#define OMAP_GPIO_116_BANK      gpio4
+#define OMAP_GPIO_117_BANK      gpio4
+#define OMAP_GPIO_118_BANK      gpio4
+#define OMAP_GPIO_119_BANK      gpio4
+#define OMAP_GPIO_120_BANK      gpio4
+#define OMAP_GPIO_121_BANK      gpio4
+#define OMAP_GPIO_122_BANK      gpio4
+#define OMAP_GPIO_123_BANK      gpio4
+#define OMAP_GPIO_124_BANK      gpio4
+#define OMAP_GPIO_125_BANK      gpio4
+#define OMAP_GPIO_126_BANK      gpio4
+#define OMAP_GPIO_127_BANK      gpio4
+
+/* Not available on OMAP2420 */
+#define OMAP_GPIO_128_BANK      gpio5
+#define OMAP_GPIO_129_BANK      gpio5
+#define OMAP_GPIO_130_BANK      gpio5
+#define OMAP_GPIO_131_BANK      gpio5
+#define OMAP_GPIO_132_BANK      gpio5
+#define OMAP_GPIO_133_BANK      gpio5
+#define OMAP_GPIO_134_BANK      gpio5
+#define OMAP_GPIO_135_BANK      gpio5
+#define OMAP_GPIO_136_BANK      gpio5
+#define OMAP_GPIO_137_BANK      gpio5
+#define OMAP_GPIO_138_BANK      gpio5
+#define OMAP_GPIO_139_BANK      gpio5
+#define OMAP_GPIO_140_BANK      gpio5
+#define OMAP_GPIO_141_BANK      gpio5
+#define OMAP_GPIO_142_BANK      gpio5
+#define OMAP_GPIO_143_BANK      gpio5
+#define OMAP_GPIO_144_BANK      gpio5
+#define OMAP_GPIO_145_BANK      gpio5
+#define OMAP_GPIO_146_BANK      gpio5
+#define OMAP_GPIO_147_BANK      gpio5
+#define OMAP_GPIO_148_BANK      gpio5
+#define OMAP_GPIO_149_BANK      gpio5
+#define OMAP_GPIO_150_BANK      gpio5
+#define OMAP_GPIO_151_BANK      gpio5
+#define OMAP_GPIO_152_BANK      gpio5
+#define OMAP_GPIO_153_BANK      gpio5
+#define OMAP_GPIO_154_BANK      gpio5
+#define OMAP_GPIO_155_BANK      gpio5
+#define OMAP_GPIO_156_BANK      gpio5
+#define OMAP_GPIO_157_BANK      gpio5
+#define OMAP_GPIO_158_BANK      gpio5
+#define OMAP_GPIO_159_BANK      gpio5
+
+/* Not available on OMAP2 */
+#define OMAP_GPIO_160_BANK      gpio6
+#define OMAP_GPIO_161_BANK      gpio6
+#define OMAP_GPIO_162_BANK      gpio6
+#define OMAP_GPIO_163_BANK      gpio6
+#define OMAP_GPIO_164_BANK      gpio6
+#define OMAP_GPIO_165_BANK      gpio6
+#define OMAP_GPIO_166_BANK      gpio6
+#define OMAP_GPIO_167_BANK      gpio6
+#define OMAP_GPIO_168_BANK      gpio6
+#define OMAP_GPIO_169_BANK      gpio6
+#define OMAP_GPIO_170_BANK      gpio6
+#define OMAP_GPIO_171_BANK      gpio6
+#define OMAP_GPIO_172_BANK      gpio6
+#define OMAP_GPIO_173_BANK      gpio6
+#define OMAP_GPIO_174_BANK      gpio6
+#define OMAP_GPIO_175_BANK      gpio6
+#define OMAP_GPIO_176_BANK      gpio6
+#define OMAP_GPIO_177_BANK      gpio6
+#define OMAP_GPIO_178_BANK      gpio6
+#define OMAP_GPIO_179_BANK      gpio6
+#define OMAP_GPIO_180_BANK      gpio6
+#define OMAP_GPIO_181_BANK      gpio6
+#define OMAP_GPIO_182_BANK      gpio6
+#define OMAP_GPIO_183_BANK      gpio6
+#define OMAP_GPIO_184_BANK      gpio6
+#define OMAP_GPIO_185_BANK      gpio6
+#define OMAP_GPIO_186_BANK      gpio6
+#define OMAP_GPIO_187_BANK      gpio6
+#define OMAP_GPIO_188_BANK      gpio6
+#define OMAP_GPIO_189_BANK      gpio6
+#define OMAP_GPIO_190_BANK      gpio6
+#define OMAP_GPIO_191_BANK      gpio6
+
+/* Only available on OMAP5 */
+#define OMAP_GPIO_192_BANK      gpio7
+#define OMAP_GPIO_193_BANK      gpio7
+#define OMAP_GPIO_194_BANK      gpio7
+#define OMAP_GPIO_195_BANK      gpio7
+#define OMAP_GPIO_196_BANK      gpio7
+#define OMAP_GPIO_197_BANK      gpio7
+#define OMAP_GPIO_198_BANK      gpio7
+#define OMAP_GPIO_199_BANK      gpio7
+#define OMAP_GPIO_200_BANK      gpio7
+#define OMAP_GPIO_201_BANK      gpio7
+#define OMAP_GPIO_202_BANK      gpio7
+#define OMAP_GPIO_203_BANK      gpio7
+#define OMAP_GPIO_204_BANK      gpio7
+#define OMAP_GPIO_205_BANK      gpio7
+#define OMAP_GPIO_206_BANK      gpio7
+#define OMAP_GPIO_207_BANK      gpio7
+#define OMAP_GPIO_208_BANK      gpio7
+#define OMAP_GPIO_209_BANK      gpio7
+#define OMAP_GPIO_210_BANK      gpio7
+#define OMAP_GPIO_211_BANK      gpio7
+#define OMAP_GPIO_212_BANK      gpio7
+#define OMAP_GPIO_213_BANK      gpio7
+#define OMAP_GPIO_214_BANK      gpio7
+#define OMAP_GPIO_215_BANK      gpio7
+#define OMAP_GPIO_216_BANK      gpio7
+#define OMAP_GPIO_217_BANK      gpio7
+#define OMAP_GPIO_218_BANK      gpio7
+#define OMAP_GPIO_219_BANK      gpio7
+#define OMAP_GPIO_220_BANK      gpio7
+#define OMAP_GPIO_221_BANK      gpio7
+#define OMAP_GPIO_222_BANK      gpio7
+#define OMAP_GPIO_223_BANK      gpio7
+
+/* Only available on OMAP5 */
+#define OMAP_GPIO_224_BANK      gpio8
+#define OMAP_GPIO_225_BANK      gpio8
+#define OMAP_GPIO_226_BANK      gpio8
+#define OMAP_GPIO_227_BANK      gpio8
+#define OMAP_GPIO_228_BANK      gpio8
+#define OMAP_GPIO_229_BANK      gpio8
+#define OMAP_GPIO_230_BANK      gpio8
+#define OMAP_GPIO_231_BANK      gpio8
+#define OMAP_GPIO_232_BANK      gpio8
+#define OMAP_GPIO_233_BANK      gpio8
+#define OMAP_GPIO_234_BANK      gpio8
+#define OMAP_GPIO_235_BANK      gpio8
+#define OMAP_GPIO_236_BANK      gpio8
+#define OMAP_GPIO_237_BANK      gpio8
+#define OMAP_GPIO_238_BANK      gpio8
+#define OMAP_GPIO_239_BANK      gpio8
+#define OMAP_GPIO_240_BANK      gpio8
+#define OMAP_GPIO_241_BANK      gpio8
+#define OMAP_GPIO_242_BANK      gpio8
+#define OMAP_GPIO_243_BANK      gpio8
+#define OMAP_GPIO_244_BANK      gpio8
+#define OMAP_GPIO_245_BANK      gpio8
+#define OMAP_GPIO_246_BANK      gpio8
+#define OMAP_GPIO_247_BANK      gpio8
+#define OMAP_GPIO_248_BANK      gpio8
+#define OMAP_GPIO_249_BANK      gpio8
+#define OMAP_GPIO_250_BANK      gpio8
+#define OMAP_GPIO_251_BANK      gpio8
+#define OMAP_GPIO_252_BANK      gpio8
+#define OMAP_GPIO_253_BANK      gpio8
+#define OMAP_GPIO_254_BANK      gpio8
+#define OMAP_GPIO_255_BANK      gpio8
+
+
+#define _OMAP_GPIO_OFFSET(gpio) \
+	(gpio & 0x1F)
+
+
+/* Declare a reference to an OMAP GPIO */
+#define OMAP_GPIO(gpio, level) \
+	<&OMAP_GPIO_##gpio##_BANK _OMAP_GPIO_OFFSET(gpio) level>
+
+#endif
-- 
1.7.5.4

