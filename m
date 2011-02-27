From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/8] OMAP4 : DSS : HDMI: HDMI driver header file
 addition
Date: Sun, 27 Feb 2011 11:28:59 +0200
Message-ID: <1298798939.1977.19.camel@deskari>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	 <1298643715-21540-5-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59492 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849Ab1B0J3D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 04:29:03 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1R9T3QM023120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 03:29:03 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1R9T3QX012967
	for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 03:29:03 -0600 (CST)
In-Reply-To: <1298643715-21540-5-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-02-25 at 08:21 -0600, K, Mythri P wrote:
> Adding the hdmi interface driver header file (hdmi.h) to the dss driver.
> Register and timing declaration to be used by the corresponding c file is added in this file.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.h |  691 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 691 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/hdmi.h
> 
> diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
> new file mode 100644
> index 0000000..7441835
> --- /dev/null
> +++ b/drivers/video/omap2/dss/hdmi.h
> @@ -0,0 +1,691 @@
> +/*
> + * hdmi.h
> + *
> + * HDMI driver definition for TI OMAP4 processors.
> + *
> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
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
> +#ifndef _HDMI_H_
> +#define _HDMI_H_

This should be more specific. For example, __OMAP2_DSS_HDMI_H would be
in line with the other includes.

> +
> +#include <linux/string.h>
> +#include <plat/display.h>
> +
> +#define HDMI_WP                        0x0
> +#define HDMI_CORE_SYS          0x400
> +#define HDMI_CORE_AV           0x900
> +#define HDMI_PLLCTRL           0x200
> +#define HDMI_PHY               0x300
> +
> +struct hdmi_reg { u16 idx; };
> +
> +#define HDMI_REG(idx)                  ((const struct hdmi_reg) { idx })
> +
> +/* HDMI Wrapper */
> +#define HDMI_WP_REG(idx)                       HDMI_REG(HDMI_WP + idx)
> +
> +#define HDMI_WP_REVISION                       HDMI_WP_REG(0x0)
> +#define HDMI_WP_SYSCONFIG                      HDMI_WP_REG(0x10)
> +#define HDMI_WP_IRQSTATUS_RAW                  HDMI_WP_REG(0x24)
> +#define HDMI_WP_IRQSTATUS                      HDMI_WP_REG(0x28)
> +#define HDMI_WP_PWR_CTRL                       HDMI_WP_REG(0x40)
> +#define HDMI_WP_IRQENABLE_SET                  HDMI_WP_REG(0x2C)
> +#define HDMI_WP_VIDEO_CFG                      HDMI_WP_REG(0x50)
> +#define HDMI_WP_VIDEO_SIZE                     HDMI_WP_REG(0x60)
> +#define HDMI_WP_VIDEO_TIMING_H                 HDMI_WP_REG(0x68)
> +#define HDMI_WP_VIDEO_TIMING_V                 HDMI_WP_REG(0x6C)
> +#define HDMI_WP_WP_CLK                         HDMI_WP_REG(0x70)
> +
> +/* HDMI IP Core System */
> +#define HDMI_CORE_SYS_REG(idx)                 HDMI_REG(HDMI_CORE_SYS + idx)
> +
> +#define HDMI_CORE_SYS_VND_IDL                  HDMI_CORE_SYS_REG(0x0)
> +#define HDMI_CORE_SYS_DEV_IDL                  HDMI_CORE_SYS_REG(0x8)
> +#define HDMI_CORE_SYS_DEV_IDH                  HDMI_CORE_SYS_REG(0xC)
> +#define HDMI_CORE_SYS_DEV_REV                  HDMI_CORE_SYS_REG(0x10)
> +#define HDMI_CORE_SYS_SRST                     HDMI_CORE_SYS_REG(0x14)
> +#define HDMI_CORE_CTRL1                                HDMI_CORE_SYS_REG(0x20)
> +#define HDMI_CORE_SYS_SYS_STAT                 HDMI_CORE_SYS_REG(0x24)
> +#define HDMI_CORE_SYS_VID_ACEN                 HDMI_CORE_SYS_REG(0x124)
> +#define HDMI_CORE_SYS_VID_MODE                 HDMI_CORE_SYS_REG(0x128)
> +#define HDMI_CORE_SYS_INTR_STATE               HDMI_CORE_SYS_REG(0x1C0)
> +#define HDMI_CORE_SYS_INTR1                    HDMI_CORE_SYS_REG(0x1C4)
> +#define HDMI_CORE_SYS_INTR2                    HDMI_CORE_SYS_REG(0x1C8)
> +#define HDMI_CORE_SYS_INTR3                    HDMI_CORE_SYS_REG(0x1CC)
> +#define HDMI_CORE_SYS_INTR4                    HDMI_CORE_SYS_REG(0x1D0)
> +#define HDMI_CORE_SYS_UMASK1                   HDMI_CORE_SYS_REG(0x1D4)
> +#define HDMI_CORE_SYS_TMDS_CTRL                        HDMI_CORE_SYS_REG(0x208)
> +#define HDMI_CORE_SYS_DE_DLY                   HDMI_CORE_SYS_REG(0xC8)
> +#define HDMI_CORE_SYS_DE_CTRL                  HDMI_CORE_SYS_REG(0xCC)
> +#define HDMI_CORE_SYS_DE_TOP                   HDMI_CORE_SYS_REG(0xD0)
> +#define HDMI_CORE_SYS_DE_CNTL                  HDMI_CORE_SYS_REG(0xD8)
> +#define HDMI_CORE_SYS_DE_CNTH                  HDMI_CORE_SYS_REG(0xDC)
> +#define HDMI_CORE_SYS_DE_LINL                  HDMI_CORE_SYS_REG(0xE0)
> +#define HDMI_CORE_SYS_DE_LINH_1                        HDMI_CORE_SYS_REG(0xE4)
> +#define HDMI_CORE_CTRL1_VEN_FOLLOWVSYNC                0x1
> +#define HDMI_CORE_CTRL1_HEN_FOLLOWHSYNC                0x1
> +#define HDMI_CORE_CTRL1_BSEL_24BITBUS          0x1
> +#define HDMI_CORE_CTRL1_EDGE_RISINGEDGE                0x1
> +
> +/* HDMI DDC E-DID */
> +#define HDMI_CORE_DDC_CMD                      HDMI_CORE_SYS_REG(0x3CC)
> +#define HDMI_CORE_DDC_STATUS                   HDMI_CORE_SYS_REG(0x3C8)
> +#define HDMI_CORE_DDC_ADDR                     HDMI_CORE_SYS_REG(0x3B4)
> +#define HDMI_CORE_DDC_OFFSET                   HDMI_CORE_SYS_REG(0x3BC)
> +#define HDMI_CORE_DDC_COUNT1                   HDMI_CORE_SYS_REG(0x3C0)
> +#define HDMI_CORE_DDC_COUNT2                   HDMI_CORE_SYS_REG(0x3C4)
> +#define HDMI_CORE_DDC_DATA                     HDMI_CORE_SYS_REG(0x3D0)
> +#define HDMI_CORE_DDC_SEGM                     HDMI_CORE_SYS_REG(0x3B8)
> +
> +/* HDMI IP Core Audio Video */
> +#define HDMI_CORE_AV_REG(idx)                  HDMI_REG(HDMI_CORE_AV + idx)
> +
> +#define HDMI_CORE_AV_HDMI_CTRL                 HDMI_CORE_AV_REG(0xBC)
> +#define HDMI_CORE_AV_DPD                       HDMI_CORE_AV_REG(0xF4)
> +#define HDMI_CORE_AV_PB_CTRL1                  HDMI_CORE_AV_REG(0xF8)
> +#define HDMI_CORE_AV_PB_CTRL2                  HDMI_CORE_AV_REG(0xFC)
> +#define HDMI_CORE_AV_AVI_TYPE                  HDMI_CORE_AV_REG(0x100)
> +#define HDMI_CORE_AV_AVI_VERS                  HDMI_CORE_AV_REG(0x104)
> +#define HDMI_CORE_AV_AVI_LEN                   HDMI_CORE_AV_REG(0x108)
> +#define HDMI_CORE_AV_AVI_CHSUM                 HDMI_CORE_AV_REG(0x10C)
> +#define HDMI_CORE_AV_AVI_DBYTE(n)              HDMI_CORE_AV_REG(n * 4 + 0x110)
> +#define HDMI_CORE_AV_AVI_DBYTE_NELEMS          HDMI_CORE_AV_REG(15)
> +#define HDMI_CORE_AV_SPD_DBYTE                 HDMI_CORE_AV_REG(0x190)
> +#define HDMI_CORE_AV_SPD_DBYTE_NELEMS          HDMI_CORE_AV_REG(27)
> +#define HDMI_CORE_AV_MPEG_DBYTE                        HDMI_CORE_AV_REG(0x290)
> +#define HDMI_CORE_AV_MPEG_DBYTE_NELEMS         HDMI_CORE_AV_REG(27)
> +#define HDMI_CORE_AV_GEN_DBYTE                 HDMI_CORE_AV_REG(0x300)
> +#define HDMI_CORE_AV_GEN_DBYTE_NELEMS          HDMI_CORE_AV_REG(31)
> +#define HDMI_CORE_AV_GEN2_DBYTE                        HDMI_CORE_AV_REG(0x380)
> +#define HDMI_CORE_AV_GEN2_DBYTE_NELEMS         HDMI_CORE_AV_REG(31)
> +#define HDMI_CORE_AV_ACR_CTRL                  HDMI_CORE_AV_REG(0x4)
> +#define HDMI_CORE_AV_FREQ_SVAL                 HDMI_CORE_AV_REG(0x8)
> +#define HDMI_CORE_AV_N_SVAL1                   HDMI_CORE_AV_REG(0xC)
> +#define HDMI_CORE_AV_N_SVAL2                   HDMI_CORE_AV_REG(0x10)
> +#define HDMI_CORE_AV_N_SVAL3                   HDMI_CORE_AV_REG(0x14)
> +#define HDMI_CORE_AV_CTS_SVAL1                 HDMI_CORE_AV_REG(0x18)
> +#define HDMI_CORE_AV_CTS_SVAL2                 HDMI_CORE_AV_REG(0x1C)
> +#define HDMI_CORE_AV_CTS_SVAL3                 HDMI_CORE_AV_REG(0x20)
> +#define HDMI_CORE_AV_CTS_HVAL1                 HDMI_CORE_AV_REG(0x24)
> +#define HDMI_CORE_AV_CTS_HVAL2                 HDMI_CORE_AV_REG(0x28)
> +#define HDMI_CORE_AV_CTS_HVAL3                 HDMI_CORE_AV_REG(0x2C)
> +#define HDMI_CORE_AV_AUD_MODE                  HDMI_CORE_AV_REG(0x50)
> +#define HDMI_CORE_AV_SPDIF_CTRL                        HDMI_CORE_AV_REG(0x54)
> +#define HDMI_CORE_AV_HW_SPDIF_FS               HDMI_CORE_AV_REG(0x60)
> +#define HDMI_CORE_AV_SWAP_I2S                  HDMI_CORE_AV_REG(0x64)
> +#define HDMI_CORE_AV_SPDIF_ERTH                        HDMI_CORE_AV_REG(0x6C)
> +#define HDMI_CORE_AV_I2S_IN_MAP                        HDMI_CORE_AV_REG(0x70)
> +#define HDMI_CORE_AV_I2S_IN_CTRL               HDMI_CORE_AV_REG(0x74)
> +#define HDMI_CORE_AV_I2S_CHST0                 HDMI_CORE_AV_REG(0x78)
> +#define HDMI_CORE_AV_I2S_CHST1                 HDMI_CORE_AV_REG(0x7C)
> +#define HDMI_CORE_AV_I2S_CHST2                 HDMI_CORE_AV_REG(0x80)
> +#define HDMI_CORE_AV_I2S_CHST4                 HDMI_CORE_AV_REG(0x84)
> +#define HDMI_CORE_AV_I2S_CHST5                 HDMI_CORE_AV_REG(0x88)
> +#define HDMI_CORE_AV_ASRC                      HDMI_CORE_AV_REG(0x8C)
> +#define HDMI_CORE_AV_I2S_IN_LEN                        HDMI_CORE_AV_REG(0x90)
> +#define HDMI_CORE_AV_HDMI_CTRL                 HDMI_CORE_AV_REG(0xBC)
> +#define HDMI_CORE_AV_AUDO_TXSTAT               HDMI_CORE_AV_REG(0xC0)
> +#define HDMI_CORE_AV_AUD_PAR_BUSCLK_1          HDMI_CORE_AV_REG(0xCC)
> +#define HDMI_CORE_AV_AUD_PAR_BUSCLK_2          HDMI_CORE_AV_REG(0xD0)
> +#define HDMI_CORE_AV_AUD_PAR_BUSCLK_3          HDMI_CORE_AV_REG(0xD4)
> +#define HDMI_CORE_AV_TEST_TXCTRL               HDMI_CORE_AV_REG(0xF0)
> +#define HDMI_CORE_AV_DPD                       HDMI_CORE_AV_REG(0xF4)
> +#define HDMI_CORE_AV_PB_CTRL1                  HDMI_CORE_AV_REG(0xF8)
> +#define HDMI_CORE_AV_PB_CTRL2                  HDMI_CORE_AV_REG(0xFC)
> +#define HDMI_CORE_AV_AVI_TYPE                  HDMI_CORE_AV_REG(0x100)
> +#define HDMI_CORE_AV_AVI_VERS                  HDMI_CORE_AV_REG(0x104)
> +#define HDMI_CORE_AV_AVI_LEN                   HDMI_CORE_AV_REG(0x108)
> +#define HDMI_CORE_AV_AVI_CHSUM                 HDMI_CORE_AV_REG(0x10C)
> +#define HDMI_CORE_AV_SPD_TYPE                  HDMI_CORE_AV_REG(0x180)
> +#define HDMI_CORE_AV_SPD_VERS                  HDMI_CORE_AV_REG(0x184)
> +#define HDMI_CORE_AV_SPD_LEN                   HDMI_CORE_AV_REG(0x188)
> +#define HDMI_CORE_AV_SPD_CHSUM                 HDMI_CORE_AV_REG(0x18C)
> +#define HDMI_CORE_AV_MPEG_TYPE                 HDMI_CORE_AV_REG(0x280)
> +#define HDMI_CORE_AV_MPEG_VERS                 HDMI_CORE_AV_REG(0x284)
> +#define HDMI_CORE_AV_MPEG_LEN                  HDMI_CORE_AV_REG(0x288)
> +#define HDMI_CORE_AV_MPEG_CHSUM                        HDMI_CORE_AV_REG(0x28C)
> +#define HDMI_CORE_AV_CP_BYTE1                  HDMI_CORE_AV_REG(0x37C)
> +#define HDMI_CORE_AV_CEC_ADDR_ID               HDMI_CORE_AV_REG(0x3FC)
> +#define HDMI_CORE_AV_SPD_DBYTE_ELSIZE          0x4
> +#define HDMI_CORE_AV_GEN2_DBYTE_ELSIZE         0x4
> +#define HDMI_CORE_AV_MPEG_DBYTE_ELSIZE         0x4
> +#define HDMI_CORE_AV_GEN_DBYTE_ELSIZE          0x4
> +
> +/* PLL */
> +#define HDMI_PLL_REG(idx)                      HDMI_REG(HDMI_PLLCTRL + idx)
> +
> +#define PLLCTRL_PLL_CONTROL                    HDMI_PLL_REG(0x0)
> +#define PLLCTRL_PLL_STATUS                     HDMI_PLL_REG(0x4)
> +#define PLLCTRL_PLL_GO                         HDMI_PLL_REG(0x8)
> +#define PLLCTRL_CFG1                           HDMI_PLL_REG(0xC)
> +#define PLLCTRL_CFG2                           HDMI_PLL_REG(0x10)
> +#define PLLCTRL_CFG3                           HDMI_PLL_REG(0x14)
> +#define PLLCTRL_CFG4                           HDMI_PLL_REG(0x20)
> +
> +/* HDMI PHY */
> +#define HDMI_PHY_REG(idx)                      HDMI_REG(HDMI_PHY + idx)
> +
> +#define HDMI_TXPHY_TX_CTRL                     HDMI_PHY_REG(0x0)
> +#define HDMI_TXPHY_DIGITAL_CTRL                        HDMI_PHY_REG(0x4)
> +#define HDMI_TXPHY_POWER_CTRL                  HDMI_PHY_REG(0x8)
> +#define HDMI_TXPHY_PAD_CFG_CTRL                        HDMI_PHY_REG(0xC)
> +
> +/* HDMI EDID Length  */
> +#define HDMI_EDID_MAX_LENGTH                           256
> +#define EDID_TIMING_DESCRIPTOR_SIZE                    0x12
> +#define EDID_DESCRIPTOR_BLOCK0_ADDRESS                 0x36
> +#define EDID_DESCRIPTOR_BLOCK1_ADDRESS                 0x80
> +#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR             4
> +#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR             4
> +
> +#define OMAP_HDMI_TIMINGS_NB                           34
> +
> +#define REG_FLD_MOD(idx, val, start, end) \
> +       hdmi_write_reg(idx, FLD_MOD(hdmi_read_reg(idx), val, start, end))
> +
> +u8             edid[HDMI_EDID_MAX_LENGTH] = {0};
> +u8             edid_set;
> +u8             header[8] = {0x0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0};
> +struct         omap_video_timings edid_timings;

