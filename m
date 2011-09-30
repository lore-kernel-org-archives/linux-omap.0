From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v12] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Fri, 30 Sep 2011 16:02:06 +0530
Message-ID: <CAP05o4LJ2P8DCri1Vf-opezP8eNX+Wghm9FBSYwy8Vrct8_YDw@mail.gmail.com>
References: <1317361216-28248-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109300107150.32653@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1109300107150.32653@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 30, 2011 at 12:42 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> a few comments
>
> On Fri, 30 Sep 2011, Keshava Munegowda wrote:
>
>> Following 2 hwmod structures are added
>> =A0 =A0 1. usb_host_hs
>> =A0 =A0 =A0 =A0 =A0The hwmod of usbhs with uhh, ehci and ohci base a=
ddresses
>> =A0 =A0 =A0 =A0 =A0functional clock and ehci, ohci irqs
>>
>> =A0 =A0 2. usb_tll_hs
>> =A0 =A0 =A0 =A0 =A0 hwmod of usbhs with the TLL base address and irq=
=2E
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> Reviewed-by: Partha Basak <parthab@india.ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0195 +++++++++++++=
+++++++++++++++
>> =A01 files changed, 195 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_3xxx_data.c
>> index 59fdb9f..bc17493 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -84,6 +84,8 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod;
>> =A0static struct omap_hwmod omap3xxx_mcbsp5_hwmod;
>> =A0static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod;
>> =A0static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod;
>> +static struct omap_hwmod omap34xx_usb_host_hs_hwmod;
>> +static struct omap_hwmod omap34xx_usb_tll_hs_hwmod;
>>
>> =A0/* L3 -> L4_CORE interface */
>> =A0static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core =3D {
>> @@ -3196,6 +3198,194 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod=
 =3D {
>> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP343=
0),
>> =A0};
>>
>> +/*
>> + * 'usb_host_hs' class
>> + * high-speed multi-port usb host controller
>> + */
>> +static struct omap_hwmod_ocp_if omap34xx_usb_host_hs__l3_main_2 =3D=
 {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap34xx_usb_host_hs_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_l3_main_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "core_l3_ick",
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> +};
>> +
>> +static struct omap_hwmod_class_sysconfig omap34xx_usb_host_hs_sysc =
=3D {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SID=
LEMODE),
>
> This register has other bitfields. =A0Please include them.
>
>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORCE | MS=
TANDBY_NO | MSTANDBY_SMART),
>> + =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap34xx_usb_host_hs_hwmod_class =3D=
 {
>> + =A0 =A0 .name =3D "usb_host_hs",
>> + =A0 =A0 .sysc =3D &omap34xx_usb_host_hs_sysc,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_masters[] =3D=
 {
>> + =A0 =A0 &omap34xx_usb_host_hs__l3_main_2,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap34xx_usb_host_hs_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480643ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064400,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480647ff,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064800,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48064cff,
>> + =A0 =A0 },
>> + =A0 =A0 {}
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_host_hs =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_usb_host_hs__ick =3D {
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_ick",
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>
> Does this really need OCPIF_SWSUP_IDLE? =A0If so, then there is a har=
dware
> bug, and some explanation is needed.
>
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_slaves[] =3D =
{
>> + =A0 =A0 &omap34xx_l4_cfg__usb_host_hs,
>> + =A0 =A0 &omap34xx_usb_host_hs__ick,
>> +};
>> +
>> +static struct omap_hwmod_opt_clk omap34xx_usb_host_hs_opt_clks[] =3D=
 {
>> + =A0 =A0 =A0 { .role =3D "usbhost_fck2", .clk =3D "usbhost_120m_fck=
", },
>
> The role here doesn't need "usbhost" in its name -- ideally it would =
be
> something like "120m_fck" or "ehci_logic_fck".

yes, I will do this.

>
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap34xx_usb_host_hs_irqs[] =3D {
>> + =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 },
>> + =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 },
>> + =A0 =A0 { .irq =3D -1 }
>> +};
>> +
>> +static struct omap_hwmod omap34xx_usb_host_hs_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_host_hs",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwmod_=
class,
>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usb_host_hs_irqs,
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbhost_48m_fck",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D OMAP3430E=
S2_USBHOST_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP3430ES=
2_EN_USBHOST1_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OMAP3=
430ES2_ST_USBHOST_IDLE_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_stdby_bit =3D OMAP=
3430ES2_ST_USBHOST_STDBY_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .opt_clks =A0 =A0 =A0 =3D omap34xx_usb_host_hs_opt_clks,
>> + =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(omap34xx_usb_host_hs_opt_=
clks),
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usb_host_hs_sl=
aves),
>> + =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap34xx_usb_host_hs_masters,
>> + =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap34xx_usb_host_hs_ma=
sters),
>> +/*
>> + * The usbhs controller prevents the enter omap to low power mode
>> + * if other than FORCE IDLE and FORCE STANDBY are used.
>> + */
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD_SW=
SUP_MSTANDBY,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)=
,
>> +};
>> +
>> +/*
>> + * 'usb_tll_hs' class
>> + * usb_tll_hs module is the adapter on the usb_host_hs ports
>> + */
>> +static struct omap_hwmod_class_sysconfig omap34xx_usb_tll_hs_sysc =3D=
 {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDL=
EMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_SOFTRESET =
| SYSC_HAS_ENAWAKEUP |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_CLOCKACTIV=
ITY),
>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART),
>> + =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap34xx_usb_tll_hs_hwmod_class =3D =
{
>> + =A0 =A0 .name =3D "usb_tll_hs",
>> + =A0 =A0 .sysc =3D &omap34xx_usb_tll_hs_sysc,
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap34xx_usb_tll_hs_irqs[] =3D {
>> + =A0 =A0 { .name =3D "tll-irq", .irq =3D 78 },
>> + =A0 =A0 { .irq =3D -1 }
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap34xx_usb_tll_hs_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "tll",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48062000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48062fff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> + =A0 =A0 {}
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_f_cfg__usb_tll_hs =3D {
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbtll_ick",
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>> +};
>
> Does this really need OCPIF_SWSUP_IDLE? =A0If so, then there is a har=
dware
> bug, and some explanation is needed.


it was not allowing enter usbhs pw domain to enter to low power idle mo=
de; so
I add a comment here.

>> +
>> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_tll_hs =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_tll_hs_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap34xx_usb_tll_hs_slaves[] =3D {
>> + =A0 =A0 &omap34xx_l4_cfg__usb_tll_hs,
>> + =A0 =A0 &omap34xx_f_cfg__usb_tll_hs,
>> +};
>> +
>> +static struct omap_hwmod omap34xx_usb_tll_hs_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_tll_hs",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_tll_hs_hwmod_c=
lass,
>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_irqs,
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbtll_fck",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP3430ES=
2_EN_USBTLL_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OMAP3=
430ES2_ST_USBTLL_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usb_tll_hs_sla=
ves),
>> +/*
>> + * The usbhs controller prevents the enter omap to low power mode
>> + * if other than FORCE IDLE for TLL mode too.
>> + */
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)=
,
>> +};
>> +
>> =A0static __initdata struct omap_hwmod *omap3xxx_hwmods[] =3D {
>> =A0 =A0 =A0 &omap3xxx_l3_main_hwmod,
>> =A0 =A0 =A0 &omap3xxx_l4_core_hwmod,
>> @@ -3225,6 +3415,11 @@ static __initdata struct omap_hwmod *omap3xxx=
_hwmods[] =3D {
>> =A0 =A0 =A0 &omap3xxx_uart2_hwmod,
>> =A0 =A0 =A0 &omap3xxx_uart3_hwmod,
>> =A0 =A0 =A0 &omap3xxx_uart4_hwmod,
>> +
>> + =A0 =A0 /* usb host class */
>> + =A0 =A0 &omap34xx_usb_host_hs_hwmod,
>> + =A0 =A0 &omap34xx_usb_tll_hs_hwmod,
>> +
>> =A0 =A0 =A0 /* dss class */
>> =A0 =A0 =A0 &omap3430es1_dss_core_hwmod,
>> =A0 =A0 =A0 &omap3xxx_dss_core_hwmod,
>> --
>> 1.6.0.4
>>
>
>
> - Paul
>
