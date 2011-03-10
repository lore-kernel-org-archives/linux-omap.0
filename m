From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 5/9] OMAP4 : DSS2 : HDMI: HDMI driver addition in the DSS
Date: Thu, 10 Mar 2011 10:52:43 +0530
Message-ID: <AANLkTin69+GHWfG6QHo65G_cpa9Odg3SDf4tgxgdXMyE@mail.gmail.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	<1299671118-20839-2-git-send-email-mythripk@ti.com>
	<1299671118-20839-3-git-send-email-mythripk@ti.com>
	<1299671118-20839-4-git-send-email-mythripk@ti.com>
	<1299671118-20839-5-git-send-email-mythripk@ti.com>
	<1299671118-20839-6-git-send-email-mythripk@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C1922B3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58280 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819Ab1CJFWp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 00:22:45 -0500
Received: by mail-vw0-f42.google.com with SMTP id 10so2334842vws.1
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 21:22:44 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C1922B3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Sanjeev,

On Wed, Mar 9, 2011 at 9:20 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of K, Mythri P
>> Sent: Wednesday, March 09, 2011 5:15 PM
>> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
>> Cc: K, Mythri P
>> Subject: [PATCH v4 5/9] OMAP4 : DSS2 : HDMI: HDMI driver addition in=
 the
>> DSS
>>
>> Adding the hdmi interface driver(hdmi.c) to the dss driver.
>> It configures the audio and video portion of HDMI based on
>> functionality called by the =A0panel driver.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Yong Zhi <y-zhi@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/Kconfig =A0 | =A0 =A08 +
>> =A0drivers/video/omap2/dss/Makefile =A0| =A0 =A01 +
>> =A0drivers/video/omap2/dss/display.c | =A0 =A03 +
>> =A0drivers/video/omap2/dss/dss.h =A0 =A0 | =A0 43 ++
>> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0| 1315
>> +++++++++++++++++++++++++++++++++++++
>> =A05 files changed, 1370 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/video/omap2/dss/hdmi.c
>>
>> diff --git a/drivers/video/omap2/dss/Kconfig
>> b/drivers/video/omap2/dss/Kconfig
>> index db01473..7749ddb 100644
>> --- a/drivers/video/omap2/dss/Kconfig
>> +++ b/drivers/video/omap2/dss/Kconfig
>> @@ -60,6 +60,14 @@ config OMAP2_DSS_VENC
>> =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 OMAP Video Encoder support for S-Video and composite=
 TV-out.