Global variables in a header file? This cannot be right.

> +
> +/* HDMI timing structure */
> +struct hdmi_timings {
> +       struct omap_video_timings timings;
> +       int vsync_pol;
> +       int hsync_pol;
> +};
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

And even more global tables...

> +
> +enum hdmi_phypwr {
> +       HDMI_PHYPWRCMD_OFF = 0,
> +       HDMI_PHYPWRCMD_LDOON = 1,
> +       HDMI_PHYPWRCMD_TXON = 2
> +};
> +
> +enum hdmi_pll_pwr {
> +       HDMI_PLLPWRCMD_ALLOFF = 0,
> +       HDMI_PLLPWRCMD_PLLONLY = 1,
> +       HDMI_PLLPWRCMD_BOTHON_ALLCLKS = 2,
> +       HDMI_PLLPWRCMD_BOTHON_NOPHYCLK = 3
> +};
> +
> +enum hdmi_core_inputbus_width {
> +       HDMI_INPUT_8BIT = 0,
> +       HDMI_INPUT_10BIT = 1,
> +       HDMI_INPUT_12BIT = 2
> +};
> +
> +enum hdmi_core_dither_trunc {
> +       HDMI_OUTPUTTRUNCATION_8BIT = 0,
> +       HDMI_OUTPUTTRUNCATION_10BIT = 1,
> +       HDMI_OUTPUTTRUNCATION_12BIT = 2,
> +       HDMI_OUTPUTDITHER_8BIT = 3,
> +       HDMI_OUTPUTDITHER_10BIT = 4,
> +       HDMI_OUTPUTDITHER_12BIT = 5
> +};
> +
> +enum hdmi_core_deepcolor_ed {
> +       HDMI_DEEPCOLORPACKECTDISABLE = 0,
> +       HDMI_DEEPCOLORPACKECTENABLE = 1
> +};
> +
> +enum hdmi_core_packet_mode {
> +       HDMI_PACKETMODERESERVEDVALUE = 0,
> +       HDMI_PACKETMODE24BITPERPIXEL = 4,
> +       HDMI_PACKETMODE30BITPERPIXEL = 5,
> +       HDMI_PACKETMODE36BITPERPIXEL = 6,
> +       HDMI_PACKETMODE48BITPERPIXEL = 7
> +};
> +
> +enum hdmi_core_hdmi_dvi {
> +       HDMI_DVI = 0,
> +       HDMI_HDMI = 1
> +};
> +
> +enum hdmi_core_tclkselclkmult {
> +       FPLL05IDCK = 0,
> +       FPLL10IDCK = 1,
> +       FPLL20IDCK = 2,
> +       FPLL40IDCK = 3
> +};
> +
> +enum hdmi_core_fs {
> +       FS_32000 = 0,
> +       FS_44100 = 1
> +};
> +
> +enum hdmi_core_layout {
> +       LAYOUT_2CH = 0,
> +       LAYOUT_8CH = 1
> +};
> +
> +enum hdmi_core_cts_mode {
> +       CTS_MODE_HW = 0,
> +       CTS_MODE_SW = 1
> +};

Enums in C are not inside any namespace. That's why enums need to have
some kind of prefix, just like defines.

 Tomi


