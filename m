From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v3 2/3] OMAP4: hwmod data: add DSS DISPC DSI1,2 RFBI HDMI VENC
Date: Tue, 15 Feb 2011 00:22:07 +0530
Message-ID: <AANLkTi=T58ZnUgo4FuVpueGDXC=7gcxqbY88vOrm4FrU@mail.gmail.com>
References: <1296127024-17507-1-git-send-email-sumit.semwal@ti.com>
 <1296127024-17507-3-git-send-email-sumit.semwal@ti.com> <4D5568BE.5060300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:59295 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751064Ab1BNSw3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 13:52:29 -0500
Received: by mail-gx0-f181.google.com with SMTP id 10so2654824gxk.26
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 10:52:28 -0800 (PST)
In-Reply-To: <4D5568BE.5060300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Janorkar, Mayuresh" <mayur@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

Hi Benoit,

On Fri, Feb 11, 2011 at 10:20 PM, Cousson, Benoit <b-cousson@ti.com> wr=
ote:
> Hi Sumit,
>
> While I was trying to merge that patch for 2.6.39, I found some chang=
es that
> I didn't expected. I will take care of cleaning this patch, but I'd t=
o get
> the rational first.
> All the other comments are purely cosmetic.
>
> On 1/27/2011 12:17 PM, Semwal, Sumit wrote:
>>
>> From: Benoit Cousson<b-cousson@ti.com>
>>
>> Add dss, dispc, dsi1, dsi2, hdmi, rfbi and venc hwmods.
>> In OMAP4 there are severals IPs that can be reached by differents
>> interconnect paths depending of the access initiator (MPU vs. SDMA).
>> In the case of the DSS, both L3 direct path and L4 CFG path can be
>> used to access all the DSS IPs. The two ocp_ip already exists to sup=
port
>> the two address spaces.
>>
>> =A0 =A0 =A0 +------------+-- L3_MAIN --+ MPU
>> =A0 IP =A0| =A0 =A0 =A0 =A0 =A0 =A0|
>> =A0 =A0 =A0 +-- L4_CFG --+
>>
>> L3 main address range is specified first, since it is used by defaul=
t.
>> dss is also considered as an IP as dispc, rfbi, and named as dss_cor=
e.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Mayuresh Janorkar<mayur@ti.com>
>> Signed-off-by: Senthilvadivu Guruswamy<svadivu@ti.com>
>> Signed-off-by: Sumit Semwal<sumit.semwal@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0603
>> ++++++++++++++++++++++++++++
>> =A01 files changed, 603 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index c2806bd..0bd579e 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -43,6 +43,13 @@
>> =A0static struct omap_hwmod omap44xx_dma_system_hwmod;
>> =A0static struct omap_hwmod omap44xx_dmm_hwmod;
>> =A0static struct omap_hwmod omap44xx_dsp_hwmod;
>> +static struct omap_hwmod omap44xx_dss_core_hwmod;
>> +static struct omap_hwmod omap44xx_dss_dispc_hwmod;
>> +static struct omap_hwmod omap44xx_dss_dsi1_hwmod;
>> +static struct omap_hwmod omap44xx_dss_dsi2_hwmod;
>> +static struct omap_hwmod omap44xx_dss_hdmi_hwmod;
>> +static struct omap_hwmod omap44xx_dss_rfbi_hwmod;
>> +static struct omap_hwmod omap44xx_dss_venc_hwmod;
>> =A0static struct omap_hwmod omap44xx_emif_fw_hwmod;
>> =A0static struct omap_hwmod omap44xx_iva_hwmod;
>> =A0static struct omap_hwmod omap44xx_l3_instr_hwmod;
>> @@ -237,12 +244,21 @@ static struct omap_hwmod_ocp_if
>> omap44xx_mpu__l3_main_1 =3D {
>> =A0 =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USE=
R_SDMA,
>> =A0};
>>
>> +/* dss -> =A0l3_main_1 */
>> +static struct omap_hwmod_ocp_if omap44xx_dss__l3_main_1 =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_dss_core_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_l3_main_1_hwmod=
,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
>> +};
>> +
>> =A0/* l3_main_1 slave ports */
>> =A0static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] =3D =
{
>> =A0 =A0 =A0 =A0 &omap44xx_dsp__l3_main_1,
>> =A0 =A0 =A0 =A0 &omap44xx_l3_main_2__l3_main_1,
>> =A0 =A0 =A0 =A0 &omap44xx_l4_cfg__l3_main_1,
>> =A0 =A0 =A0 =A0 &omap44xx_mpu__l3_main_1,
>> +&omap44xx_dss__l3_main_1,
>> =A0};
>>
>> =A0static struct omap_hwmod omap44xx_l3_main_1_hwmod =3D {
>> @@ -746,6 +762,584 @@ static struct omap_hwmod omap44xx_dsp_hwmod =3D=
 {
>> =A0 =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMA=
P4430),
>> =A0};
>>
>> +/* =3D=3D=3D=3D DSS related classes =3D=3D=3D=3D */
>
> That line should not be removed.
>
>> + /*
>> + * 'dispc' class
>> + * display controller
>> + */
>> +
>> +static struct omap_hwmod_class_sysconfig omap44xx_dispc_sysc =3D {
>> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_=
CLOCKACTIVITY |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_ENAWAK=
EUP | SYSC_HAS_MIDLEMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_SIDLEM=
ODE | SYSC_HAS_SOFTRESET |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSS_HAS_RESET_=
STATUS),
>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SI=
DLE_SMART |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORCE =
| MSTANDBY_NO | MSTANDBY_SMART),
>> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D&omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap44xx_dispc_hwmod_class =3D {
>> + =A0 =A0 =A0 .name =3D "dispc",
>> + =A0 =A0 =A0 .sysc =3D&omap44xx_dispc_sysc,
>> +};
>> +
>> +/* dss_dispc */
>> +static struct omap_hwmod_irq_info omap44xx_dss_dispc_irqs[] =3D {
>> + =A0 =A0 =A0 { .irq =3D 25 + OMAP44XX_IRQ_GIC_START },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap44xx_dss_dispc_sdma_reqs[] =3D=
 {
>> + =A0 =A0 =A0 { .dma_req =3D 5 + OMAP44XX_DMA_REQ_START },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_dispc_addrs[] =3D =
{
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48041000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48041fff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> =A0dss_dispc */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dispc =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_per_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_dispc_hwmod=
,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_dispc_addrs=
,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_disp=
c_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_dispc_dma_addrs[] =
=3D {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x58001000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x58001fff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>
> The L3 mapping should be before the L4 one. This is the same for the =
other
> hwmods. Please note that this is just to be in sync with the generate=
d code,
> it does not have any impact on the functionality.
>
>> +
>> +/* l3_main_2 -> =A0dss_dispc */
>> +static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dispc =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l3_main_2_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_dispc_hwmod=
,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_dispc_dma_a=
ddrs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_disp=
c_dma_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_SDMA,
>> +};
>> +
>> +/* dss_dispc slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] =3D {
>> +&omap44xx_l3_main_2__dss_dispc,
>> +&omap44xx_l4_per__dss_dispc,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_dss_dispc_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dss_dispc",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dispc_hwmod_cla=
ss,
>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_dss_dispc_irqs,
>> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_dss_dispc_ir=
qs),
>> + =A0 =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap44xx_dss_dispc_sdma_reqs=
,
>> + =A0 =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap44xx_dss_dispc_sd=
ma_reqs),
>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "dss_fck",
>> + =A0 =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4=
430_CM_DSS_DSS_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_dss_dispc_slaves,
>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_dispc_=
slaves),
>> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4=
430),
>> +};
>> +
>> +/*
>> + * 'dsi' class
>> + * display serial interface controller
>> + */
>> +static struct omap_hwmod_class_sysconfig omap44xx_dsi_sysc =3D {
>> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_=
CLOCKACTIVITY |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_ENAWAK=
EUP | SYSC_HAS_SIDLEMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_SOFTRE=
SET | SYSS_HAS_RESET_STATUS),
>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SI=
DLE_SMART),
>> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D&omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap44xx_dsi_hwmod_class =3D {
>> + =A0 =A0 =A0 .name =3D "dsi",
>> + =A0 =A0 =A0 .sysc =3D&omap44xx_dsi_sysc,
>> +};
>> +
>> +/* dss_dsi1 */
>> +static struct omap_hwmod_irq_info omap44xx_dss_dsi1_irqs[] =3D {
>> + =A0 =A0 =A0 { .irq =3D 53 + OMAP44XX_IRQ_GIC_START },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap44xx_dss_dsi1_sdma_reqs[] =3D=
 {
>> + =A0 =A0 =A0 { .dma_req =3D 74 + OMAP44XX_DMA_REQ_START },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_dsi1_addrs[] =3D {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48044000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480440ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> =A0dss_dsi1 */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi1 =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_per_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_dsi1_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_dsi1_addrs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_dsi1=
_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_dsi1_dma_addrs[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x58004000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x580040ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l3_main_2 -> =A0dss_dsi1 */
>> +static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi1 =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l3_main_2_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_dsi1_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_dsi1_dma_ad=
drs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_dsi1=
_dma_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_SDMA,
>> +};
>> +
>> +/* dss_dsi1 slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_dss_dsi1_slaves[] =3D {
>> +&omap44xx_l3_main_2__dss_dsi1,
>> +&omap44xx_l4_per__dss_dsi1,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_dss_dsi1_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dss_dsi1",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dsi_hwmod_class=
,
>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_dss_dsi1_irqs,
>> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_dss_dsi1_irq=
s),
>> + =A0 =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap44xx_dss_dsi1_sdma_reqs,
>> + =A0 =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap44xx_dss_dsi1_sdm=
a_reqs),
>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "dss_fck",
>> + =A0 =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4=
430_CM_DSS_DSS_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_dss_dsi1_slaves,
>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_dsi1_s=
laves),
>> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4=
430),
>> +};
>> +
>> +/* dss_dsi2 */
>> +static struct omap_hwmod_irq_info omap44xx_dss_dsi2_irqs[] =3D {
>> + =A0 =A0 =A0 { .irq =3D 84 + OMAP44XX_IRQ_GIC_START },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap44xx_dss_dsi2_sdma_reqs[] =3D=
 {
>> + =A0 =A0 =A0 { .dma_req =3D 83 + OMAP44XX_DMA_REQ_START },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_dsi2_addrs[] =3D {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48045000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480450ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> =A0dss_dsi2 */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi2 =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_per_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_dsi2_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_dsi2_addrs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_dsi2=
_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_dsi2_dma_addrs[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x58005000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x580050ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l3_main_2 -> =A0dss_dsi2 */
>> +static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l3_main_2_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_dsi2_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_dsi2_dma_ad=
drs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_dsi2=
_dma_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_SDMA,
>> +};
>> +
>> +/* dss_dsi2 slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_dss_dsi2_slaves[] =3D {
>> +&omap44xx_l3_main_2__dss_dsi2,
>> +&omap44xx_l4_per__dss_dsi2,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_dss_dsi2_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dss_dsi2",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dsi_hwmod_class=
,
>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_dss_dsi2_irqs,
>> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_dss_dsi2_irq=
s),
>> + =A0 =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap44xx_dss_dsi2_sdma_reqs,
>> + =A0 =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap44xx_dss_dsi2_sdm=
a_reqs),
>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "dss_fck",
>> + =A0 =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4=
430_CM_DSS_DSS_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_dss_dsi2_slaves,
>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_dsi2_s=
laves),
>> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4=
430),
>> +};
>> +
>> +/*
>> + * 'dss' class
>> + * display sub-system
>> + */
>> +static struct omap_hwmod_class_sysconfig omap44xx_dss_sysc =3D {
>> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D SYSS_HAS_RESET_STATUS,
>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SI=
DLE_SMART),
>
> There is a read-only SYSCONFIG in DSS, so it is not usable at all to =
change
> the idlemode.
> The attribute should be empty.
>
>> +};
>> +
>> +static struct omap_hwmod_class omap44xx_dss_hwmod_class =3D {
>> + =A0 =A0 =A0 .name =3D "dss",
>> + =A0 =A0 =A0 .sysc =3D&omap44xx_dss_sysc,
>> +};
>> +
>> +/* dss */
>> +/* dss master ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_dss_masters[] =3D {
>> +&omap44xx_dss__l3_main_1,
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap44xx_dss_irqs[] =3D {
>> + =A0 =A0 =A0 { .irq =3D 25 + OMAP44XX_IRQ_GIC_START },
>
> Why did you map that irq to the dss_core? It is already mapped to dis=
pc.
I didn't change this portion, so I guess it must've gotten mixed up
when Senthil merged. But I should've re-validated - will take care in
future.
>
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_addrs[] =3D {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48040000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4804007f=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> =A0dss */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__dss =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_per_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_core_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_addrs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_addr=
s),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_dma_addrs[] =3D {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x58000000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x5800007f=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l3_main_2 -> =A0dss */
>> +static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l3_main_2_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_core_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_dma_addrs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_dma_=
addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_SDMA,
>> +};
>> +
>> +/* dss slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_dss_slaves[] =3D {
>> +&omap44xx_l3_main_2__dss,
>> +&omap44xx_l4_per__dss,
>> +};
>> +
>> +static struct omap_hwmod_opt_clk dss_opt_clks[] =3D {
>> + =A0 =A0 =A0 { .role =3D "sys_clk", .clk =3D "dss_sys_clk" },
>> + =A0 =A0 =A0 { .role =3D "tv_clk", .clk =3D "dss_tv_clk" },
>> + =A0 =A0 =A0 { .role =3D "dss_clk", .clk =3D "dss_dss_clk" },
>> + =A0 =A0 =A0 { .role =3D "video_clk", .clk =3D "dss_48mhz_clk" },
>> +};
>> +
>> +static struct omap_hwmod omap44xx_dss_core_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dss_core",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_hwmod_class=
,
>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_dss_irqs,
>> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_dss_irqs),
>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "dss_fck",
>> + =A0 =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4=
430_CM_DSS_DSS_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .opt_clks =A0 =A0 =A0 =3D dss_opt_clks,
>> + =A0 =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(dss_opt_clks),
>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_dss_slaves,
>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_slaves=
),
>> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_dss_masters,
>> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_dss_master=
s),
>> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4=
430),
>> +};
>> +
>> +/*
>> + * 'hdmi' class
>> + * hdmi controller
>> + */
>> +
>> +static struct omap_hwmod_class omap44xx_hdmi_hwmod_class =3D {
>> + =A0 =A0 =A0 .name =3D "hdmi",
>
> The sysconfig is missing for the hdmi.
Inadvertent miss. Missed in consolidation I guess; my apologies.
>
>> +};
>> +
>> +/* dss_hdmi */
>> +static struct omap_hwmod_irq_info omap44xx_dss_hdmi_irqs[] =3D {
>> + =A0 =A0 =A0 { .irq =3D 101 + OMAP44XX_IRQ_GIC_START },
>> +};
>> +
>> +static struct omap_hwmod_dma_info omap44xx_dss_hdmi_sdma_reqs[] =3D=
 {
>> + =A0 =A0 =A0 { .dma_req =3D 75 + OMAP44XX_DMA_REQ_START },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_hdmi_addrs[] =3D {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48046000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48046fff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> =A0dss_hdmi */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_hdmi =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_per_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_hdmi_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_hdmi_addrs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_hdmi=
_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_hdmi_dma_addrs[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x58006000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x58006fff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l3_main_2 -> =A0dss_hdmi */
>> +static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l3_main_2_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_hdmi_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_hdmi_dma_ad=
drs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_hdmi=
_dma_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_SDMA,
>> +};
>> +
>> +/* dss_hdmi slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_dss_hdmi_slaves[] =3D {
>> +&omap44xx_l3_main_2__dss_hdmi,
>> +&omap44xx_l4_per__dss_hdmi,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_dss_hdmi_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dss_hdmi",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_hdmi_hwmod_clas=
s,
>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_dss_hdmi_irqs,
>> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_dss_hdmi_irq=
s),
>> + =A0 =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap44xx_dss_hdmi_sdma_reqs,
>> + =A0 =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap44xx_dss_hdmi_sdm=
a_reqs),
>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "dss_fck",
>> + =A0 =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4=
430_CM_DSS_DSS_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_dss_hdmi_slaves,
>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_hdmi_s=
laves),
>> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4=
430),
>> +};
>> +
>> + /*
>> + * 'rfbi' class
>> + * remote frame buffer interface
>> + */
>> +
>> +static struct omap_hwmod_class_sysconfig omap44xx_rfbi_sysc =3D {
>
> The name should be dss_rfbi.
>
>> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_=
SIDLEMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_SOFTRE=
SET | SYSS_HAS_RESET_STATUS),
>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SI=
DLE_SMART),
>> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D&omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap44xx_rfbi_hwmod_class =3D {
>> + =A0 =A0 =A0 .name =3D "rfbi",
>> + =A0 =A0 =A0 .sysc =3D&omap44xx_rfbi_sysc,
>> +};
>> +
>> +/* dss_rfbi */
>> +static struct omap_hwmod_dma_info omap44xx_dss_rfbi_sdma_reqs[] =3D=
 {
>> + =A0 =A0 =A0 { .dma_req =3D 13 + OMAP44XX_DMA_REQ_START },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_rfbi_addrs[] =3D {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48042000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480420ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> =A0dss_rfbi */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_rfbi =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_per_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_rfbi_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_rfbi_addrs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_rfbi=
_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_rfbi_dma_addrs[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x58002000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x580020ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l3_main_2 -> =A0dss_rfbi */
>> +static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_rfbi =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l3_main_2_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_rfbi_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_rfbi_dma_ad=
drs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_rfbi=
_dma_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_SDMA,
>> +};
>> +
>> +/* dss_rfbi slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_dss_rfbi_slaves[] =3D {
>> +&omap44xx_l3_main_2__dss_rfbi,
>> +&omap44xx_l4_per__dss_rfbi,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_dss_rfbi_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dss_rfbi",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_rfbi_hwmod_clas=
s,
>> + =A0 =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D omap44xx_dss_rfbi_sdma_reqs,
>> + =A0 =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(omap44xx_dss_rfbi_sdm=
a_reqs),
>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "dss_fck",
>> + =A0 =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4=
430_CM_DSS_DSS_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_dss_rfbi_slaves,
>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_rfbi_s=
laves),
>> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4=
430),
>> +};
>> +
>> +/*
>> + * 'venc' class
>> + * video encoder
>> + */
>> +
>> +static struct omap_hwmod_class_sysconfig omap44xx_venc_sysc =3D {
>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SI=
DLE_SMART),
>> +};
>
> There is no sysconfig at all in the VENC module, so this structure sh=
ould
> not be there at all.
Yes, you're right.
>
>> +
>> +static struct omap_hwmod_class omap44xx_venc_hwmod_class =3D {
>> + =A0 =A0 =A0 .name =3D "venc",
>> + =A0 =A0 =A0 .sysc =3D&omap44xx_venc_sysc,
>> +};
>> +
>> +/* dss_venc */
>> +static struct omap_hwmod_addr_space omap44xx_dss_venc_addrs[] =3D {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48043000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480430ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l4_per -> =A0dss_venc */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_per_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_venc_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_venc_addrs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_venc=
_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_dss_venc_dma_addrs[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x58003000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x580030ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l3_main_2 -> =A0dss_venc */
>> +static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_venc =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l3_main_2_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_dss_venc_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_dss_venc_dma_ad=
drs,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_dss_venc=
_dma_addrs),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_SDMA,
>> +};
>> +
>> +/* dss_venc slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_dss_venc_slaves[] =3D {
>> +&omap44xx_l3_main_2__dss_venc,
>> +&omap44xx_l4_per__dss_venc,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_dss_venc_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dss_venc",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_venc_hwmod_clas=
s,
>
> Why don't you have any main_clk entry for venc, whereas all the other=
 dss
> submodules does have:
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "dss_fck",
This must be a miss; the other main_clk were also added / consolidated
into this one patch, so I think it got missed during that.
>
>
> Regards,
> Benoit
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
