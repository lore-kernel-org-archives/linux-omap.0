From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass base_address
Date: Thu, 23 Jun 2011 11:21:04 +0530
Message-ID: <BANLkTin6ZShO-fmcA-FOm5f+XdhnR3iLDA@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D625B05@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33603 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751582Ab1FWFvk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 01:51:40 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so1063688fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 22:51:38 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D625B05@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Sanjeev,

On Mon, Jun 20, 2011 at 7:03 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of K, Mythri P
>> Sent: Friday, June 17, 2011 1:47 PM
>> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
>> Cc: K, Mythri P
>> Subject: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass
>> base_address
>
> [sp] HDMI appears twice on the subject. One of these can be removed.
> =A0 =A0 Also, it isn't clear (though implied) whose base address is b=
eing
> =A0 =A0 passed.
>
> =A0 =A0 The changes in the patch aren't limited to DSS alone.
> =A0 =A0 See updated to hdmi_core_audio_config(), hdmi_wp_audio_config=
_format(),
> =A0 =A0 hdmi_wp_audio_config_dma(), etc.
>
The changes are related to the HDMI driver which as of this patch is
in DSS. You see any concerns ? It is only later that those functions
are moved out .

>>
>> As the base_address of the HDMI might differ across SoC's,
>
> [sp] Is 'base_address' a variable? OR did you mean 'base address'?
>
>> offset of the HDMI
>> logical blocks and base address got from the platform data are passe=
d
>> dynamically to the functions that modify HDMI IP registers.
>
> [sp] Overall, the sentence can be simplified.
>
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/hdmi.c | =A0518
>> ++++++++++++++++++++++++----------------
>> =A0drivers/video/omap2/dss/hdmi.h | =A0292 +++++++++++------------
>> =A02 files changed, 452 insertions(+), 358 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c
>> b/drivers/video/omap2/dss/hdmi.c
>> index 5e5b98b..1d16ee2 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -43,11 +43,17 @@
>> =A0#include "hdmi.h"
>> =A0#include "dss_features.h"
>>
>> +#define HDMI_WP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0
>> +#define HDMI_CORE_SYS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x400
>> +#define HDMI_CORE_AV =A0 =A0 =A0 =A0 0x900
>> +#define HDMI_PLLCTRL =A0 =A0 =A0 =A0 0x200
>> +#define HDMI_PHY =A0 =A0 =A0 =A0 =A0 =A0 0x300
>> +
>> =A0static struct {
>> =A0 =A0 =A0 struct mutex lock;
>> =A0 =A0 =A0 struct omap_display_platform_data *pdata;
>> =A0 =A0 =A0 struct platform_device *pdev;
>> - =A0 =A0 void __iomem *base_wp; =A0/* HDMI wrapper */
>> + =A0 =A0 struct hdmi_ip_data hdmi_data;
>> =A0 =A0 =A0 int code;
>> =A0 =A0 =A0 int mode;
>> =A0 =A0 =A0 u8 edid[HDMI_EDID_MAX_LENGTH];
>> @@ -146,21 +152,51 @@ static const int code_vesa[85] =3D {
>>
>> =A0static const u8 edid_header[8] =3D {0x0, 0xff, 0xff, 0xff,
>> 0xff, 0xff, 0xff, 0x0};
>>
>> -static inline void hdmi_write_reg(const struct hdmi_reg idx, u32 va=
l)
>> +static inline void hdmi_write_reg(void __iomem *base_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const stru=
ct hdmi_reg idx, u32 val)
>> +{
>> + =A0 =A0 __raw_writel(val, base_addr + idx.idx);
>> +}
>> +
>> +static inline u32 hdmi_read_reg(void __iomem *base_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const stru=
ct hdmi_reg idx)
>> +{
>> + =A0 =A0 return __raw_readl(base_addr + idx.idx);
>> +}
>> +
>> +static inline void __iomem *hdmi_wp_base(struct hdmi_ip_data
>> *ip_data)
>> +{
>> + =A0 =A0 return (void __iomem *) (ip_data->base_wp);
>> +}
>> +
>> +static inline void __iomem *hdmi_phy_base(struct
>> hdmi_ip_data *ip_data)
>> =A0{
>> - =A0 =A0 __raw_writel(val, hdmi.base_wp + idx.idx);
>> + =A0 =A0 return (void __iomem *) (ip_data->base_wp +
>> ip_data->hdmi_phy_offset);
>> =A0}
>>
>> -static inline u32 hdmi_read_reg(const struct hdmi_reg idx)
>> +static inline void __iomem *hdmi_pll_base(struct
>> hdmi_ip_data *ip_data)
>> =A0{
>> - =A0 =A0 return __raw_readl(hdmi.base_wp + idx.idx);
>> + =A0 =A0 return (void __iomem *) (ip_data->base_wp +
>> ip_data->hdmi_pll_offset);
>> =A0}
>>
>> -static inline int hdmi_wait_for_bit_change(const struct hdmi_reg id=
x,
>> +static inline void __iomem *hdmi_av_base(struct hdmi_ip_data
>> *ip_data)
>> +{
>> + =A0 =A0 return (void __iomem *)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ip_data->base_wp +
>> ip_data->hdmi_core_av_offset);
>> +}
>> +
>> +static inline void __iomem *hdmi_core_sys_base(struct
>> hdmi_ip_data *ip_data)
>> +{
>> + =A0 =A0 return (void __iomem *)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ip_data->base_wp +
>> ip_data->hdmi_core_sys_offset);
>> +}
>> +
>> +static inline int hdmi_wait_for_bit_change(void __iomem *base_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const stru=
ct hdmi_reg idx,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int b2, =
int b1, u32 val)
>> =A0{
>> =A0 =A0 =A0 u32 t =3D 0;
>> - =A0 =A0 while (val !=3D REG_GET(idx, b2, b1)) {
>> + =A0 =A0 while (val !=3D REG_GET(base_addr, idx, b2, b1)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t++ > 10000)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !val;
>> @@ -225,21 +261,22 @@ int hdmi_init_display(struct
>> omap_dss_device *dssdev)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static int hdmi_pll_init(enum hdmi_clk_refsel refsel, int dcofreq,
>> +static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 enum hdmi_clk_refsel refsel, int dcofreq,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_pll_info *fmt, u16 sd)
>> =A0{
>> =A0 =A0 =A0 u32 r;
>>
>> =A0 =A0 =A0 /* PLL start always use manual mode */
>> - =A0 =A0 REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
>> + =A0 =A0 REG_FLD_MOD(hdmi_pll_base(ip_data),
>> PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
>>
>> - =A0 =A0 r =3D hdmi_read_reg(PLLCTRL_CFG1);
>> + =A0 =A0 r =3D hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1);
>> =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM */
>> =A0 =A0 =A0 r =3D FLD_MOD(r, fmt->regn, 8, 1); =A0/* CFG1_PLL_REGN *=
/
>>
>> - =A0 =A0 hdmi_write_reg(PLLCTRL_CFG1, r);
>> + =A0 =A0 hdmi_write_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1, r);
>
> [sp] hdmi_pll_base(ip_data) is used at many places withing this
> =A0 =A0 function. Have you checked if saving the result in a local
> =A0 =A0 variable generates any better code than repetitive ADD operat=
ion
> =A0 =A0 in the function.
>
> =A0 =A0 Same comment applies to similar use in other functions
> =A0 =A0 modified in this patch.
>
I had this comment from Tomi as well , Yes in some places it makes
sense to have a local variable to save , but then in certain functions
where there are four writes with 3 different base address it doesn't
make sense to add 3 variables.
> [snip]...[snip]
>
>> -static int hdmi_core_ddc_edid(u8 *pedid, int ext)
>> +static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 u8 *pedid, int ext)
>> =A0{
>> =A0 =A0 =A0 u32 i, j;
>> =A0 =A0 =A0 char checksum =3D 0;
>> =A0 =A0 =A0 u32 offset =3D 0;
>>
>> =A0 =A0 =A0 /* Turn on CLK for DDC */
>> - =A0 =A0 REG_FLD_MOD(HDMI_CORE_AV_DPD, 0x7, 2, 0);
>> + =A0 =A0 REG_FLD_MOD(hdmi_av_base(ip_data), HDMI_CORE_AV_DPD, 0x7, =
2, 0);
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* SW HACK : Without the Delay DDC(i2c bus) reads 0 va=
lues /
>> @@ -416,21 +462,23 @@ static int hdmi_core_ddc_edid(u8
>> *pedid, int ext)
>>
>> =A0 =A0 =A0 if (!ext) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Clk SCL Devices */
>> - =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0xA, 3, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(hdmi_core_sys_base(ip_data),
>> +
>> HDMI_CORE_DDC_CMD, 0xA, 3, 0);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI_CORE_DDC_STATUS_IN_PROG */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (hdmi_wait_for_bit_change(HDMI_CORE_DDC=
_STATUS,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 4, 4, 0) !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if
>> (hdmi_wait_for_bit_change(hdmi_core_sys_base(ip_data),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 HDMI_CORE_DDC_STATUS,
>> 4, 4, 0) !=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to progra=
m DDC\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Clear FIFO */
>> - =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(hdmi_core_sys_base(ip_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ,
>> HDMI_CORE_DDC_CMD, 0x9, 3, 0);
>
> [sp] Misplaced "," at beginning of the line.
>
Not a part of the patch i suppose?
> [snip]...[snip]
>
>> =A0static void update_hdmi_timings(struct hdmi_config *cfg,
>> @@ -1166,16 +1231,16 @@ static int hdmi_power_on(struct
>> omap_dss_device *dssdev)
>>
>> =A0 =A0 =A0 hdmi_compute_pll(dssdev, phy, &pll_data);
>>
>> - =A0 =A0 hdmi_wp_video_start(0);
>> + =A0 =A0 hdmi_wp_video_start(&hdmi.hdmi_data, 0);
>>
>> - =A0 =A0 /* config the PLL and PHY first */
>> - =A0 =A0 r =3D hdmi_pll_program(&pll_data);
>> + =A0 =A0 /* config the PLL and PHY hdmi_set_pll_pwrfirst */
>
> [sp] Is the change in comment intended?
I shall remove this as it is unrelated to the patch
>
> [snip]...[snip]
>
> ~sanjeev
>



--=20
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