>>
>> +config OMAP2_DSS_HDMI
>> + =A0 =A0 bool "HDMI support"
>> + =A0 =A0 depends on ARCH_OMAP4
>> + =A0 =A0 =A0 =A0default y
>> + =A0 =A0 help
>> + =A0 =A0 =A0 HDMI Interface. This adds the High Definition Multimed=
ia
>> Interface.
>> + =A0 =A0 =A0 See http://www.hdmi.org/ for HDMI specification.
>> +
> [sp] This may have been discussed earlier... but if the interface is
> =A0 =A0 supported only on OMAP4, wouldn't it be better to rename
> =A0 =A0 OMAP2_DSS_HDMI as OMAP4_DSS_HDMI?
> =A0 =A0 Or, the implementation can be used by OMAP3 as well. If so, y=
ou
> =A0 =A0 may want to update the depends.
I shall change it to OMAP4.
>
>> =A0config OMAP2_DSS_SDI
>> =A0 =A0 =A0 bool "SDI support"
>> =A0 =A0 =A0 depends on ARCH_OMAP3
>> diff --git a/drivers/video/omap2/dss/Makefile
>> b/drivers/video/omap2/dss/Makefile
>> index 7db17b5..5998b69 100644
>> --- a/drivers/video/omap2/dss/Makefile
>> +++ b/drivers/video/omap2/dss/Makefile
>> @@ -5,3 +5,4 @@ omapdss-$(CONFIG_OMAP2_DSS_RFBI) +=3D rfbi.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_VENC) +=3D venc.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_SDI) +=3D sdi.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_DSI) +=3D dsi.o
>> +omapdss-$(CONFIG_OMAP2_DSS_HDMI) +=3D hdmi.o
>> diff --git a/drivers/video/omap2/dss/display.c
>> b/drivers/video/omap2/dss/display.c
>> index c40bcbd..a85a6f3 100644
>> --- a/drivers/video/omap2/dss/display.c
>> +++ b/drivers/video/omap2/dss/display.c
>> @@ -418,6 +418,9 @@ void dss_init_device(struct platform_device *pde=
v,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D dsi_init_display(dssdev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0#endif
>> + =A0 =A0 case OMAP_DISPLAY_TYPE_HDMI:
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_init_display(dssdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Support for display '%s' not com=
piled in.\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dssdev->=
name);
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss=
/dss.h
>> index 008cbf4..3eb2661 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -174,6 +174,16 @@ struct dsi_clock_info {
>> =A0 =A0 =A0 bool use_sys_clk;
>> =A0};
>>
>> +/* HDMI PLL structure */
>> +struct hdmi_pll_info {
>> + =A0 =A0 u16 regn;
>> + =A0 =A0 u16 regm;
>> + =A0 =A0 u32 regmf;
>> + =A0 =A0 u16 regm2;
>> + =A0 =A0 u16 regsd;
>> + =A0 =A0 u16 dcofreq;
>> +};
>> +
>> =A0struct seq_file;
>> =A0struct platform_device;
>>
>> @@ -437,6 +447,39 @@ static inline void venc_uninit_platform_driver(=
void)
>> =A0}
>> =A0#endif
>>
>> +/* HDMI */
>> +#ifdef CONFIG_OMAP2_DSS_HDMI
>> +int hdmi_init_platform_driver(void);
>> +void hdmi_uninit_platform_driver(void);
>> +int hdmi_init_display(struct omap_dss_device *dssdev);
>> +#else
>> +static inline int hdmi_init_display(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +static inline int hdmi_init_platform_driver(void)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +static inline void hdmi_uninit_platform_driver(void)
>> +{
>> +}
>> +#endif
>> +int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev);
>> +void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
>> +#ifdef CONFIG_OMAP4_PANEL_HDMI
>> +int hdmi_panel_init(void);
>> +void hdmi_panel_exit(void);
>> +#else
>> +static inline int hdmi_panel_init(void)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +static inline void hdmi_panel_exit(void)
>> +{
>> +}
>> +#endif
>> +
>> =A0/* RFBI */
>> =A0#ifdef CONFIG_OMAP2_DSS_RFBI
>> =A0int rfbi_init_platform_driver(void);
>> diff --git a/drivers/video/omap2/dss/hdmi.c
>> b/drivers/video/omap2/dss/hdmi.c
>> new file mode 100644
>> index 0000000..6852843
>> --- /dev/null
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -0,0 +1,1315 @@
>> +/*
>> + * hdmi.c
>> + *
>> + * HDMI interface DSS driver setting for TI's OMAP4 family of proce=
ssor.
>> + * Copyright (C) 2010-2011 Texas Instruments Incorporated -
>> http://www.ti.com/
>> + * Authors: Yong Zhi
>> + * =A0 Mythri pk <mythripk@ti.com>
>> + *
>> + *
>
> [sp] Extra blank lines here
>
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> it
>> + * under the terms of the GNU General Public License version 2 as
>> published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License
>> for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#define DSS_SUBSYS_NAME "HDMI"
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mutex.h>
>> +#include <linux/delay.h>
>> +#include <linux/string.h>
>> +#include <plat/display.h>
>> +
>> +#include "dss.h"
>> +#include "hdmi.h"
>> +
>> +static struct {
>> + =A0 =A0 struct mutex lock;
>> + =A0 =A0 struct omap_display_platform_data *pdata;
>> + =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 void __iomem *base_wp; =A0/* HDMI wrapper */
>> + =A0 =A0 int code;
>> + =A0 =A0 int mode;
>> + =A0 =A0 u8 edid[HDMI_EDID_MAX_LENGTH];
>> + =A0 =A0 u8 edid_set;
>> + =A0 =A0 struct hdmi_config cfg;
>> +} hdmi;
>> +
>> +/*
>> + * Logic for the below structure
>> + * user enters the CEA or VESA timings by specifying
>> + * the hdmicode which corresponds to CEA/VESA timings
>> + * please refer to section 6.3 in HDMI 1.3 specification for timing=
 code.
>> + * There is a correspondence between CEA/VESA timing and code.
>> + * In the below structure, cea_vesa_timings corresponds to all
>> + * The OMAP4 supported timing =A0CEA and VESA timing values.
>> + * code_cea corresponds to the CEA code entered by the user,
>> + * The use of it is to get the timing from the cea_vesa_timing arra=
y.
>> + * Similarly for code_vesa.
>> + * code_index is backmapping, Once EDID is read from the TV
>> + * EDID is parsed to find the timing values to map it back to the
>> + * corresponding CEA or VESA index this structure is used.
>> + */
>
> [sp] Is the comment intentionally formatted as it is?
> =A0 =A0 There seems to be an opportunity to improve the text and
> =A0 =A0 readability here.
>
I shall try to indent.
>> +
>> +/*
>> + * This is the structure which has all supported timing
>> + * values that OMAP4 supports
>> + */
>
> [sp] Seems to be repeat of the comment just above.
>
>> +static const struct hdmi_timings cea_vesa_timings[OMAP_HDMI_TIMINGS=
_NB] =3D
>> {
>> + =A0 =A0 { {640, 480, 25200, 96, 16, 48, 2, 10, 33} , 0 , 0},
>> + =A0 =A0 { {1280, 720, 74250, 40, 440, 220, 5, 5, 20}, 1, 1},
>> + =A0 =A0 { {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1},
>> + =A0 =A0 { {720, 480, 27027, 62, 16, 60, 6, 9, 30}, 0, 0},
>> + =A0 =A0 { {2880, 576, 108000, 256, 48, 272, 5, 5, 39}, 0, 0},
>> + =A0 =A0 { {1440, 240, 27027, 124, 38, 114, 3, 4, 15}, 0, 0},
>> + =A0 =A0 { {1440, 288, 27000, 126, 24, 138, 3, 2, 19}, 0, 0},
>> + =A0 =A0 { {1920, 540, 74250, 44, 528, 148, 5, 2, 15}, 1, 1},
>> + =A0 =A0 { {1920, 540, 74250, 44, 88, 148, 5, 2, 15}, 1, 1},
>> + =A0 =A0 { {1920, 1080, 148500, 44, 88, 148, 5, 4, 36}, 1, 1},
>> + =A0 =A0 { {720, 576, 27000, 64, 12, 68, 5, 5, 39}, 0, 0},
>> + =A0 =A0 { {1440, 576, 54000, 128, 24, 136, 5, 5, 39}, 0, 0},
>> + =A0 =A0 { {1920, 1080, 148500, 44, 528, 148, 5, 4, 36}, 1, 1},
>> + =A0 =A0 { {2880, 480, 108108, 248, 64, 240, 6, 9, 30}, 0, 0},
>> + =A0 =A0 { {1920, 1080, 74250, 44, 638, 148, 5, 4, 36}, 1, 1},
>> + =A0 =A0 /* VESA From Here */
>> + =A0 =A0 { {640, 480, 25175, 96, 16, 48, 2 , 11, 31}, 0, 0},
>> + =A0 =A0 { {800, 600, 40000, 128, 40, 88, 4 , 1, 23}, 1, 1},
>> + =A0 =A0 { {848, 480, 33750, 112, 16, 112, 8 , 6, 23}, 1, 1},
>> + =A0 =A0 { {1280, 768, 79500, 128, 64, 192, 7 , 3, 20}, 1, 0},
>> + =A0 =A0 { {1280, 800, 83500, 128, 72, 200, 6 , 3, 22}, 1, 0},
>> + =A0 =A0 { {1360, 768, 85500, 112, 64, 256, 6 , 3, 18}, 1, 1},
>> + =A0 =A0 { {1280, 960, 108000, 112, 96, 312, 3 , 1, 36}, 1, 1},
>> + =A0 =A0 { {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38}, 1, 1},
>> + =A0 =A0 { {1024, 768, 65000, 136, 24, 160, 6, 3, 29}, 0, 0},
>> + =A0 =A0 { {1400, 1050, 121750, 144, 88, 232, 4, 3, 32}, 1, 0},
>> + =A0 =A0 { {1440, 900, 106500, 152, 80, 232, 6, 3, 25}, 1, 0},
>> + =A0 =A0 { {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30}, 1, 0},
>> + =A0 =A0 { {1366, 768, 85500, 143, 70, 213, 3, 3, 24}, 1, 1},
>> + =A0 =A0 { {1920, 1080, 148500, 44, 148, 80, 5, 4, 36}, 1, 1},
>> + =A0 =A0 { {1280, 768, 68250, 32, 48, 80, 7, 3, 12}, 0, 1},
>> + =A0 =A0 { {1400, 1050, 101000, 32, 48, 80, 4, 3, 23}, 0, 1},
>> + =A0 =A0 { {1680, 1050, 119000, 32, 48, 80, 6, 3, 21}, 0, 1},
>> + =A0 =A0 { {1280, 800, 79500, 32, 48, 80, 6, 3, 14}, 0, 1},
>> + =A0 =A0 { {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1}
>> +};
>> +
>> +/*
>> + * This is a static mapping array which maps the timing values
>> + * with corresponding CEA / VESA code
>> + */
>> +static const int code_index[OMAP_HDMI_TIMINGS_NB] =3D {
>> + =A0 =A0 1, 19, 4, 2, 37, 6, 21, 20, 5, 16, 17, 29, 31, 35, 32,
>> + =A0 =A0 /* <--15 CEA 17--> vesa*/
>> + =A0 =A0 4, 9, 0xE, 0x17, 0x1C, 0x27, 0x20, 0x23, 0x10, 0x2A,
>> + =A0 =A0 0X2F, 0x3A, 0X51, 0X52, 0x16, 0x29, 0x39, 0x1B
>> +};
>> +
>> +/*
>> + * This is reverse static mapping which maps the CEA / VESA code
>> + * to the corresponding timing values
>> + */
>> +static const int code_cea[39] =3D {
>> + =A0 =A0 -1, =A00, =A03, =A03, =A02, =A08, =A05, =A05, -1, -1,
>> + =A0 =A0 -1, -1, -1, -1, -1, -1, =A09, 10, 10, =A01,
>> + =A0 =A0 7, =A0 6, =A06, -1, -1, -1, -1, -1, -1, 11,
>> + =A0 =A0 11, 12, 14, -1, -1, 13, 13, =A04, =A04
>> +};
>> +
>> +static const int code_vesa[85] =3D {
>> + =A0 =A0 -1, -1, -1, -1, 15, -1, -1, -1, -1, 16,
>> + =A0 =A0 -1, -1, -1, -1, 17, -1, 23, -1, -1, -1,
>> + =A0 =A0 -1, -1, 29, 18, -1, -1, -1, 32, 19, -1,
>> + =A0 =A0 -1, -1, 21, -1, -1, 22, -1, -1, -1, 20,
>> + =A0 =A0 -1, 30, 24, -1, -1, -1, -1, 25, -1, -1,
>> + =A0 =A0 -1, -1, -1, -1, -1, -1, -1, 31, 26, -1,
>> + =A0 =A0 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
>> + =A0 =A0 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
>> + =A0 =A0 -1, 27, 28, -1, 33};
>> +
>> +static const u8 edid_header[8] =3D {0x0, 0xff, 0xff, 0xff, 0xff, 0x=
ff,
>> 0xff, 0x0};
>> +
>> +static inline void hdmi_write_reg(const struct hdmi_reg idx, u32 va=
l)
>> +{
>> + =A0 =A0 __raw_writel(val, hdmi.base_wp + idx.idx);
>> +}
>> +
>> +static inline u32 hdmi_read_reg(const struct hdmi_reg idx)
>> +{
>> + =A0 =A0 return __raw_readl(hdmi.base_wp + idx.idx);
>> +}
>
> [sp] Suggestion - reg.idx reads better than idx.idx esp since the arg=
ument
> =A0 =A0 type is "struct hdmi_reg".\
I have named it similar to other DSS register read functions.
>
>> +
>> +static inline int hdmi_wait_for_bit_change(const struct hdmi_reg id=
x,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int b2, in=
t b1, u32 val)
>> +{
>> + =A0 =A0 u32 t =3D 0;
>> + =A0 =A0 while (val !=3D REG_GET(idx, b2, b1)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (t++ > 10000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !val;
>
> [sp] Just wanted to confirm that "!val" is really safe to return from=
 here.
yes , again similar to other DSS function.
>
>> + =A0 =A0 }
>> + =A0 =A0 return val;
>> +}
>> +
>> +int hdmi_init_display(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 DSSDBG("init_display\n");
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int hdmi_pll_init(enum hdmi_clk_refsel refsel, int dcofreq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_pll_info *fmt, u16 sd)
>> +{
>> + =A0 =A0 u32 r;
>> +
>> + =A0 =A0 /* PLL start always use manual mode */
>> + =A0 =A0 REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
>> +
>> + =A0 =A0 r =3D hdmi_read_reg(PLLCTRL_CFG1);
>> + =A0 =A0 r =3D FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM */
>> + =A0 =A0 r =3D FLD_MOD(r, fmt->regn, 8, 1); =A0/* CFG1_PLL_REGN */
>> +
>> + =A0 =A0 hdmi_write_reg(PLLCTRL_CFG1, r);
>> +
>> + =A0 =A0 r =3D hdmi_read_reg(PLLCTRL_CFG2);
>> +
>> + =A0 =A0 r =3D FLD_MOD(r, 0x0, 12, 12); /* PLL_HIGHFREQ divide by 2=
 */
>> + =A0 =A0 r =3D FLD_MOD(r, 0x1, 13, 13); /* PLL_REFEN */
>> + =A0 =A0 r =3D FLD_MOD(r, 0x0, 14, 14); /* PHY_CLKINEN de-assert du=
ring locking
>> */
>> +
>> + =A0 =A0 if (dcofreq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* divider programming for frequency beyon=
d 1000Mhz */
>> + =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(PLLCTRL_CFG3, sd, 17, 10);
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, 0x4, 3, 1); /* 1000MHz an=
d 2000MHz */
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, 0x2, 3, 1); /* 500MHz and=
 1000MHz */
>> + =A0 =A0 }
>> +
>> + =A0 =A0 hdmi_write_reg(PLLCTRL_CFG2, r);
>> +
>> + =A0 =A0 r =3D hdmi_read_reg(PLLCTRL_CFG4);
>> + =A0 =A0 r =3D FLD_MOD(r, fmt->regm2, 24, 18);
>> + =A0 =A0 r =3D FLD_MOD(r, fmt->regmf, 17, 0);
>> +
>> + =A0 =A0 hdmi_write_reg(PLLCTRL_CFG4, r);
>> +
>> + =A0 =A0 /* go now */
>> + =A0 =A0 REG_FLD_MOD(PLLCTRL_PLL_GO, 0x1, 0, 0);
>> +
>> + =A0 =A0 /* wait for bit change */
>> + =A0 =A0 if (hdmi_wait_for_bit_change(PLLCTRL_PLL_GO, 0, 0, 1) !=3D=
 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("PLL GO bit not set\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Wait till the lock bit is set in PLL status */
>> + =A0 =A0 if (hdmi_wait_for_bit_change(PLLCTRL_PLL_STATUS, 1, 1, 1) =
!=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("cannot lock PLL\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("CFG1 0x%x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi_read_reg(PLLCTRL_CFG1=
));
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("CFG2 0x%x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi_read_reg(PLLCTRL_CFG2=
));
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("CFG4 0x%x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi_read_reg(PLLCTRL_CFG4=
));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 DSSDBG("PLL locked!\n");
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/* PHY_PWR_CMD */
>> +static int hdmi_set_phy_pwr(enum hdmi_phy_pwr val)
>> +{
>> + =A0 =A0 /* Command for power control of HDMI PHY */
>> + =A0 =A0 REG_FLD_MOD(HDMI_WP_PWR_CTRL, val, 7, 6);
>> +
>> + =A0 =A0 /* Status of the power control of HDMI PHY */
>> + =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_WP_PWR_CTRL, 5, 4, val) =
!=3D val) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to set PHY power mode to %d=
\n", val);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> [sp] Is -ENODEV appropriate. Going by error message, function seems t=
o be
> =A0 =A0 setting the power mode?

yes , but as we are waiting on device to set the status, probably i
can set a TIMEDOUT.

>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/* PLL_PWR_CMD */
>> +static int hdmi_set_pll_pwr(enum hdmi_pll_pwr val)
>> +{
>> + =A0 =A0 /* Command for power control of HDMI PLL */
>> + =A0 =A0 REG_FLD_MOD(HDMI_WP_PWR_CTRL, val, 3, 2);
>> +
>> + =A0 =A0 /* wait till PHY_PWR_STATUS is set */
>> + =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_WP_PWR_CTRL, 1, 0, val) =
!=3D val) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to set PHY_PWR_STATUS\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> [sp] same comment here.
>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int hdmi_pll_reset(void)
>> +{
>> + =A0 =A0 /* SYSRESET =A0controlled by power FSM */
>> + =A0 =A0 REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 3, 3);
>> +
>> + =A0 =A0 /* READ 0x0 reset is in progress */
>> + =A0 =A0 if (hdmi_wait_for_bit_change(PLLCTRL_PLL_STATUS, 0, 0, 1) =
!=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to sysreset PLL\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int hdmi_phy_init(void)
>> +{
>> + =A0 =A0 u16 r =3D 0;
>> +
>> + =A0 =A0 r =3D hdmi_set_phy_pwr(HDMI_PHYPWRCMD_LDOON);
>> + =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> +
>> + =A0 =A0 r =3D hdmi_set_phy_pwr(HDMI_PHYPWRCMD_TXON);
>> + =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return r;
>
> [sp] When we return from here, HDMI_PHYPWRCMD_LDOON was
> =A0 =A0 successful. Is it okay to leave the state as is?
yes
>
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Read address 0 in order to get the SCP reset done com=
pleted
>> + =A0 =A0 =A0* Dummy access performed to make sure reset is done
>> + =A0 =A0 =A0*/
>> + =A0 =A0 hdmi_read_reg(HDMI_TXPHY_TX_CTRL);
>
> [sp] Is this known behavior/feature - or a workaround?
It is a known behavior.
>
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Write to phy address 0 to configure the clock
>> + =A0 =A0 =A0* use HFBITCLK write HDMI_TXPHY_TX_CONTROL_FREQOUT fiel=
d
>> + =A0 =A0 =A0*/
>> + =A0 =A0 REG_FLD_MOD(HDMI_TXPHY_TX_CTRL, 0x1, 31, 30);
>> +
>> + =A0 =A0 /* Write to phy address 1 to start HDMI line (TXVALID and =
TMDSCLKEN)
>> */
>> + =A0 =A0 hdmi_write_reg(HDMI_TXPHY_DIGITAL_CTRL, 0xF0000000);
>
> [sp] Can REG_FLD_MOD be used here as well? - comment suggests only
> =A0 =A0 2 fields being updated.
It is used to configure TXVALID and TMDSCLKEN .2 other bits to say use
the configured value.
>
>> +
>> + =A0 =A0 /* Setup max LDO voltage */
>> + =A0 =A0 REG_FLD_MOD(HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
>> +
>> + =A0 =A0 /* Write to phy address 3 to change the polarity control *=
/
>> + =A0 =A0 REG_FLD_MOD(HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int hdmi_wait_softreset(void)
>> +{
>> + =A0 =A0 /* reset W1 */
>> + =A0 =A0 REG_FLD_MOD(HDMI_WP_SYSCONFIG, 0x1, 0, 0);
>> +
>> + =A0 =A0 /* wait till SOFTRESET =3D=3D 0 */
>> + =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_WP_SYSCONFIG, 0, 0, 0) !=
=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("sysconfig reset failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> [sp] Is -ENODEV appropriate?
Will replace with TIMEDOUT.
>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int hdmi_pll_program(struct hdmi_pll_info *fmt)
>> +{
>> + =A0 =A0 u16 r =3D 0;
>> + =A0 =A0 enum hdmi_clk_refsel refsel;
>> +
>> + =A0 =A0 /* wait for wrapper reset */
>> + =A0 =A0 hdmi_wait_softreset();
>
> [sp] Return value isn;t being checked here. If -ENODEV was returned,
> =A0 =A0 is it safe to move ahead?
>
>> +
>> + =A0 =A0 r =3D hdmi_set_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
>> + =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> +
>> + =A0 =A0 r =3D hdmi_set_pll_pwr(HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
>> + =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> +
>> + =A0 =A0 hdmi_pll_reset();
>
> [sp] Return value is again ignored here. This function can return
> =A0 =A0 -ETIMEDOUT. Is it okay to ignore it?
>
>> +
>> + =A0 =A0 refsel =3D HDMI_REFSEL_SYSCLK;
>> +
>> + =A0 =A0 r =3D hdmi_pll_init(refsel, fmt->dcofreq, fmt, fmt->regsd)=
;
>> + =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return r;
>
> [sp] When we return from this error location, much of clock and
> =A0 =A0 power config seems to have been done. Can we leave them in
> =A0 =A0 same state?
yes , because on error we would anyway be cutting clocks , and that
would be over written while configuring next.
>
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void hdmi_phy_off(void)
>> +{
>> + =A0 =A0 hdmi_set_phy_pwr(HDMI_PHYPWRCMD_OFF);
>> +}
>> +
>> +static int hdmi_core_ddc_edid(u8 *pEDID, int ext)
>
> [sp] Variable pEDID seems bit different. Suggest using lowercase for =
it.
>
>> +{
>> + =A0 =A0 u32 i, j;
>> + =A0 =A0 char checksum =3D 0;
>> + =A0 =A0 u32 offset =3D 0;
>> +
>> + =A0 =A0 /* Turn on CLK for DDC */
>> + =A0 =A0 REG_FLD_MOD(HDMI_CORE_AV_DPD, 0x7, 2, 0);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* SW HACK : Without the Delay DDC(i2c bus) reads 0 valu=
es /
>> + =A0 =A0 =A0* right shifted values( The behavior is not consistent =
and seen
>> only
>> + =A0 =A0 =A0* with some TV's)
>> + =A0 =A0 =A0*/
>> + =A0 =A0 usleep_range(800, 1000);
>> +
>> + =A0 =A0 if (!ext) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Clk SCL Devices */
>> + =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0xA, 3, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI_CORE_DDC_STATUS_IN_PROG No timer n=
eeded */
>
> [sp] What is significance of "No timer needed"?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_CORE_DDC=
_STATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 4, 4, 0) !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to program =
DDC\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Clear FIFO */
>> + =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI_CORE_DDC_STATUS_IN_PROG */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_CORE_DDC=
_STATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 4, 4, 0) !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to program =
DDC\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ext % 2 !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D 0x80;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Load Segment Address Register */
>> + =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_SEGM, ext/2, 7, 0);
>> +
>> + =A0 =A0 /* Load Slave Address Register */
>> + =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_ADDR, 0xA0 >> 1, 7, 1);
>> +
>> + =A0 =A0 /* Load Offset Address Register */
>> + =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_OFFSET, offset, 7, 0);
>> +
>> + =A0 =A0 /* Load Byte Count */
>> + =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_COUNT1, 0x80, 7, 0);
>> + =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_COUNT2, 0x0, 1, 0);
>> +
>> + =A0 =A0 /* Set DDC_CMD */
>> + =A0 =A0 if (ext)
>> + =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x4, 3, 0);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x2, 3, 0);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Do not optimize this part of the code, seems
>> + =A0 =A0 =A0* DDC bus needs some time to get stabilized
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 /* HDMI_CORE_DDC_STATUS_BUS_LOW */
>> + =A0 =A0 if (REG_GET(HDMI_CORE_DDC_STATUS, 6, 6) =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("I2C Bus Low?\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 }
>> + =A0 =A0 /* HDMI_CORE_DDC_STATUS_NO_ACK */
>> + =A0 =A0 if (REG_GET(HDMI_CORE_DDC_STATUS, 5, 5) =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("I2C No Ack\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 }
>> +
> [sp] Is -EIO appropriate error here?
I2c is not responding , so i think EIO would be appropriate, Do you
have any other suggestions?
>
>> + =A0 =A0 i =3D ext * 128;
>> + =A0 =A0 j =3D 0;
>> + =A0 =A0 while (((REG_GET(HDMI_CORE_DDC_STATUS, 4, 4) =3D=3D 1) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (REG_GET(HDMI_CORE_DDC_STA=
TUS, 2, 2) =3D=3D 0)) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 j < 128) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (REG_GET(HDMI_CORE_DDC_STATUS, 2, 2) =3D=
=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIFO not empty */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pEDID[i++] =3D REG_GET(HDM=
I_CORE_DDC_DATA, 7, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 j++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for (j =3D 0; j < 128; j++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 checksum +=3D pEDID[j];
>> +
>> + =A0 =A0 if (checksum !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("E-EDID checksum failed!!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int read_edid(u8 *pEDID, u16 max_length)
>> +{
>> + =A0 =A0 int r =3D 0, n =3D 0, i =3D 0;
>> + =A0 =A0 int max_ext_blocks =3D (max_length / 128) - 1;
>> +
>> + =A0 =A0 r =3D hdmi_core_ddc_edid(pEDID, 0);
>> + =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>
> [sp] Same query on -EIO here.
Again it is because of i2c fail , so I think EIO is appropriate.
>
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 n =3D pEDID[0x7e];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* README: need to comply with max_lengt=
h set by the caller.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Better implementation should be to al=
locate necessary
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* memory to store EDID according to nb_=
block field found
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* in first block
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> [sp] Shouldn't this info go to the function header instead?
It is for the parameter passed , so i added it while checking for the p=
arameter.
>
>> +
> [sp] extra line
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (n > max_ext_blocks)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 n =3D max_ext_blocks;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 1; i <=3D n; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_core_ddc_edid(p=
EDID, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EI=
O;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int get_timings_index(void)
>> +{
>> + =A0 =A0 int code;
>> +
>> + =A0 =A0 if (hdmi.mode =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 code =3D code_vesa[hdmi.code];
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 code =3D code_cea[hdmi.code];
>> +
>> + =A0 =A0 if (code =3D=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 code =3D 9;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI code 16 corresponds to 1920 * 1080=
 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 hdmi.code =3D 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI mode 1 corresponds to HDMI 0 to DV=
I */
>> + =A0 =A0 =A0 =A0 =A0 =A0 hdmi.mode =3D HDMI_HDMI;
>> + =A0 =A0 }
>> + =A0 =A0 return code;
>> +}
>> +
>> +static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timi=
ng)
>> +{
>> + =A0 =A0 int i =3D 0, code =3D -1, temp_vsync =3D 0, temp_hsync =3D=
 0;
>> + =A0 =A0 int timing_vsync =3D 0, timing_hsync =3D 0;
>> + =A0 =A0 struct omap_video_timings temp;
>> + =A0 =A0 struct hdmi_cm cm =3D {-1};
>> + =A0 =A0 DSSDBG("hdmi_get_code\n");
>> +
>> + =A0 =A0 for (i =3D 0; i < OMAP_HDMI_TIMINGS_NB; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp =3D cea_vesa_timings[i].timings;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((temp.pixel_clock =3D=3D timing->pixel=
_clock) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (temp.x_res =3D=3D timing-=
>x_res) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (temp.y_res =3D=3D timing-=
>y_res)) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_hsync =3D temp.hfp + =
temp.hsw + temp.hbp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_hsync =3D timing->h=
fp + timing->hsw + timing->hbp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_vsync =3D temp.vfp + =
temp.vsw + temp.vbp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_vsync =3D timing->v=
fp + timing->vsw + timing->vbp;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("temp_hsync =3D %d =
, temp_vsync =3D %d"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "timing_hs=
ync =3D %d, timing_vsync =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_hsync=
, temp_hsync,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_hsy=
nc, timing_vsync);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((temp_hsync =3D=3D tim=
ing_hsync) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (temp_vsync =3D=3D timing_vsync)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D i=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cm.code =3D=
 code_index[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (code <=
 14)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cm.mode =3D HDMI_HDMI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cm.mode =3D HDMI_DVI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("Hd=
mi_code =3D %d mode =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0cm.code, cm.mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return cm;
>> +}
>> +
>> +static void get_horz_vert_timing_info(int current_descriptor_addrs,=
 u8
>> *edid ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct omap_video_timings *timings)
>> +{
>> + =A0 =A0 /* X and Y resolution */
>> + =A0 =A0 timings->x_res =3D (((edid[current_descriptor_addrs + 4] &=
 0xF0) << 4)
>> |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0edid[current_descriptor=
_addrs + 2]);
>> + =A0 =A0 timings->y_res =3D (((edid[current_descriptor_addrs + 7] &=
 0xF0) << 4)
>> |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0edid[current_descriptor=
_addrs + 5]);
>> +
>> + =A0 =A0 timings->pixel_clock =3D ((edid[current_descriptor_addrs +=
 1] << 8) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid[curre=
nt_descriptor_addrs]);
>> +
>> + =A0 =A0 timings->pixel_clock =3D 10 * timings->pixel_clock;
>> +
>> + =A0 =A0 /* HORIZONTAL FRONT PORCH */
>> + =A0 =A0 timings->hfp =3D edid[current_descriptor_addrs + 8] |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((edid[current_descriptor_=
addrs + 11] & 0xc0) << 2);
>> + =A0 =A0 /* HORIZONTAL SYNC WIDTH */
>> + =A0 =A0 timings->hsw =3D edid[current_descriptor_addrs + 9] |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((edid[current_descriptor_=
addrs + 11] & 0x30) << 4);
>> + =A0 =A0 /* HORIZONTAL BACK PORCH */
>> + =A0 =A0 timings->hbp =3D (((edid[current_descriptor_addrs + 4] & 0=
x0F) << 8) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid[current_descriptor_ad=
drs + 3]) -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timings->hfp + timings->h=
sw);
>> + =A0 =A0 /* VERTICAL FRONT PORCH */
>> + =A0 =A0 timings->vfp =3D ((edid[current_descriptor_addrs + 10] & 0=
xF0) >> 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((edid[current_descriptor_=
addrs + 11] & 0x0f) << 2);
>> + =A0 =A0 /* VERTICAL SYNC WIDTH */
>> + =A0 =A0 timings->vsw =3D (edid[current_descriptor_addrs + 10] & 0x=
0F) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((edid[current_descriptor_=
addrs + 11] & 0x03) << 4);
>> + =A0 =A0 /* VERTICAL BACK PORCH */
>> + =A0 =A0 timings->vbp =3D (((edid[current_descriptor_addrs + 7] & 0=
x0F) << 8) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid[current_descriptor_ad=
drs + 6]) -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timings->vfp + timings->v=
sw);
>> +
>> +}
>> +
>> +/* Description : This function gets the resolution information from=
 EDID
>> */
> [sp] Suggest using kernel documentation style.
>
>> +static void get_edid_timing_data(u8 *edid)
>
> [sp] Contrast use of *edid vs *pEDID few functions above.
>
>> +{
>> + =A0 =A0 u8 count;
>> + =A0 =A0 u16 current_descriptor_addrs;
>> + =A0 =A0 struct hdmi_cm cm;
>> + =A0 =A0 struct omap_video_timings edid_timings;
>> +
>> + =A0 =A0 /* seach block 0, there are 4 DTDs arranged in priority or=
der */
>> + =A0 =A0 for (count =3D 0; count < EDID_SIZE_BLOCK0_TIMING_DESCRIPT=
OR; count++)
>> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 current_descriptor_addrs =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EDID_DESCRIPTOR_BLOCK0_ADD=
RESS +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count * EDID_TIMING_DESCRI=
PTOR_SIZE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 get_horz_vert_timing_info(current_descript=
or_addrs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid, &edi=
d_timings);
>> + =A0 =A0 =A0 =A0 =A0 =A0 cm =3D hdmi_get_code(&edid_timings);
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("Block0[%d] value matches code =3D =
%d , mode =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count, cm.code, cm.mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cm.code =3D=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.code =3D cm.code;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.mode =3D cm.mode;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("code =3D %d , mode=
 =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.code,=
 hdmi.mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 if (edid[0x7e] !=3D 0x00) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (count =3D 0; count < EDID_SIZE_BLOCK1=
_TIMING_DESCRIPTOR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_descriptor_addrs =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EDID_DESCRIPTOR_BLOCK1_ADD=
RESS +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count * EDID_TIMING_DESCRI=
PTOR_SIZE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_horz_vert_timing_info(=
current_descriptor_addrs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 edid, &edid_timings);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cm =3D hdmi_get_code(&edid=
_timings);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("Block1[%d] value m=
atches code =3D %d, mode =3D %d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count, cm.=
code, cm.mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cm.code =3D=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.code =
=3D cm.code;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.mode =
=3D cm.mode;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("co=
de =3D %d , mode =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 hdmi.code, hdmi.mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 DSSINFO("no valid timing found , falling back to VGA\n");
>> + =A0 =A0 hdmi.code =3D 4; /* setting default value of 640 480 VGA *=
/
>> + =A0 =A0 hdmi.mode =3D HDMI_DVI;
>> +}
>> +
>> +static int hdmi_read_edid(struct omap_video_timings *dp)
>> +{
>> + =A0 =A0 int ret =3D 0, code;
>> +
>> + =A0 =A0 memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
>> +
>> + =A0 =A0 if (!hdmi.edid_set)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D read_edid(hdmi.edid, HDMI_EDID_MAX=
_LENGTH);
>> +
>> + =A0 =A0 if (ret !=3D 0) {
>
> [sp] Shouldn't we check for success case first?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("failed to read E-EDID\n");
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!memcmp(hdmi.edid, edid_header, sizeof=
(edid_header))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* search for timings of d=
efault resolution */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_edid_timing_data(hdmi.=
edid);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.edid_set =3D true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!hdmi.edid_set) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSINFO("fallback to VGA\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 hdmi.code =3D 4; /* setting default value =
of 640 480 VGA */
>> + =A0 =A0 =A0 =A0 =A0 =A0 hdmi.mode =3D HDMI_DVI;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 code =3D get_timings_index();
>> +
>> + =A0 =A0 *dp =3D cea_vesa_timings[code].timings;
>> +
>> + =A0 =A0 return 0;
>
> [sp] Function will always return 0. Shouldn't it be void?
will change to void.
>

Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
