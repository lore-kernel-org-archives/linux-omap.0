From: "K, Mythri P" <mythripk@ti.com>
Subject: [PATCH 1/2] OMAP:DSS:RFC Patch to add support for HDMI as panel
 driver
Date: Thu, 26 Aug 2010 10:47:15 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BE2A6AB3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44828 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826Ab0HZFRZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 01:17:25 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>

From: Mythri P K <mythripk@ti.com>

This is an RFC patch to add support for HDMI panel driver in OMAP.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/displays/hdmi_omap4_panel.c | 1443 +++++++++++++++++++++++
 drivers/video/omap2/displays/hdmi_omap4_panel.h |  672 +++++++++++
 2 files changed, 2115 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/hdmi_omap4_panel.c
 create mode 100644 drivers/video/omap2/displays/hdmi_omap4_panel.h

diff --git a/drivers/video/omap2/displays/hdmi_omap4_panel.c b/drivers/video/omap2/displays/hdmi_omap4_panel.c
new file mode 100644
index 0000000..4319076
--- /dev/null
+++ b/drivers/video/omap2/displays/hdmi_omap4_panel.c
@@ -0,0 +1,1443 @@
+/*
+ * hdmi_lib.c
+ *
+ * HDMI library support functions for TI OMAP processors.
+ *
+ * Copyright (C) 2010 Texas Instruments
+ * Author: Yong Zhi <y-zhi@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+/* Rev history:
+ * MythriPk <mythripk@ti.com>  -Redesigned on the driver to adhere to DSS2 model.
+ *                             -Added EDID/EEDID reading and to handle checksum
+ *                             -Autodetect of sink When the HDMI is enabled
+ *                             -support for all resolutions and timings
+ *                                     supported by the DSS hardware.
+ * Rob Clark <rob@ti.com>      -Clean up of debug code and functions.
+ *
+ */
+
+#define DSS_SUBSYS_NAME "HDMI"
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <../drivers/video/omap2/displays/hdmi_omap4_panel.h>
+
+static struct {
+       void __iomem *base_core;     /*0*/
+       void __iomem *base_core_av;  /*1*/
+       void __iomem *base_wp;       /*2*/
+       void __iomem *base_phy;
+       void __iomem *base_pll;
+       int code;
+       int mode;
+       struct mutex hdmi_lock;
+} hdmi;
+
+static inline void hdmi_write_reg(u32 base, u16 idx, u32 val)
+{
+       void __iomem *b;
+
+       switch (base) {
+       case HDMI_CORE_SYS:
+         b = hdmi.base_core;
+         break;
+       case HDMI_CORE_AV:
+         b = hdmi.base_core_av;
+         break;
+       case HDMI_WP:
+         b = hdmi.base_wp;
+         break;
+       case HDMI_PHY:
+         b = hdmi.base_phy;
+         break;
+       case HDMI_PLLCTRL:
+         b = hdmi.base_pll;
+         break;
+       default:
+         BUG();
+       }
+       __raw_writel(val, b + idx);
+       /* DBG("write = 0x%x idx =0x%x\r\n", val, idx); */
+}
+
+static inline u32 hdmi_read_reg(u32 base, u16 idx)
+{
+       void __iomem *b;
+       u32 l;
+
+       switch (base) {
+       case HDMI_CORE_SYS:
+        b = hdmi.base_core;
+        break;
+       case HDMI_CORE_AV:
+        b = hdmi.base_core_av;
+        break;
+       case HDMI_WP:
+        b = hdmi.base_wp;
+        break;
+       case HDMI_PHY:
+        b = hdmi.base_phy;
+        break;
+       case HDMI_PLLCTRL:
+        b = hdmi.base_pll;
+        break;
+       default:
+        BUG();
+       }
+       l = __raw_readl(b + idx);
+
+       /* DBG("addr = 0x%p rd = 0x%x idx = 0x%x\r\n", (b+idx), l, idx); */
+       return l;
+}
+
+static int hdmi_pll_init(int refsel, int dcofreq,
+               struct hdmi_pll_info *fmt, u16 sd)
+{
+       u32 r;
+       unsigned t = 500000;
+       u32 pll = HDMI_PLLCTRL;
+
+       /* PLL start always use manual mode */
+       REG_FLD_MOD(pll, PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
+
+       r = hdmi_read_reg(pll, PLLCTRL_CFG1);
+       r = FLD_MOD(r, fmt->regm, 20, 9); /* CFG1__PLL_REGM */
+       r = FLD_MOD(r, fmt->regn, 8, 1);  /* CFG1__PLL_REGN */
+       r = FLD_MOD(r, fmt->regm4, 25, 21); /* M4_CLOCK_DIV */
+
+       hdmi_write_reg(pll, PLLCTRL_CFG1, r);
+
+       r = hdmi_read_reg(pll, PLLCTRL_CFG2);
+
+       r = FLD_MOD(r, 0x0, 11, 11); /* PLL_CLKSEL 1: PLL 0: SYS*/
+       r = FLD_MOD(r, 0x0, 12, 12); /* PLL_HIGHFREQ divide by 2 */
+       r = FLD_MOD(r, 0x1, 13, 13); /* PLL_REFEN */
+       r = FLD_MOD(r, 0x0, 14, 14); /* PHY_CLKINEN de-assert during locking */
+       r = FLD_MOD(r, 0x1, 20, 20); /* HSDIVBYPASS assert during locking */
+       r = FLD_MOD(r, refsel, 22, 21); /* REFSEL */
+       /* DPLL3  used by DISPC or HDMI itself*/
+       r = FLD_MOD(r, 0x0, 17, 17); /* M4_CLOCK_PWDN */
+       r = FLD_MOD(r, 0x1, 16, 16); /* M4_CLOCK_EN */
+
+       if (dcofreq) {
+               /* divider programming for 1080p */
+               REG_FLD_MOD(pll, PLLCTRL_CFG3, sd, 17, 10);
+               r = FLD_MOD(r, 0x4, 3, 1); /* 1000MHz and 2000MHz */
+       } else
+               r = FLD_MOD(r, 0x2, 3, 1); /* 500MHz and 1000MHz */
+
+       hdmi_write_reg(pll, PLLCTRL_CFG2, r);
+
+       r = hdmi_read_reg(pll, PLLCTRL_CFG4);
+       r = FLD_MOD(r, 0, 24, 18); /* todo: M2 */
+       r = FLD_MOD(r, fmt->regmf, 17, 0);
+
+       /* go now */
+       REG_FLD_MOD(pll, PLLCTRL_PLL_GO, 0x1ul, 0, 0);
+
+       /* wait for bit change */
+       while (FLD_GET(hdmi_read_reg(pll, PLLCTRL_PLL_GO), 0, 0))
+
+       /* Wait till the lock bit is set */
+       /* read PLL status */
+       while (0 == FLD_GET(hdmi_read_reg(pll, PLLCTRL_PLL_STATUS), 1, 1)) {
+               udelay(1);
+               if (!--t) {
+                       printk(KERN_WARNING "HDMI: cannot lock PLL\n");
+                       DBG("CFG1 0x%x\n", hdmi_read_reg(pll, PLLCTRL_CFG1));
+                       DBG("CFG2 0x%x\n", hdmi_read_reg(pll, PLLCTRL_CFG2));
+                       DBG("CFG4 0x%x\n", hdmi_read_reg(pll, PLLCTRL_CFG4));
+                       return -EIO;
+               }
+       }
+
+       DBG("PLL locked!\n");
+
+       r = hdmi_read_reg(pll, PLLCTRL_CFG2);
+       r = FLD_MOD(r, 0, 0, 0);        /* PLL_IDLE */
+       r = FLD_MOD(r, 0, 5, 5);        /* PLL_PLLLPMODE */
+       r = FLD_MOD(r, 0, 6, 6);        /* PLL_LOWCURRSTBY */
+       r = FLD_MOD(r, 0, 8, 8);        /* PLL_DRIFTGUARDEN */
+       r = FLD_MOD(r, 0, 10, 9);       /* PLL_LOCKSEL */
+       r = FLD_MOD(r, 1, 13, 13);      /* PLL_REFEN */
+       r = FLD_MOD(r, 1, 14, 14);      /* PHY_CLKINEN */
+       r = FLD_MOD(r, 0, 15, 15);      /* BYPASSEN */
+       r = FLD_MOD(r, 0, 20, 20);      /* HSDIVBYPASS */
+       hdmi_write_reg(pll, PLLCTRL_CFG2, r);
+
+       return 0;
+}
+
+static int hdmi_pll_reset(void)
+{
+       int t = 0;
+
+       /* SYSREEST  controled by power FSM*/
+       REG_FLD_MOD(HDMI_PLLCTRL, PLLCTRL_PLL_CONTROL, 0x0, 3, 3);
+
+       /* READ 0x0 reset is in progress */
+       while (!FLD_GET(hdmi_read_reg(HDMI_PLLCTRL,
+                       PLLCTRL_PLL_STATUS), 0, 0)) {
+               udelay(1);
+               if (t++ > 1000) {
+                       ERR("Failed to sysrest PLL\n");
+                       return -ENODEV;
+               }
+       }
+       return 0;
+}
+
+static int hdmi_phy_init(u32 w1,
+               u32 phy)
+{
+       int r;
+
+       /* wait till PHY_PWR_STATUS=LDOON */
+       /* HDMI_PHYPWRCMD_LDOON = 1 */
+       r = hdmi_w1_set_wait_phy_pwr(1);
+       if (r)
+               return r;
+
+       /* wait till PHY_PWR_STATUS=TXON */
+       r = hdmi_w1_set_wait_phy_pwr(2);
+       if (r)
+               return r;
+
+       /* read address 0 in order to get the SCPreset done completed */
+       /* Dummy access performed to solve resetdone issue */
+       hdmi_read_reg(phy, HDMI_TXPHY_TX_CTRL);
+
+       /* write to phy address 0 to configure the clock */
+       /* use HFBITCLK write HDMI_TXPHY_TX_CONTROL__FREQOUT field */
+       REG_FLD_MOD(phy, HDMI_TXPHY_TX_CTRL, 0x1, 31, 30);
+
+       /* write to phy address 1 to start HDMI line (TXVALID and TMDSCLKEN) */
+       hdmi_write_reg(phy, HDMI_TXPHY_DIGITAL_CTRL,
+                               0xF0000000);
+
+       /* setup max LDO voltage */
+       REG_FLD_MOD(phy, HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
+       /*  write to phy address 3 to change the polarity control  */
+       REG_FLD_MOD(phy, HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
+
+       mdelay(20);
+
+       return 0;
+}
+
+int hdmi_pll_program(struct hdmi_pll_info *fmt)
+{
+       u32 r;
+       int refsel;
+
+       int pllpwrwait;
+
+       /* wait for wrapper rest */
+       hdmi_w1_set_wait_softreset();
+
+       /* power off PLL */
+       pllpwrwait = HDMI_PLLPWRCMD_ALLOFF;
+       r = hdmi_w1_set_wait_pll_pwr(pllpwrwait);
+       if (r)
+               return r;
+
+       /* power on PLL */
+       pllpwrwait = HDMI_PLLPWRCMD_BOTHON_ALLCLKS;
+       r = hdmi_w1_set_wait_pll_pwr(pllpwrwait);
+       if (r)
+               return r;
+
+       hdmi_pll_reset();
+
+       refsel = 0x3; /* select SYSCLK reference */
+
+       r = hdmi_pll_init(refsel, fmt->dcofreq, fmt, fmt->regsd);
+
+       return r;
+}
+
+static int hdmi_phy_off(u32 name)
+{
+       int r = 0;
+
+       /* wait till PHY_PWR_STATUS=OFF */
+       /* HDMI_PHYPWRCMD_OFF = 0 */
+       r = hdmi_w1_set_wait_phy_pwr(0);
+       if (r)
+               return r;
+
+       mdelay(20);
+
+       return 0;
+}
+
+
+int hdmi_core_ddc_edid(u8 *pEDID)
+{
+       u32 i, j, l;
+       char checksum = 0;
+       u32 sts = HDMI_CORE_DDC_STATUS;
+       u32 ins = HDMI_CORE_SYS;
+
+       /* Turn on CLK for DDC */
+       REG_FLD_MOD(HDMI_CORE_AV, HDMI_CORE_AV_DPD, 0x7, 2, 0);
+
+       /* Wait */
+       mdelay(10);
+
+       /* Clk SCL Devices */
+       REG_FLD_MOD(ins, HDMI_CORE_DDC_CMD, 0xA, 3, 0);
+
+       /* HDMI_CORE_DDC_STATUS__IN_PROG */
+       while (FLD_GET(hdmi_read_reg(ins, sts), 4, 4) == 1)
+
+       /* Clear FIFO */
+       REG_FLD_MOD(ins, HDMI_CORE_DDC_CMD, 0x9, 3, 0);
+
+       /* HDMI_CORE_DDC_STATUS__IN_PROG */
+       while (FLD_GET(hdmi_read_reg(ins, sts), 4, 4) == 1)
+
+       /* Load Slave Address Register */
+       REG_FLD_MOD(ins, HDMI_CORE_DDC_ADDR, 0xA0 >> 1, 7, 1);
+
+       /* Load Offset Address Register */
+       REG_FLD_MOD(ins, HDMI_CORE_DDC_OFFSET, 0x0, 7, 0);
+       /* Load Byte Count */
+       REG_FLD_MOD(ins, HDMI_CORE_DDC_COUNT1, 0x100, 7, 0);
+       REG_FLD_MOD(ins, HDMI_CORE_DDC_COUNT2, 0x100>>8, 1, 0);
+       /* Set DDC_CMD */
+       REG_FLD_MOD(ins, HDMI_CORE_DDC_CMD, 0x2, 3, 0);
+
+       /* Yong: do not optimize this part of the code, seems
+       DDC bus needs some time to get stabilized
+       */
+       l = hdmi_read_reg(ins, sts);
+
+       /* HDMI_CORE_DDC_STATUS__BUS_LOW */
+       if (FLD_GET(l, 6, 6) == 1) {
+               printk("I2C Bus Low?\n\r");
+               return -1;
+       }
+       /* HDMI_CORE_DDC_STATUS__NO_ACK */
+       if (FLD_GET(l, 5, 5) == 1) {
+               printk("I2C No Ack\n\r");
+               return -1;
+       }
+
+       j = 100;
+       while (j--) {
+               l = hdmi_read_reg(ins, sts);
+               /* progress */
+               if (FLD_GET(l, 4, 4) == 1) {
+                       /* HACK: Load Slave Address Register again */
+                       REG_FLD_MOD(ins, HDMI_CORE_DDC_ADDR, 0xA0 >> 1, 7, 1);
+                       REG_FLD_MOD(ins, HDMI_CORE_DDC_CMD, 0x2, 3, 0);
+                       break;
+               }
+               mdelay(20);
+       }
+
+       i = 0;
+       while (((FLD_GET(hdmi_read_reg(ins, sts), 4, 4) == 1)
+                       | (FLD_GET(hdmi_read_reg(ins, sts), 2, 2) == 0)) && i < 256) {
+               if (FLD_GET(hdmi_read_reg(ins,
+                       sts), 2, 2) == 0) {
+                       /* FIFO not empty */
+                       pEDID[i++] = FLD_GET(hdmi_read_reg(ins, HDMI_CORE_DDC_DATA), 7, 0);
+               }
+       }
+
+       if (pEDID[0x14] == 0x80) {/* Digital Display */
+               if (pEDID[0x7e] == 0x00) {/* No Extention Block */
+                       for (j = 0; j < 128; j++)
+                               checksum += pEDID[j];
+                       DBG("No extension 128 bit checksum\n");
+               } else {
+                       for (j = 0; j < 256; j++)
+                               checksum += pEDID[j];
+                       DBG("Extension present 256 bit checksum\n");
+                       /* HDMI_CORE_DDC_READ_EXTBLOCK(); */
+               }
+       } else {
+               DBG("Analog Display\n");
+       }
+
+#ifdef DEBUG_EDID
+       DBG("Header:\n");
+       for (i = 0x00; i < 0x08; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("Vendor & Product:\n");
+       for (i = 0x08; i < 0x12; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("EDID Structure:\n");
+       for (i = 0x12; i < 0x14; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("Basic Display Parameter:\n");
+       for (i = 0x14; i < 0x19; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("Color Characteristics:\n");
+       for (i = 0x19; i < 0x23; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("Established timings:\n");
+       for (i = 0x23; i < 0x26; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("Standart timings:\n");
+       for (i = 0x26; i < 0x36; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("Detailed timing1:\n");
+       for (i = 0x36; i < 0x48; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("Detailed timing2:\n");
+       for (i = 0x48; i < 0x5a; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("Detailed timing3:\n");
+       for (i = 0x5a; i < 0x6c; i++)
+               DBG("%02x\n", pEDID[i]);
+       DBG("Detailed timing4:\n");
+       for (i = 0x6c; i < 0x7e; i++)
+               DBG("%02x\n", pEDID[i]);
+#endif
+       if (checksum != 0) {
+               printk("E-EDID checksum failed!!");
+               return -1;
+       }
+       return 0;
+}
+
+static inline void print_omap_video_timings(struct omap_video_timings *timings)
+{
+       extern unsigned int dss_debug;
+       if (dss_debug) {
+               printk(KERN_DEBUG "Timing Info:\n");
+               printk(KERN_DEBUG "  pixel_clk = %d\n", timings->pixel_clock);
+               printk(KERN_DEBUG "  x_res     = %d\n", timings->x_res);
+               printk(KERN_DEBUG "  y_res     = %d\n", timings->y_res);
+               printk(KERN_DEBUG "  hfp       = %d\n", timings->hfp);
+               printk(KERN_DEBUG "  hsw       = %d\n", timings->hsw);
+               printk(KERN_DEBUG "  hbp       = %d\n", timings->hbp);
+               printk(KERN_DEBUG "  vfp       = %d\n", timings->vfp);
+               printk(KERN_DEBUG "  vsw       = %d\n", timings->vsw);
+               printk(KERN_DEBUG "  vbp       = %d\n", timings->vbp);
+       }
+}
+
+static int get_timings_index(void)
+{
+       int code;
+
+       if (hdmi.mode == 0)
+               code = code_vesa[hdmi.code];
+       else
+               code = code_cea[hdmi.code];
+
+       if (code == -1) {
+               code = 9;
+               hdmi.code = 16;
+               hdmi.mode = 1;
+       }
+       return code;
+}
+
+static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing)
+{
+       int i = 0, code = -1, temp_vsync = 0, temp_hsync = 0;
+       int timing_vsync = 0, timing_hsync = 0;
+       struct omap_video_timings temp;
+       struct hdmi_cm cm = {-1};
+       DBG("hdmi_get_code");
+
+       for (i = 0; i < 31; i++) {
+               temp = cea_vesa_timings[i];
+               if ((temp.pixel_clock == timing->pixel_clock) &&
+                       (temp.x_res == timing->x_res) &&
+                       (temp.y_res == timing->y_res)) {
+
+                       temp_hsync = temp.hfp + temp.hsw + temp.hbp;
+                       timing_hsync = timing->hfp + timing->hsw + timing->hbp;
+                       temp_vsync = temp.vfp + temp.vsw + temp.vbp;
+                       timing_vsync = timing->vfp + timing->vsw + timing->vbp;
+
+                       printk("Temp_hsync = %d , temp_vsync = %d , \
+                               timing_hsync = %d, timing_vsync = %d", \
+                               temp_hsync, temp_hsync, timing_hsync, timing_vsync);
+
+                       if ((temp_hsync == timing_hsync)  &&  (temp_vsync == timing_vsync)) {
+                               code = i;
+                               cm.code = code_index[i];
+                               if (code < 14)
+                                       cm.mode = HDMI_HDMI;
+                               else
+                                       cm.mode = HDMI_DVI;
+                               DBG("Hdmi_code = %d mode = %d\n", cm.code, cm.mode);
+                               print_omap_video_timings(&temp);
+                               break;
+                        }
+               }
+
+       }
+       return cm;
+}
+
+void get_horz_vert_timing_info(int current_descriptor_addrs, u8 *edid , struct omap_video_timings *timings)
+{
+       /*X and Y resolution */
+       timings->x_res = (((edid[current_descriptor_addrs + 4] & 0xF0) << 4) |
+                        edid[current_descriptor_addrs + 2]);
+       timings->y_res = (((edid[current_descriptor_addrs + 7] & 0xF0) << 4) |
+                        edid[current_descriptor_addrs + 5]);
+
+       timings->pixel_clock = ((edid[current_descriptor_addrs + 1] << 8) |
+                                       edid[current_descriptor_addrs]);
+
+       timings->pixel_clock = 10 * timings->pixel_clock;
+
+       /*HORIZONTAL FRONT PORCH */
+       timings->hfp = edid[current_descriptor_addrs + 8];
+       /*HORIZONTAL SYNC WIDTH */
+       timings->hsw = edid[current_descriptor_addrs + 9];
+       /*HORIZONTAL BACK PORCH */
+       timings->hbp = (((edid[current_descriptor_addrs + 4]
+                                         & 0x0F) << 8) |
+                                       edid[current_descriptor_addrs + 3]) -
+               (timings->hfp + timings->hsw);
+       /*VERTICAL FRONT PORCH */
+       timings->vfp = ((edid[current_descriptor_addrs + 10] &
+                                      0xF0) >> 4);
+       /*VERTICAL SYNC WIDTH */
+       timings->vsw = (edid[current_descriptor_addrs + 10] &
+                                     0x0F);
+       /*VERTICAL BACK PORCH */
+       timings->vbp = (((edid[current_descriptor_addrs + 7] &
+                                       0x0F) << 8) |
+                                     edid[current_descriptor_addrs + 6]) -
+               (timings->vfp + timings->vsw);
+
+       print_omap_video_timings(timings);
+
+}
+
+/*------------------------------------------------------------------------------
+ | Function    : get_edid_timing_data
+ +------------------------------------------------------------------------------
+ | Description : This function gets the resolution information from EDID
+ |
+ | Parameters  : void
+ |
+ | Returns     : void
+ +----------------------------------------------------------------------------*/
+static int get_edid_timing_data(u8 *edid)
+{
+       u8 count, code;
+       u16 current_descriptor_addrs;
+       struct hdmi_cm cm;
+       /* Seach block 0, there are 4 DTDs arranged in priority order */
+       for (count = 0; count < EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR; count++) {
+               current_descriptor_addrs =
+                       EDID_DESCRIPTOR_BLOCK0_ADDRESS +
+                       count * EDID_TIMING_DESCRIPTOR_SIZE;
+               get_horz_vert_timing_info(current_descriptor_addrs, edid, &edid_timings);
+               cm = hdmi_get_code(&edid_timings);
+               DBG("Block0[%d] value matches code = %d , mode = %d",\
+                       count, cm.code, cm.mode);
+               if (cm.code == -1)
+                       continue;
+               else {
+                       hdmi.code = cm.code;
+                       hdmi.mode = cm.mode;
+                       DBG("code = %d , mode = %d", hdmi.code, hdmi.mode);
+                       return 1;
+               }
+
+       }
+       if (edid[0x7e] != 0x00) {
+               for (count = 0; count < EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR; count++) {
+                       current_descriptor_addrs =
+                       EDID_DESCRIPTOR_BLOCK1_ADDRESS +
+                       count * EDID_TIMING_DESCRIPTOR_SIZE;
+                       get_horz_vert_timing_info(current_descriptor_addrs, edid,\
+                                                       &edid_timings);
+                       cm = hdmi_get_code(&edid_timings);
+                       DBG("Block1[%d] value matches code = %d , mode = %d",\
+                               count, cm.code, cm.mode);
+                       if (cm.code == -1)
+                               continue;
+                       else {
+                               hdmi.code = cm.code;
+                               hdmi.mode = cm.mode;
+                               DBG("code = %d , mode = %d", hdmi.code, hdmi.mode);
+                               return 1;
+                       }
+
+               }
+       }
+       hdmi.code = 4; /*setting default value of 640 480 VGA*/
+       hdmi.mode = HDMI_DVI;
+       code = code_vesa[hdmi.code];
+       edid_timings = cea_vesa_timings[code];
+       return 1;
+
+}
+
+static int hdmi_read_edid(struct omap_video_timings *dp)
+{
+       int r = 0, i = 0 , ret, code;
+
+       memset(edid, 0, HDMI_EDID_MAX_LENGTH);
+
+       if (!edid_set) {
+               ret = hdmi_core_ddc_edid(edid);
+       }
+       if (ret != 0)
+               printk(KERN_WARNING "HDMI failed to read E-EDID\n");
+       else {
+               if (!memcmp(edid, header, sizeof(header))) {
+                       /* search for timings of default resolution */
+                       if (get_edid_timing_data(edid))
+                               edid_set = true;
+               }
+
+       }
+
+       if (!edid_set) {
+               DBG("fallback to VGA\n");
+               hdmi.code = 4; /*setting default value of 640 480 VGA*/
+               hdmi.mode = HDMI_DVI;
+       }
+       code = get_timings_index();
+
+       *dp = cea_vesa_timings[code];
+
+       DBG(KERN_INFO"hdmi read EDID:\n");
+       print_omap_video_timings(dp);
+
+       return r;
+}
+
+static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
+       struct hdmi_core_infoframe_avi *avi_cfg,
+       struct hdmi_core_packet_enable_repeat *repeat_cfg)
+{
+       DBG("Enter hdmi_core_init()\n");
+
+       /*video core*/
+       video_cfg->ip_bus_width = HDMI_INPUT_8BIT;
+       video_cfg->op_dither_truc = HDMI_OUTPUTTRUNCATION_8BIT;
+       video_cfg->deep_color_pkt = HDMI_DEEPCOLORPACKECTDISABLE;
+       video_cfg->pkt_mode = HDMI_PACKETMODERESERVEDVALUE;
+       video_cfg->hdmi_dvi = HDMI_DVI;
+       video_cfg->tclk_sel_clkmult = FPLL10IDCK;
+
+
+       /*info frame*/
+       avi_cfg->db1_format = 0;
+       avi_cfg->db1_active_info = 0;
+       avi_cfg->db1_bar_info_dv = 0;
+       avi_cfg->db1_scan_info = 0;
+       avi_cfg->db2_colorimetry = 0;
+       avi_cfg->db2_aspect_ratio = 0;
+       avi_cfg->db2_active_fmt_ar = 0;
+       avi_cfg->db3_itc = 0;
+       avi_cfg->db3_ec = 0;
+       avi_cfg->db3_q_range = 0;
+       avi_cfg->db3_nup_scaling = 0;
+       avi_cfg->db4_videocode = 0;
+       avi_cfg->db5_pixel_repeat = 0;
+       avi_cfg->db6_7_line_eoftop = 0 ;
+       avi_cfg->db8_9_line_sofbottom = 0;
+       avi_cfg->db10_11_pixel_eofleft = 0;
+       avi_cfg->db12_13_pixel_sofright = 0;
+
+       /*packet enable and repeat*/
+       repeat_cfg->audio_pkt = 0;
+       repeat_cfg->audio_pkt_repeat = 0;
+       repeat_cfg->avi_infoframe = 0;
+       repeat_cfg->avi_infoframe_repeat = 0;
+       repeat_cfg->gen_cntrl_pkt = 0;
+       repeat_cfg->gen_cntrl_pkt_repeat = 0;
+       repeat_cfg->generic_pkt = 0;
+       repeat_cfg->generic_pkt_repeat = 0;
+}
+
+static void hdmi_core_powerdown_disable(void)
+{
+       DBG("Enter hdmi_core_powerdown_disable()\n");
+       REG_FLD_MOD(HDMI_CORE_SYS, HDMI_CORE_CTRL1, 0x0, 0, 0);
+}
+
+/* todo: power off the core */
+static __attribute__ ((unused)) void hdmi_core_powerdown_enable(void)
+{
+       REG_FLD_MOD(HDMI_CORE_SYS, HDMI_CORE_CTRL1, 0x1, 0, 0);
+}
+
+static void hdmi_core_swreset_release(void)
+{
+       DBG("Enter hdmi_core_swreset_release()\n");
+       REG_FLD_MOD(HDMI_CORE_SYS, HDMI_CORE_SYS__SRST, 0x0, 0, 0);
+}
+
+static void hdmi_core_swreset_assert(void)
+{
+       DBG("Enter hdmi_core_swreset_assert ()\n");
+       REG_FLD_MOD(HDMI_CORE_SYS, HDMI_CORE_SYS__SRST, 0x1, 0, 0);
+}
+
+/* DSS_HDMI_CORE_VIDEO_CONFIG */
+static int hdmi_core_video_config(
+       struct hdmi_core_video_config *cfg)
+{
+       u32 name = HDMI_CORE_SYS;
+       u32 av_name = HDMI_CORE_AV;
+       u32 r = 0;
+
+       /*sys_ctrl1 default configuration not tunable*/
+       u32 ven;
+       u32 hen;
+       u32 bsel;
+       u32 edge;
+
+       /*sys_ctrl1 default configuration not tunable*/
+       ven = HDMI_CORE_CTRL1_VEN__FOLLOWVSYNC;
+       hen = HDMI_CORE_CTRL1_HEN__FOLLOWHSYNC;
+       bsel = HDMI_CORE_CTRL1_BSEL__24BITBUS;
+       edge = HDMI_CORE_CTRL1_EDGE__RISINGEDGE;
+
+       /*sys_ctrl1 default configuration not tunable*/
+       r = hdmi_read_reg(name, HDMI_CORE_CTRL1);
+       r = FLD_MOD(r, ven, 5, 5);
+       r = FLD_MOD(r, hen, 4, 4);
+       r = FLD_MOD(r, bsel, 2, 2);
+       r = FLD_MOD(r, edge, 1, 1);
+       hdmi_write_reg(name, HDMI_CORE_CTRL1, r);
+
+       REG_FLD_MOD(name, HDMI_CORE_SYS__VID_ACEN, cfg->ip_bus_width, 7, 6);
+
+       /*Vid_Mode */
+       r = hdmi_read_reg(name, HDMI_CORE_SYS__VID_MODE);
+       /*dither truncation configuration*/
+       if (cfg->op_dither_truc >
+                               HDMI_OUTPUTTRUNCATION_12BIT) {
+               r = FLD_MOD(r, cfg->op_dither_truc - 3, 7, 6);
+               r = FLD_MOD(r, 1, 5, 5);
+       } else {
+               r = FLD_MOD(r, cfg->op_dither_truc, 7, 6);
+               r = FLD_MOD(r, 0, 5, 5);
+       }
+       hdmi_write_reg(name, HDMI_CORE_SYS__VID_MODE, r);
+
+       /*HDMI_Ctrl*/
+       r = hdmi_read_reg(av_name, HDMI_CORE_AV_HDMI_CTRL);
+       r = FLD_MOD(r, cfg->deep_color_pkt, 6, 6);
+       r = FLD_MOD(r, cfg->pkt_mode, 5, 3);
+       r = FLD_MOD(r, cfg->hdmi_dvi, 0, 0);
+       hdmi_write_reg(av_name, HDMI_CORE_AV_HDMI_CTRL, r);
+
+       /*TMDS_CTRL*/
+       REG_FLD_MOD(name, HDMI_CORE_SYS__TMDS_CTRL,
+               cfg->tclk_sel_clkmult, 6, 5);
+
+       return 0;
+}
+
+static int hdmi_core_aux_infoframe_avi(u32 name,
+       struct hdmi_core_infoframe_avi info_avi)
+{
+       u16 offset;
+       int dbyte, dbyte_size;
+       u32 val;
+
+       dbyte = HDMI_CORE_AV_AVI_DBYTE;
+       dbyte_size = HDMI_CORE_AV_AVI_DBYTE__ELSIZE;
+       /*info frame video*/
+       hdmi_write_reg(name, HDMI_CORE_AV_AVI_TYPE, 0x082);
+       hdmi_write_reg(name, HDMI_CORE_AV_AVI_VERS, 0x002);
+       hdmi_write_reg(name, HDMI_CORE_AV_AVI_LEN, 0x00D);
+
+       offset = dbyte + (0 * dbyte_size);
+       val = (info_avi.db1_format << 5) |
+               (info_avi.db1_active_info << 4) |
+               (info_avi.db1_bar_info_dv << 2) |
+               (info_avi.db1_scan_info);
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (1 * dbyte_size);
+       val = (info_avi.db2_colorimetry << 6) |
+               (info_avi.db2_aspect_ratio << 4) |
+               (info_avi.db2_active_fmt_ar);
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (2 * dbyte_size);
+       val = (info_avi.db3_itc << 7) |
+               (info_avi.db3_ec << 4) |
+               (info_avi.db3_q_range << 2) |
+               (info_avi.db3_nup_scaling);
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (3 * dbyte_size);
+       hdmi_write_reg(name, offset, info_avi.db4_videocode);
+
+       offset = dbyte + (4 * dbyte_size);
+       val = info_avi.db5_pixel_repeat;
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (5 * dbyte_size);
+       val = info_avi.db6_7_line_eoftop & 0x00FF;
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (6 * dbyte_size);
+       val = ((info_avi.db6_7_line_eoftop >> 8) & 0x00FF);
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (7 * dbyte_size);
+       val = info_avi.db8_9_line_sofbottom & 0x00FF;
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (8 * dbyte_size);
+       val = ((info_avi.db8_9_line_sofbottom >> 8) & 0x00FF);
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (9 * dbyte_size);
+       val = info_avi.db10_11_pixel_eofleft & 0x00FF;
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (10 * dbyte_size);
+       val = ((info_avi.db10_11_pixel_eofleft >> 8) & 0x00FF);
+       hdmi_write_reg(name, offset, val);
+
+       offset = dbyte + (11 * dbyte_size);
+       val = info_avi.db12_13_pixel_sofright & 0x00FF;
+       hdmi_write_reg(name, offset , val);
+
+       offset = dbyte + (12 * dbyte_size);
+       val = ((info_avi.db12_13_pixel_sofright >> 8) & 0x00FF);
+       hdmi_write_reg(name, offset, val);
+
+       return 0;
+}
+
+static int hdmi_core_av_packet_config(u32 name,
+       struct hdmi_core_packet_enable_repeat repeat_cfg)
+{
+       /*enable/repeat the infoframe*/
+       hdmi_write_reg(name, HDMI_CORE_AV_PB_CTRL1,
+               (repeat_cfg.audio_pkt << 5)|
+               (repeat_cfg.audio_pkt_repeat << 4)|
+               (repeat_cfg.avi_infoframe << 1)|
+               (repeat_cfg.avi_infoframe_repeat));
+
+       /*enable/repeat the packet*/
+       hdmi_write_reg(name, HDMI_CORE_AV_PB_CTRL2,
+               (repeat_cfg.gen_cntrl_pkt << 3)|
+               (repeat_cfg.gen_cntrl_pkt_repeat << 2)|
+               (repeat_cfg.generic_pkt << 1)|
+               (repeat_cfg.generic_pkt_repeat));
+       return 0;
+}
+
+static void hdmi_w1_init(struct hdmi_video_timing *timings,
+       struct hdmi_video_format *video_fmt,
+       struct hdmi_video_interface *video_int,
+       struct hdmi_irq_vector *irq_enable)
+{
+       DBG("Enter hdmi_w1_init\n");
+
+       timings->hbp = 0;
+       timings->hfp = 0;
+       timings->hsw = 0;
+       timings->vbp = 0;
+       timings->vfp = 0;
+       timings->vsw = 0;
+
+       video_fmt->packing_mode = HDMI_PACK_10b_RGB_YUV444;
+       video_fmt->y_res = 0;
+       video_fmt->x_res = 0;
+
+       video_int->vsp = 0;
+       video_int->hsp = 0;
+
+       video_int->interlacing = 0;
+       video_int->tm = 0; /* HDMI_TIMING_SLAVE */
+
+       irq_enable->pll_recal = 0;
+       irq_enable->pll_unlock = 0;
+       irq_enable->pll_lock = 0;
+       irq_enable->phy_disconnect = 1;
+       irq_enable->phy_connect = 1;
+       irq_enable->phy_short_5v = 0;
+       irq_enable->video_end_fr = 0;
+       irq_enable->video_vsync = 0;
+       irq_enable->fifo_sample_req = 0;
+       irq_enable->fifo_overflow = 0;
+       irq_enable->fifo_underflow = 0;
+       irq_enable->ocp_timeout = 0;
+       irq_enable->core = 1;
+
+
+}
+
+
+static void hdmi_w1_irq_enable(struct hdmi_irq_vector *irq_enable)
+{
+       u32 r = 0;
+
+       r = ((irq_enable->pll_recal << 31) |
+               (irq_enable->pll_unlock << 30) |
+               (irq_enable->pll_lock << 29) |
+               (irq_enable->phy_disconnect << 26) |
+               (irq_enable->phy_connect << 25) |
+               (irq_enable->phy_short_5v << 24) |
+               (irq_enable->video_end_fr << 17) |
+               (irq_enable->video_vsync << 16) |
+               (irq_enable->fifo_sample_req << 10) |
+               (irq_enable->fifo_overflow << 9) |
+               (irq_enable->fifo_underflow << 8) |
+               (irq_enable->ocp_timeout << 4) |
+               (irq_enable->core << 0));
+
+       hdmi_write_reg(HDMI_WP, HDMI_WP_IRQENABLE_SET, r);
+}
+
+static inline int hdmi_w1_wait_for_bit_change(const u32 ins,
+       u32 idx, int b2, int b1, int val)
+{
+       int t = 0;
+       while (val != FLD_GET(hdmi_read_reg(ins, idx), b2, b1)) {
+               udelay(1);
+               if (t++ > 1000)
+                       return !val;
+       }
+       return val;
+}
+
+/* todo: add timeout value */
+int hdmi_w1_set_wait_srest(void)
+{
+       /* reset W1 */
+       REG_FLD_MOD(HDMI_WP, HDMI_WP_SYSCONFIG, 0x1, 0, 0);
+
+       /* wait till SOFTRESET == 0 */
+       while (FLD_GET(hdmi_read_reg(HDMI_WP, HDMI_WP_SYSCONFIG), 0, 0))
+               ;
+
+       return 0;
+}
+
+/* PHY_PWR_CMD */
+int hdmi_w1_set_wait_phy_pwr(int val)
+{
+       REG_FLD_MOD(HDMI_WP, HDMI_WP_PWR_CTRL, val, 7, 6);
+
+       if (hdmi_w1_wait_for_bit_change(HDMI_WP,
+               HDMI_WP_PWR_CTRL, 5, 4, val) != val) {
+               ERR("Failed to set PHY power mode to %d\n", val);
+               return -ENODEV;
+       }
+       return 0;
+}
+
+/* PLL_PWR_CMD */
+int hdmi_w1_set_wait_pll_pwr(int val)
+{
+       REG_FLD_MOD(HDMI_WP, HDMI_WP_PWR_CTRL, val, 3, 2);
+
+       /* wait till PHY_PWR_STATUS=ON */
+       if (hdmi_w1_wait_for_bit_change(HDMI_WP,
+               HDMI_WP_PWR_CTRL, 1, 0, val) != val) {
+               ERR("Failed to set PHY_PWR_STATUS to ON\n");
+               return -ENODEV;
+       }
+
+       return 0;
+}
+
+void hdmi_w1_video_stop(void)
+{
+       REG_FLD_MOD(HDMI_WP, HDMI_WP_VIDEO_CFG, 0, 31, 31);
+}
+
+void hdmi_w1_video_start(void)
+{
+       REG_FLD_MOD(HDMI_WP, HDMI_WP_VIDEO_CFG, (u32)0x1, 31, 31);
+}
+
+static void hdmi_w1_video_init_format(struct hdmi_video_format *video_fmt,
+       struct hdmi_video_timing *timings, struct hdmi_config *param)
+{
+       DBG("Enter HDMI_W1_ConfigVideoResolutionTiming()\n");
+
+       video_fmt->y_res = param->lpp;
+       video_fmt->x_res = param->ppl;
+
+       timings->hbp = param->hbp;
+       timings->hfp = param->hfp;
+       timings->hsw = param->hsw;
+       timings->vbp = param->vbp;
+       timings->vfp = param->vfp;
+       timings->vsw = param->vsw;
+}
+
+static void hdmi_w1_video_config_format(
+       struct hdmi_video_format *video_fmt)
+{
+       u32 l = 0;
+
+       REG_FLD_MOD(HDMI_WP, HDMI_WP_VIDEO_CFG, video_fmt->packing_mode, 10, 8);
+
+       l |= FLD_VAL(video_fmt->y_res, 31, 16);
+       l |= FLD_VAL(video_fmt->x_res, 15, 0);
+       hdmi_write_reg(HDMI_WP, HDMI_WP_VIDEO_SIZE, l);
+}
+
+static void hdmi_w1_video_config_interface(
+       struct hdmi_video_interface *video_int)
+{
+       u32 r;
+       DBG("Enter HDMI_W1_ConfigVideoInterface()\n");
+
+       r = hdmi_read_reg(HDMI_WP, HDMI_WP_VIDEO_CFG);
+       r = FLD_MOD(r, video_int->vsp, 7, 7);
+       r = FLD_MOD(r, video_int->hsp, 6, 6);
+       r = FLD_MOD(r, video_int->interlacing, 3, 3);
+       r = FLD_MOD(r, video_int->tm, 1, 0);
+       hdmi_write_reg(HDMI_WP, HDMI_WP_VIDEO_CFG, r);
+}
+
+static void hdmi_w1_video_config_timing(
+       struct hdmi_video_timing *timings)
+{
+       u32 timing_h = 0;
+       u32 timing_v = 0;
+
+       DBG("Enter HDMI_W1_ConfigVideoTiming ()\n");
+
+       timing_h |= FLD_VAL(timings->hbp, 31, 20);
+       timing_h |= FLD_VAL(timings->hfp, 19, 8);
+       timing_h |= FLD_VAL(timings->hsw, 7, 0);
+       hdmi_write_reg(HDMI_WP, HDMI_WP_VIDEO_TIMING_H, timing_h);
+
+       timing_v |= FLD_VAL(timings->vbp, 31, 20);
+       timing_v |= FLD_VAL(timings->vfp, 19, 8);
+       timing_v |= FLD_VAL(timings->vsw, 7, 0);
+       hdmi_write_reg(HDMI_WP, HDMI_WP_VIDEO_TIMING_V, timing_v);
+}
+
+int hdmi_lib_enable(struct hdmi_config *cfg)
+{
+       u32 r, val;
+
+       u32 av_name = HDMI_CORE_AV;
+
+       /*HDMI*/
+       struct hdmi_video_timing video_timing;
+       struct hdmi_video_format video_format;
+       struct hdmi_video_interface video_interface;
+       struct hdmi_irq_vector irq_enable;
+
+
+       /*HDMI core*/
+       struct hdmi_core_infoframe_avi avi_cfg;
+       struct hdmi_core_video_config v_core_cfg;
+
+       struct hdmi_core_packet_enable_repeat repeat_cfg;
+
+       hdmi_w1_init(&video_timing, &video_format,
+               &video_interface, &irq_enable);
+
+       hdmi_core_init(&v_core_cfg,
+               &avi_cfg,
+               &repeat_cfg);
+
+       /* Enable PLL Lock and UnLock intrerrupts */
+       irq_enable.pll_unlock = 1;
+       irq_enable.pll_lock = 1;
+
+       /***************** init DSS register **********************/
+       hdmi_w1_irq_enable(&irq_enable);
+
+       hdmi_w1_video_init_format(&video_format,
+                       &video_timing, cfg);
+
+       hdmi_w1_video_config_timing(&video_timing);
+
+       /*video config*/
+       video_format.packing_mode = HDMI_PACK_24b_RGB_YUV444_YUV422;
+
+       hdmi_w1_video_config_format(&video_format);
+
+       /* FIXME */
+       video_interface.vsp = cfg->v_pol;
+       video_interface.hsp = cfg->h_pol;
+       video_interface.interlacing = cfg->interlace;
+       video_interface.tm = 1 ; /* HDMI_TIMING_MASTER_24BIT */
+
+       hdmi_w1_video_config_interface(&video_interface);
+
+       /* hnagalla */
+       val = hdmi_read_reg(HDMI_WP, HDMI_WP_VIDEO_SIZE);
+
+       val &= 0x0FFFFFFF;
+       val |= ((0x1f) << 27); /* wakeup */
+       hdmi_write_reg(HDMI_WP, HDMI_WP_VIDEO_SIZE, val);
+
+
+       /****************************** CORE *******************************/
+       /************* configure core video part ********************************/
+       /*set software reset in the core*/
+       hdmi_core_swreset_assert();
+
+       /*power down off*/
+       hdmi_core_powerdown_disable();
+
+       v_core_cfg.pkt_mode = HDMI_PACKETMODE24BITPERPIXEL;
+       v_core_cfg.hdmi_dvi = HDMI_HDMI;
+
+
+       r = hdmi_core_video_config(&v_core_cfg);
+
+
+       /*release software reset in the core*/
+       hdmi_core_swreset_release();
+
+       /*configure packet*/
+       /*info frame video see doc CEA861-D page 65*/
+       avi_cfg.db1_format = INFOFRAME_AVI_DB1Y_RGB;
+       avi_cfg.db1_active_info =
+               INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_OFF;
+       avi_cfg.db1_bar_info_dv = INFOFRAME_AVI_DB1B_NO;
+       avi_cfg.db1_scan_info = INFOFRAME_AVI_DB1S_0;
+       avi_cfg.db2_colorimetry = INFOFRAME_AVI_DB2C_NO;
+       avi_cfg.db2_aspect_ratio = INFOFRAME_AVI_DB2M_NO;
+       avi_cfg.db2_active_fmt_ar = INFOFRAME_AVI_DB2R_SAME;
+       avi_cfg.db3_itc = INFOFRAME_AVI_DB3ITC_NO;
+       avi_cfg.db3_ec = INFOFRAME_AVI_DB3EC_XVYUV601;
+       avi_cfg.db3_q_range = INFOFRAME_AVI_DB3Q_DEFAULT;
+       avi_cfg.db3_nup_scaling = INFOFRAME_AVI_DB3SC_NO;
+       avi_cfg.db4_videocode = cfg->video_format;
+       avi_cfg.db5_pixel_repeat = INFOFRAME_AVI_DB5PR_NO;
+       avi_cfg.db6_7_line_eoftop = 0;
+       avi_cfg.db8_9_line_sofbottom = 0;
+       avi_cfg.db10_11_pixel_eofleft = 0;
+       avi_cfg.db12_13_pixel_sofright = 0;
+
+       r = hdmi_core_aux_infoframe_avi(av_name, avi_cfg);
+
+       /*enable/repeat the infoframe*/
+       repeat_cfg.avi_infoframe = PACKETENABLE;
+       repeat_cfg.avi_infoframe_repeat = PACKETREPEATON;
+       /* wakeup */
+       repeat_cfg.audio_pkt = PACKETENABLE;
+       repeat_cfg.audio_pkt_repeat = PACKETREPEATON;
+       r = hdmi_core_av_packet_config(av_name, repeat_cfg);
+
+       REG_FLD_MOD(av_name, HDMI_CORE_AV__HDMI_CTRL, cfg->hdmi_dvi, 0, 0);
+       return r;
+}
+
+int hdmi_lib_init(void)
+{
+       u32 rev;
+
+       hdmi.base_wp = ioremap(HDMI_WP, (HDMI_HDCP - HDMI_WP));
+
+       if (!hdmi.base_wp) {
+               ERR("can't ioremap WP\n");
+               return -ENOMEM;
+       }
+
+       hdmi.base_pll = ioremap(HDMI_PLLCTRL, 64);
+       if (!hdmi.base_pll) {
+               ERR("can't ioremap pll\n");
+               return -ENOMEM;
+       }
+       hdmi.base_phy = ioremap(HDMI_PHY, 64);
+
+       if (!hdmi.base_phy) {
+               ERR("can't ioremap phy\n");
+               return -ENOMEM;
+       }
+
+       hdmi.base_core = hdmi.base_wp + 0x400;
+       hdmi.base_core_av = hdmi.base_wp + 0x900;
+
+       rev = hdmi_read_reg(HDMI_WP, HDMI_WP_REVISION);
+
+       printk(KERN_INFO "OMAP HDMI W1 rev %d.%d\n",
+               FLD_GET(rev, 10, 8), FLD_GET(rev, 5, 0));
+
+       return 0;
+}
+
+void hdmi_lib_exit(void)
+{
+       iounmap(hdmi.base_wp);
+       iounmap(hdmi.base_pll);
+       iounmap(hdmi.base_phy);
+}
+
+void dump_regs(void)
+{
+       DBG("W1 VIDEO_CFG = 0x%x\r\n", hdmi_read_reg(HDMI_WP, 0x50ul));
+       DBG("Core CTRL1 = 0x%x\r\n", hdmi_read_reg(HDMI_WP, 0x420ul));
+       DBG("Core VID_MODE = 0x%x\r\n", hdmi_read_reg(HDMI_WP, 0x528ul));
+       DBG("Core AV_CTRL = 0x%x\r\n", hdmi_read_reg(HDMI_WP, 0x9bcul));
+       DBG("Core VID_ACEN = 0x%x\r\n", hdmi_read_reg(HDMI_WP, 0x524ul));
+       DBG("Core PB_CTR2 packet buf = 0x%x\r\n", hdmi_read_reg(HDMI_WP, 0x9fcul));
+}
+
+int hdmi_w1_set_wait_softreset(void)
+{
+       /* reset W1 */
+       REG_FLD_MOD(HDMI_WP, HDMI_WP_SYSCONFIG, 0x1, 0, 0);
+
+       /* wait till SOFTRESET == 0 */
+       while (FLD_GET(hdmi_read_reg(HDMI_WP, HDMI_WP_SYSCONFIG), 0, 0))
+               ;
+
+       return 0;
+}
+
+int dss_hdmi_config(struct omap_video_timings timings, u32 video_format,
+       u32 mode)
+{
+       int err;
+       struct hdmi_config data;
+
+       data.ppl = timings.x_res;
+       data.lpp = timings.y_res;
+       data.pixel_clock = timings.pixel_clock;
+
+       data.hsw = timings.hsw;
+       data.hfp = timings.hfp;
+       data.hbp = timings.hbp;
+       data.vsw = timings.vsw;
+       data.vfp = timings.vfp;
+       data.vbp = timings.vbp;
+
+       data.h_pol = 1;
+       data.v_pol = 1;
+       data.hdmi_dvi = mode;
+       data.video_format = video_format;
+
+       err = hdmi_lib_enable(&data);
+
+       return err;
+}
+
+static int hdmi_panel_probe(struct omap_dss_device *dssdev)
+{
+       int code;
+       printk("ENTER hdmi_panel_probe()\n");
+
+       dssdev->panel.config = OMAP_DSS_LCD_TFT |
+                       OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
+
+       code = get_timings_index();
+
+       dssdev->panel.timings = cea_vesa_timings[code];
+
+       printk("hdmi_panel_probe x_res= %d y_res = %d", dssdev->panel.timings.x_res,
+                dssdev->panel.timings.y_res);
+
+       mdelay(50);
+
+       return 0;
+}
+
+static void hdmi_panel_remove(struct omap_dss_device *dssdev)
+{
+
+}
+
+static int hdmi_panel_enable(struct omap_dss_device *dssdev)
+{
+       int r, code = 0;
+       struct hdmi_pll_info pll_data;
+       struct omap_video_timings *p;
+       int clkin, n, phy;
+       /* the tv overlay manager is shared*/
+       if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
+               r = -EINVAL;
+               return r;
+       }
+
+       hdmi_w1_video_stop();
+
+       p = &dssdev->panel.timings;
+
+       DBG("hdmi_panel_probe x_res= %d y_res = %d", dssdev->panel.timings.x_res,
+                dssdev->panel.timings.y_res);
+
+       r = hdmi_enable_display(dssdev);
+
+       if (r) {
+               DBG("failed to power on\n");
+               return r;
+       }
+
+       DBG("No edid set thus will be calling hdmi_read_edid");
+       r = hdmi_read_edid(p);
+       if (r) {
+               r = -EIO;
+               return r;
+       }
+
+       code = get_timings_index();
+       dssdev->panel.timings = cea_vesa_timings[code];
+
+       clkin = 3840; /* 38.4 mHz */
+       n = 15; /* this is a constant for our math */
+       phy = p->pixel_clock;
+       compute_hdmi_pll(clkin, phy, n, &pll_data);
+
+       /* config the PLL and PHY first */
+       r = hdmi_pll_program(&pll_data);
+       if (r) {
+               DBG("Failed to lock PLL\n");
+               r = -EIO;
+               return r;
+       }
+
+       r = hdmi_phy_init(HDMI_WP, HDMI_PHY);
+       if (r) {
+               DBG("Failed to start PHY\n");
+               r = -EIO;
+               return r;
+       }
+
+       dss_hdmi_config(*p, hdmi.code, hdmi.mode);
+
+       hdmi_dispc_setting(dssdev);
+
+       printk("will enable video frame now");
+       hdmi_w1_video_start();
+
+       dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+       printk("set to active ready to return");
+       return 0;
+}
+
+static void hdmi_panel_disable(struct omap_dss_device *dssdev)
+{
+       if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
+               goto end;
+
+       if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED) {
+               /* suspended is the same as disabled with venc */
+               dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+               goto end;
+       }
+       hdmi_w1_video_stop();
+
+       hdmi_phy_off(HDMI_WP);
+
+       hdmi_w1_set_wait_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
+
+       hdmi_disable_display(dssdev);
+
+       edid_set = 0;
+
+       dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+
+end: ;/*Do nothing*/
+}
+
+static int hdmi_panel_suspend(struct omap_dss_device *dssdev)
+{
+       if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
+               goto end;
+
+       if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
+               goto end;
+
+       dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+       hdmi_display_suspend(dssdev);
+
+
+end: return 0;
+}
+
+static int hdmi_panel_resume(struct omap_dss_device *dssdev)
+{
+       int r = 0;
+       if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+               r = -EINVAL;
+               return r;
+       }
+
+       hdmi_display_resume(dssdev);
+
+       dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+       return 0;
+}
+
+static void hdmi_get_timings(struct omap_dss_device *dssdev,
+                       struct omap_video_timings *timings)
+{
+       *timings = dssdev->panel.timings;
+}
+
+static void hdmi_set_timings(struct omap_dss_device *dssdev,
+                       struct omap_video_timings *timings)
+{
+       DBG("hdmi_set_timings\n");
+
+       dssdev->panel.timings = *timings;
+
+       if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+               /* turn the hdmi off and on to get new timings to use */
+               hdmi_disable_display(dssdev);
+               hdmi_enable_display(dssdev);
+       }
+}
+
+static struct omap_dss_driver hdmi_driver = {
+       .probe          = hdmi_panel_probe,
+       .remove         = hdmi_panel_remove,
+       .enable         = hdmi_panel_enable,
+       .disable        = hdmi_panel_disable,
+       .suspend        = hdmi_panel_suspend,
+       .resume         = hdmi_panel_resume,
+       .get_timings    = hdmi_get_timings,
+       .set_timings    = hdmi_set_timings,
+       .driver                 = {
+               .name   = "hdmi_panel",
+               .owner  = THIS_MODULE,
+       },
+};
+/* driver end */
+
+static int __init hdmi_panel_init(void)
+{
+       hdmi_lib_init();
+
+       omap_dss_register_driver(&hdmi_driver);
+
+       return 0;
+}
+
+static void __exit hdmi_panel_exit(void)
+{
+       hdmi_lib_exit();
+       omap_dss_unregister_driver(&hdmi_driver);
+
+}
+
+module_init(hdmi_panel_init);
+module_exit(hdmi_panel_exit);
+
diff --git a/drivers/video/omap2/displays/hdmi_omap4_panel.h b/drivers/video/omap2/displays/hdmi_omap4_panel.h
new file mode 100644
index 0000000..c50b0d0
--- /dev/null
+++ b/drivers/video/omap2/displays/hdmi_omap4_panel.h
@@ -0,0 +1,672 @@
+ /*
+ * hdmi_lib.h
+ *
+ * HDMI driver definition for TI OMAP processors.
+ *
+ * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef _HDMI_H_
+#define _HDMI_H_
+
+#include <linux/string.h>
+#include <plat/display.h>
+
+
+#define HDMI_WP                        0x58006000
+#define HDMI_CORE_SYS          0x58006400
+#define HDMI_CORE_AV           0x58006900
+#define HDMI_HDCP              0x58007000
+#define HDMI_PLLCTRL           0x58006200
+#define HDMI_PHY               0x58006300
+#define HDMI_PLLCTRL           0x58006200
+#define HDMI_PHY               0x58006300
+
+
+/* HDMI PHY */
+#define HDMI_TXPHY_TX_CTRL                             0x0ul
+#define HDMI_TXPHY_DIGITAL_CTRL                                0x4ul
+#define HDMI_TXPHY_POWER_CTRL                          0x8ul
+
+/* HDMI Wrapper */
+#define HDMI_WP_REVISION                               0x0ul
+#define HDMI_WP_SYSCONFIG                              0x10ul
+#define HDMI_WP_IRQSTATUS_RAW                          0x24ul
+#define HDMI_WP_IRQSTATUS                              0x28ul
+#define HDMI_WP_PWR_CTRL                               0x40ul
+#define HDMI_WP_IRQENABLE_SET                          0x2Cul
+#define HDMI_WP_VIDEO_CFG                              0x50ul
+#define HDMI_WP_VIDEO_SIZE                             0x60ul
+#define HDMI_WP_VIDEO_TIMING_H                         0x68ul
+#define HDMI_WP_VIDEO_TIMING_V                         0x6Cul
+#define HDMI_WP_WP_CLK                                 0x70ul
+
+/* HDMI IP Core System */
+#define HDMI_CORE_SYS__VND_IDL                         0x0ul
+#define HDMI_CORE_SYS__DEV_IDL                         0x8ul
+#define HDMI_CORE_SYS__DEV_IDH                         0xCul
+#define HDMI_CORE_SYS__DEV_REV                         0x10ul
+#define HDMI_CORE_SYS__SRST                            0x14ul
+#define HDMI_CORE_CTRL1                                        0x20ul
+#define HDMI_CORE_SYS__SYS_STAT                                0x24ul
+#define HDMI_CORE_SYS__VID_ACEN                                0x124ul
+#define HDMI_CORE_SYS__VID_MODE                                0x128ul
+#define HDMI_CORE_SYS__INTR_STATE                      0x1C0ul
+#define HDMI_CORE_SYS__INTR1                           0x1C4ul
+#define HDMI_CORE_SYS__INTR2                           0x1C8ul
+#define HDMI_CORE_SYS__INTR3                           0x1CCul
+#define HDMI_CORE_SYS__INTR4                           0x1D0ul
+#define HDMI_CORE_SYS__UMASK1                          0x1D4ul
+#define HDMI_CORE_SYS__TMDS_CTRL                       0x208ul
+#define HDMI_CORE_CTRL1_VEN__FOLLOWVSYNC               0x1ul
+#define HDMI_CORE_CTRL1_HEN__FOLLOWHSYNC               0x1ul
+#define HDMI_CORE_CTRL1_BSEL__24BITBUS                 0x1ul
+#define HDMI_CORE_CTRL1_EDGE__RISINGEDGE               0x1ul
+#define HDMI_CORE_SYS__DE_DLY                          0xC8ul
+#define HDMI_CORE_SYS__DE_CTRL                         0xCCul
+#define HDMI_CORE_SYS__DE_TOP                          0xD0ul
+#define HDMI_CORE_SYS__DE_CNTL                         0xD8ul
+#define HDMI_CORE_SYS__DE_CNTH                         0xDCul
+#define HDMI_CORE_SYS__DE_LINL                         0xE0ul
+#define HDMI_CORE_SYS__DE_LINH__1                      0xE4ul
+
+/* HDMI IP Core Audio Video */
+#define HDMI_CORE_AV_HDMI_CTRL                         0xBCul
+#define HDMI_CORE_AV_DPD                               0xF4ul
+#define HDMI_CORE_AV_PB_CTRL1                          0xF8ul
+#define HDMI_CORE_AV_PB_CTRL2                          0xFCul
+#define HDMI_CORE_AV_AVI_TYPE                          0x100ul
+#define HDMI_CORE_AV_AVI_VERS                          0x104ul
+#define HDMI_CORE_AV_AVI_LEN                           0x108ul
+#define HDMI_CORE_AV_AVI_CHSUM                         0x10Cul
+#define HDMI_CORE_AV_AVI_DBYTE                         0x110ul
+#define HDMI_CORE_AV_AVI_DBYTE__ELSIZE                 0x4ul
+
+/* HDMI DDC E-DID */
+#define HDMI_CORE_DDC_CMD                              0x3CCul
+#define HDMI_CORE_DDC_STATUS                           0x3C8ul
+#define HDMI_CORE_DDC_ADDR                             0x3B4ul
+#define HDMI_CORE_DDC_OFFSET                           0x3BCul
+#define HDMI_CORE_DDC_COUNT1                           0x3C0ul
+#define HDMI_CORE_DDC_COUNT2                           0x3C4ul
+#define HDMI_CORE_DDC_DATA                             0x3D0ul
+#define HDMI_CORE_DDC_SEGM                             0x3B8ul
+
+#define HDMI_CORE_AV__AVI_DBYTE                                0x110ul
+#define HDMI_CORE_AV__AVI_DBYTE__ELSIZE                        0x4ul
+#define HDMI_IP_CORE_AV__AVI_DBYTE__NELEMS             15
+#define HDMI_CORE_AV__SPD_DBYTE                                0x190ul
+#define HDMI_CORE_AV__SPD_DBYTE__ELSIZE                        0x4ul
+#define HDMI_CORE_AV__SPD_DBYTE__NELEMS                        27
+#define HDMI_CORE_AV__MPEG_DBYTE                       0x290ul
+#define HDMI_CORE_AV__MPEG_DBYTE__ELSIZE               0x4ul
+#define HDMI_CORE_AV__MPEG_DBYTE__NELEMS               27
+#define HDMI_CORE_AV__GEN_DBYTE                                0x300ul
+#define HDMI_CORE_AV__GEN_DBYTE__ELSIZE                        0x4ul
+#define HDMI_CORE_AV__GEN_DBYTE__NELEMS                        31
+#define HDMI_CORE_AV__GEN2_DBYTE                       0x380ul
+#define HDMI_CORE_AV__GEN2_DBYTE__ELSIZE               0x4ul
+#define HDMI_CORE_AV__GEN2_DBYTE__NELEMS               31
+#define HDMI_CORE_AV__ACR_CTRL                         0x4ul
+#define HDMI_CORE_AV__FREQ_SVAL                                0x8ul
+#define HDMI_CORE_AV__N_SVAL1                          0xCul
+#define HDMI_CORE_AV__N_SVAL2                          0x10ul
+#define HDMI_CORE_AV__N_SVAL3                          0x14ul
+#define HDMI_CORE_AV__CTS_SVAL1                                0x18ul
+#define HDMI_CORE_AV__CTS_SVAL2                                0x1Cul
+#define HDMI_CORE_AV__CTS_SVAL3                                0x20ul
+#define HDMI_CORE_AV__CTS_HVAL1                                0x24ul
+#define HDMI_CORE_AV__CTS_HVAL2                                0x28ul
+#define HDMI_CORE_AV__CTS_HVAL3                                0x2Cul
+#define HDMI_CORE_AV__AUD_MODE                         0x50ul
+#define HDMI_CORE_AV__SPDIF_CTRL                       0x54ul
+#define HDMI_CORE_AV__HW_SPDIF_FS                      0x60ul
+#define HDMI_CORE_AV__SWAP_I2S                         0x64ul
+#define HDMI_CORE_AV__SPDIF_ERTH                       0x6Cul
+#define HDMI_CORE_AV__I2S_IN_MAP                       0x70ul
+#define HDMI_CORE_AV__I2S_IN_CTRL                      0x74ul
+#define HDMI_CORE_AV__I2S_CHST0                                0x78ul
+#define HDMI_CORE_AV__I2S_CHST1                                0x7Cul
+#define HDMI_CORE_AV__I2S_CHST2                                0x80ul
+#define HDMI_CORE_AV__I2S_CHST4                                0x84ul
+#define HDMI_CORE_AV__I2S_CHST5                                0x88ul
+#define HDMI_CORE_AV__ASRC                             0x8Cul
+#define HDMI_CORE_AV__I2S_IN_LEN                       0x90ul
+#define HDMI_CORE_AV__HDMI_CTRL                                0xBCul
+#define HDMI_CORE_AV__AUDO_TXSTAT                      0xC0ul
+#define HDMI_CORE_AV__AUD_PAR_BUSCLK_1                 0xCCul
+#define HDMI_CORE_AV__AUD_PAR_BUSCLK_2                 0xD0ul
+#define HDMI_CORE_AV__AUD_PAR_BUSCLK_3                 0xD4ul
+#define HDMI_CORE_AV__TEST_TXCTRL                      0xF0ul
+#define HDMI_CORE_AV__DPD                              0xF4ul
+#define HDMI_CORE_AV__PB_CTRL1                         0xF8ul
+#define HDMI_CORE_AV__PB_CTRL2                         0xFCul
+#define HDMI_CORE_AV__AVI_TYPE                         0x100ul
+#define HDMI_CORE_AV__AVI_VERS                         0x104ul
+#define HDMI_CORE_AV__AVI_LEN                          0x108ul
+#define HDMI_CORE_AV__AVI_CHSUM                                0x10Cul
+#define HDMI_CORE_AV__SPD_TYPE                         0x180ul
+#define HDMI_CORE_AV__SPD_VERS                         0x184ul
+#define HDMI_CORE_AV__SPD_LEN                          0x188ul
+#define HDMI_CORE_AV__SPD_CHSUM                                0x18Cul
+#define HDMI_CORE_AV__MPEG_TYPE                                0x280ul
+#define HDMI_CORE_AV__MPEG_VERS                                0x284ul
+#define HDMI_CORE_AV__MPEG_LEN                         0x288ul
+#define HDMI_CORE_AV__MPEG_CHSUM                       0x28Cul
+#define HDMI_CORE_AV__CP_BYTE1                         0x37Cul
+#define HDMI_CORE_AV__CEC_ADDR_ID                      0x3FCul
+
+/* PLL */
+#define PLLCTRL_PLL_CONTROL                            0x0ul
+#define PLLCTRL_PLL_STATUS                             0x4ul
+#define PLLCTRL_PLL_GO                                 0x8ul
+#define PLLCTRL_CFG1                                   0xCul
+#define PLLCTRL_CFG2                                   0x10ul
+#define PLLCTRL_CFG3                                   0x14ul
+#define PLLCTRL_CFG4                                   0x20ul
+
+/* HDMI PHY */
+#define HDMI_TXPHY_TX_CTRL                             0x0ul
+#define HDMI_TXPHY_DIGITAL_CTRL                                0x4ul
+#define HDMI_TXPHY_POWER_CTRL                          0x8ul
+#define HDMI_TXPHY_PAD_CFG_CTRL                                0xCul
+
+
+/* HDMI EDID Length  */
+#define HDMI_EDID_MAX_LENGTH                           256
+#define EDID_TIMING_DESCRIPTOR_SIZE                    0x12
+#define EDID_DESCRIPTOR_BLOCK0_ADDRESS                 0x36
+#define EDID_DESCRIPTOR_BLOCK1_ADDRESS                 0x80
+#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR             4
+#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR             4
+
+
+#define DBG(format, ...) \
+       printk(KERN_ERR "hdmi: " format, ## __VA_ARGS__)
+#define ERR(format, ...) \
+       printk(KERN_ERR "hdmi error: " format, ## __VA_ARGS__)
+
+#define FLD_MASK(start, end)   (((1 << (start - end + 1)) - 1) << (end))
+#define FLD_VAL(val, start, end) (((val) << end) & FLD_MASK(start, end))
+#define FLD_GET(val, start, end) (((val) & FLD_MASK(start, end)) >> (end))
+#define FLD_MOD(orig, val, start, end) \
+       (((orig) & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end))
+
+#define REG_FLD_MOD(base, idx, val, start, end) \
+       hdmi_write_reg(base, idx, FLD_MOD(hdmi_read_reg(base, idx), val, start, end))
+
+#define RD_REG_32(COMP, REG)            hdmi_read_reg(COMP, REG)
+#define WR_REG_32(COMP, REG, VAL)       hdmi_write_reg(COMP, REG, (u32)(VAL))
+
+
+u8             edid[HDMI_EDID_MAX_LENGTH] = {0};
+u8             edid_set = 0;
+u8             header[8] = {0x0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0};
+struct         omap_video_timings edid_timings;
+
+/* Logic for the below structure
+ * User enters the CEA or VESA timings by specifying
+ * the hdmicode which corresponds to CEA/VESA timings
+ * Please refer to section 6.3 in HDMI 1.3 specification for timing code.
+ * There is a correspondence between CEA/VESA timing and code.
+ * In the below structure , cea_vesa_timings corresponds  to all
+ * The OMAP4 supported timing  CEA and VESA timing values.
+ * code_cea corresponds to the CEA code entered by the user ,
+ * The use of it is to get the timing from the cea_vesa_timing array.
+ * Similarly for code_vesa.
+ * code_index is backmapping, Once EDID is read from the TV
+ * we the timing values but if we have to map it back to the
+ * corresponding CEA or VESA index this structure is used.
+ */
+
+/*This is the structure which has all supported timing values that OMAP4 supports*/
+struct omap_video_timings cea_vesa_timings[31] = {{640, 480, 25200, 96, 16, 48, 2, 10, 33},
+                                               {1280, 720, 74250, 40, 440, 220, 5, 5, 20},
+                                               {1280, 720, 74250, 40, 110, 220, 5, 5, 20},
+                                               {720, 480, 27000, 62, 16, 60, 6, 9, 30},
+                                               {2880, 576, 108000, 256, 48, 272, 5, 5, 39},
+                                               {1440, 240, 27000, 124, 38, 114, 3, 4, 15},
+                                               {1440, 288, 27000, 126, 24, 138, 3, 2, 19},
+                                               {1920, 540, 74250, 44, 528, 148, 5, 2, 15},
+                                               {1920, 540, 74250, 44, 88, 148, 5, 2, 15},
+                                               {1920, 1080, 148500, 44, 88, 148, 5, 4, 36},
+                                               {720, 576, 27000, 64, 12, 68, 5, 5, 39},
+                                               {1440, 576, 54000, 128, 24, 136, 5, 5, 39},
+                                               {1920, 1080, 148500, 44, 528, 148, 5, 4, 36},
+                                               {2880, 480, 108000, 248, 64, 240, 6, 9, 30},
+                                               /*Vesa frome here*/
+                                               {640, 480, 25175, 96, 16, 48, 2 , 11, 31},
+                                               {800, 600, 40000, 128, 40, 88, 4 , 1, 23},
+                                               {848, 480, 33750, 112, 16, 112, 8 , 6, 23},
+                                               {1280, 768, 71000, 128, 64, 192, 7 , 3, 20},
+                                               {1280, 800, 83500, 128, 72, 200, 6 , 3, 22},
+                                               {1360, 768, 85500, 112, 64, 256, 6 , 3, 18},
+                                               {1280, 960, 108000, 112, 96, 312, 3 , 1, 36},
+                                               {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38},
+                                               {1024, 768, 65000, 136, 24, 160, 6, 3, 29},
+                                               {1400, 1050, 121750, 144, 88, 232, 4, 3, 32},
+                                               {1440, 900, 106500, 152, 80, 232, 6, 3, 25},
+                                               {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30},
+                                               {1366, 768, 85500, 143, 70, 213, 3, 3, 24},
+                                               {1920, 1080, 148500, 44, 88, 80, 5, 4, 36},
+                                               {1280, 768, 68250, 32, 48, 80, 7, 3, 12},
+                                               {1400, 1050, 101000, 32, 48, 80, 4, 3, 23},
+                                               {1680, 1050, 119000, 32, 48, 80, 6, 3, 21} } ;
+
+/*This is a static Mapping array which maps the timing values with corresponding CEA / VESA code*/
+int code_index[31] = {
+                       1, 19, 4, 2, 37, 6, 21, 20, 5, 16, 17,
+                       29, 31, 35, /* <--14 CEA 17--> vesa*/
+                       4, 9, 0xE, 0x17, 0x1C, 0x27, 0x20, 0x23,
+                       0x10, 0x2A, 0X2F, 0x3A, 0X51, 0X52, 0x16,
+                       0x29, 0x39};
+
+/*This is revere static mapping which maps the CEA / VESA code to the corresponding timing values*/
+int code_cea[39] = {
+                       -1, 0, 3, 3, 2, 8, 5, 5, -1, -1, -1, -1,
+                       -1, -1, -1, -1, 9, 10, 10, 1, 7, 6, 6 ,
+                       -1, -1, -1, -1, -1, -1, 11, 11, 12, -1,
+                       -1, -1, 13, 13, 4, 4};
+
+int code_vesa[83] = {
+                       -1, -1, -1, -1, 14, -1, -1, -1, -1, 15,
+                       -1, -1, -1, -1, 16, -1, 22, -1, -1, -1,
+                       -1, -1, 28, 17, -1, -1, -1, -1, 18, -1,
+                       -1, -1, 20, -1, -1, 21, -1, -1, -1, 19,
+                       -1, 29, 23, -1, -1, -1, -1, 24, -1, -1,
+                       -1, -1, -1, -1, -1, -1, -1, 30, 25, -1,
+                       -1, -1, -1, -1, -1, -1 , -1, -1, -1, -1,
+                       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+                       -1, 26, 27};
+
+enum hdmi_phypwr {
+       HDMI_PHYPWRCMD_OFF = 0,
+       HDMI_PHYPWRCMD_LDOON = 1,
+       HDMI_PHYPWRCMD_TXON = 2
+};
+
+enum hdmi_pll_pwr {
+       HDMI_PLLPWRCMD_ALLOFF = 0,
+       HDMI_PLLPWRCMD_PLLONLY = 1,
+       HDMI_PLLPWRCMD_BOTHON_ALLCLKS = 2,
+       HDMI_PLLPWRCMD_BOTHON_NOPHYCLK = 3
+};
+
+enum hdmi_core_inputbus_width {
+       HDMI_INPUT_8BIT = 0,
+       HDMI_INPUT_10BIT = 1,
+       HDMI_INPUT_12BIT = 2
+};
+
+enum hdmi_core_dither_trunc {
+       HDMI_OUTPUTTRUNCATION_8BIT = 0,
+       HDMI_OUTPUTTRUNCATION_10BIT = 1,
+       HDMI_OUTPUTTRUNCATION_12BIT = 2,
+       HDMI_OUTPUTDITHER_8BIT = 3,
+       HDMI_OUTPUTDITHER_10BIT = 4,
+       HDMI_OUTPUTDITHER_12BIT = 5
+};
+
+enum hdmi_core_deepcolor_ed {
+       HDMI_DEEPCOLORPACKECTDISABLE = 0,
+       HDMI_DEEPCOLORPACKECTENABLE = 1
+};
+
+enum hdmi_core_packet_mode {
+       HDMI_PACKETMODERESERVEDVALUE = 0,
+       HDMI_PACKETMODE24BITPERPIXEL = 4,
+       HDMI_PACKETMODE30BITPERPIXEL = 5,
+       HDMI_PACKETMODE36BITPERPIXEL = 6,
+       HDMI_PACKETMODE48BITPERPIXEL = 7
+};
+
+enum hdmi_core_hdmi_dvi {
+       HDMI_DVI        = 0,
+       HDMI_HDMI       = 1
+};
+
+enum hdmi_core_tclkselclkmult {
+       FPLL05IDCK  = 0,
+       FPLL10IDCK  = 1,
+       FPLL20IDCK  = 2,
+       FPLL40IDCK  = 3
+};
+
+enum hdmi_core_fs {
+       FS_32000 = 0,
+       FS_44100 = 1
+};
+
+enum hdmi_core_layout {
+       LAYOUT_2CH = 0,
+       LAYOUT_8CH = 1
+};
+
+enum hdmi_core_cts_mode {
+       CTS_MODE_HW = 0,
+       CTS_MODE_SW = 1
+};
+
+enum hdmi_core_packet_ctrl {
+       PACKETENABLE = 1,
+       PACKETDISABLE = 0,
+       PACKETREPEATON = 1,
+       PACKETREPEATOFF = 0
+};
+
+/* INFOFRAME_AVI_ definations */
+enum hdmi_core_infoframe {
+       INFOFRAME_AVI_DB1Y_RGB = 0,
+       INFOFRAME_AVI_DB1Y_YUV422 = 1,
+       INFOFRAME_AVI_DB1Y_YUV444 = 2,
+       INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_OFF = 0,
+       INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_ON =  1,
+       INFOFRAME_AVI_DB1B_NO = 0,
+       INFOFRAME_AVI_DB1B_VERT = 1,
+       INFOFRAME_AVI_DB1B_HORI = 2,
+       INFOFRAME_AVI_DB1B_VERTHORI = 3,
+       INFOFRAME_AVI_DB1S_0 = 0,
+       INFOFRAME_AVI_DB1S_1 = 1,
+       INFOFRAME_AVI_DB1S_2 = 2,
+       INFOFRAME_AVI_DB2C_NO = 0,
+       INFOFRAME_AVI_DB2C_ITU601 = 1,
+       INFOFRAME_AVI_DB2C_ITU709 = 2,
+       INFOFRAME_AVI_DB2C_EC_EXTENDED = 3,
+       INFOFRAME_AVI_DB2M_NO = 0,
+       INFOFRAME_AVI_DB2M_43 = 1,
+       INFOFRAME_AVI_DB2M_169 = 2,
+       INFOFRAME_AVI_DB2R_SAME = 8,
+       INFOFRAME_AVI_DB2R_43 = 9,
+       INFOFRAME_AVI_DB2R_169 = 10,
+       INFOFRAME_AVI_DB2R_149 = 11,
+       INFOFRAME_AVI_DB3ITC_NO = 0,
+       INFOFRAME_AVI_DB3ITC_YES = 1,
+       INFOFRAME_AVI_DB3EC_XVYUV601 = 0,
+       INFOFRAME_AVI_DB3EC_XVYUV709 = 1,
+       INFOFRAME_AVI_DB3Q_DEFAULT = 0,
+       INFOFRAME_AVI_DB3Q_LR = 1,
+       INFOFRAME_AVI_DB3Q_FR = 2,
+       INFOFRAME_AVI_DB3SC_NO = 0,
+       INFOFRAME_AVI_DB3SC_HORI = 1,
+       INFOFRAME_AVI_DB3SC_VERT = 2,
+       INFOFRAME_AVI_DB3SC_HORIVERT = 3,
+       INFOFRAME_AVI_DB5PR_NO = 0,
+       INFOFRAME_AVI_DB5PR_2 = 1,
+       INFOFRAME_AVI_DB5PR_3 = 2,
+       INFOFRAME_AVI_DB5PR_4 = 3,
+       INFOFRAME_AVI_DB5PR_5 = 4,
+       INFOFRAME_AVI_DB5PR_6 = 5,
+       INFOFRAME_AVI_DB5PR_7 = 6,
+       INFOFRAME_AVI_DB5PR_8 = 7,
+       INFOFRAME_AVI_DB5PR_9 = 8,
+       INFOFRAME_AVI_DB5PR_10 = 9
+};
+
+enum hdmi_stereo_channel {
+       HDMI_STEREO_NOCHANNEL = 0,
+       HDMI_STEREO_ONECHANNELS = 1,
+       HDMI_STEREO_TWOCHANNELS = 2,
+       HDMI_STEREO_THREECHANNELS = 3,
+       HDMI_STEREO_FOURCHANNELS = 4
+};
+
+enum hdmi_cea_code {
+       HDMI_CEA_CODE_00 = 0x0,
+       HDMI_CEA_CODE_01 = 0x1,
+       HDMI_CEA_CODE_02 = 0x2,
+       HDMI_CEA_CODE_03 = 0x3,
+       HDMI_CEA_CODE_04 = 0x4,
+       HDMI_CEA_CODE_05 = 0x5,
+       HDMI_CEA_CODE_06 = 0x6,
+       HDMI_CEA_CODE_07 = 0x7,
+       HDMI_CEA_CODE_08 = 0x8,
+       HDMI_CEA_CODE_09 = 0x9,
+       HDMI_CEA_CODE_0A = 0xA,
+       HDMI_CEA_CODE_0B = 0xB,
+       HDMI_CEA_CODE_0C = 0xC,
+       HDMI_CEA_CODE_0D = 0xD,
+       HDMI_CEA_CODE_0E = 0xE,
+       HDMI_CEA_CODE_0F = 0xF,
+       HDMI_CEA_CODE_10 = 0x10,
+       HDMI_CEA_CODE_11 = 0x11,
+       HDMI_CEA_CODE_12 = 0x12,
+       HDMI_CEA_CODE_13 = 0x13,
+       HDMI_CEA_CODE_14 = 0x14,
+       HDMI_CEA_CODE_15 = 0x15,
+       HDMI_CEA_CODE_16 = 0x16,
+       HDMI_CEA_CODE_17 = 0x17,
+       HDMI_CEA_CODE_18 = 0x18,
+       HDMI_CEA_CODE_19 = 0x19,
+       HDMI_CEA_CODE_1A = 0x1A,
+       HDMI_CEA_CODE_1B = 0x1B,
+       HDMI_CEA_CODE_1C = 0x1C,
+       HDMI_CEA_CODE_1D = 0x1D,
+       HDMI_CEA_CODE_1E = 0x1E,
+       HDMI_CEA_CODE_1F = 0x1F,
+       HDMI_CEA_CODE_20 = 0x20,
+       HDMI_CEA_CODE_21 = 0x21,
+       HDMI_CEA_CODE_22 = 0x22,
+       HDMI_CEA_CODE_23 = 0x23,
+       HDMI_CEA_CODE_24 = 0x24,
+       HDMI_CEA_CODE_25 = 0x25,
+       HDMI_CEA_CODE_26 = 0x26
+};
+
+enum hdmi_iec_format {
+       HDMI_AUDIO_FORMAT_LPCM = 0,
+       HDMI_AUDIO_FORMAT_IEC = 1
+};
+
+enum hdmi_audio_justify {
+       HDMI_AUDIO_JUSTIFY_LEFT = 0,
+       HDMI_AUDIO_JUSTIFY_RIGHT = 1
+};
+
+enum hdmi_sample_order {
+       HDMI_SAMPLE_RIGHT_FIRST = 0,
+       HDMI_SAMPLE_LEFT_FIRST = 1
+};
+
+enum hdmi_sample_perword {
+       HDMI_ONEWORD_ONE_SAMPLE = 0,
+       HDMI_ONEWORD_TWO_SAMPLES = 1
+};
+
+enum hdmi_sample_size {
+       HDMI_SAMPLE_16BITS = 0,
+       HDMI_SAMPLE_24BITS = 1
+};
+
+enum hdmi_dma_irq {
+       HDMI_THRESHOLD_DMA = 0,
+       HDMI_THRESHOLD_IRQ = 1
+};
+
+enum hdmi_block_start_end {
+       HDMI_BLOCK_STARTEND_ON = 0,
+       HDMI_BLOCK_STARTEND_OFF = 1
+};
+
+
+enum hdmi_core_if_fs {
+       IF_FS_NO     = 0x0,
+       IF_FS_32000  = 0x1,
+       IF_FS_44100  = 0x2,
+       IF_FS_48000  = 0x3,
+       IF_FS_88200  = 0x4,
+       IF_FS_96000  = 0x5,
+       IF_FS_176400 = 0x6,
+       IF_FS_192000 = 0x7
+};
+
+enum hdmi_core_if_sample_size{
+       IF_NO_PER_SAMPLE = 0x0,
+       IF_16BIT_PER_SAMPLE = 0x1,
+       IF_20BIT_PER_SAMPLE = 0x2,
+       IF_24BIT_PER_SAMPLE = 0x3
+};
+
+
+enum hdmi_packing_mode {
+       HDMI_PACK_10b_RGB_YUV444 = 0,
+       HDMI_PACK_24b_RGB_YUV444_YUV422 = 1,
+       HDMI_PACK_20b_YUV422 = 2,
+       HDMI_PACK_ALREADYPACKED = 7
+};
+
+
+struct hdmi_core_video_config {
+       enum hdmi_core_inputbus_width           ip_bus_width;
+       enum hdmi_core_dither_trunc             op_dither_truc;
+       enum hdmi_core_deepcolor_ed             deep_color_pkt;
+       enum hdmi_core_packet_mode              pkt_mode;
+       enum hdmi_core_hdmi_dvi                 hdmi_dvi;
+       enum hdmi_core_tclkselclkmult           tclk_sel_clkmult;
+};
+
+/*Refer to section 8.2 in HDMI 1.3 specification for details about infoframe databytes*/
+struct hdmi_core_infoframe_avi {
+       u8              db1_format;             /*Y0, Y1 rgb,yCbCr*/
+       u8              db1_active_info;        /*A0  Active Information Present*/
+       u8              db1_bar_info_dv;        /*B0, B1 Bar info data valid*/
+       u8              db1_scan_info;          /*S0, S1 scan information*/
+       u8              db2_colorimetry;        /*C0, C1 colorimetry*/
+       u8              db2_aspect_ratio;       /*M0, M1 Aspect Ratio (4:3, 16:9)*/
+       u8              db2_active_fmt_ar;      /*R0...R3 Active Format Aspect Ratio*/
+       u8              db3_itc;                /*ITC IT Content.*/
+       u8              db3_ec;                 /*EC0, EC1, EC2 Extended Colorimetry*/
+       u8              db3_q_range;            /*Q1, Q0 Quantization range*/
+       u8              db3_nup_scaling;        /*SC1, SC0 Non-uniform Picture Scaling*/
+       u8              db4_videocode;          /*VIC0...6 Video Format Identification*/
+       u8              db5_pixel_repeat;       /*PR0...PR3 Pixel Repetition factor*/
+       u16             db6_7_line_eoftop;      /*Line Number of End of Top Bar*/
+       u16             db8_9_line_sofbottom;   /*Line Number of Start of Bottom Bar*/
+       u16             db10_11_pixel_eofleft;  /*Pixel Number of End of Left Bar*/
+       u16             db12_13_pixel_sofright; /*Pixel Number of Start of Right Bar*/
+};
+
+struct hdmi_core_packet_enable_repeat {
+       u32             audio_pkt;
+       u32             audio_pkt_repeat;
+       u32             avi_infoframe;
+       u32             avi_infoframe_repeat;
+       u32             gen_cntrl_pkt;
+       u32             gen_cntrl_pkt_repeat;
+       u32             generic_pkt;
+       u32             generic_pkt_repeat;
+};
+
+struct hdmi_audio_format {
+       enum hdmi_stereo_channel        stereo_channel_enable;
+       enum hdmi_cea_code              audio_channel_location;
+       enum hdmi_iec_format            iec;
+       enum hdmi_audio_justify         justify;
+       enum hdmi_sample_order          left_before;
+       enum hdmi_sample_perword        sample_number;
+       enum hdmi_sample_size           sample_size;
+};
+
+
+struct hdmi_audio_dma {
+       u8                              dma_transfer;
+       u8                              block_size;
+       enum hdmi_dma_irq               dma_or_irq;
+       u16                             threshold_value;
+       enum hdmi_block_start_end       block_start_end;
+};
+
+struct hdmi_video_format {
+       enum hdmi_packing_mode  packing_mode;
+       u32                     y_res;  /*Line per panel*/
+       u32                     x_res;  /*pixel per line*/
+};
+
+struct hdmi_video_interface {
+       int                     vsp;    /*Vsync polarity*/
+       int                     hsp;    /*Hsync polarity*/
+       int                     interlacing;
+       int                     tm;     /*Timing mode*/
+};
+
+struct hdmi_video_timing {
+       u32                     hbp;
+       u32                     hfp;
+       u32                     hsw;
+       u32                     vbp;
+       u32                     vfp;
+       u32                     vsw;
+};
+
+struct hdmi_config {
+       u16                     ppl;    /* pixel per line */
+       u16                     lpp;    /* line per panel */
+       u32                     pixel_clock;
+       u16                     hsw;    /* Horizontal synchronization pulse width */
+       u16                     hfp;    /* Horizontal front porch */
+       u16                     hbp;    /* Horizontal back porch */
+       u16                     vsw;    /* Vertical synchronization pulse width */
+       u16                     vfp;    /* Vertical front porch */
+       u16                     vbp;    /* Vertical back porch */
+       u16                     interlace;
+       u16                     h_pol;
+       u16                     v_pol;
+       u16                     hdmi_dvi;
+       u16                     video_format;
+};
+
+struct hdmi_core_audio_config {
+       enum hdmi_core_fs               fs; /* 0=32KHz - 1=44.1KHz */
+       u32                             n;
+       u32                             cts;
+       u32                             aud_par_busclk;
+       enum hdmi_core_layout           layout; /* 0: 2Ch - 1: 8Ch */
+       enum hdmi_core_cts_mode         cts_mode; /* 0: HW  - 1: SW*/
+       enum hdmi_core_if_fs            if_fs;
+       u32                             if_channel_number;
+       enum hdmi_core_if_sample_size   if_sample_size;
+       enum hdmi_cea_code              if_audio_channel_location;
+};
+
+static struct hdmi_cm {
+       int code;
+       int mode;
+};
+
+struct hdmi_irq_vector {
+       u8      pll_recal;
+       u8      pll_unlock;
+       u8      pll_lock;
+       u8      phy_disconnect;
+       u8      phy_connect;
+       u8      phy_short_5v;
+       u8      video_end_fr;
+       u8      video_vsync;
+       u8      fifo_sample_req;
+       u8      fifo_overflow;
+       u8      fifo_underflow;
+       u8      ocp_timeout;
+       u8      core;
+};
+
+/* Function prototype */
+int hdmi_w1_set_wait_phy_pwr(int param);
+int hdmi_w1_set_wait_pll_pwr(int param);
+int hdmi_w1_set_wait_softreset(void);
+int hdmi_w1_wrapper_disable(u32);
+int hdmi_w1_wrapper_enable(u32);
+int hdmi_core_ddc_edid(u8 *data);
+int dss_hdmi_config(struct omap_video_timings timings, u32 video_format, u32 mode);
+int hdmi_lib_init(void);
+void hdmi_lib_exit(void);
+int hdmi_pll_program(struct hdmi_pll_info *fmt);
+
+#endif
+
--
1.5.6.3

