From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 5/8] OMAP4 : DSS2 : HDMI: HDMI driver addition in the DSS
 drivers interface
Date: Mon, 28 Feb 2011 11:41:31 +0530
Message-ID: <AANLkTimiQ2pdvzP0OAnq5YqzkWq_91XLMWSq1K5M_3VH@mail.gmail.com>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	<1298643715-21540-6-git-send-email-mythripk@ti.com>
	<1298801837.1977.63.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44127 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750853Ab1B1GLe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:11:34 -0500
Received: by mail-vw0-f49.google.com with SMTP id 7so4395595vws.22
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 22:11:32 -0800 (PST)
In-Reply-To: <1298801837.1977.63.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Sun, Feb 27, 2011 at 3:47 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-02-25 at 08:21 -0600, K, Mythri P wrote:
>> Adding the hdmi interface driver(hdmi.c) to the dss driver.
>> It configures the audio and video portion of HDMI in the
>> display header file to be accessed by the panels.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/Kconfig =A0 | =A0 =A08 +
>> =A0drivers/video/omap2/dss/Makefile =A0| =A0 =A01 +
>> =A0drivers/video/omap2/dss/display.c | =A0 =A03 +
>> =A0drivers/video/omap2/dss/dss.h =A0 =A0 | =A0 33 +
>> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0| 1276 ++++++++++++++++++++=
+++++++++++++++++
>> =A0drivers/video/omap2/dss/hdmi.h =A0 =A0| =A0 =A09 +
>> =A06 files changed, 1330 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/video/omap2/dss/hdmi.c
>>
>> diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/d=
ss/Kconfig
>> index 0d031b2..fe1ab09 100644
>> --- a/drivers/video/omap2/dss/Kconfig
>> +++ b/drivers/video/omap2/dss/Kconfig
>> @@ -60,6 +60,14 @@ config OMAP2_DSS_VENC
>> =A0 =A0 =A0 =A0 help
>> =A0 =A0 =A0 =A0 =A0 OMAP Video Encoder support for S-Video and compo=
site TV-out.
>>
>> +config OMAP2_DSS_HDMI
>> + =A0 =A0 =A0 bool "HDMI support"
>> + =A0 =A0 =A0 depends on ARCH_OMAP4
>> + =A0 =A0 =A0 =A0default n
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 HDMI Interface. This adds the High Definition Mult=
imedia Interface.
>> + =A0 =A0 =A0 =A0 See http://www.hdmi.org/ for HDMI specification.
>> +
>> =A0config OMAP2_DSS_SDI
>> =A0 =A0 =A0 =A0 bool "SDI support"
>> =A0 =A0 =A0 =A0 depends on ARCH_OMAP3
>> diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/=
dss/Makefile
>> index 7db17b5..5998b69 100644
>> --- a/drivers/video/omap2/dss/Makefile
>> +++ b/drivers/video/omap2/dss/Makefile
>> @@ -5,3 +5,4 @@ omapdss-$(CONFIG_OMAP2_DSS_RFBI) +=3D rfbi.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_VENC) +=3D venc.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_SDI) +=3D sdi.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_DSI) +=3D dsi.o
>> +omapdss-$(CONFIG_OMAP2_DSS_HDMI) +=3D hdmi.o
>> diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2=
/dss/display.c
>> index e10b303..cbab61a 100644
>> --- a/drivers/video/omap2/dss/display.c
>> +++ b/drivers/video/omap2/dss/display.c
>> @@ -447,6 +447,9 @@ void dss_init_device(struct platform_device *pde=
v,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D dsi_init_display(dssdev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0#endif
>> + =A0 =A0 =A0 case OMAP_DISPLAY_TYPE_HDMI:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_init_display(dssdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> =A0 =A0 =A0 =A0 }
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss=
/dss.h
>> index d199ba7..171877e 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -163,6 +163,16 @@ struct dsi_clock_info {
>> =A0 =A0 =A0 =A0 bool use_dss2_fck;
>> =A0};
>>
>> +/* HDMI PLL structure */
>> +struct hdmi_pll_info {
>> + =A0 =A0 =A0 u16 regn;
>> + =A0 =A0 =A0 u16 regm;
>> + =A0 =A0 =A0 u32 regmf;
>> + =A0 =A0 =A0 u16 regm2;
>> + =A0 =A0 =A0 u16 regsd;
>> + =A0 =A0 =A0 u16 dcofreq;
>> +};
>> +
>> =A0struct seq_file;
>> =A0struct platform_device;
>>
>> @@ -428,6 +438,29 @@ static inline void venc_uninit_platform_driver(=
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
>> + =A0 =A0 =A0 return 0;
>> +}
>> +static inline int hdmi_init_platform_driver(void)
>> +{
>> + =A0 =A0 =A0 return 0;
>> +}
>> +static inline void hdmi_uninit_platform_driver(void)
>> +{
>> +}
>> +#endif
>> +int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev);
>> +void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
>> +int omapdss_hdmi_display_suspend(struct omap_dss_device *dssdev);
>> +int omapdss_hdmi_display_resume(struct omap_dss_device *dssdev);
>> +
>> =A0/* RFBI */
>> =A0#ifdef CONFIG_OMAP2_DSS_RFBI
>> =A0int rfbi_init_platform_driver(void);
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> new file mode 100644
>> index 0000000..1cd861f
>> --- /dev/null
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -0,0 +1,1276 @@
>> +/*
>> + * hdmi.c
>> + *
>> + * HDMI interface DSS driver setting for TI's OMAP4 family of proce=
ssor.
>> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://=
www.ti.com/
>> + * Authors: Yong Zhi
>
> Who is Yong Zhi and where's his signed-off-by?
Yong zhi had written some of the functions in this file , which was in
a library.He no longer works on the driver though .
>
>> + * =A0 =A0 Mythri pk <mythripk@ti.com>
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along with
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
>> + =A0 =A0 =A0 struct mutex lock;
>> + =A0 =A0 =A0 struct omap_display_platform_data *pdata;
>> + =A0 =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 =A0 void __iomem *base_wp; =A0/* HDMI wrapper */
>> + =A0 =A0 =A0 int code;
>> + =A0 =A0 =A0 int mode;
>> + =A0 =A0 =A0 struct hdmi_config cfg;
>> +} hdmi;
>> +
>> +static inline void hdmi_write_reg(const struct hdmi_reg idx, u32 va=
l)
>> +{
>> + =A0 =A0 =A0 __raw_writel(val, hdmi.base_wp + idx.idx);
>> +}
>> +
>> +static inline u32 hdmi_read_reg(const struct hdmi_reg idx)
>> +{
>> + =A0 =A0 =A0 u32 l;
>> + =A0 =A0 =A0 l =3D __raw_readl(hdmi.base_wp + idx.idx);
>> + =A0 =A0 =A0 return l;
>> +}
>
> No need for the l variable.
sorry should have checked.
>
>> +
>> +static inline int hdmi_wait_for_bit_change(const struct hdmi_reg id=
x,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int b2=
, int b1, u32 val)
>> +{
>> + =A0 =A0 =A0 u32 t =3D 0;
>> + =A0 =A0 =A0 while (val !=3D FLD_GET(hdmi_read_reg(idx), b2, b1)) {
>
> There's REG_GET macro used in other DSS files to read bits from the
> registers.
Hmm i see that in dsi.c REG_GET is defined to do the same,
#define REG_GET(idx, start, end) \
	FLD_GET(dsi_read_reg(idx), start, end)
So should this be fine of should i define a new REG_GET ?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t++ > 10000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !val;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return val;
>> +}
>> +
>> +int hdmi_init_display(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 =A0 DSSDBG("init_display\n");
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int hdmi_pll_init(int refsel, int dcofreq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_pll_info *fmt, u16 sd)
>> +{
>> + =A0 =A0 =A0 u32 r;
>> +
>> + =A0 =A0 =A0 /* PLL start always use manual mode */
>> + =A0 =A0 =A0 REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
>> +
>> + =A0 =A0 =A0 r =3D hdmi_read_reg(PLLCTRL_CFG1);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM *=
/
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regn, 8, 1); =A0/* CFG1_PLL_REGN=
 */
>> +
>> + =A0 =A0 =A0 hdmi_write_reg(PLLCTRL_CFG1, r);
>> +
>> + =A0 =A0 =A0 r =3D hdmi_read_reg(PLLCTRL_CFG2);
>> +
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, 0x0, 12, 12); /* PLL_HIGHFREQ divide =
by 2 */
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, 0x1, 13, 13); /* PLL_REFEN */
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, 0x0, 14, 14); /* PHY_CLKINEN de-asser=
t during locking */
>> +
>> + =A0 =A0 =A0 if (dcofreq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* divider programming for frequency b=
eyond 1000Mhz */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(PLLCTRL_CFG3, sd, 17, 10);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, 0x4, 3, 1); /* 1000MH=
z and 2000MHz */
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, 0x2, 3, 1); /* 500MHz=
 and 1000MHz */
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 hdmi_write_reg(PLLCTRL_CFG2, r);
>> +
>> + =A0 =A0 =A0 r =3D hdmi_read_reg(PLLCTRL_CFG4);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regm2, 24, 18);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regmf, 17, 0);
>> +
>> + =A0 =A0 =A0 hdmi_write_reg(PLLCTRL_CFG4, r);
>> +
>> + =A0 =A0 =A0 /* go now */
>> + =A0 =A0 =A0 REG_FLD_MOD(PLLCTRL_PLL_GO, 0x1, 0, 0);
>> +
>> + =A0 =A0 =A0 /* wait for bit change */
>> + =A0 =A0 =A0 if (hdmi_wait_for_bit_change(PLLCTRL_PLL_GO, 0, 0, 1) =
!=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("PLL GO bit not set\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Wait till the lock bit is set in PLL status */
>> + =A0 =A0 =A0 if (hdmi_wait_for_bit_change(PLLCTRL_PLL_STATUS, 1, 1,=
 1) !=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("cannot lock PLL\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("CFG1 0x%x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi_read_reg(PLLCTRL_=
CFG1));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("CFG2 0x%x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi_read_reg(PLLCTRL_=
CFG2));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("CFG4 0x%x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi_read_reg(PLLCTRL_=
CFG4));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 DSSDBG("PLL locked!\n");
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int hdmi_pll_reset(void)
>> +{
>> + =A0 =A0 =A0 /* SYSRESET =A0controlled by power FSM */
>> + =A0 =A0 =A0 REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 3, 3);
>> +
>> + =A0 =A0 =A0 /* READ 0x0 reset is in progress */
>> + =A0 =A0 =A0 if (hdmi_wait_for_bit_change(PLLCTRL_PLL_STATUS, 0, 0,=
 1) !=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to sysreset PLL\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int hdmi_phy_init(void)
>> +{
>> + =A0 =A0 =A0 u16 r =3D 0;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* wait till PHY_PWR_STATUS=3DLDOON
>> + =A0 =A0 =A0 =A0* HDMI_PHYPWRCMD_LDOON =3D 1
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 r =3D hdmi_wait_phy_pwr(1);
>
> Why doesn't hdmi_wait_phy_pwr use an enum?
I shall change.
>
>> + =A0 =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> +
>> + =A0 =A0 =A0 /* wait till PHY_PWR_STATUS=3DTXON */
>> + =A0 =A0 =A0 r =3D hdmi_wait_phy_pwr(2);
>> + =A0 =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Read address 0 in order to get the SCP reset done=
 completed
>> + =A0 =A0 =A0 =A0* Dummy access performed to make sure reset is done
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 hdmi_read_reg(HDMI_TXPHY_TX_CTRL);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Write to phy address 0 to configure the clock
>> + =A0 =A0 =A0 =A0* use HFBITCLK write HDMI_TXPHY_TX_CONTROL_FREQOUT =
field
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_TXPHY_TX_CTRL, 0x1, 31, 30);
>> +
>> + =A0 =A0 =A0 /* Write to phy address 1 to start HDMI line (TXVALID =
and TMDSCLKEN) */
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_TXPHY_DIGITAL_CTRL, 0xF0000000);
>> +
>> + =A0 =A0 =A0 /* Setup max LDO voltage */
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
>> +
>> + =A0 =A0 =A0 /* Write to phy address 3 to change the polarity contr=
ol */
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +int hdmi_pll_program(struct hdmi_pll_info *fmt)
>
> This, and some other functions in this file, could be static.
Hmm ok i shall see what all functions will not be needed from other
files and make them static.
>
>> +{
>> + =A0 =A0 =A0 u16 r =3D 0;
>> + =A0 =A0 =A0 int refsel;
>> +
>> + =A0 =A0 =A0 /* wait for wrapper reset */
>> + =A0 =A0 =A0 hdmi_wait_softreset();
>> +
>> + =A0 =A0 =A0 /* power off PLL */
>> + =A0 =A0 =A0 r =3D hdmi_wait_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
>> + =A0 =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> +
>> + =A0 =A0 =A0 /* power on PLL */
>> + =A0 =A0 =A0 r =3D hdmi_wait_pll_pwr(HDMI_PLLPWRCMD_BOTHON_ALLCLKS)=
;
>> + =A0 =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> +
>> + =A0 =A0 =A0 hdmi_pll_reset();
>> +
>> + =A0 =A0 =A0 refsel =3D 0x3; /* select SYSCLK reference */
>> +
>> + =A0 =A0 =A0 r =3D hdmi_pll_init(refsel, fmt->dcofreq, fmt, fmt->re=
gsd);
>> + =A0 =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static void hdmi_phy_off(void)
>> +{
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Wait till PHY_PWR_STATUS=3DOFF
>> + =A0 =A0 =A0 =A0* HDMI_PHYPWRCMD_OFF =3D 0
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 hdmi_wait_phy_pwr(0);
>> +}
>> +
>> +int hdmi_core_ddc_edid(u8 *pEDID, int ext)
>> +{
>> + =A0 =A0 =A0 u32 i, j, l;
>> + =A0 =A0 =A0 char checksum =3D 0;
>> + =A0 =A0 =A0 u32 offset =3D 0;
>> +
>> + =A0 =A0 =A0 /* Turn on CLK for DDC */
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_AV_DPD, 0x7, 2, 0);
>> +
>> + =A0 =A0 =A0 /* HACK : DDC needs time to stablize */
>> + =A0 =A0 =A0 mdelay(10);
>
> So what is the reason for this? It's a sleep that for unknown reason
> make the code work? Or is there an idea why this is needed?
This is the time it needs to stabilize DDC, else most of the time it
reads a 0 or
wrong shifted values , so i have prefixed with a HACK.
>
>> +
>> + =A0 =A0 =A0 if (!ext) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Clk SCL Devices */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0xA, 3,=
 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI_CORE_DDC_STATUS_IN_PROG No tim=
er needed */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_CORE=
_DDC_STATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 4, 4, 0) !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to prog=
ram DDC\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Clear FIFO */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3,=
 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI_CORE_DDC_STATUS_IN_PROG */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_CORE=
_DDC_STATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 4, 4, 0) !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to prog=
ram DDC\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext % 2 !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D 0x80;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Load Segment Address Register */
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_SEGM, ext/2, 7, 0);
>> +
>> + =A0 =A0 =A0 /* Load Slave Address Register */
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_ADDR, 0xA0 >> 1, 7, 1);
>> +
>> + =A0 =A0 =A0 /* Load Offset Address Register */
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_OFFSET, offset, 7, 0);
>> +
>> + =A0 =A0 =A0 /* Load Byte Count */
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_COUNT1, 0x80, 7, 0);
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_COUNT2, 0x0, 1, 0);
>> +
>> + =A0 =A0 =A0 /* Set DDC_CMD */
>> + =A0 =A0 =A0 if (ext)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x4, 3,=
 0);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x2, 3,=
 0);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Do not optimize this part of the code, seems
