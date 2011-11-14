From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Mon, 14 Nov 2011 18:10:07 +0530
Message-ID: <1321274409-24643-2-git-send-email-rnayak@ti.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43181 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640Ab1KNMk2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 07:40:28 -0500
In-Reply-To: <1321274409-24643-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linus.walleij@stericsson.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

This adds a driver for the OMAP pinmux portions of the system
control module.
The driver is based on the u300 pinmux driver and only supports
OMAP4 platforms for now. Also has very minimal functions/pin-groups
for OMAP4 defined.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/pinctrl/Kconfig       |    7 +
 drivers/pinctrl/Makefile      |    1 +
 drivers/pinctrl/pinmux-omap.c |  735 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 743 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pinctrl/pinmux-omap.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index ef56644..f0770be 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -40,4 +40,11 @@ config PINMUX_U300
 	help
 	  Say Y here to enable the U300 pinmux driver
 
+config PINMUX_OMAP
+	bool "OMAP pinmux driver"
+	depends on ARCH_OMAP
+	select PINMUX
+	help
+	  Say Y here to enable the OMAP pinmux driver
+
 endif
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index bdc548a..c79e8c6 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_PINCTRL)		+= core.o
 obj-$(CONFIG_PINMUX)		+= pinmux.o
 obj-$(CONFIG_PINMUX_SIRF)	+= pinmux-sirf.o
 obj-$(CONFIG_PINMUX_U300)	+= pinmux-u300.o
