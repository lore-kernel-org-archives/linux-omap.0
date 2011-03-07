From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 5/9] OMAP4 : DSS2 : HDMI: HDMI driver header file
 addition
Date: Mon, 7 Mar 2011 11:46:25 +0200
Message-ID: <1299491185.2281.144.camel@deskari>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
	 <1299224907-11354-6-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50378 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755007Ab1CGJqb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 04:46:31 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p279kU9O026692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 03:46:30 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p279kUKp011656
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 03:46:30 -0600 (CST)
In-Reply-To: <1299224907-11354-6-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-03-04 at 01:48 -0600, K, Mythri P wrote:
> Adding the hdmi interface driver header file (hdmi.h) to the dss driver.
> Register and timing declaration to be used by the corresponding c file
> is added in this file.

The subject and description are wrong. Always before sending patches do
a quick sanity check, by check the subjects, looking at the stats in the
intro letter, etc.

> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/Kconfig   |    8 +
>  drivers/video/omap2/dss/Makefile  |    1 +
>  drivers/video/omap2/dss/display.c |    3 +
>  drivers/video/omap2/dss/dss.h     |   31 +
>  drivers/video/omap2/dss/hdmi.c    | 1332 +++++++++++++++++++++++++++++++++++++
>  drivers/video/omap2/dss/hdmi.h    |    5 +
>  6 files changed, 1380 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/hdmi.c
> 
> diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
> index db01473..7749ddb 100644
> --- a/drivers/video/omap2/dss/Kconfig
> +++ b/drivers/video/omap2/dss/Kconfig
> @@ -60,6 +60,14 @@ config OMAP2_DSS_VENC
>         help
>           OMAP Video Encoder support for S-Video and composite TV-out.
> 
> +config OMAP2_DSS_HDMI
> +       bool "HDMI support"
> +       depends on ARCH_OMAP4
> +        default y
> +       help
> +         HDMI Interface. This adds the High Definition Multimedia Interface.
> +         See http://www.hdmi.org/ for HDMI specification.
> +
>  config OMAP2_DSS_SDI
>         bool "SDI support"
>         depends on ARCH_OMAP3
> diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
> index 7db17b5..5998b69 100644
> --- a/drivers/video/omap2/dss/Makefile
> +++ b/drivers/video/omap2/dss/Makefile
> @@ -5,3 +5,4 @@ omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
>  omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
>  omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
>  omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
> +omapdss-$(CONFIG_OMAP2_DSS_HDMI) += hdmi.o
> diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
> index e10b303..cbab61a 100644
> --- a/drivers/video/omap2/dss/display.c
> +++ b/drivers/video/omap2/dss/display.c
> @@ -447,6 +447,9 @@ void dss_init_device(struct platform_device *pdev,
>                 r = dsi_init_display(dssdev);
>                 break;
>  #endif
> +       case OMAP_DISPLAY_TYPE_HDMI:
> +               r = hdmi_init_display(dssdev);
> +               break;
>         default:
>                 BUG();
>         }
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 004c782..5d4a7f6 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -168,6 +168,16 @@ struct dsi_clock_info {
>         bool use_dss2_fck;
>  };
> 
> +/* HDMI PLL structure */
> +struct hdmi_pll_info {
> +       u16 regn;
> +       u16 regm;
> +       u32 regmf;
> +       u16 regm2;
> +       u16 regsd;
> +       u16 dcofreq;
> +};
> +
>  struct seq_file;
>  struct platform_device;
> 
> @@ -432,6 +442,27 @@ static inline void venc_uninit_platform_driver(void)
>  }
>  #endif
> 
> +/* HDMI */
> +#ifdef CONFIG_OMAP2_DSS_HDMI
> +int hdmi_init_platform_driver(void);
> +void hdmi_uninit_platform_driver(void);
> +int hdmi_init_display(struct omap_dss_device *dssdev);
> +#else
> +static inline int hdmi_init_display(struct omap_dss_device *dssdev)
> +{
> +       return 0;
> +}
> +static inline int hdmi_init_platform_driver(void)
> +{
> +       return 0;
> +}
> +static inline void hdmi_uninit_platform_driver(void)
> +{
> +}
> +#endif
> +int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev);
> +void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
> +
>  /* RFBI */
>  #ifdef CONFIG_OMAP2_DSS_RFBI
>  int rfbi_init_platform_driver(void);
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> new file mode 100644
> index 0000000..a6f7936
> --- /dev/null
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -0,0 +1,1332 @@
> +/*
> + * hdmi.c
> + *
> + * HDMI interface DSS driver setting for TI's OMAP4 family of processor.
> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
> + * Authors: Yong Zhi
> + *     Mythri pk <mythripk@ti.com>
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define DSS_SUBSYS_NAME "HDMI"
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +#include <plat/display.h>
> +
> +#include "dss.h"
> +#include "hdmi.h"
> +
> +static struct {
> +       struct mutex lock;
> +       struct omap_display_platform_data *pdata;
> +       struct platform_device *pdev;
> +       void __iomem *base_wp;  /* HDMI wrapper */
> +       int code;
> +       int mode;
> +       u8 edid[HDMI_EDID_MAX_LENGTH];
> +       u8 edid_set;
> +       struct hdmi_config cfg;
> +} hdmi;
> +
> +/*
> + * Logic for the below structure
> + * user enters the CEA or VESA timings by specifying
> + * the hdmicode which corresponds to CEA/VESA timings
> + * please refer to section 6.3 in HDMI 1.3 specification for timing code.
> + * There is a correspondence between CEA/VESA timing and code.
> + * In the below structure, cea_vesa_timings corresponds to all
> + * The OMAP4 supported timing  CEA and VESA timing values.
> + * code_cea corresponds to the CEA code entered by the user,
> + * The use of it is to get the timing from the cea_vesa_timing array.
> + * Similarly for code_vesa.
> + * code_index is backmapping, Once EDID is read from the TV
> + * EDID is parsed to find the timing values to map it back to the
> + * corresponding CEA or VESA index this structure is used.
> + */
> +
> +/*
> + * This is the structure which has all supported timing
> + * values that OMAP4 supports
> + */
> +struct hdmi_timings cea_vesa_timings[OMAP_HDMI_TIMINGS_NB] = {

At least this, code_vesa and header should be static and const. Please
go through these once properly, so that I don't have to comment on the
same things on every review round.

> +       { {640, 480, 25200, 96, 16, 48, 2, 10, 33} , 0 , 0},
> +       { {1280, 720, 74250, 40, 440, 220, 5, 5, 20}, 1, 1},
> +       { {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1},
> +       { {720, 480, 27027, 62, 16, 60, 6, 9, 30}, 0, 0},
> +       { {2880, 576, 108000, 256, 48, 272, 5, 5, 39}, 0, 0},
> +       { {1440, 240, 27027, 124, 38, 114, 3, 4, 15}, 0, 0},
> +       { {1440, 288, 27000, 126, 24, 138, 3, 2, 19}, 0, 0},
> +       { {1920, 540, 74250, 44, 528, 148, 5, 2, 15}, 1, 1},
> +       { {1920, 540, 74250, 44, 88, 148, 5, 2, 15}, 1, 1},
> +       { {1920, 1080, 148500, 44, 88, 148, 5, 4, 36}, 1, 1},
> +       { {720, 576, 27000, 64, 12, 68, 5, 5, 39}, 0, 0},
> +       { {1440, 576, 54000, 128, 24, 136, 5, 5, 39}, 0, 0},
> +       { {1920, 1080, 148500, 44, 528, 148, 5, 4, 36}, 1, 1},
> +       { {2880, 480, 108108, 248, 64, 240, 6, 9, 30}, 0, 0},
> +       { {1920, 1080, 74250, 44, 638, 148, 5, 4, 36}, 1, 1},
> +       /* VESA From Here */
> +       { {640, 480, 25175, 96, 16, 48, 2 , 11, 31}, 0, 0},
> +       { {800, 600, 40000, 128, 40, 88, 4 , 1, 23}, 1, 1},
> +       { {848, 480, 33750, 112, 16, 112, 8 , 6, 23}, 1, 1},
> +       { {1280, 768, 79500, 128, 64, 192, 7 , 3, 20}, 1, 0},
> +       { {1280, 800, 83500, 128, 72, 200, 6 , 3, 22}, 1, 0},
> +       { {1360, 768, 85500, 112, 64, 256, 6 , 3, 18}, 1, 1},
> +       { {1280, 960, 108000, 112, 96, 312, 3 , 1, 36}, 1, 1},
> +       { {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38}, 1, 1},
> +       { {1024, 768, 65000, 136, 24, 160, 6, 3, 29}, 0, 0},
> +       { {1400, 1050, 121750, 144, 88, 232, 4, 3, 32}, 1, 0},
> +       { {1440, 900, 106500, 152, 80, 232, 6, 3, 25}, 1, 0},
> +       { {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30}, 1, 0},
> +       { {1366, 768, 85500, 143, 70, 213, 3, 3, 24}, 1, 1},
> +       { {1920, 1080, 148500, 44, 148, 80, 5, 4, 36}, 1, 1},
> +       { {1280, 768, 68250, 32, 48, 80, 7, 3, 12}, 0, 1},
> +       { {1400, 1050, 101000, 32, 48, 80, 4, 3, 23}, 0, 1},
> +       { {1680, 1050, 119000, 32, 48, 80, 6, 3, 21}, 0, 1},
> +       { {1280, 800, 79500, 32, 48, 80, 6, 3, 14}, 0, 1},
> +       { {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1}
> +};
> +
> +/*
> + * This is a static mapping array which maps the timing values
> + * with corresponding CEA / VESA code
> + */
> +static int code_index[OMAP_HDMI_TIMINGS_NB] = {
> +       1, 19, 4, 2, 37, 6, 21, 20, 5, 16, 17, 29, 31, 35, 32,
> +       /* <--15 CEA 17--> vesa*/
> +       4, 9, 0xE, 0x17, 0x1C, 0x27, 0x20, 0x23, 0x10, 0x2A,
> +       0X2F, 0x3A, 0X51, 0X52, 0x16, 0x29, 0x39, 0x1B
> +};
> +
> +/*
> + * This is reverse static mapping which maps the CEA / VESA code
> + * to the corresponding timing values
> + */
> +static int code_cea[39] = {
> +       -1,  0,  3,  3,  2,  8,  5,  5, -1, -1,
> +       -1, -1, -1, -1, -1, -1,  9, 10, 10,  1,
> +       7,   6,  6, -1, -1, -1, -1, -1, -1, 11,
> +       11, 12, 14, -1, -1, 13, 13,  4,  4
> +};
> +
> +int code_vesa[85] = {
> +       -1, -1, -1, -1, 15, -1, -1, -1, -1, 16,
> +       -1, -1, -1, -1, 17, -1, 23, -1, -1, -1,
> +       -1, -1, 29, 18, -1, -1, -1, 32, 19, -1,
> +       -1, -1, 21, -1, -1, 22, -1, -1, -1, 20,
> +       -1, 30, 24, -1, -1, -1, -1, 25, -1, -1,
> +       -1, -1, -1, -1, -1, -1, -1, 31, 26, -1,
> +       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
> +       -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
> +       -1, 27, 28, -1, 33};
> +
> +const u8 header[8] = {0x0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0};

Bad variable name, use something more descriptive.

> +
> +static inline void hdmi_write_reg(const struct hdmi_reg idx, u32 val)
> +{
> +       __raw_writel(val, hdmi.base_wp + idx.idx);
> +}
> +
> +static inline u32 hdmi_read_reg(const struct hdmi_reg idx)
> +{
> +       return __raw_readl(hdmi.base_wp + idx.idx);
> +}
> +
> +static inline int hdmi_wait_for_bit_change(const struct hdmi_reg idx,
> +                               int b2, int b1, u32 val)
> +{
> +       u32 t = 0;
> +       while (val != REG_GET(idx, b2, b1)) {
> +               udelay(1);
> +               if (t++ > 10000)
> +                       return !val;
> +       }
> +       return val;
> +}
> +
> +int hdmi_init_display(struct omap_dss_device *dssdev)
> +{
> +       DSSDBG("init_display\n");
> +
> +       return 0;
> +}
> +
> +static int hdmi_pll_init(int refsel, int dcofreq,
> +               struct hdmi_pll_info *fmt, u16 sd)
> +{

The refsel parameter should be an enum.

> +       u32 r;
> +
> +       /* PLL start always use manual mode */
> +       REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
> +
> +       r = hdmi_read_reg(PLLCTRL_CFG1);
> +       r = FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM */
> +       r = FLD_MOD(r, fmt->regn, 8, 1);  /* CFG1_PLL_REGN */
> +
> +       hdmi_write_reg(PLLCTRL_CFG1, r);
> +
> +       r = hdmi_read_reg(PLLCTRL_CFG2);
> +
> +       r = FLD_MOD(r, 0x0, 12, 12); /* PLL_HIGHFREQ divide by 2 */
> +       r = FLD_MOD(r, 0x1, 13, 13); /* PLL_REFEN */
> +       r = FLD_MOD(r, 0x0, 14, 14); /* PHY_CLKINEN de-assert during locking */
> +
> +       if (dcofreq) {
> +               /* divider programming for frequency beyond 1000Mhz */
> +               REG_FLD_MOD(PLLCTRL_CFG3, sd, 17, 10);
> +               r = FLD_MOD(r, 0x4, 3, 1); /* 1000MHz and 2000MHz */
> +       } else {
> +               r = FLD_MOD(r, 0x2, 3, 1); /* 500MHz and 1000MHz */
> +       }
> +
> +       hdmi_write_reg(PLLCTRL_CFG2, r);
> +
> +       r = hdmi_read_reg(PLLCTRL_CFG4);
> +       r = FLD_MOD(r, fmt->regm2, 24, 18);
> +       r = FLD_MOD(r, fmt->regmf, 17, 0);
> +
> +       hdmi_write_reg(PLLCTRL_CFG4, r);
> +
> +       /* go now */
> +       REG_FLD_MOD(PLLCTRL_PLL_GO, 0x1, 0, 0);
> +
> +       /* wait for bit change */
> +       if (hdmi_wait_for_bit_change(PLLCTRL_PLL_GO, 0, 0, 1) != 1) {
> +               DSSERR("PLL GO bit not set\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       /* Wait till the lock bit is set in PLL status */
> +       if (hdmi_wait_for_bit_change(PLLCTRL_PLL_STATUS, 1, 1, 1) != 1) {
> +               DSSWARN("cannot lock PLL\n");
> +               DSSWARN("CFG1 0x%x\n",
> +                       hdmi_read_reg(PLLCTRL_CFG1));
> +               DSSWARN("CFG2 0x%x\n",
> +                       hdmi_read_reg(PLLCTRL_CFG2));
> +               DSSWARN("CFG4 0x%x\n",
> +                       hdmi_read_reg(PLLCTRL_CFG4));
> +               return -ETIMEDOUT;
> +       }
> +
> +       DSSDBG("PLL locked!\n");
> +
> +       return 0;
> +}
> +
> +/* PHY_PWR_CMD */
> +static int hdmi_wait_phy_pwr(int val)

These comments apply also to the function below.

The parameter should be an enum.

The function is misnamed. This doesn't wait for the power mode to
change, as the name implies. This sets the power mode.

> +{
> +       REG_FLD_MOD(HDMI_WP_PWR_CTRL, val, 7, 6);

Could you mark the name of the bits set with a comment.

> +
> +       if (hdmi_wait_for_bit_change(HDMI_WP_PWR_CTRL, 5, 4, val) != val) {
> +               DSSERR("Failed to set PHY power mode to %d\n", val);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +/* PLL_PWR_CMD */
> +static int hdmi_wait_pll_pwr(int val)
> +{
> +       REG_FLD_MOD(HDMI_WP_PWR_CTRL, val, 3, 2);
> +
> +       /* wait till PHY_PWR_STATUS=ON */

That's not true, it waits until the status is whatever is set with the
val parameter.

> +       if (hdmi_wait_for_bit_change(HDMI_WP_PWR_CTRL, 1, 0, val) != val) {
> +               DSSERR("Failed to set PHY_PWR_STATUS to ON\n");
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hdmi_pll_reset(void)
> +{
> +       /* SYSRESET  controlled by power FSM */
> +       REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 3, 3);
> +
> +       /* READ 0x0 reset is in progress */
> +       if (hdmi_wait_for_bit_change(PLLCTRL_PLL_STATUS, 0, 0, 1) != 1) {
> +               DSSERR("Failed to sysreset PLL\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hdmi_phy_init(void)
> +{
> +       u16 r = 0;
> +
> +       /* wait till PHY_PWR_STATUS=LDOON */

This comment is extra, it just says the same what the function and
argument below say.

> +       r = hdmi_wait_phy_pwr(HDMI_PHYPWRCMD_LDOON);
> +       if (r)
> +               return r;
> +
> +       /* wait till PHY_PWR_STATUS=TXON */

This comment is extra, it just says the same what the function and
argument below say.

> +       r = hdmi_wait_phy_pwr(HDMI_PHYPWRCMD_TXON);
> +       if (r)
> +               return r;
> +
> +       /*
> +        * Read address 0 in order to get the SCP reset done completed
> +        * Dummy access performed to make sure reset is done
> +        */
> +       hdmi_read_reg(HDMI_TXPHY_TX_CTRL);
> +
> +       /*
> +        * Write to phy address 0 to configure the clock
> +        * use HFBITCLK write HDMI_TXPHY_TX_CONTROL_FREQOUT field
> +        */
> +       REG_FLD_MOD(HDMI_TXPHY_TX_CTRL, 0x1, 31, 30);
> +
> +       /* Write to phy address 1 to start HDMI line (TXVALID and TMDSCLKEN) */
> +       hdmi_write_reg(HDMI_TXPHY_DIGITAL_CTRL, 0xF0000000);
> +
> +       /* Setup max LDO voltage */
> +       REG_FLD_MOD(HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
> +
> +       /* Write to phy address 3 to change the polarity control */
> +       REG_FLD_MOD(HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
> +
> +       return 0;
> +}
> +
> +static int hdmi_pll_program(struct hdmi_pll_info *fmt)
> +{
> +       u16 r = 0;
> +       int refsel;
> +
> +       /* wait for wrapper reset */
> +       hdmi_wait_softreset();
> +
> +       /* power off PLL */
> +       r = hdmi_wait_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
> +       if (r)
> +               return r;
> +
> +       /* power on PLL */
> +       r = hdmi_wait_pll_pwr(HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
> +       if (r)
> +               return r;

No need for the comments above. They are clear from the functions
called.

> +
> +       hdmi_pll_reset();
> +
> +       refsel = 0x3; /* select SYSCLK reference */
> +
> +       r = hdmi_pll_init(refsel, fmt->dcofreq, fmt, fmt->regsd);
> +       if (r)
> +               return r;
> +
> +       return 0;
> +}
> +
> +static void hdmi_phy_off(void)
> +{
> +       /* Wait till PHY_PWR_STATUS=OFF */

This comment is extra also.

> +       hdmi_wait_phy_pwr(HDMI_PHYPWRCMD_OFF);
> +}
> +
> +static int hdmi_core_ddc_edid(u8 *pEDID, int ext)
> +{
> +       u32 i, j;
> +       char checksum = 0;
> +       u32 offset = 0;
> +
> +       /* Turn on CLK for DDC */
> +       REG_FLD_MOD(HDMI_CORE_AV_DPD, 0x7, 2, 0);
> +
> +       /*
> +        * SW HACK : DDC needs time to stablize else it sometimes reads 0 values
> +        * or right shifted values.
> +        */
> +       usleep_range(800, 1000);

This is still unclear. Is it an OMAP HW problem? OMAP HW feature? A
feature in HDMI TVs? A HDMI spec delay? Or unknown reason?

> +
> +       if (!ext) {
> +               /* Clk SCL Devices */
> +               REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0xA, 3, 0);
> +
> +               /* HDMI_CORE_DDC_STATUS_IN_PROG No timer needed */
> +               if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS,
> +                                               4, 4, 0) != 0) {
> +                       DSSERR("Failed to program DDC\n");
> +                       return -ETIMEDOUT;
> +               }
> +
> +               /* Clear FIFO */
> +               REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3, 0);
> +
> +               /* HDMI_CORE_DDC_STATUS_IN_PROG */
> +               if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS,
> +                                               4, 4, 0) != 0) {
> +                       DSSERR("Failed to program DDC\n");
> +                       return -ETIMEDOUT;
> +               }
> +
> +       } else {
> +               if (ext % 2 != 0)
> +                       offset = 0x80;
> +       }
> +
> +       /* Load Segment Address Register */
> +       REG_FLD_MOD(HDMI_CORE_DDC_SEGM, ext/2, 7, 0);
> +
> +       /* Load Slave Address Register */
> +       REG_FLD_MOD(HDMI_CORE_DDC_ADDR, 0xA0 >> 1, 7, 1);
> +
> +       /* Load Offset Address Register */
> +       REG_FLD_MOD(HDMI_CORE_DDC_OFFSET, offset, 7, 0);
> +
> +       /* Load Byte Count */
> +       REG_FLD_MOD(HDMI_CORE_DDC_COUNT1, 0x80, 7, 0);
> +       REG_FLD_MOD(HDMI_CORE_DDC_COUNT2, 0x0, 1, 0);
> +
> +       /* Set DDC_CMD */
> +       if (ext)
> +               REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x4, 3, 0);
> +       else
> +               REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x2, 3, 0);
> +
> +       /*
> +        * Do not optimize this part of the code, seems
> +        * DDC bus needs some time to get stabilized
> +        */
> +
> +       /* HDMI_CORE_DDC_STATUS_BUS_LOW */
> +       if (REG_GET(HDMI_CORE_DDC_STATUS, 6, 6) == 1) {
> +               DSSWARN("I2C Bus Low?\n");
> +               return -EIO;
> +       }
> +       /* HDMI_CORE_DDC_STATUS_NO_ACK */
> +       if (REG_GET(HDMI_CORE_DDC_STATUS, 5, 5) == 1) {
> +               DSSWARN("I2C No Ack\n");
> +               return -EIO;
> +       }
> +
> +       i = ext * 128;
> +       j = 0;
> +       while (((REG_GET(HDMI_CORE_DDC_STATUS, 4, 4) == 1) ||
> +                       (REG_GET(HDMI_CORE_DDC_STATUS, 2, 2) == 0)) &&
> +                       j < 128) {
> +
> +               if (REG_GET(HDMI_CORE_DDC_STATUS, 2, 2) == 0) {
> +                       /* FIFO not empty */
> +                       pEDID[i++] = REG_GET(HDMI_CORE_DDC_DATA, 7, 0);
> +                       j++;
> +               }
> +       }
> +
> +       for (j = 0; j < 128; j++)
> +               checksum += pEDID[j];
> +
> +       if (checksum != 0) {
> +               DSSERR("E-EDID checksum failed!!\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +int read_edid(u8 *pEDID, u16 max_length)
> +{
> +       int r = 0, n = 0, i = 0;
> +       int max_ext_blocks = (max_length / 128) - 1;
> +
> +       r = hdmi_core_ddc_edid(pEDID, 0);
> +       if (r) {
> +               return -EIO;
> +       } else {
> +               n = pEDID[0x7e];
> +
> +               /*
> +                * README: need to comply with max_length set by the caller.
> +                * Better implementation should be to allocate necessary
> +                * memory to store EDID according to nb_block field found
> +                * in first block
> +                */
> +
> +               if (n > max_ext_blocks)
> +                       n = max_ext_blocks;
> +
> +               for (i = 1; i <= n; i++) {
> +                       r = hdmi_core_ddc_edid(pEDID, i);
> +                       if (r)
> +                               return -EIO;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static void print_omap_video_timings(struct omap_video_timings *timings)
> +{
> +       DSSINFO("Timing Info:\n");
> +       DSSINFO("pixel_clk = %d\n", timings->pixel_clock);
> +       DSSINFO("  x_res     = %d\n", timings->x_res);
> +       DSSINFO("  y_res     = %d\n", timings->y_res);
> +       DSSINFO("  hfp       = %d\n", timings->hfp);
> +       DSSINFO("  hsw       = %d\n", timings->hsw);
> +       DSSINFO("  hbp       = %d\n", timings->hbp);
> +       DSSINFO("  vfp       = %d\n", timings->vfp);
> +       DSSINFO("  vsw       = %d\n", timings->vsw);
> +       DSSINFO("  vbp       = %d\n", timings->vbp);
> +}
> +
> +static int get_timings_index(void)
> +{
> +       int code;
> +
> +       if (hdmi.mode == 0)
> +               code = code_vesa[hdmi.code];
> +       else
> +               code = code_cea[hdmi.code];
> +
> +       if (code == -1) {
> +               code = 9;
> +               /* HDMI code 16 corresponds to 1920 * 1080 */
> +               hdmi.code = 16;
> +               /* HDMI mode 1 corresponds to HDMI 0 to DVI */
> +               hdmi.mode = HDMI_HDMI;
> +       }
> +       return code;
> +}
> +
> +static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing)
> +{
> +       int i = 0, code = -1, temp_vsync = 0, temp_hsync = 0;
> +       int timing_vsync = 0, timing_hsync = 0;
> +       struct omap_video_timings temp;
> +       struct hdmi_cm cm = {-1};
> +       DSSDBG("hdmi_get_code\n");
> +
> +       for (i = 0; i < OMAP_HDMI_TIMINGS_NB; i++) {
> +               temp = cea_vesa_timings[i].timings;
> +               if ((temp.pixel_clock == timing->pixel_clock) &&
> +                       (temp.x_res == timing->x_res) &&
> +                       (temp.y_res == timing->y_res)) {
> +
> +                       temp_hsync = temp.hfp + temp.hsw + temp.hbp;
> +                       timing_hsync = timing->hfp + timing->hsw + timing->hbp;
> +                       temp_vsync = temp.vfp + temp.vsw + temp.vbp;
> +                       timing_vsync = timing->vfp + timing->vsw + timing->vbp;
> +
> +                       DSSDBG("temp_hsync = %d , temp_vsync = %d"
> +                               "timing_hsync = %d, timing_vsync = %d\n",
> +                               temp_hsync, temp_hsync,
> +                               timing_hsync, timing_vsync);
> +
> +                       if ((temp_hsync == timing_hsync) &&
> +                                       (temp_vsync == timing_vsync)) {
> +                               code = i;
> +                               cm.code = code_index[i];
> +                               if (code < 14)
> +                                       cm.mode = HDMI_HDMI;
> +                               else
> +                                       cm.mode = HDMI_DVI;
> +                               DSSINFO("Hdmi_code = %d mode = %d\n",
> +                                        cm.code, cm.mode);
> +                               print_omap_video_timings(&temp);
> +                               break;
> +                        }
> +               }
> +       }
> +
> +       return cm;
> +}
> +
> +static void get_horz_vert_timing_info(int current_descriptor_addrs, u8 *edid ,
> +               struct omap_video_timings *timings)
> +{
> +       /* X and Y resolution */
> +       timings->x_res = (((edid[current_descriptor_addrs + 4] & 0xF0) << 4) |
> +                        edid[current_descriptor_addrs + 2]);
> +       timings->y_res = (((edid[current_descriptor_addrs + 7] & 0xF0) << 4) |
> +                        edid[current_descriptor_addrs + 5]);
> +
> +       timings->pixel_clock = ((edid[current_descriptor_addrs + 1] << 8) |
> +                               edid[current_descriptor_addrs]);
> +
> +       timings->pixel_clock = 10 * timings->pixel_clock;
> +
> +       /* HORIZONTAL FRONT PORCH */
> +       timings->hfp = edid[current_descriptor_addrs + 8] |
> +                       ((edid[current_descriptor_addrs + 11] & 0xc0) << 2);
> +       /* HORIZONTAL SYNC WIDTH */
> +       timings->hsw = edid[current_descriptor_addrs + 9] |
> +                       ((edid[current_descriptor_addrs + 11] & 0x30) << 4);
> +       /* HORIZONTAL BACK PORCH */
> +       timings->hbp = (((edid[current_descriptor_addrs + 4] & 0x0F) << 8) |
> +                       edid[current_descriptor_addrs + 3]) -
> +                       (timings->hfp + timings->hsw);
> +       /* VERTICAL FRONT PORCH */
> +       timings->vfp = ((edid[current_descriptor_addrs + 10] & 0xF0) >> 4) |
> +                       ((edid[current_descriptor_addrs + 11] & 0x0f) << 2);
> +       /* VERTICAL SYNC WIDTH */
> +       timings->vsw = (edid[current_descriptor_addrs + 10] & 0x0F) |
> +                       ((edid[current_descriptor_addrs + 11] & 0x03) << 4);
> +       /* VERTICAL BACK PORCH */
> +       timings->vbp = (((edid[current_descriptor_addrs + 7] & 0x0F) << 8) |
> +                       edid[current_descriptor_addrs + 6]) -
> +                       (timings->vfp + timings->vsw);
> +
> +       print_omap_video_timings(timings);
> +
> +}
> +
> +/* Description : This function gets the resolution information from EDID */
> +static void get_edid_timing_data(u8 *edid)
> +{
> +       u8 count;
> +       u16 current_descriptor_addrs;
> +       struct hdmi_cm cm;
> +       struct omap_video_timings edid_timings;
> +
> +       /* seach block 0, there are 4 DTDs arranged in priority order */
> +       for (count = 0; count < EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR; count++) {
> +               current_descriptor_addrs =
> +                       EDID_DESCRIPTOR_BLOCK0_ADDRESS +
> +                       count * EDID_TIMING_DESCRIPTOR_SIZE;
> +               get_horz_vert_timing_info(current_descriptor_addrs,
> +                               edid, &edid_timings);
> +               cm = hdmi_get_code(&edid_timings);
> +               DSSINFO("Block0[%d] value matches code = %d , mode = %d\n",
> +                       count, cm.code, cm.mode);
> +               if (cm.code == -1) {
> +                       continue;
> +               } else {
> +                       hdmi.code = cm.code;
> +                       hdmi.mode = cm.mode;
> +                       DSSINFO("code = %d , mode = %d\n",
> +                               hdmi.code, hdmi.mode);
> +                       return;
> +               }
> +       }
> +       if (edid[0x7e] != 0x00) {
> +               for (count = 0; count < EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR;
> +                       count++) {
> +                       current_descriptor_addrs =
> +                       EDID_DESCRIPTOR_BLOCK1_ADDRESS +
> +                       count * EDID_TIMING_DESCRIPTOR_SIZE;
> +                       get_horz_vert_timing_info(current_descriptor_addrs,
> +                                               edid, &edid_timings);
> +                       cm = hdmi_get_code(&edid_timings);
> +                       DSSINFO("Block1[%d] value matches code = %d, mode = %d",
> +                               count, cm.code, cm.mode);
> +                       if (cm.code == -1) {
> +                               continue;
> +                       } else {
> +                               hdmi.code = cm.code;
> +                               hdmi.mode = cm.mode;
> +                               DSSINFO("code = %d , mode = %d\n",
> +                                       hdmi.code, hdmi.mode);
> +                               return;
> +                       }
> +               }
> +       }
> +
> +       DSSINFO("no valid timing found , falling back to VGA\n");
> +       hdmi.code = 4; /* setting default value of 640 480 VGA */
> +       hdmi.mode = HDMI_DVI;
> +}
> +
> +static int hdmi_read_edid(struct omap_video_timings *dp)
> +{
> +       int ret = 0, code;
> +
> +       memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
> +
> +       if (!hdmi.edid_set)
> +               ret = read_edid(hdmi.edid, HDMI_EDID_MAX_LENGTH);
> +
> +       if (ret != 0) {
> +               DSSWARN("failed to read E-EDID\n");
> +       } else {
> +               if (!memcmp(hdmi.edid, header, sizeof(header))) {
> +                       /* search for timings of default resolution */
> +                       get_edid_timing_data(hdmi.edid);
> +                       hdmi.edid_set = true;
> +               }
> +       }
> +
> +       if (!hdmi.edid_set) {
> +               DSSINFO("fallback to VGA\n");
> +               hdmi.code = 4; /* setting default value of 640 480 VGA */
> +               hdmi.mode = HDMI_DVI;
> +       }
> +
> +       code = get_timings_index();
> +
> +       *dp = cea_vesa_timings[code].timings;
> +
> +       DSSDBG("print EDID timings\n");
> +       print_omap_video_timings(dp);
> +
> +       return 0;
> +}
> +
> +static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
> +                       struct hdmi_core_infoframe_avi *avi_cfg,
> +                       struct hdmi_core_packet_enable_repeat *repeat_cfg)
> +{
> +       DSSDBG("Enter hdmi_core_init\n");
> +
> +       /* video core */
> +       video_cfg->ip_bus_width = HDMI_INPUT_8BIT;
> +       video_cfg->op_dither_truc = HDMI_OUTPUTTRUNCATION_8BIT;
> +       video_cfg->deep_color_pkt = HDMI_DEEPCOLORPACKECTDISABLE;
> +       video_cfg->pkt_mode = HDMI_PACKETMODERESERVEDVALUE;
> +       video_cfg->hdmi_dvi = HDMI_DVI;
> +       video_cfg->tclk_sel_clkmult = HDMI_FPLL10IDCK;
> +
> +       /* info frame */
> +       avi_cfg->db1_format = 0;
> +       avi_cfg->db1_active_info = 0;
> +       avi_cfg->db1_bar_info_dv = 0;
> +       avi_cfg->db1_scan_info = 0;
> +       avi_cfg->db2_colorimetry = 0;
> +       avi_cfg->db2_aspect_ratio = 0;
> +       avi_cfg->db2_active_fmt_ar = 0;
> +       avi_cfg->db3_itc = 0;
> +       avi_cfg->db3_ec = 0;
> +       avi_cfg->db3_q_range = 0;
> +       avi_cfg->db3_nup_scaling = 0;
> +       avi_cfg->db4_videocode = 0;
> +       avi_cfg->db5_pixel_repeat = 0;
> +       avi_cfg->db6_7_line_eoftop = 0 ;
> +       avi_cfg->db8_9_line_sofbottom = 0;
> +       avi_cfg->db10_11_pixel_eofleft = 0;
> +       avi_cfg->db12_13_pixel_sofright = 0;
> +
> +       /* packet enable and repeat */
> +       repeat_cfg->audio_pkt = 0;
> +       repeat_cfg->audio_pkt_repeat = 0;
> +       repeat_cfg->avi_infoframe = 0;
> +       repeat_cfg->avi_infoframe_repeat = 0;
> +       repeat_cfg->gen_cntrl_pkt = 0;
> +       repeat_cfg->gen_cntrl_pkt_repeat = 0;
> +       repeat_cfg->generic_pkt = 0;
> +       repeat_cfg->generic_pkt_repeat = 0;
> +}
> +
> +static void hdmi_core_powerdown_disable(void)
> +{
> +       DSSDBG("Enter hdmi_core_powerdown_disable\n");
> +       REG_FLD_MOD(HDMI_CORE_CTRL1, 0x0, 0, 0);
> +}
> +
> +static void hdmi_core_swreset_release(void)
> +{
> +       DSSDBG("Enter hdmi_core_swreset_release\n");
> +       REG_FLD_MOD(HDMI_CORE_SYS_SRST, 0x0, 0, 0);
> +}
> +
> +static void hdmi_core_swreset_assert(void)
> +{
> +       DSSDBG("Enter hdmi_core_swreset_assert\n");
> +       REG_FLD_MOD(HDMI_CORE_SYS_SRST, 0x1, 0, 0);
> +}
> +
> +/* DSS_HDMI_CORE_VIDEO_CONFIG */
> +static void hdmi_core_video_config(struct hdmi_core_video_config *cfg)
> +{
> +       u32 r = 0;
> +
> +       /* sys_ctrl1 default configuration not tunable */
> +       r = hdmi_read_reg(HDMI_CORE_CTRL1);
> +       r = FLD_MOD(r, HDMI_CORE_CTRL1_VEN_FOLLOWVSYNC, 5, 5);
> +       r = FLD_MOD(r, HDMI_CORE_CTRL1_HEN_FOLLOWHSYNC, 4, 4);
> +       r = FLD_MOD(r, HDMI_CORE_CTRL1_BSEL_24BITBUS, 2, 2);
> +       r = FLD_MOD(r, HDMI_CORE_CTRL1_EDGE_RISINGEDGE, 1, 1);
> +       hdmi_write_reg(HDMI_CORE_CTRL1, r);
> +
> +       REG_FLD_MOD(HDMI_CORE_SYS_VID_ACEN, cfg->ip_bus_width, 7, 6);
> +
> +       /* Vid_Mode */
> +       r = hdmi_read_reg(HDMI_CORE_SYS_VID_MODE);
> +
> +       /* dither truncation configuration */
> +       if (cfg->op_dither_truc > HDMI_OUTPUTTRUNCATION_12BIT) {
> +               r = FLD_MOD(r, cfg->op_dither_truc - 3, 7, 6);
> +               r = FLD_MOD(r, 1, 5, 5);
> +       } else {
> +               r = FLD_MOD(r, cfg->op_dither_truc, 7, 6);
> +               r = FLD_MOD(r, 0, 5, 5);
> +       }
> +       hdmi_write_reg(HDMI_CORE_SYS_VID_MODE, r);
> +
> +       /* HDMI_Ctrl */
> +       r = hdmi_read_reg(HDMI_CORE_AV_HDMI_CTRL);
> +       r = FLD_MOD(r, cfg->deep_color_pkt, 6, 6);
> +       r = FLD_MOD(r, cfg->pkt_mode, 5, 3);
> +       r = FLD_MOD(r, cfg->hdmi_dvi, 0, 0);
> +       hdmi_write_reg(HDMI_CORE_AV_HDMI_CTRL, r);
> +
> +       /* TMDS_CTRL */
> +       REG_FLD_MOD(HDMI_CORE_SYS_TMDS_CTRL,
> +               cfg->tclk_sel_clkmult, 6, 5);
> +}
> +
> +static void hdmi_core_aux_infoframe_avi_config(
> +               struct hdmi_core_infoframe_avi info_avi)
> +{
> +       u32 val;
> +       char sum = 0, checksum = 0;
> +
> +       sum += 0x82 + 0x002 + 0x00D;
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_TYPE, 0x082);
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_VERS, 0x002);
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_LEN, 0x00D);
> +
> +       val = (info_avi.db1_format << 5) |
> +               (info_avi.db1_active_info << 4) |
> +               (info_avi.db1_bar_info_dv << 2) |
> +               (info_avi.db1_scan_info);
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(0), val);
> +       sum += val;
> +
> +       val = (info_avi.db2_colorimetry << 6) |
> +               (info_avi.db2_aspect_ratio << 4) |
> +               (info_avi.db2_active_fmt_ar);
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(1), val);
> +       sum += val;
> +
> +       val = (info_avi.db3_itc << 7) |
> +               (info_avi.db3_ec << 4) |
> +               (info_avi.db3_q_range << 2) |
> +               (info_avi.db3_nup_scaling);
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(2), val);
> +       sum += val;
> +
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(3), info_avi.db4_videocode);
> +       sum += info_avi.db4_videocode;
> +
> +       val = info_avi.db5_pixel_repeat;
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(4), val);
> +       sum += val;
> +
> +       val = info_avi.db6_7_line_eoftop & 0x00FF;
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(5), val);
> +       sum += val;
> +
> +       val = ((info_avi.db6_7_line_eoftop >> 8) & 0x00FF);
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(6), val);
> +       sum += val;
> +
> +       val = info_avi.db8_9_line_sofbottom & 0x00FF;
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(7), val);
> +       sum += val;
> +
> +       val = ((info_avi.db8_9_line_sofbottom >> 8) & 0x00FF);
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(8), val);
> +       sum += val;
> +
> +       val = info_avi.db10_11_pixel_eofleft & 0x00FF;
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(9), val);
> +       sum += val;
> +
> +       val = ((info_avi.db10_11_pixel_eofleft >> 8) & 0x00FF);
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(10), val);
> +       sum += val;
> +
> +       val = info_avi.db12_13_pixel_sofright & 0x00FF;
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(11), val);
> +       sum += val;
> +
> +       val = ((info_avi.db12_13_pixel_sofright >> 8) & 0x00FF);
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(12), val);
> +       sum += val;
> +
> +       checksum = 0x100 - sum;
> +       hdmi_write_reg(HDMI_CORE_AV_AVI_CHSUM, checksum);
> +}
> +
> +static void hdmi_core_av_packet_config(
> +               struct hdmi_core_packet_enable_repeat repeat_cfg)
> +{
> +       /* enable/repeat the infoframe */
> +       hdmi_write_reg(HDMI_CORE_AV_PB_CTRL1,
> +               (repeat_cfg.audio_pkt << 5)|
> +               (repeat_cfg.audio_pkt_repeat << 4)|
> +               (repeat_cfg.avi_infoframe << 1)|
> +               (repeat_cfg.avi_infoframe_repeat));
> +
> +       /* enable/repeat the packet */
> +       hdmi_write_reg(HDMI_CORE_AV_PB_CTRL2,
> +               (repeat_cfg.gen_cntrl_pkt << 3)|
> +               (repeat_cfg.gen_cntrl_pkt_repeat << 2)|
> +               (repeat_cfg.generic_pkt << 1)|
> +               (repeat_cfg.generic_pkt_repeat));

Use space before |

> +}
> +
> +static void hdmi_wp_init(struct hdmi_video_timing *timings,
> +                       struct hdmi_video_format *video_fmt,
> +                       struct hdmi_video_interface *video_int)
> +{
> +       DSSDBG("Enter hdmi_wp_init\n");
> +
> +       timings->hbp = 0;
> +       timings->hfp = 0;
> +       timings->hsw = 0;
> +       timings->vbp = 0;
> +       timings->vfp = 0;
> +       timings->vsw = 0;
> +
> +       video_fmt->packing_mode = HDMI_PACK_10b_RGB_YUV444;
> +       video_fmt->y_res = 0;
> +       video_fmt->x_res = 0;
> +
> +       video_int->vsp = 0;
> +       video_int->hsp = 0;
> +
> +       video_int->interlacing = 0;
> +       video_int->tm = 0; /* HDMI_TIMING_SLAVE */
> +
> +}
> +
> +static void hdmi_wp_video_stop(void)
> +{
> +       REG_FLD_MOD(HDMI_WP_VIDEO_CFG, 0, 31, 31);
> +}
> +
> +static void hdmi_wp_video_start(void)
> +{
> +       REG_FLD_MOD(HDMI_WP_VIDEO_CFG, (u32)0x1, 31, 31);

No need for the typecast.

> +}
> +
> +static void hdmi_wp_video_init_format(struct hdmi_video_format *video_fmt,
> +       struct hdmi_video_timing *timings, struct hdmi_config *param)
> +{
> +       DSSDBG("Enter hdmi_wp_video_init_format\n");
> +
> +       video_fmt->y_res = param->lpp;
> +       video_fmt->x_res = param->ppl;
> +
> +       timings->hbp = param->hbp;
> +       timings->hfp = param->hfp;
> +       timings->hsw = param->hsw;
> +       timings->vbp = param->vbp;
> +       timings->vfp = param->vfp;
> +       timings->vsw = param->vsw;
> +}
> +
> +static void hdmi_wp_video_config_format(
> +               struct hdmi_video_format *video_fmt)
> +{
> +       u32 l = 0;
> +
> +       REG_FLD_MOD(HDMI_WP_VIDEO_CFG, video_fmt->packing_mode, 10, 8);
> +
> +       l |= FLD_VAL(video_fmt->y_res, 31, 16);
> +       l |= FLD_VAL(video_fmt->x_res, 15, 0);
> +       hdmi_write_reg(HDMI_WP_VIDEO_SIZE, l);
> +}
> +
> +static void hdmi_wp_video_config_interface(
> +               struct hdmi_video_interface *video_int)
> +{
> +       u32 r;
> +       DSSDBG("Enter hdmi_wp_video_config_interface\n");
> +
> +       r = hdmi_read_reg(HDMI_WP_VIDEO_CFG);
> +       r = FLD_MOD(r, video_int->vsp, 7, 7);
> +       r = FLD_MOD(r, video_int->hsp, 6, 6);
> +       r = FLD_MOD(r, video_int->interlacing, 3, 3);
> +       r = FLD_MOD(r, video_int->tm, 1, 0);
> +       hdmi_write_reg(HDMI_WP_VIDEO_CFG, r);
> +}
> +
> +static void hdmi_wp_video_config_timing(
> +               struct hdmi_video_timing *timings)
> +{
> +       u32 timing_h = 0;
> +       u32 timing_v = 0;
> +
> +       DSSDBG("Enter hdmi_wp_video_config_timing\n");
> +
> +       timing_h |= FLD_VAL(timings->hbp, 31, 20);
> +       timing_h |= FLD_VAL(timings->hfp, 19, 8);
> +       timing_h |= FLD_VAL(timings->hsw, 7, 0);
> +       hdmi_write_reg(HDMI_WP_VIDEO_TIMING_H, timing_h);
> +
> +       timing_v |= FLD_VAL(timings->vbp, 31, 20);
> +       timing_v |= FLD_VAL(timings->vfp, 19, 8);
> +       timing_v |= FLD_VAL(timings->vsw, 7, 0);
> +       hdmi_write_reg(HDMI_WP_VIDEO_TIMING_V, timing_v);
> +}
> +
> +void hdmi_basic_configure(struct hdmi_config *cfg)
> +{
> +       /* HDMI */
> +       struct hdmi_video_timing video_timing;
> +       struct hdmi_video_format video_format;
> +       struct hdmi_video_interface video_interface;
> +       /* HDMI core */
> +       struct hdmi_core_infoframe_avi avi_cfg;
> +       struct hdmi_core_video_config v_core_cfg;
> +       struct hdmi_core_packet_enable_repeat repeat_cfg;
> +
> +       hdmi_wp_init(&video_timing, &video_format,
> +               &video_interface);
> +
> +       hdmi_core_init(&v_core_cfg,
> +               &avi_cfg,
> +               &repeat_cfg);
> +
> +       /* init DSS register */
> +       hdmi_wp_video_init_format(&video_format,
> +                       &video_timing, cfg);
> +
> +       hdmi_wp_video_config_timing(&video_timing);
> +
> +       /* video config */
> +       video_format.packing_mode = HDMI_PACK_24b_RGB_YUV444_YUV422;
> +
> +       hdmi_wp_video_config_format(&video_format);
> +
> +       video_interface.vsp = cfg->v_pol;
> +       video_interface.hsp = cfg->h_pol;
> +       video_interface.interlacing = cfg->interlace;
> +       video_interface.tm = 1 ; /* HDMI_TIMING_MASTER_24BIT */
> +
> +       hdmi_wp_video_config_interface(&video_interface);
> +
> +       /*
> +        * configure core video part
> +        * set software reset in the core
> +        */
> +       hdmi_core_swreset_assert();
> +
> +       /* power down off */
> +       hdmi_core_powerdown_disable();
> +
> +       v_core_cfg.pkt_mode = HDMI_PACKETMODE24BITPERPIXEL;
> +       v_core_cfg.hdmi_dvi = cfg->hdmi_dvi;
> +
> +       hdmi_core_video_config(&v_core_cfg);
> +
> +       /* release software reset in the core */
> +       hdmi_core_swreset_release();
> +
> +       /*
> +        * configure packet
> +        * info frame video see doc CEA861-D page 65
> +        */
> +       avi_cfg.db1_format = HDMI_INFOFRAME_AVI_DB1Y_RGB;
> +       avi_cfg.db1_active_info =
> +               HDMI_INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_OFF;
> +       avi_cfg.db1_bar_info_dv = HDMI_INFOFRAME_AVI_DB1B_NO;
> +       avi_cfg.db1_scan_info = HDMI_INFOFRAME_AVI_DB1S_0;
> +       avi_cfg.db2_colorimetry = HDMI_INFOFRAME_AVI_DB2C_NO;
> +       avi_cfg.db2_aspect_ratio = HDMI_INFOFRAME_AVI_DB2M_NO;
> +       avi_cfg.db2_active_fmt_ar = HDMI_INFOFRAME_AVI_DB2R_SAME;
> +       avi_cfg.db3_itc = HDMI_INFOFRAME_AVI_DB3ITC_NO;
> +       avi_cfg.db3_ec = HDMI_INFOFRAME_AVI_DB3EC_XVYUV601;
> +       avi_cfg.db3_q_range = HDMI_INFOFRAME_AVI_DB3Q_DEFAULT;
> +       avi_cfg.db3_nup_scaling = HDMI_INFOFRAME_AVI_DB3SC_NO;
> +       avi_cfg.db4_videocode = cfg->video_format;
> +       avi_cfg.db5_pixel_repeat = HDMI_INFOFRAME_AVI_DB5PR_NO;
> +       avi_cfg.db6_7_line_eoftop = 0;
> +       avi_cfg.db8_9_line_sofbottom = 0;
> +       avi_cfg.db10_11_pixel_eofleft = 0;
> +       avi_cfg.db12_13_pixel_sofright = 0;
> +
> +       hdmi_core_aux_infoframe_avi_config(avi_cfg);
> +
> +       /* enable/repeat the infoframe */
> +       repeat_cfg.avi_infoframe = HDMI_PACKETENABLE;
> +       repeat_cfg.avi_infoframe_repeat = HDMI_PACKETREPEATON;
> +
> +       /* wakeup */
> +       repeat_cfg.audio_pkt = HDMI_PACKETENABLE;
> +       repeat_cfg.audio_pkt_repeat = HDMI_PACKETREPEATON;
> +       hdmi_core_av_packet_config(repeat_cfg);
> +}
> +
> +static void update_hdmi_timings(struct hdmi_config *cfg,
> +               struct omap_video_timings *timings, int code)
> +{
> +       cfg->ppl = timings->x_res;
> +       cfg->lpp = timings->y_res;
> +       cfg->hbp = timings->hbp;
> +       cfg->hfp = timings->hfp;
> +       cfg->hsw = timings->hsw;
> +       cfg->vbp = timings->vbp;
> +       cfg->vfp = timings->vfp;
> +       cfg->vsw = timings->vsw;
> +       cfg->pixel_clock = timings->pixel_clock;
> +       cfg->v_pol = cea_vesa_timings[code].vsync_pol;
> +       cfg->h_pol = cea_vesa_timings[code].hsync_pol;
> +}
> +
> +int hdmi_wait_softreset(void)
> +{
> +       /* reset W1 */
> +       REG_FLD_MOD(HDMI_WP_SYSCONFIG, 0x1, 0, 0);
> +
> +       /* wait till SOFTRESET == 0 */
> +       if (hdmi_wait_for_bit_change(HDMI_WP_SYSCONFIG, 0, 0, 0) != 0) {
> +               DSSERR("sysconfig reset failed\n");
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static void hdmi_compute_pll(unsigned long clkin, int phy,
> +       int n, struct hdmi_pll_info *pi)
> +{
> +       unsigned long refclk;
> +       u32 mf;
> +
> +       /*
> +        * Input clock is predivided by N + 1
> +        * out put of which is reference clk
> +        */
> +       refclk = clkin / (n + 1);
> +       pi->regn = n;
> +
> +       /*
> +        * multiplier is pixel_clk/ref_clk
> +        * Multiplying by 100 to avoid fractional part removal
> +        */
> +       pi->regm = (phy * 100/(refclk))/100;
> +       pi->regm2 = 1;
> +
> +       /*
> +        * fractional multiplier is remainder of the difference between
> +        * multiplier and actual phy(required pixel clock thus should be
> +        * multiplied by 2^18(262144) divided by the reference clock
> +        */
> +       mf = (phy - pi->regm * refclk) * 262144;
> +       pi->regmf = mf/(refclk);
> +
> +       /*
> +        * Dcofreq should be set to 1 if required pixel clock
> +        * is greater than 1000MHz
> +        */
> +       pi->dcofreq = phy > 1000 * 100;
> +       pi->regsd = ((pi->regm * clkin / 10) / ((n + 1) * 250) + 5) / 10;
> +
> +       DSSDBG("M = %d Mf = %d\n", pi->regm, pi->regmf);
> +       DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
> +}
> +
> +static void hdmi_enable_clocks(int enable)
> +{
> +       if (enable)
> +               dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK |
> +                               DSS_CLK_SYSCK | DSS_CLK_VIDFCK);
> +       else
> +               dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK |
> +                               DSS_CLK_SYSCK | DSS_CLK_VIDFCK);
> +}
> +
> +static int hdmi_power_on(struct omap_dss_device *dssdev)
> +{
> +       int r, code = 0;
> +       struct hdmi_pll_info pll_data;
> +       struct omap_video_timings *p;
> +       int clkin, n, phy;
> +
> +       hdmi_enable_clocks(1);
> +
> +       dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 0);
> +
> +       p = &dssdev->panel.timings;
> +
> +       DSSDBG("hdmi_power_on x_res= %d y_res = %d\n",
> +               dssdev->panel.timings.x_res,
> +               dssdev->panel.timings.y_res);
> +
> +       DSSDBG("Read EDID as no EDID is not set on poweron\n");
> +       r = hdmi_read_edid(p);
> +       if (r)
> +               goto err;
> +
> +       code = get_timings_index();
> +       dssdev->panel.timings = cea_vesa_timings[code].timings;
> +       update_hdmi_timings(&hdmi.cfg, p, code);
> +
> +       clkin = 3840; /* 38.4 MHz */
> +       n = 15; /* this is a constant for our math */
> +       phy = p->pixel_clock;
> +
> +       hdmi_compute_pll(clkin, phy, n, &pll_data);
> +
> +       hdmi_wp_video_stop();
> +
> +       /* config the PLL and PHY first */
> +       r = hdmi_pll_program(&pll_data);
> +       if (r) {
> +               DSSDBG("Failed to lock PLL\n");
> +               goto err;
> +       }
> +
> +       r = hdmi_phy_init();
> +       if (r) {
> +               DSSDBG("Failed to start PHY\n");
> +               goto err;
> +       }
> +
> +       hdmi.cfg.hdmi_dvi = hdmi.mode;
> +       hdmi.cfg.video_format = hdmi.code;
> +       hdmi_basic_configure(&hdmi.cfg);
> +
> +       /* Make selection of HDMI in DSS */
> +       dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
> +
> +       /* Select the dispc clock source as PRCM clock, to ensure that it is not
> +        * DSI PLL source as the clock selected by DSI PLL might not be
> +        * sufficient for the resolution selected / that can be changed
> +        * dynamically by user. This can be moved to single location , say
> +        * Boardfile.
> +        */
> +       dss_select_dispc_clk_source(DSS_CLK_SRC_FCK);
> +
> +       /* bypass TV gamma table */
> +       dispc_enable_gamma_table(0);
> +
> +       /* tv size */
> +       dispc_set_digit_size(dssdev->panel.timings.x_res,
> +                       dssdev->panel.timings.y_res);
> +
> +       dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 1);
> +
> +       hdmi_wp_video_start();
> +
> +       return 0;
> +err:
> +       hdmi_enable_clocks(0);
> +       return -EIO;
> +}
> +
> +static void hdmi_power_off(struct omap_dss_device *dssdev)
> +{
> +       dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 0);
> +
> +       hdmi_wp_video_stop();
> +       hdmi_phy_off();
> +       hdmi_wait_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
> +       hdmi_enable_clocks(0);
> +
> +       hdmi.edid_set = 0;
> +}
> +
> +int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
> +{
> +       int r = 0;
> +
> +       DSSDBG("ENTER hdmi_display_enable\n");
> +
> +       mutex_lock(&hdmi.lock);
> +
> +       r = omap_dss_start_device(dssdev);
> +       if (r) {
> +               DSSDBG("failed to start device\n");

This should be an error, not dbg.

> +               goto err0;
> +       }
> +
> +       if (dssdev->platform_enable)
> +               dssdev->platform_enable(dssdev);

platform_enable returns an error value, it should be checked also.

> +
> +       r = hdmi_power_on(dssdev);
> +       if (r) {
> +               DSSERR("failed to power on device\n");
> +               goto err1;
> +       }
> +
> +       mutex_unlock(&hdmi.lock);
> +       return 0;
> +
> +err1:
> +       if (dssdev->platform_disable)
> +               dssdev->platform_disable(dssdev);
> +       omap_dss_stop_device(dssdev);
> +err0:
> +       mutex_unlock(&hdmi.lock);
> +       return r;
> +}
> +
> +void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
> +{
> +       DSSDBG("Enter hdmi_display_disable\n");
> +
> +       mutex_lock(&hdmi.lock);
> +
> +       hdmi_power_off(dssdev);
> +
> +       if (dssdev->platform_disable)
> +               dssdev->platform_disable(dssdev);
> +
> +       omap_dss_stop_device(dssdev);
> +
> +       mutex_unlock(&hdmi.lock);
> +}
> +
> +/* HDMI HW IP initialisation */
> +static int omapdss_hdmihw_probe(struct platform_device *pdev)
> +{
> +       struct resource *hdmi_mem;
> +
> +       hdmi.pdata = pdev->dev.platform_data;
> +       hdmi.pdev = pdev;
> +
> +       mutex_init(&hdmi.lock);
> +
> +       hdmi_mem = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
> +       if (!hdmi_mem) {
> +               DSSERR("can't get IORESOURCE_MEM HDMI\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Base address taken from platform */
> +       hdmi.base_wp = ioremap(hdmi_mem->start, resource_size(hdmi_mem));
> +       if (!hdmi.base_wp) {
> +               DSSERR("can't ioremap WP\n");
> +               return -ENOMEM;
> +       }
> +       return 0;
> +}
> +
> +static int omapdss_hdmihw_remove(struct platform_device *pdev)
> +{
> +       iounmap(hdmi.base_wp);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver omapdss_hdmihw_driver = {
> +       .probe          = omapdss_hdmihw_probe,
> +       .remove         = omapdss_hdmihw_remove,
> +       .driver         = {
> +               .name   = "omapdss_hdmi",
> +               .owner  = THIS_MODULE,
> +       },
> +};
> +
> +int hdmi_init_platform_driver(void)
> +{
> +       return platform_driver_register(&omapdss_hdmihw_driver);
> +}
> +
> +void hdmi_uninit_platform_driver(void)
> +{
> +       return platform_driver_unregister(&omapdss_hdmihw_driver);
> +}
> diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
> index 002f6d2..b6ab898 100644
> --- a/drivers/video/omap2/dss/hdmi.h
> +++ b/drivers/video/omap2/dss/hdmi.h
> @@ -441,4 +441,9 @@ struct hdmi_irq_vector {
>         u8      core;
>  };
> 
> +/* Function prototype */
> +int hdmi_wait_softreset(void);
> +int read_edid(u8 *pEDID, u16 max_length);
> +void hdmi_basic_configure(struct hdmi_config *cfg);

These are not called from anywhere else than hdmi.c. They can be static
and no need for these prototypes.

 Tomi