>> + =A0 =A0 =A0 =A0* DDC bus needs some time to get stabilized
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 l =3D hdmi_read_reg(HDMI_CORE_DDC_STATUS);
>> +
>> + =A0 =A0 =A0 /* HDMI_CORE_DDC_STATUS_BUS_LOW */
>> + =A0 =A0 =A0 if (FLD_GET(l, 6, 6) =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("I2C Bus Low?\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 /* HDMI_CORE_DDC_STATUS_NO_ACK */
>> + =A0 =A0 =A0 if (FLD_GET(l, 5, 5) =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("I2C No Ack\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 i =3D ext * 128;
>> + =A0 =A0 =A0 j =3D 0;
>> + =A0 =A0 =A0 while (((FLD_GET(hdmi_read_reg(HDMI_CORE_DDC_STATUS), =
4, 4) =3D=3D 1) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (FLD_GET(hdmi_read_reg(HDMI_CORE_DDC_S=
TATUS), 2, 2) =3D=3D 0)) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 j < 128) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (FLD_GET(hdmi_read_reg(HDMI_CORE_DD=
C_STATUS), 2, 2) =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIFO not empty */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pEDID[i++] =3D FLD_GET=
(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi_r=
ead_reg(HDMI_CORE_DDC_DATA), 7, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 j++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 for (j =3D 0; j < 128; j++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 checksum +=3D pEDID[j];
>> +
>> + =A0 =A0 =A0 if (checksum !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("E-EDID checksum failed!!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +int read_edid(u8 *pEDID, u16 max_length)
>> +{
>> + =A0 =A0 =A0 int r =3D 0, n =3D 0, i =3D 0;
>> + =A0 =A0 =A0 int max_ext_blocks =3D (max_length / 128) - 1;
>> +
>> + =A0 =A0 =A0 r =3D hdmi_core_ddc_edid(pEDID, 0);
>> + =A0 =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n =3D pEDID[0x7e];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* README: need to comply with max_l=
ength set by the caller.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Better implementation should be t=
o allocate necessary
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* memory to store EDID according to=
 nb_block field found
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in first block
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (n > max_ext_blocks)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 n =3D max_ext_blocks;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 1; i <=3D n; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_core_ddc_ed=
id(pEDID, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
 -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static inline void print_omap_video_timings(struct omap_video_timin=
gs *timings)
>
> Why is this inline?
Its only a print function , called many times by the driver. Do you
see any reason not to make it inline?
>
>> +{
>> + =A0 =A0 =A0 DSSINFO("Timing Info:\n");
>> + =A0 =A0 =A0 DSSINFO("pixel_clk =3D %d\n", timings->pixel_clock);
>> + =A0 =A0 =A0 DSSINFO(" =A0x_res =A0 =A0 =3D %d\n", timings->x_res);
>> + =A0 =A0 =A0 DSSINFO(" =A0y_res =A0 =A0 =3D %d\n", timings->y_res);
>> + =A0 =A0 =A0 DSSINFO(" =A0hfp =A0 =A0 =A0 =3D %d\n", timings->hfp);
>> + =A0 =A0 =A0 DSSINFO(" =A0hsw =A0 =A0 =A0 =3D %d\n", timings->hsw);
>> + =A0 =A0 =A0 DSSINFO(" =A0hbp =A0 =A0 =A0 =3D %d\n", timings->hbp);
>> + =A0 =A0 =A0 DSSINFO(" =A0vfp =A0 =A0 =A0 =3D %d\n", timings->vfp);
>> + =A0 =A0 =A0 DSSINFO(" =A0vsw =A0 =A0 =A0 =3D %d\n", timings->vsw);
>> + =A0 =A0 =A0 DSSINFO(" =A0vbp =A0 =A0 =A0 =3D %d\n", timings->vbp);
>> +}
>> +
>> +static int get_timings_index(void)
>> +{
>> + =A0 =A0 =A0 int code;
>> +
>> + =A0 =A0 =A0 if (hdmi.mode =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D code_vesa[hdmi.code];
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D code_cea[hdmi.code];
>> +
>> + =A0 =A0 =A0 if (code =3D=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D 9;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI code 16 corresponds to 1920 * =
1080 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.code =3D 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI mode 1 corresponds to HDMI 0 t=
o DVI */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.mode =3D HDMI_HDMI;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return code;
>> +}
>> +
>> +static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timi=
ng)
>> +{
>> + =A0 =A0 =A0 int i =3D 0, code =3D -1, temp_vsync =3D 0, temp_hsync=
 =3D 0;
>> + =A0 =A0 =A0 int timing_vsync =3D 0, timing_hsync =3D 0;
>> + =A0 =A0 =A0 struct omap_video_timings temp;
>> + =A0 =A0 =A0 struct hdmi_cm cm =3D {-1};
>> + =A0 =A0 =A0 DSSDBG("hdmi_get_code\n");
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < OMAP_HDMI_TIMINGS_NB; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D cea_vesa_timings[i].timings;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((temp.pixel_clock =3D=3D timing->p=
ixel_clock) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (temp.x_res =3D=3D tim=
ing->x_res) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (temp.y_res =3D=3D tim=
ing->y_res)) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_hsync =3D temp.hf=
p + temp.hsw + temp.hbp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_hsync =3D timin=
g->hfp + timing->hsw + timing->hbp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_vsync =3D temp.vf=
p + temp.vsw + temp.vbp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing_vsync =3D timin=
g->vfp + timing->vsw + timing->vbp;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("temp_hsync =3D=
 %d , temp_vsync =3D %d"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "timin=
g_hsync =3D %d, timing_vsync =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_h=
sync, temp_hsync,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing=
_hsync, timing_vsync);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((temp_hsync =3D=3D=
 timing_hsync) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (temp_vsync =3D=3D timing_vsync)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D=
 i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cm.cod=
e =3D code_index[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (co=
de < 14)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cm.mode =3D HDMI_HDMI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cm.mode =3D HDMI_DVI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSINF=
O("Hdmi_code =3D %d mode =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0cm.code, cm.mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print_=
omap_video_timings(&temp);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return cm;
>> +}
>> +
>> +void get_horz_vert_timing_info(int current_descriptor_addrs, u8 *ed=
id ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_video_timings *timings)
>> +{
>> + =A0 =A0 =A0 /* X and Y resolution */
>> + =A0 =A0 =A0 timings->x_res =3D (((edid[current_descriptor_addrs + =
4] & 0xF0) << 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0edid[current_descri=
ptor_addrs + 2]);
>> + =A0 =A0 =A0 timings->y_res =3D (((edid[current_descriptor_addrs + =
7] & 0xF0) << 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0edid[current_descri=
ptor_addrs + 5]);
>> +
>> + =A0 =A0 =A0 timings->pixel_clock =3D ((edid[current_descriptor_add=
rs + 1] << 8) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid[c=
urrent_descriptor_addrs]);
>> +
>> + =A0 =A0 =A0 timings->pixel_clock =3D 10 * timings->pixel_clock;
>> +
>> + =A0 =A0 =A0 /* HORIZONTAL FRONT PORCH */
>> + =A0 =A0 =A0 timings->hfp =3D edid[current_descriptor_addrs + 8] |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((edid[current_descrip=
tor_addrs + 11] & 0xc0) << 2);
>> + =A0 =A0 =A0 /* HORIZONTAL SYNC WIDTH */
>> + =A0 =A0 =A0 timings->hsw =3D edid[current_descriptor_addrs + 9] |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((edid[current_descrip=
tor_addrs + 11] & 0x30) << 4);
>> + =A0 =A0 =A0 /* HORIZONTAL BACK PORCH */
>> + =A0 =A0 =A0 timings->hbp =3D (((edid[current_descriptor_addrs + 4]=
 & 0x0F) << 8) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid[current_descripto=
r_addrs + 3]) -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timings->hfp + timing=
s->hsw);
>> + =A0 =A0 =A0 /* VERTICAL FRONT PORCH */
>> + =A0 =A0 =A0 timings->vfp =3D ((edid[current_descriptor_addrs + 10]=
 & 0xF0) >> 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((edid[current_descrip=
tor_addrs + 11] & 0x0f) << 2);
>> + =A0 =A0 =A0 /* VERTICAL SYNC WIDTH */
>> + =A0 =A0 =A0 timings->vsw =3D (edid[current_descriptor_addrs + 10] =
& 0x0F) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((edid[current_descrip=
tor_addrs + 11] & 0x03) << 4);
>> + =A0 =A0 =A0 /* VERTICAL BACK PORCH */
>> + =A0 =A0 =A0 timings->vbp =3D (((edid[current_descriptor_addrs + 7]=
 & 0x0F) << 8) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid[current_descripto=
r_addrs + 6]) -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timings->vfp + timing=
s->vsw);
>> +
>> + =A0 =A0 =A0 print_omap_video_timings(timings);
>> +
>> +}
>> +
>> +/* Description : This function gets the resolution information from=
 EDID */
>> +static void get_edid_timing_data(u8 *edid)
>> +{
>> + =A0 =A0 =A0 u8 count, code;
>> + =A0 =A0 =A0 u16 current_descriptor_addrs;
>> + =A0 =A0 =A0 struct hdmi_cm cm;
>> +
>> + =A0 =A0 =A0 /* seach block 0, there are 4 DTDs arranged in priorit=
y order */
>> + =A0 =A0 =A0 for (count =3D 0; count < EDID_SIZE_BLOCK0_TIMING_DESC=
RIPTOR; count++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_descriptor_addrs =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EDID_DESCRIPTOR_BLOCK0=
_ADDRESS +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count * EDID_TIMING_DE=
SCRIPTOR_SIZE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_horz_vert_timing_info(current_desc=
riptor_addrs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid, =
&edid_timings);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cm =3D hdmi_get_code(&edid_timings);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSINFO("Block0[%d] value matches code=
 =3D %d , mode =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count, cm.code, cm.mod=
e);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cm.code =3D=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.code =3D cm.code;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.mode =3D cm.mode;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSINFO("code =3D %d ,=
 mode =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.c=
ode, hdmi.mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (edid[0x7e] !=3D 0x00) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (count =3D 0; count < EDID_SIZE_BL=
OCK1_TIMING_DESCRIPTOR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_descriptor_add=
rs =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EDID_DESCRIPTOR_BLOCK1=
_ADDRESS +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count * EDID_TIMING_DE=
SCRIPTOR_SIZE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_horz_vert_timing_i=
nfo(current_descriptor_addrs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 edid, &edid_timings);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cm =3D hdmi_get_code(&=
edid_timings);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSINFO("Block1[%d] va=
lue matches code =3D %d, mode =3D %d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count,=
 cm.code, cm.mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cm.code =3D=3D -1)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 contin=
ue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.c=
ode =3D cm.code;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.m=
ode =3D cm.mode;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSINF=
O("code =3D %d , mode =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 hdmi.code, hdmi.mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 DSSINFO("no valid timing found , falling back to VGA\n=
");
>> + =A0 =A0 =A0 hdmi.code =3D 4; /* setting default value of 640 480 V=
GA */
>> + =A0 =A0 =A0 hdmi.mode =3D HDMI_DVI;
>> + =A0 =A0 =A0 code =3D code_vesa[hdmi.code];
>> + =A0 =A0 =A0 edid_timings =3D cea_vesa_timings[code].timings;
>> +}
>> +
>> +static int hdmi_read_edid(struct omap_video_timings *dp)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0, code;
>> +
>> + =A0 =A0 =A0 memset(edid, 0, HDMI_EDID_MAX_LENGTH);
>> +
>> + =A0 =A0 =A0 if (!edid_set)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D read_edid(edid, HDMI_EDID_MAX_=
LENGTH);
>> +
>> + =A0 =A0 =A0 if (ret !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSWARN("failed to read E-EDID\n");
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!memcmp(edid, header, sizeof(heade=
r))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* search for timings =
of default resolution */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_edid_timing_data(e=
did);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid_set =3D true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (!edid_set) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSINFO("fallback to VGA\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.code =3D 4; /* setting default va=
lue of 640 480 VGA */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.mode =3D HDMI_DVI;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 code =3D get_timings_index();
>> +
>> + =A0 =A0 =A0 *dp =3D cea_vesa_timings[code].timings;
>> +
>> + =A0 =A0 =A0 DSSDBG("print EDID timings\n");
>> + =A0 =A0 =A0 print_omap_video_timings(dp);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static void hdmi_core_init(struct hdmi_core_video_config *video_cfg=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_core_infof=
rame_avi *avi_cfg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_core_packe=
t_enable_repeat *repeat_cfg)
>> +{
>> + =A0 =A0 =A0 DSSDBG("Enter hdmi_core_init\n");
>> +
>> + =A0 =A0 =A0 /* video core */
>> + =A0 =A0 =A0 video_cfg->ip_bus_width =3D HDMI_INPUT_8BIT;
>> + =A0 =A0 =A0 video_cfg->op_dither_truc =3D HDMI_OUTPUTTRUNCATION_8B=
IT;
>> + =A0 =A0 =A0 video_cfg->deep_color_pkt =3D HDMI_DEEPCOLORPACKECTDIS=
ABLE;
>> + =A0 =A0 =A0 video_cfg->pkt_mode =3D HDMI_PACKETMODERESERVEDVALUE;
>> + =A0 =A0 =A0 video_cfg->hdmi_dvi =3D HDMI_DVI;
>> + =A0 =A0 =A0 video_cfg->tclk_sel_clkmult =3D FPLL10IDCK;
>> +
>> + =A0 =A0 =A0 /* info frame */
>> + =A0 =A0 =A0 avi_cfg->db1_format =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db1_active_info =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db1_bar_info_dv =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db1_scan_info =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db2_colorimetry =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db2_aspect_ratio =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db2_active_fmt_ar =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db3_itc =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db3_ec =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db3_q_range =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db3_nup_scaling =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db4_videocode =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db5_pixel_repeat =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db6_7_line_eoftop =3D 0 ;
>> + =A0 =A0 =A0 avi_cfg->db8_9_line_sofbottom =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db10_11_pixel_eofleft =3D 0;
>> + =A0 =A0 =A0 avi_cfg->db12_13_pixel_sofright =3D 0;
>> +
>> + =A0 =A0 =A0 /* packet enable and repeat */
>> + =A0 =A0 =A0 repeat_cfg->audio_pkt =3D 0;
>> + =A0 =A0 =A0 repeat_cfg->audio_pkt_repeat =3D 0;
>> + =A0 =A0 =A0 repeat_cfg->avi_infoframe =3D 0;
>> + =A0 =A0 =A0 repeat_cfg->avi_infoframe_repeat =3D 0;
>> + =A0 =A0 =A0 repeat_cfg->gen_cntrl_pkt =3D 0;
>> + =A0 =A0 =A0 repeat_cfg->gen_cntrl_pkt_repeat =3D 0;
>> + =A0 =A0 =A0 repeat_cfg->generic_pkt =3D 0;
>> + =A0 =A0 =A0 repeat_cfg->generic_pkt_repeat =3D 0;
>> +}
>> +
>> +static void hdmi_core_powerdown_disable(void)
>> +{
>> + =A0 =A0 =A0 DSSDBG("Enter hdmi_core_powerdown_disable\n");
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_CTRL1, 0x0, 0, 0);
>> +}
>> +
>> +static void hdmi_core_swreset_release(void)
>> +{
>> + =A0 =A0 =A0 DSSDBG("Enter hdmi_core_swreset_release\n");
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_SYS_SRST, 0x0, 0, 0);
>> +}
>> +
>> +static void hdmi_core_swreset_assert(void)
>> +{
>> + =A0 =A0 =A0 DSSDBG("Enter hdmi_core_swreset_assert\n");
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_SYS_SRST, 0x1, 0, 0);
>> +}
>> +
>> +/* DSS_HDMI_CORE_VIDEO_CONFIG */
>> +static void hdmi_core_video_config(struct hdmi_core_video_config *c=
fg)
>> +{
>> + =A0 =A0 =A0 u32 r =3D 0;
>> +
>> + =A0 =A0 =A0 /* sys_ctrl1 default configuration not tunable */
>> + =A0 =A0 =A0 r =3D hdmi_read_reg(HDMI_CORE_CTRL1);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, HDMI_CORE_CTRL1_VEN_FOLLOWVSYNC, 5, 5=
);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, HDMI_CORE_CTRL1_HEN_FOLLOWHSYNC, 4, 4=
);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, HDMI_CORE_CTRL1_BSEL_24BITBUS, 2, 2);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, HDMI_CORE_CTRL1_EDGE_RISINGEDGE, 1, 1=
);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_CTRL1, r);
>> +
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_SYS_VID_ACEN, cfg->ip_bus_width,=
 7, 6);
>> +
>> + =A0 =A0 =A0 /* Vid_Mode */
>> + =A0 =A0 =A0 r =3D hdmi_read_reg(HDMI_CORE_SYS_VID_MODE);
>> +
>> + =A0 =A0 =A0 /* dither truncation configuration */
>> + =A0 =A0 =A0 if (cfg->op_dither_truc > HDMI_OUTPUTTRUNCATION_12BIT)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, cfg->op_dither_truc -=
 3, 7, 6);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, 1, 5, 5);
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, cfg->op_dither_truc, =
7, 6);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, 0, 5, 5);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_SYS_VID_MODE, r);
>> +
>> + =A0 =A0 =A0 /* HDMI_Ctrl */
>> + =A0 =A0 =A0 r =3D hdmi_read_reg(HDMI_CORE_AV_HDMI_CTRL);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, cfg->deep_color_pkt, 6, 6);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, cfg->pkt_mode, 5, 3);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, cfg->hdmi_dvi, 0, 0);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_HDMI_CTRL, r);
>> +
>> + =A0 =A0 =A0 /* TMDS_CTRL */
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_SYS_TMDS_CTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg->tclk_sel_clkmult, 6, 5);
>> +}
>> +
>> +static void hdmi_core_aux_infoframe_avi_config(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_core_infoframe_avi info_av=
i)
>> +{
>> + =A0 =A0 =A0 u32 val;
>> + =A0 =A0 =A0 char sum =3D 0, checksum =3D 0;
>> +
>> + =A0 =A0 =A0 sum +=3D 0x82 + 0x002 + 0x00D;
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_TYPE, 0x082);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_VERS, 0x002);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_LEN, 0x00D);
>> +
>> + =A0 =A0 =A0 val =3D (info_avi.db1_format << 5) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info_avi.db1_active_info << 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info_avi.db1_bar_info_dv << 2) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info_avi.db1_scan_info);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(0), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D (info_avi.db2_colorimetry << 6) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info_avi.db2_aspect_ratio << 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info_avi.db2_active_fmt_ar);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(1), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D (info_avi.db3_itc << 7) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info_avi.db3_ec << 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info_avi.db3_q_range << 2) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (info_avi.db3_nup_scaling);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(2), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(3), info_avi.db4=
_videocode);
>> + =A0 =A0 =A0 sum +=3D info_avi.db4_videocode;
>> +
>> + =A0 =A0 =A0 val =3D info_avi.db5_pixel_repeat;
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(4), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D info_avi.db6_7_line_eoftop & 0x00FF;
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(5), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D ((info_avi.db6_7_line_eoftop >> 8) & 0x00FF);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(6), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D info_avi.db8_9_line_sofbottom & 0x00FF;
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(7), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D ((info_avi.db8_9_line_sofbottom >> 8) & 0x00FF=
);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(8), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D info_avi.db10_11_pixel_eofleft & 0x00FF;
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(9), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D ((info_avi.db10_11_pixel_eofleft >> 8) & 0x00F=
=46);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(10), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D info_avi.db12_13_pixel_sofright & 0x00FF;
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(11), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 val =3D ((info_avi.db12_13_pixel_sofright >> 8) & 0x00=
=46F);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_DBYTE(12), val);
>> + =A0 =A0 =A0 sum +=3D val;
>> +
>> + =A0 =A0 =A0 checksum =3D 0x100 - sum;
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_AVI_CHSUM, checksum);
>> +}
>> +
>> +static void hdmi_core_av_packet_config(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_core_packet_enable_repeat =
repeat_cfg)
>> +{
>> + =A0 =A0 =A0 /* enable/repeat the infoframe */
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_PB_CTRL1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (repeat_cfg.audio_pkt << 5)|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (repeat_cfg.audio_pkt_repeat << 4)|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (repeat_cfg.avi_infoframe << 1)|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (repeat_cfg.avi_infoframe_repeat));
>> +
>> + =A0 =A0 =A0 /* enable/repeat the packet */
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_CORE_AV_PB_CTRL2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (repeat_cfg.gen_cntrl_pkt << 3)|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (repeat_cfg.gen_cntrl_pkt_repeat << 2)=
|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (repeat_cfg.generic_pkt << 1)|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (repeat_cfg.generic_pkt_repeat));
>> +}
>> +
>> +static void hdmi_wp_init(struct hdmi_video_timing *timings,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_video_form=
at *video_fmt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_video_inte=
rface *video_int)
>> +{
>> + =A0 =A0 =A0 DSSDBG("Enter hdmi_wp_init\n");
>> +
>> + =A0 =A0 =A0 timings->hbp =3D 0;
>> + =A0 =A0 =A0 timings->hfp =3D 0;
>> + =A0 =A0 =A0 timings->hsw =3D 0;
>> + =A0 =A0 =A0 timings->vbp =3D 0;
>> + =A0 =A0 =A0 timings->vfp =3D 0;
>> + =A0 =A0 =A0 timings->vsw =3D 0;
>> +
>> + =A0 =A0 =A0 video_fmt->packing_mode =3D HDMI_PACK_10b_RGB_YUV444;
>> + =A0 =A0 =A0 video_fmt->y_res =3D 0;
>> + =A0 =A0 =A0 video_fmt->x_res =3D 0;
>> +
>> + =A0 =A0 =A0 video_int->vsp =3D 0;
>> + =A0 =A0 =A0 video_int->hsp =3D 0;
>> +
>> + =A0 =A0 =A0 video_int->interlacing =3D 0;
>> + =A0 =A0 =A0 video_int->tm =3D 0; /* HDMI_TIMING_SLAVE */
>> +
>> +}
>> +
>> +/* PHY_PWR_CMD */
>> +int hdmi_wait_phy_pwr(int val)
>> +{
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_WP_PWR_CTRL, val, 7, 6);
>> +
>> + =A0 =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_WP_PWR_CTRL, 5, 4, v=
al) !=3D val) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to set PHY power mode t=
o %d\n", val);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/* PLL_PWR_CMD */
>> +int hdmi_wait_pll_pwr(int val)
>> +{
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_WP_PWR_CTRL, val, 3, 2);
>> +
>> + =A0 =A0 =A0 /* wait till PHY_PWR_STATUS=3DON */
>> + =A0 =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_WP_PWR_CTRL, 1, 0, v=
al) !=3D val) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to set PHY_PWR_STATUS t=
o ON\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +void hdmi_wp_video_stop(void)
>> +{
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_WP_VIDEO_CFG, 0, 31, 31);
>> +}
>> +
>> +void hdmi_wp_video_start(void)
>> +{
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_WP_VIDEO_CFG, (u32)0x1, 31, 31);
>> +}
>> +
>> +static void hdmi_wp_video_init_format(struct hdmi_video_format *vid=
eo_fmt,
>> + =A0 =A0 =A0 struct hdmi_video_timing *timings, struct hdmi_config =
*param)
>> +{
>> + =A0 =A0 =A0 DSSDBG("Enter hdmi_wp_video_init_format\n");
>> +
>> + =A0 =A0 =A0 video_fmt->y_res =3D param->lpp;
>> + =A0 =A0 =A0 video_fmt->x_res =3D param->ppl;
>> +
>> + =A0 =A0 =A0 timings->hbp =3D param->hbp;
>> + =A0 =A0 =A0 timings->hfp =3D param->hfp;
>> + =A0 =A0 =A0 timings->hsw =3D param->hsw;
>> + =A0 =A0 =A0 timings->vbp =3D param->vbp;
>> + =A0 =A0 =A0 timings->vfp =3D param->vfp;
>> + =A0 =A0 =A0 timings->vsw =3D param->vsw;
>> +}
>> +
>> +static void hdmi_wp_video_config_format(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_video_format *video_fmt)
>> +{
>> + =A0 =A0 =A0 u32 l =3D 0;
>> +
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_WP_VIDEO_CFG, video_fmt->packing_mode=
, 10, 8);
>> +
>> + =A0 =A0 =A0 l |=3D FLD_VAL(video_fmt->y_res, 31, 16);
>> + =A0 =A0 =A0 l |=3D FLD_VAL(video_fmt->x_res, 15, 0);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_WP_VIDEO_SIZE, l);
>> +}
>> +
>> +static void hdmi_wp_video_config_interface(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_video_interface *video_int=
)
>> +{
>> + =A0 =A0 =A0 u32 r;
>> + =A0 =A0 =A0 DSSDBG("Enter hdmi_wp_video_config_interface\n");
>> +
>> + =A0 =A0 =A0 r =3D hdmi_read_reg(HDMI_WP_VIDEO_CFG);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, video_int->vsp, 7, 7);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, video_int->hsp, 6, 6);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, video_int->interlacing, 3, 3);
>> + =A0 =A0 =A0 r =3D FLD_MOD(r, video_int->tm, 1, 0);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_WP_VIDEO_CFG, r);
>> +}
>> +
>> +static void hdmi_wp_video_config_timing(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_video_timing *timings)
>> +{
>> + =A0 =A0 =A0 u32 timing_h =3D 0;
>> + =A0 =A0 =A0 u32 timing_v =3D 0;
>> +
>> + =A0 =A0 =A0 DSSDBG("Enter hdmi_wp_video_config_timing\n");
>> +
>> + =A0 =A0 =A0 timing_h |=3D FLD_VAL(timings->hbp, 31, 20);
>> + =A0 =A0 =A0 timing_h |=3D FLD_VAL(timings->hfp, 19, 8);
>> + =A0 =A0 =A0 timing_h |=3D FLD_VAL(timings->hsw, 7, 0);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_WP_VIDEO_TIMING_H, timing_h);
>> +
>> + =A0 =A0 =A0 timing_v |=3D FLD_VAL(timings->vbp, 31, 20);
>> + =A0 =A0 =A0 timing_v |=3D FLD_VAL(timings->vfp, 19, 8);
>> + =A0 =A0 =A0 timing_v |=3D FLD_VAL(timings->vsw, 7, 0);
>> + =A0 =A0 =A0 hdmi_write_reg(HDMI_WP_VIDEO_TIMING_V, timing_v);
>> +}
>> +
>> +void hdmi_lib_enable(struct hdmi_config *cfg)
>> +{
>
> There is no library here.
>
>> + =A0 =A0 =A0 /* HDMI */
>> + =A0 =A0 =A0 struct hdmi_video_timing video_timing;
>> + =A0 =A0 =A0 struct hdmi_video_format video_format;
>> + =A0 =A0 =A0 struct hdmi_video_interface video_interface;
>> + =A0 =A0 =A0 /* HDMI core */
>> + =A0 =A0 =A0 struct hdmi_core_infoframe_avi avi_cfg;
>> + =A0 =A0 =A0 struct hdmi_core_video_config v_core_cfg;
>> + =A0 =A0 =A0 struct hdmi_core_packet_enable_repeat repeat_cfg;
>> +
>> + =A0 =A0 =A0 hdmi_wp_init(&video_timing, &video_format,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &video_interface);
>> +
>> + =A0 =A0 =A0 hdmi_core_init(&v_core_cfg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &avi_cfg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &repeat_cfg);
>> +
>> + =A0 =A0 =A0 /* init DSS register */
>> + =A0 =A0 =A0 hdmi_wp_video_init_format(&video_format,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &video_timing, cfg);
>> +
>> + =A0 =A0 =A0 hdmi_wp_video_config_timing(&video_timing);
>> +
>> + =A0 =A0 =A0 /* video config */
>> + =A0 =A0 =A0 video_format.packing_mode =3D HDMI_PACK_24b_RGB_YUV444=
_YUV422;
>> +
>> + =A0 =A0 =A0 hdmi_wp_video_config_format(&video_format);
>> +
>> + =A0 =A0 =A0 video_interface.vsp =3D cfg->v_pol;
>> + =A0 =A0 =A0 video_interface.hsp =3D cfg->h_pol;
>> + =A0 =A0 =A0 video_interface.interlacing =3D cfg->interlace;
>> + =A0 =A0 =A0 video_interface.tm =3D 1 ; /* HDMI_TIMING_MASTER_24BIT=
 */
>> +
>> + =A0 =A0 =A0 hdmi_wp_video_config_interface(&video_interface);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* configure core video part
>> + =A0 =A0 =A0 =A0* set software reset in the core
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 hdmi_core_swreset_assert();
>> +
>> + =A0 =A0 =A0 /* power down off */
>> + =A0 =A0 =A0 hdmi_core_powerdown_disable();
>> +
>> + =A0 =A0 =A0 v_core_cfg.pkt_mode =3D HDMI_PACKETMODE24BITPERPIXEL;
>> + =A0 =A0 =A0 v_core_cfg.hdmi_dvi =3D cfg->hdmi_dvi;
>> +
>> + =A0 =A0 =A0 hdmi_core_video_config(&v_core_cfg);
>> +
>> + =A0 =A0 =A0 /* release software reset in the core */
>> + =A0 =A0 =A0 hdmi_core_swreset_release();
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* configure packet
>> + =A0 =A0 =A0 =A0* info frame video see doc CEA861-D page 65
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 avi_cfg.db1_format =3D INFOFRAME_AVI_DB1Y_RGB;
>> + =A0 =A0 =A0 avi_cfg.db1_active_info =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INFOFRAME_AVI_DB1A_ACTIVE_FORMAT_OFF;
>> + =A0 =A0 =A0 avi_cfg.db1_bar_info_dv =3D INFOFRAME_AVI_DB1B_NO;
>> + =A0 =A0 =A0 avi_cfg.db1_scan_info =3D INFOFRAME_AVI_DB1S_0;
>> + =A0 =A0 =A0 avi_cfg.db2_colorimetry =3D INFOFRAME_AVI_DB2C_NO;
>> + =A0 =A0 =A0 avi_cfg.db2_aspect_ratio =3D INFOFRAME_AVI_DB2M_NO;
>> + =A0 =A0 =A0 avi_cfg.db2_active_fmt_ar =3D INFOFRAME_AVI_DB2R_SAME;
>> + =A0 =A0 =A0 avi_cfg.db3_itc =3D INFOFRAME_AVI_DB3ITC_NO;
>> + =A0 =A0 =A0 avi_cfg.db3_ec =3D INFOFRAME_AVI_DB3EC_XVYUV601;
>> + =A0 =A0 =A0 avi_cfg.db3_q_range =3D INFOFRAME_AVI_DB3Q_DEFAULT;
>> + =A0 =A0 =A0 avi_cfg.db3_nup_scaling =3D INFOFRAME_AVI_DB3SC_NO;
>> + =A0 =A0 =A0 avi_cfg.db4_videocode =3D cfg->video_format;
>> + =A0 =A0 =A0 avi_cfg.db5_pixel_repeat =3D INFOFRAME_AVI_DB5PR_NO;
>> + =A0 =A0 =A0 avi_cfg.db6_7_line_eoftop =3D 0;
>> + =A0 =A0 =A0 avi_cfg.db8_9_line_sofbottom =3D 0;
>> + =A0 =A0 =A0 avi_cfg.db10_11_pixel_eofleft =3D 0;
>> + =A0 =A0 =A0 avi_cfg.db12_13_pixel_sofright =3D 0;
>> +
>> + =A0 =A0 =A0 hdmi_core_aux_infoframe_avi_config(avi_cfg);
>> +
>> + =A0 =A0 =A0 /* enable/repeat the infoframe */
>> + =A0 =A0 =A0 repeat_cfg.avi_infoframe =3D PACKETENABLE;
>> + =A0 =A0 =A0 repeat_cfg.avi_infoframe_repeat =3D PACKETREPEATON;
>> +
>> + =A0 =A0 =A0 /* wakeup */
>> + =A0 =A0 =A0 repeat_cfg.audio_pkt =3D PACKETENABLE;
>> + =A0 =A0 =A0 repeat_cfg.audio_pkt_repeat =3D PACKETREPEATON;
>> + =A0 =A0 =A0 hdmi_core_av_packet_config(repeat_cfg);
>> +}
>> +
>> +static void update_hdmi_timings(struct hdmi_config *cfg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_video_timings *timings, in=
t code)
>> +{
>> + =A0 =A0 =A0 cfg->ppl =3D timings->x_res;
>> + =A0 =A0 =A0 cfg->lpp =3D timings->y_res;
>> + =A0 =A0 =A0 cfg->hbp =3D timings->hbp;
>> + =A0 =A0 =A0 cfg->hfp =3D timings->hfp;
>> + =A0 =A0 =A0 cfg->hsw =3D timings->hsw;
>> + =A0 =A0 =A0 cfg->vbp =3D timings->vbp;
>> + =A0 =A0 =A0 cfg->vfp =3D timings->vfp;
>> + =A0 =A0 =A0 cfg->vsw =3D timings->vsw;
>> + =A0 =A0 =A0 cfg->pixel_clock =3D timings->pixel_clock;
>> + =A0 =A0 =A0 cfg->v_pol =3D cea_vesa_timings[code].vsync_pol;
>> + =A0 =A0 =A0 cfg->h_pol =3D cea_vesa_timings[code].hsync_pol;
>> +}
>> +
>> +void hdmi_lib_exit(void)
>> +{
>> +
>> +}
>> +
>> +int hdmi_wait_softreset(void)
>> +{
>> + =A0 =A0 =A0 /* reset W1 */
>> + =A0 =A0 =A0 REG_FLD_MOD(HDMI_WP_SYSCONFIG, 0x1, 0, 0);
>> +
>> + =A0 =A0 =A0 /* wait till SOFTRESET =3D=3D 0 */
>> + =A0 =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_WP_SYSCONFIG, 0, 0, =
0) !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("sysconfig reset failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +void hdmi_compute_pll(unsigned long clkin, int phy,
>> + =A0 =A0 =A0 int n, struct hdmi_pll_info *pi)
>> +{
>> + =A0 =A0 =A0 unsigned long refclk;
>> + =A0 =A0 =A0 u32 mf;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Input clock is predivided by N + 1
>> + =A0 =A0 =A0 =A0* out put of which is reference clk
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 refclk =3D clkin / (n + 1);
>> + =A0 =A0 =A0 pi->regn =3D n;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* multiplier is pixel_clk/ref_clk
>> + =A0 =A0 =A0 =A0* Multiplying by 100 to avoid fractional part remov=
al
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 pi->regm =3D (phy * 100/(refclk))/100;
>> + =A0 =A0 =A0 pi->regm2 =3D 1;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* fractional multiplier is remainder of the differe=
nce between
>> + =A0 =A0 =A0 =A0* multiplier and actual phy(required pixel clock th=
us should be
>> + =A0 =A0 =A0 =A0* multiplied by 2^18(262144) divided by the referen=
ce clock
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 mf =3D (phy - pi->regm * refclk) * 262144;
>> + =A0 =A0 =A0 pi->regmf =3D mf/(refclk);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Dcofreq should be set to 1 if required pixel cloc=
k
>> + =A0 =A0 =A0 =A0* is greater than 1000MHz
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 pi->dcofreq =3D phy > 1000 * 100;
>> + =A0 =A0 =A0 pi->regsd =3D ((pi->regm * clkin / 10) / ((n + 1) * 25=
0) + 5) / 10;
>> +
>> + =A0 =A0 =A0 DSSDBG("M =3D %d Mf =3D %d\n", pi->regm, pi->regmf);
>> + =A0 =A0 =A0 DSSDBG("range =3D %d sd =3D %d\n", pi->dcofreq, pi->re=
gsd);
>> +}
>> +
>> +static void hdmi_enable_clocks(int enable)
>> +{
>> + =A0 =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dss_clk_enable(DSS_CLK_ICK | DSS_CLK_F=
CK |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSS_CL=
K_SYSCK | DSS_CLK_VIDFCK);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dss_clk_disable(DSS_CLK_ICK | DSS_CLK_=
=46CK |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSS_CL=
K_SYSCK | DSS_CLK_VIDFCK);
>> +}
>> +
>> +static int hdmi_power_on(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 =A0 int r, code =3D 0;
>> + =A0 =A0 =A0 struct hdmi_pll_info pll_data;
>> + =A0 =A0 =A0 struct omap_video_timings *p;
>> + =A0 =A0 =A0 int clkin, n, phy;
>> +
>> + =A0 =A0 =A0 hdmi_enable_clocks(1);
>> +
>> + =A0 =A0 =A0 dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 0);
>> +
>> + =A0 =A0 =A0 p =3D &dssdev->panel.timings;
>> +
>> + =A0 =A0 =A0 DSSDBG("hdmi_power_on x_res=3D %d y_res =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dssdev->panel.timings.x_res,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dssdev->panel.timings.y_res);
>> +
>> + =A0 =A0 =A0 DSSDBG("Read EDID as no EDID is not set on poweron\n")=
;
>> + =A0 =A0 =A0 r =3D hdmi_read_edid(p);
>> + =A0 =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> +
>> + =A0 =A0 =A0 code =3D get_timings_index();
>> + =A0 =A0 =A0 dssdev->panel.timings =3D cea_vesa_timings[code].timin=
gs;
>> + =A0 =A0 =A0 update_hdmi_timings(&hdmi.cfg, p, code);
>> +
>> + =A0 =A0 =A0 clkin =3D 3840; /* 38.4 MHz */
>> + =A0 =A0 =A0 n =3D 15; /* this is a constant for our math */
>> + =A0 =A0 =A0 phy =3D p->pixel_clock;
>> +
>> + =A0 =A0 =A0 hdmi_compute_pll(clkin, phy, n, &pll_data);
>> +
>> + =A0 =A0 =A0 hdmi_wp_video_stop();
>> +
>> + =A0 =A0 =A0 /* config the PLL and PHY first */
>> + =A0 =A0 =A0 r =3D hdmi_pll_program(&pll_data);
>> + =A0 =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("Failed to lock PLL\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 r =3D hdmi_phy_init();
>> + =A0 =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("Failed to start PHY\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 hdmi.cfg.hdmi_dvi =3D hdmi.mode;
>> + =A0 =A0 =A0 hdmi.cfg.video_format =3D hdmi.code;
>> + =A0 =A0 =A0 hdmi_lib_enable(&hdmi.cfg);
>> +
>> + =A0 =A0 =A0 /* these settings are independent of overlays */
>> + =A0 =A0 =A0 dss_select_hdmi_venc(1);
>> +
>> + =A0 =A0 =A0 /* bypass TV gamma table */
>> + =A0 =A0 =A0 dispc_enable_gamma_table(0);
>> +
>> + =A0 =A0 =A0 /* tv size */
>> + =A0 =A0 =A0 dispc_set_digit_size(dssdev->panel.timings.x_res,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dssdev->panel.timings.=
y_res);
>> +
>> + =A0 =A0 =A0 dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 1);
>> +
>> + =A0 =A0 =A0 hdmi_wp_video_start();
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static void hdmi_power_off(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 =A0 dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 0);
>> +
>> + =A0 =A0 =A0 hdmi_wp_video_stop();
>> + =A0 =A0 =A0 hdmi_phy_off();
>> + =A0 =A0 =A0 hdmi_wait_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
>> + =A0 =A0 =A0 hdmi_enable_clocks(0);
>> +
>> + =A0 =A0 =A0 edid_set =3D 0;
>> +}
>> +
>> +int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 =A0 int r =3D 0;
>> +
>> + =A0 =A0 =A0 DSSDBG("ENTER hdmi_display_enable\n");
>> +
>> + =A0 =A0 =A0 mutex_lock(&hdmi.lock);
>> +
>> + =A0 =A0 =A0 r =3D omap_dss_start_device(dssdev);
>> + =A0 =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("failed to start device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (dssdev->platform_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dssdev->platform_enable(dssdev);
>> +
>> + =A0 =A0 =A0 r =3D hdmi_power_on(dssdev);
>> + =A0 =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("failed to power on device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 =A0 }
>> +
>> +err:
>> + =A0 =A0 =A0 mutex_unlock(&hdmi.lock);
>
> The error handling here needs to handle omap_dss_start_device and
> platform_enable.
ok.
>
>> +
>> + =A0 =A0 =A0 return r;
>> +}
>> +
>> +void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 =A0 DSSDBG("Enter hdmi_display_disable\n");
>> +
>> + =A0 =A0 =A0 mutex_lock(&hdmi.lock);
>> +
>> + =A0 =A0 =A0 omap_dss_stop_device(dssdev);
>> +
>> + =A0 =A0 =A0 if (dssdev->platform_disable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dssdev->platform_disable(dssdev);
>> +
>> + =A0 =A0 =A0 hdmi_power_off(dssdev);
>> +
>
> You should do the disabling in reverse order compared to enabling.
>
>> + =A0 =A0 =A0 mutex_unlock(&hdmi.lock);
>> +}
>> +
>> +int omapdss_hdmi_display_suspend(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 =A0 DSSDBG("hdmi_display_suspend\n");
>> +
>> + =A0 =A0 =A0 mutex_lock(&hdmi.lock);
>> +
>> + =A0 =A0 =A0 omap_dss_stop_device(dssdev);
>> +
>> + =A0 =A0 =A0 hdmi_power_off(dssdev);
>> +
>> + =A0 =A0 =A0 mutex_unlock(&hdmi.lock);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>
> The code in suspend and resume do not match. And what is the need for
> suspend and resume? They are the same as disable and enable.
>
sorry i was carried over by calling corresponding function from panel
driver ,I could reuse
enable and disable functions in hdmi.c for suspend and resume.

> =A0Tomi
>
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