+obj-$(CONFIG_PINMUX_OMAP)	+= pinmux-omap.o
diff --git a/drivers/pinctrl/pinmux-omap.c b/drivers/pinctrl/pinmux-omap.c
new file mode 100644
index 0000000..fa96fbd
--- /dev/null
+++ b/drivers/pinctrl/pinmux-omap.c
@@ -0,0 +1,735 @@
+/*
+ * Driver for the OMAP pinmux controller
+ *
+ * Copyright (C) 2011 Texas Instruments
+ * Author: Rajendra Nayak <rnayak@ti.com>
+ *
+ * The OMAP control module has a device-control sub-module
+ * which handles all pin/padmuxing for OMAP. The sub-module
+ * is further split into a 'core' instance within the CORE
+ * powerdomain and a 'wkup' instance within the WAKEUP
+ * powerdomain (which is always powered on)
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#define DRIVER_NAME "pinmux-omap"
+
+#define OMAP_NUM_PADS 547
+
+/* omap4 mux mode options for each pin. See TRM for options */
+#define OMAP_MUX_MODE0	0
+#define OMAP_MUX_MODE1	1
+#define OMAP_MUX_MODE2	2
+#define OMAP_MUX_MODE3	3
+#define OMAP_MUX_MODE4	4
+#define OMAP_MUX_MODE5	5
+#define OMAP_MUX_MODE6	6
+#define OMAP_MUX_MODE7	7
+
+#define OMAP_MUX_NR_MODES	8
+
+/* omap4 core pads */
+static const struct pinctrl_pin_desc omap4_core_pads[] = {
+	PINCTRL_PIN(0, "c12"),
+	PINCTRL_PIN(1, "d12"),
+	PINCTRL_PIN(2, "c13"),
+	PINCTRL_PIN(3, "d13"),
+	PINCTRL_PIN(4, "c15"),
+	PINCTRL_PIN(5, "d15"),
+	PINCTRL_PIN(6, "a16"),
+	PINCTRL_PIN(7, "b16"),
+	PINCTRL_PIN(8, "c16"),
+	PINCTRL_PIN(9, "d16"),
+	PINCTRL_PIN(10, "c17"),
+	PINCTRL_PIN(11, "d17"),
+	PINCTRL_PIN(12, "c18"),
+	PINCTRL_PIN(13, "d18"),
+	PINCTRL_PIN(14, "c19"),
+	PINCTRL_PIN(15, "d19"),
+	PINCTRL_PIN(16, "b17"),
+	PINCTRL_PIN(17, "a18"),
+	PINCTRL_PIN(18, "b18"),
+	PINCTRL_PIN(19, "a19"),
+	PINCTRL_PIN(20, "b19"),
+	PINCTRL_PIN(21, "b20"),
+	PINCTRL_PIN(22, "a21"),
+	PINCTRL_PIN(23, "b21"),
+	PINCTRL_PIN(24, "c20"),
+	PINCTRL_PIN(25, "d20"),
+	PINCTRL_PIN(26, "b25"),
+	PINCTRL_PIN(27, "c21"),
+	PINCTRL_PIN(28, "d21"),
+	PINCTRL_PIN(29, "c22"),
+	PINCTRL_PIN(30, "c25"),
+	PINCTRL_PIN(31, "b22"),
+	PINCTRL_PIN(32, "d25"),
+	PINCTRL_PIN(33, "b11"),
+	PINCTRL_PIN(34, "b12"),
+	PINCTRL_PIN(35, "c23"),
+	PINCTRL_PIN(36, "d22"),
+	PINCTRL_PIN(37, "b26"),
+	PINCTRL_PIN(38, "b23"),
+	PINCTRL_PIN(39, "d23"),
+	PINCTRL_PIN(40, "a24"),
+	PINCTRL_PIN(41, "b24"),
+	PINCTRL_PIN(42, "c24"),
+	PINCTRL_PIN(43, "d24"),
+	PINCTRL_PIN(44, "b9"),
+	PINCTRL_PIN(45, "b10"),
+	PINCTRL_PIN(46, "a8"),
+	PINCTRL_PIN(47, "b8"),
+	PINCTRL_PIN(48, "r26"),
+	PINCTRL_PIN(49, "r25"),
+	PINCTRL_PIN(50, "t26"),
+	PINCTRL_PIN(51, "t25"),
+	PINCTRL_PIN(52, "u26"),
+	PINCTRL_PIN(53, "u25"),
+	PINCTRL_PIN(54, "v26"),
+	PINCTRL_PIN(55, "v25"),
+	PINCTRL_PIN(56, "w26"),
+	PINCTRL_PIN(57, "w25"),
+	PINCTRL_PIN(58, "m26"),
+	PINCTRL_PIN(59, "m25"),
+	PINCTRL_PIN(60, "n26"),
+	PINCTRL_PIN(61, "n25"),
+	PINCTRL_PIN(62, "t27"),
+	PINCTRL_PIN(63, "u27"),
+	PINCTRL_PIN(64, "v27"),
+	PINCTRL_PIN(65, "ae18"),
+	PINCTRL_PIN(66, "ag19"),
+	PINCTRL_PIN(67, "af19"),
+	PINCTRL_PIN(68, "ae19"),
+	PINCTRL_PIN(69, "af18"),
+	PINCTRL_PIN(70, "ag18"),
+	PINCTRL_PIN(71, "ae17"),
+	PINCTRL_PIN(72, "af17"),
+	PINCTRL_PIN(73, "ah17"),
+	PINCTRL_PIN(74, "ae16"),
+	PINCTRL_PIN(75, "af16"),
+	PINCTRL_PIN(76, "ag16"),
+	PINCTRL_PIN(77, "af14"),
+	PINCTRL_PIN(78, "ae14"),
+	PINCTRL_PIN(79, "h2"),
+	PINCTRL_PIN(80, "h3"),
+	PINCTRL_PIN(81, "d2"),
+	PINCTRL_PIN(82, "e3"),
+	PINCTRL_PIN(83, "e4"),
+	PINCTRL_PIN(84, "e2"),
+	PINCTRL_PIN(85, "e1"),
+	PINCTRL_PIN(86, "f4"),
+	PINCTRL_PIN(87, "f3"),
+	PINCTRL_PIN(88, "f1"),
+	PINCTRL_PIN(89, "g4"),
+	PINCTRL_PIN(90, "g3"),
+	PINCTRL_PIN(91, "ad27"),
+	PINCTRL_PIN(92, "ad26"),
+	PINCTRL_PIN(93, "ad25"),
+	PINCTRL_PIN(94, "ac28"),
+	PINCTRL_PIN(95, "ac26"),
+	PINCTRL_PIN(96, "ac25"),
+	PINCTRL_PIN(97, "ab25"),
+	PINCTRL_PIN(98, "ac27"),
+	PINCTRL_PIN(99, "ag25"),
+	PINCTRL_PIN(100, "af25"),
+	PINCTRL_PIN(101, "ae25"),
+	PINCTRL_PIN(102, "af26"),
+	PINCTRL_PIN(103, "ah26"),
+	PINCTRL_PIN(104, "ae24"),
+	PINCTRL_PIN(105, "af24"),
+	PINCTRL_PIN(106, "ag24"),
+	PINCTRL_PIN(107, "ah24"),
+	PINCTRL_PIN(108, "ab26"),
+	PINCTRL_PIN(109, "ab27"),
+	PINCTRL_PIN(110, "aa25"),
+	PINCTRL_PIN(111, "aa26"),
+	PINCTRL_PIN(112, "aa27"),
+	PINCTRL_PIN(113, "ae28"),
+	PINCTRL_PIN(114, "ae26"),
+	PINCTRL_PIN(115, "c26"),
+	PINCTRL_PIN(116, "d26"),
+	PINCTRL_PIN(117, "w27"),
+	PINCTRL_PIN(118, "y27"),
+	PINCTRL_PIN(119, "ag21"),
+	PINCTRL_PIN(120, "ah22"),
+	PINCTRL_PIN(121, "af22"),
+	PINCTRL_PIN(122, "ae22"),
+	PINCTRL_PIN(123, "ag22"),
+	PINCTRL_PIN(124, "ae23"),
+	PINCTRL_PIN(125, "af23"),
+	PINCTRL_PIN(126, "ag23"),
+	PINCTRL_PIN(127, "ah23"),
+	PINCTRL_PIN(128, "f27"),
+	PINCTRL_PIN(129, "f28"),
+	PINCTRL_PIN(130, "g27"),
+	PINCTRL_PIN(131, "g28"),
+	PINCTRL_PIN(132, "ae5"),
+	PINCTRL_PIN(133, "af5"),
+	PINCTRL_PIN(134, "ae4"),
+	PINCTRL_PIN(135, "af4"),
+	PINCTRL_PIN(136, "ag3"),
+	PINCTRL_PIN(137, "af3"),
+	PINCTRL_PIN(138, "ae21"),
+	PINCTRL_PIN(139, "af20"),
+	PINCTRL_PIN(140, "af21"),
+	PINCTRL_PIN(141, "ae20"),
+	PINCTRL_PIN(142, "ag20"),
+	PINCTRL_PIN(143, "ah19"),
+	PINCTRL_PIN(144, "ag12"),
+	PINCTRL_PIN(145, "af12"),
+	PINCTRL_PIN(146, "ae12"),
+	PINCTRL_PIN(147, "ag13"),
+	PINCTRL_PIN(148, "ae11"),
+	PINCTRL_PIN(149, "af11"),
+	PINCTRL_PIN(150, "ag11"),
+	PINCTRL_PIN(151, "ah11"),
+	PINCTRL_PIN(152, "ae10"),
+	PINCTRL_PIN(153, "af10"),
+	PINCTRL_PIN(154, "ag10"),
+	PINCTRL_PIN(155, "ae9"),
+	PINCTRL_PIN(156, "af13"),
+	PINCTRL_PIN(157, "ae13"),
+	PINCTRL_PIN(158, "g26"),
+	PINCTRL_PIN(159, "g25"),
+	PINCTRL_PIN(160, "h26"),
+	PINCTRL_PIN(161, "h25"),
+	PINCTRL_PIN(162, "j27"),
+	PINCTRL_PIN(163, "h27"),
+	PINCTRL_PIN(164, "j26"),
+	PINCTRL_PIN(165, "j25"),
+	PINCTRL_PIN(166, "k26"),
+	PINCTRL_PIN(167, "k25"),
+	PINCTRL_PIN(168, "l27"),
+	PINCTRL_PIN(169, "k27"),
+	PINCTRL_PIN(170, "c3"),
+	PINCTRL_PIN(171, "b5"),
+	PINCTRL_PIN(172, "b4"),
+	PINCTRL_PIN(173, "aa28"),
+	PINCTRL_PIN(174, "y28"),
+	PINCTRL_PIN(175, "ae6"),
+	PINCTRL_PIN(176, "af6"),
+	PINCTRL_PIN(177, "f26"),
+	PINCTRL_PIN(178, "e27"),
+	PINCTRL_PIN(179, "e26"),
+	PINCTRL_PIN(180, "e25"),
+	PINCTRL_PIN(181, "d28"),
+	PINCTRL_PIN(182, "d27"),
+	PINCTRL_PIN(183, "m2"),
+	PINCTRL_PIN(184, "n2"),
+	PINCTRL_PIN(185, "p2"),
+	PINCTRL_PIN(186, "v1"),
+	PINCTRL_PIN(187, "v2"),
+	PINCTRL_PIN(188, "w1"),
+	PINCTRL_PIN(189, "w2"),
+	PINCTRL_PIN(190, "w3"),
+	PINCTRL_PIN(191, "w4"),
+	PINCTRL_PIN(192, "y2"),
+	PINCTRL_PIN(193, "y3"),
+	PINCTRL_PIN(194, "y4"),
+	PINCTRL_PIN(195, "aa1"),
+	PINCTRL_PIN(196, "aa2"),
+	PINCTRL_PIN(197, "aa3"),
+	PINCTRL_PIN(198, "aa4"),
+	PINCTRL_PIN(199, "ab2"),
+	PINCTRL_PIN(200, "ab3"),
+	PINCTRL_PIN(201, "ab4"),
+	PINCTRL_PIN(202, "ac4"),
+};
+
+/* omap4 wkup pads */
+static const struct pinctrl_pin_desc omap4_wkup_pads[] = {
+	PINCTRL_PIN(0, "c12"),
+	PINCTRL_PIN(1, "d12"),
+	PINCTRL_PIN(2, "c13"),
+	PINCTRL_PIN(3, "d13"),
+	PINCTRL_PIN(4, "c15"),
+	PINCTRL_PIN(5, "d15"),
+	PINCTRL_PIN(6, "a16"),
+	PINCTRL_PIN(7, "b16"),
+	PINCTRL_PIN(8, "c16"),
+	PINCTRL_PIN(9, "d16"),
+	PINCTRL_PIN(10, "c17"),
+	PINCTRL_PIN(11, "d17"),
+	PINCTRL_PIN(12, "c18"),
+	PINCTRL_PIN(13, "d18"),
+	PINCTRL_PIN(14, "c19"),
+	PINCTRL_PIN(15, "d19"),
+	PINCTRL_PIN(16, "b17"),
+	PINCTRL_PIN(17, "a18"),
+	PINCTRL_PIN(18, "b18"),
+	PINCTRL_PIN(19, "a19"),
+	PINCTRL_PIN(20, "b19"),
+	PINCTRL_PIN(21, "b20"),
+	PINCTRL_PIN(22, "a21"),
+	PINCTRL_PIN(23, "b21"),
+	PINCTRL_PIN(24, "c20"),
+	PINCTRL_PIN(25, "d20"),
+	PINCTRL_PIN(26, "b25"),
+	PINCTRL_PIN(27, "c21"),
+	PINCTRL_PIN(28, "d21"),
+	PINCTRL_PIN(29, "c22"),
+	PINCTRL_PIN(30, "c25"),
+	PINCTRL_PIN(31, "b22"),
+	PINCTRL_PIN(32, "d25"),
+	PINCTRL_PIN(33, "b11"),
+	PINCTRL_PIN(34, "b12"),
+	PINCTRL_PIN(35, "c23"),
+	PINCTRL_PIN(36, "d22"),
+	PINCTRL_PIN(37, "b26"),
+	PINCTRL_PIN(38, "b23"),
+	PINCTRL_PIN(39, "d23"),
+	PINCTRL_PIN(40, "a24"),
+	PINCTRL_PIN(41, "b24"),
+	PINCTRL_PIN(42, "c24"),
+	PINCTRL_PIN(43, "d24"),
+	PINCTRL_PIN(44, "b9"),
+	PINCTRL_PIN(45, "b10"),
+	PINCTRL_PIN(46, "a8"),
+	PINCTRL_PIN(47, "b8"),
+	PINCTRL_PIN(48, "r26"),
+	PINCTRL_PIN(49, "r25"),
+	PINCTRL_PIN(50, "h4"),
+	PINCTRL_PIN(51, "j2"),
+	PINCTRL_PIN(52, "g2"),
+	PINCTRL_PIN(53, "j1"),
+	PINCTRL_PIN(54, "k1"),
+	PINCTRL_PIN(55, "ag9"),
+	PINCTRL_PIN(56, "af9"),
+	PINCTRL_PIN(57, "ah6"),
+	PINCTRL_PIN(58, "ag8"),
+	PINCTRL_PIN(59, "ad1"),
+	PINCTRL_PIN(60, "ad2"),
+	PINCTRL_PIN(61, "ad3"),
+	PINCTRL_PIN(62, "ad4"),
+	PINCTRL_PIN(63, "ac2"),
+	PINCTRL_PIN(64, "ac3"),
+	PINCTRL_PIN(65, "ag7"),
+	PINCTRL_PIN(66, "ae7"),
+	PINCTRL_PIN(67, "af7"),
+	PINCTRL_PIN(68, "ah7"),
+	PINCTRL_PIN(69, "ag6"),
+	PINCTRL_PIN(70, "af8"),
+	PINCTRL_PIN(71, "ae8"),
+	PINCTRL_PIN(72, "ah2"),
+	PINCTRL_PIN(73, "ag1"),
+	PINCTRL_PIN(74, "ae3"),
+	PINCTRL_PIN(75, "ah1"),
+	PINCTRL_PIN(76, "ae1"),
+	PINCTRL_PIN(77, "ae2"),
+};
+
+/**
+ * @dev: a pointer back to containing device
+ * @virtbase: the offset to the controller in virtual memory
+ */
+struct omap_pmx {
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	u32 phybase;
+	u32 physize;
+	void __iomem *virtbase;
+};
+
+/**
+ * struct omap_pin_group - describes a omap pin group
+ * @name: the name of this specific pin group
+ * @pins: an array of discrete physical pins used in this group, taken
+ *	from the driver-local pin enumeration space
+ * @muxmodes: mux mode to be configured for each pin
+ * @num_pins: the number of pins in this group array, i.e. the number of
+ *	elements in .pins so we can iterate over that array
+ */
+struct omap_pin_group {
+	const char *name;
+	const unsigned *pins;
+	const unsigned *muxmodes;
+	const unsigned num_pins;
+};
+
+static const unsigned hdmi_pins[] = {
+	44, /* HDMI_HPD */
+	45, /* HDMI_CEC */
+	46, /* HDMI_DDC_SCL */
+	47, /* HDMI_DDC_SDA */
+};
+
+static const unsigned hdmi_muxmodes[] = {
+	OMAP_MUX_MODE0,
+	OMAP_MUX_MODE0,
+	OMAP_MUX_MODE0,
+	OMAP_MUX_MODE0,
+};
+
+static const unsigned sdmmc5_pins[] = {
+	132, /* WLAN SDIO: MMC5 CMD */
+	133, /* WLAN SDIO: MMC5 CLK */
+	134, /* WLAN SDIO: MMC5 DAT0 */
+	135, /* WLAN SDIO: MMC5 DAT1 */
+	136, /* WLAN SDIO: MMC5 DAT2 */
+	137, /* WLAN SDIO: MMC5 DAT3 */
+};
+
+static const unsigned sdmmc5_muxmodes[] = {
+	OMAP_MUX_MODE0,
+	OMAP_MUX_MODE0,
+	OMAP_MUX_MODE0,
+	OMAP_MUX_MODE0,
+	OMAP_MUX_MODE0,
+	OMAP_MUX_MODE0,
+};
+
+static const unsigned dispc2_pins[] = {
+	145, /* dispc2_data23 */
+	146, /* dispc2_data22 */
+	147, /* dispc2_data21 */
+	148, /* dispc2_data19 */
+	149, /* dispc2_data18 */
+	150, /* dispc2_data15 */
+	151, /* dispc2_data14 */
+	152, /* dispc2_data13 */
+	153, /* dispc2_data12 */
+	154, /* dispc2_data11 */
+	186, /* dispc2_data10 */
+	187, /* dispc2_data9 */
+	188, /* dispc2_data16 */
+	189, /* dispc2_data17 */
+	190, /* dispc2_hsync */
+	191, /* dispc2_pclk */
+	192, /* dispc2_vsync */
+	193, /* dispc2_de */
+	194, /* dispc2_data8 */
+	195, /* dispc2_data7 */
+	196, /* dispc2_data6 */
+	197, /* dispc2_data5 */
+	198, /* dispc2_data4 */
+	199, /* dispc2_data3 */
+	200, /* dispc2_data2 */
+	201, /* dispc2_data1 */
+	202, /* dispc2_data0 */
+};
+
+static const unsigned dispc2_muxmodes[] = {
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+	OMAP_MUX_MODE5,
+};
+
+static const struct omap_pin_group omap_pin_groups[] = {
+	{
+		.name = "hdmi_grp",
+		.pins = hdmi_pins,
+		.muxmodes = hdmi_muxmodes,
+		.num_pins = ARRAY_SIZE(hdmi_pins),
+	},
+	{
+		.name = "sdmmc5_grp",
+		.pins = sdmmc5_pins,
+		.muxmodes = sdmmc5_muxmodes,
+		.num_pins = ARRAY_SIZE(sdmmc5_pins),
+	},
+	{
+		.name = "dispc2_grp",
+		.pins = dispc2_pins,
+		.muxmodes = dispc2_muxmodes,
+		.num_pins = ARRAY_SIZE(dispc2_pins),
+	},
+};
+
+static int omap_list_groups(struct pinctrl_dev *pctldev, unsigned selector)
+{
+	if (selector >= ARRAY_SIZE(omap_pin_groups))
+		return -EINVAL;
+	return 0;
+}
+
+static const char *omap_get_group_name(struct pinctrl_dev *pctldev,
+				       unsigned selector)
+{
+	if (selector >= ARRAY_SIZE(omap_pin_groups))
+		return NULL;
+	return omap_pin_groups[selector].name;
+}
+
+static int omap_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
+			       const unsigned **pins,
+			       unsigned *num_pins)
+{
+	if (selector >= ARRAY_SIZE(omap_pin_groups))
+		return -EINVAL;
+	*pins = omap_pin_groups[selector].pins;
+	*num_pins = omap_pin_groups[selector].num_pins;
+	return 0;
+}
+
+static void omap_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+		   unsigned offset)
+{
+	seq_printf(s, " " DRIVER_NAME);
+}
+
+static struct pinctrl_ops omap_pctrl_ops = {
+	.list_groups = omap_list_groups,
+	.get_group_name = omap_get_group_name,
+	.get_group_pins = omap_get_group_pins,
+	.pin_dbg_show = omap_pin_dbg_show,
+};
+
+/*
+ * Here we define the available functions and their corresponding pin groups
+ */
+
+/**
+ * struct omap_pmx_func - describes omap pinmux functions
+ * @name: the name of this specific function
+ * @groups: corresponding pin groups
+ * @onmask: bits to set to enable this when doing pin muxing
+ */
+struct omap_pmx_func {
+	const char *name;
+	const char * const *groups;
+	const unsigned num_groups;
+	const struct omap_pmx_mask *mask;
+};
+
+static const char * const hdmi_grps[] = { "hdmi_grp" };
+static const char * const sdmmc5_grps[] = { "sdmmc5_grp" };
+static const char * const dispc2_grps[] = { "dispc2_grp" };
+
+static const struct omap_pmx_func omap_pmx_functions[] = {
+	{
+		.name = "hdmi",
+		.groups = hdmi_grps,
+		.num_groups = ARRAY_SIZE(hdmi_grps),
+	},
+	{
+		.name = "sdmmc5",
+		.groups = sdmmc5_grps,
+		.num_groups = ARRAY_SIZE(sdmmc5_grps),
+	},
+	{
+		.name = "dispc2",
+		.groups = dispc2_grps,
+		.num_groups = ARRAY_SIZE(dispc2_grps),
+	},
+};
+
+/* handle 8 bit registers too, for now only worry about 16bit ones*/
+static u16 omap_pmx_read(struct omap_pmx *opmx, unsigned pin)
+{
+	return __raw_readw(opmx->virtbase + (pin * 2));
+}
+
+static void omap_pmx_write(u16 val, struct omap_pmx *opmx, unsigned pin)
+{
+	__raw_writew(val, opmx->virtbase + (pin * 2));
+}
+
+static void omap_pmx_endisable(struct omap_pmx *opmx, unsigned selector,
+			       unsigned group, bool enable)
+{
+	int i;
+	unsigned pin, muxmode;
+	u16 oldval, newval;
+
+	for (i = 0; i < omap_pin_groups[group].num_pins; i++) {
+		pin = omap_pin_groups[group].pins[i];
+		muxmode = omap_pin_groups[group].muxmodes[i];
+		/* Put disabled pins in safe (MODE7) mode */
+		if (!enable)
+			muxmode = OMAP_MUX_MODE7;
+		oldval = omap_pmx_read(opmx, pin);
+		newval = (oldval & ~(OMAP_MUX_NR_MODES - 1)) | muxmode;
+		omap_pmx_write(newval, opmx, pin);
+	}
+}
+
+static int omap_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
+			   unsigned group)
+{
+	struct omap_pmx *opmx;
+
+	opmx = pinctrl_dev_get_drvdata(pctldev);
+	omap_pmx_endisable(opmx, selector, group, true);
+
+	return 0;
+}
+
+static void omap_pmx_disable(struct pinctrl_dev *pctldev, unsigned selector,
+			     unsigned group)
+{
+	struct omap_pmx *opmx;
+
+	opmx = pinctrl_dev_get_drvdata(pctldev);
+	omap_pmx_endisable(opmx, selector, group, false);
+}
+
+static int omap_pmx_list_funcs(struct pinctrl_dev *pctldev, unsigned selector)
+{
+	if (selector >= ARRAY_SIZE(omap_pmx_functions))
+		return -EINVAL;
+	return 0;
+}
+
+static const char *omap_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					  unsigned selector)
+{
+	return omap_pmx_functions[selector].name;
+}
+
+static int omap_pmx_get_groups(struct pinctrl_dev *pctldev, unsigned selector,
+			       const char * const **groups,
+			       unsigned * const num_groups)
+{
+	*groups = omap_pmx_functions[selector].groups;
+	*num_groups = omap_pmx_functions[selector].num_groups;
+	return 0;
+}
+
+static struct pinmux_ops omap_pmx_ops = {
+	.list_functions = omap_pmx_list_funcs,
+	.get_function_name = omap_pmx_get_func_name,
+	.get_function_groups = omap_pmx_get_groups,
+	.enable = omap_pmx_enable,
+	.disable = omap_pmx_disable,
+};
+
+static struct pinctrl_desc omap_pmx_desc = {
+	.name = DRIVER_NAME,
+	.maxpin = OMAP_NUM_PADS-1,
+	.pctlops = &omap_pctrl_ops,
+	.pmxops = &omap_pmx_ops,
+	.owner = THIS_MODULE,
+};
+
+static int __init omap_pmx_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct omap_pmx *opmx;
+	struct resource *res;
+
+	/* Create state holders etc for this driver */
+	opmx = devm_kzalloc(&pdev->dev, sizeof(*opmx), GFP_KERNEL);
+	if (!opmx)
+		return -ENOMEM;
+
+	opmx->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENOENT;
+		goto out_no_resource;
+	}
+	opmx->phybase = res->start;
+	opmx->physize = resource_size(res);
+
+	if (request_mem_region(opmx->phybase, opmx->physize,
+			       DRIVER_NAME) == NULL) {
+		ret = -ENOMEM;
+		goto out_no_memregion;
+	}
+
+	opmx->virtbase = ioremap(opmx->phybase, opmx->physize);
+	if (!opmx->virtbase) {
+		ret = -ENOMEM;
+		goto out_no_remap;
+	}
+
+	if (pdev->id) {
+		omap_pmx_desc.pins = omap4_wkup_pads;
+		omap_pmx_desc.npins = ARRAY_SIZE(omap4_wkup_pads);
+	} else {
+		omap_pmx_desc.pins = omap4_core_pads;
+		omap_pmx_desc.npins = ARRAY_SIZE(omap4_core_pads);
+	}
+
+	opmx->pctl = pinctrl_register(&omap_pmx_desc, &pdev->dev, opmx);
+	if (!opmx->pctl) {
+		dev_err(&pdev->dev, "could not register OMAP pinmux driver\n");
+		ret = -EINVAL;
+		goto out_no_pmx;
+	}
+
+	platform_set_drvdata(pdev, opmx);
+
+	dev_info(&pdev->dev, "initialized OMAP pinmux driver\n");
+
+	return 0;
+
+out_no_pmx:
+	iounmap(opmx->virtbase);
+out_no_remap:
+	platform_set_drvdata(pdev, NULL);
+out_no_memregion:
+	release_mem_region(opmx->phybase, opmx->physize);
+out_no_resource:
+	devm_kfree(&pdev->dev, opmx);
+	return ret;
+}
+
+static int __exit omap_pmx_remove(struct platform_device *pdev)
+{
+	struct omap_pmx *opmx = platform_get_drvdata(pdev);
+
+	pinctrl_unregister(opmx->pctl);
+	iounmap(opmx->virtbase);
+	release_mem_region(opmx->phybase, opmx->physize);
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, opmx);
+
+	return 0;
+}
+
+static struct platform_driver omap_pmx_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+	.remove = __exit_p(omap_pmx_remove),
+};
+
+static int __init omap_pmx_init(void)
+{
+	return platform_driver_probe(&omap_pmx_driver, omap_pmx_probe);
+}
+arch_initcall(omap_pmx_init);
+
+static void __exit omap_pmx_exit(void)
+{
+	platform_driver_unregister(&omap_pmx_driver);
+}
+module_exit(omap_pmx_exit);
+
+MODULE_AUTHOR("Rajendra Nayak <rnayak@ti.com>");
+MODULE_DESCRIPTION("OMAP pin control driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.1

