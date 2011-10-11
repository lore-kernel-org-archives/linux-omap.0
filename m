From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v14] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Tue, 11 Oct 2011 13:25:06 +0530
Message-ID: <CAP05o4LScPwbvo01pqg-5LOLc52shNdGWhs9xX8BRaq+OsAe-g@mail.gmail.com>
References: <1318319470-20409-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318319470-20409-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 1:21 PM, Keshava Munegowda
<keshava_mgowda@ti.com> wrote:
> Following 2 hwmod structures are added
> =A0 =A01. usb_host_hs
> =A0 =A0 =A0 =A0 The hwmod of usbhs with uhh, ehci and ohci base addre=
sses
> =A0 =A0 =A0 =A0 functional clock and ehci, ohci irqs
>
> =A0 =A02. usb_tll_hs
> =A0 =A0 =A0 =A0 =A0hwmod of usbhs with the TLL base address and irq.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak <parthab@india.ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0230 ++++++++++++++=
++++++++++++++
> =A01 files changed, 230 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_3xxx_data.c
> index 59fdb9f..c06b4a4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -84,6 +84,8 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod;
> =A0static struct omap_hwmod omap3xxx_mcbsp5_hwmod;
> =A0static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod;
> =A0static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod;
> +static struct omap_hwmod omap34xx_usb_host_hs_hwmod;
> +static struct omap_hwmod omap34xx_usb_tll_hs_hwmod;
>
> =A0/* L3 -> L4_CORE interface */
> =A0static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core =3D {
> @@ -3196,6 +3198,229 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod =
=3D {
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3=
430),
> =A0};
>
> +/*
> + * 'usb_host_hs' class
> + * high-speed multi-port usb host controller
> + */
> +static struct omap_hwmod_ocp_if omap34xx_usb_host_hs__l3_main_2 =3D =
{
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap34xx_usb_host_hs_hwmod=
,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_l3_main_hwmod,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "core_l3_ick",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap34xx_usb_host_hs_sysc =3D=
 {
> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_=
CLOCKACTIVITY |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_SIDLEMO=
DE | SYSC_HAS_ENAWAKEUP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_SOFTRES=
ET | SYSC_HAS_AUTOIDLE),
> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORCE |=
 MSTANDBY_NO | MSTANDBY_SMART),
> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap34xx_usb_host_hs_hwmod_class =3D =
{
> + =A0 =A0 =A0 .name =3D "usb_host_hs",
> + =A0 =A0 =A0 .sysc =3D &omap34xx_usb_host_hs_sysc,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_masters[] =3D =
{
> + =A0 =A0 =A0 &omap34xx_usb_host_hs__l3_main_2,
> +};
> +
> +static struct omap_hwmod_addr_space omap34xx_usb_host_hs_addrs[] =3D=
 {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480643ff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE=
_RT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064400,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480647ff,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48064cff,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {}
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_usb_host_hs__ick =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwm=
od,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_ick",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_addr=
s,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_slaves[] =3D {
> + =A0 =A0 =A0 &omap34xx_usb_host_hs__ick,
> +};
> +
> +static struct omap_hwmod_opt_clk omap34xx_usb_host_hs_opt_clks[] =3D=
 {
> + =A0 =A0 =A0 =A0 { .role =3D "ehci_logic_fck", .clk =3D "usbhost_120=
m_fck", },
> +};
> +
> +static struct omap_hwmod_irq_info omap34xx_usb_host_hs_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 },
> + =A0 =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 },
> + =A0 =A0 =A0 { .irq =3D -1 }
> +};
> +
> +static struct omap_hwmod omap34xx_usb_host_hs_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_host_hs",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwm=
od_class,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usb_host_hs_irqs,
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbhost_48m_fck",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D OMAP34=
30ES2_USBHOST_MOD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP343=
0ES2_EN_USBHOST1_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OM=
AP3430ES2_ST_USBHOST_IDLE_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_stdby_bit =3D O=
MAP3430ES2_ST_USBHOST_STDBY_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .opt_clks =A0 =A0 =A0 =3D omap34xx_usb_host_hs_opt_clks=
,
> + =A0 =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(omap34xx_usb_host_hs_o=
pt_clks),
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_slaves=
,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usb_host_hs=
_slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap34xx_usb_host_hs_master=
s,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap34xx_usb_host_hs=
_masters),
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Errata: USBHOST Configured In Smart-Idle Can Lead =
To a Deadlock
> + =A0 =A0 =A0 =A0* id: i660
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Description:
> + =A0 =A0 =A0 =A0* In the following configuration :
> + =A0 =A0 =A0 =A0* - USBHOST module is set to smart-idle mode
> + =A0 =A0 =A0 =A0* - PRCM asserts idle_req to the USBHOST module ( Th=
is typically
> + =A0 =A0 =A0 =A0* =A0 happens when the system is going to a low powe=
r mode : all ports
> + =A0 =A0 =A0 =A0* =A0 have been suspended, the master part of the US=
BHOST module has
> + =A0 =A0 =A0 =A0* =A0 entered the standby state, and SW has cut the =
functional clocks)
> + =A0 =A0 =A0 =A0* - an USBHOST interrupt occurs before the module is=
 able to answer
> + =A0 =A0 =A0 =A0* =A0 idle_ack, typically a remote wakeup IRQ.
> + =A0 =A0 =A0 =A0* Then the USB HOST module will enter a deadlock sit=
uation where it
> + =A0 =A0 =A0 =A0* is no more accessible nor functional.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Workaround:
> + =A0 =A0 =A0 =A0* Don't use smart idle; use only force idle, hence H=
WMOD_SWSUP_SIDLE
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 /* Errata: USB host EHCI may stall when entering smart-=
standby mode
> + =A0 =A0 =A0 =A0* Id: i571
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Description:
> + =A0 =A0 =A0 =A0* When the USBHOST module is set to smart-standby mo=
de, and when it is
> + =A0 =A0 =A0 =A0* ready to enter the standby state (i.e. all ports a=
re suspended and
> + =A0 =A0 =A0 =A0* all attached devices are in suspend mode), then it=
 can wrongly assert
> + =A0 =A0 =A0 =A0* the Mstandby signal too early while there are stil=
l some residual OCP
> + =A0 =A0 =A0 =A0* transactions ongoing. If this condition occurs, th=
e internal state
> + =A0 =A0 =A0 =A0* machine may go to an undefined state and the USB l=
ink may be stuck
> + =A0 =A0 =A0 =A0* upon the next resume.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Workaround:
> + =A0 =A0 =A0 =A0* Don't use smart standby; use only force standby,
> + =A0 =A0 =A0 =A0* hence HWMOD_SWSUP_MSTANDBY
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 /* During system boot; If the hwmod framework resets th=
e module
> + =A0 =A0 =A0 =A0* the module will have smart idle settings; which ca=
n lead to deadlock
> + =A0 =A0 =A0 =A0* (above Errata Id:i660); so, dont reset the module =
during boot;
> + =A0 =A0 =A0 =A0* Use HWMOD_INIT_NO_RESET.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD=
_SWSUP_MSTANDBY |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HWMOD_INIT_NO_RESET=
,
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP34=
30),
> +};
> +
> +/*
> + * 'usb_tll_hs' class
> + * usb_tll_hs module is the adapter on the usb_host_hs ports
> + */
> +static struct omap_hwmod_class_sysconfig omap34xx_usb_tll_hs_sysc =3D=
 {
> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_CLOCKACTIVITY | SYSC_=
HAS_SIDLEMODE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_ENAWAKE=
UP | SYSC_HAS_SOFTRESET |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_AUTOIDL=
E),
> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART),
> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap34xx_usb_tll_hs_hwmod_class =3D {
> + =A0 =A0 =A0 .name =3D "usb_tll_hs",
> + =A0 =A0 =A0 .sysc =3D &omap34xx_usb_tll_hs_sysc,
> +};
> +
> +static struct omap_hwmod_irq_info omap34xx_usb_tll_hs_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "tll-irq", .irq =3D 78 },
> + =A0 =A0 =A0 { .irq =3D -1 }
> +};
> +
> +static struct omap_hwmod_addr_space omap34xx_usb_tll_hs_addrs[] =3D =
{
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "tll",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48062000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48062fff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE=
_RT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {}
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_usb_tll_hs__l3_main_2 =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap34xx_usb_tll_hs_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_l3_main_hwmod,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "core_l3_ick",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usb_tll_hs_masters[] =3D {
> + =A0 =A0 =A0 &omap34xx_usb_tll_hs__l3_main_2,
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_ick_cfg__usb_tll_hs =3D {
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbtll_ick",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_addrs=
,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usb_tll_hs_slaves[] =3D {
> + =A0 =A0 =A0 &omap34xx_ick_cfg__usb_tll_hs,
> +};
> +
> +static struct omap_hwmod omap34xx_usb_tll_hs_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_tll_hs",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_tll_hs_hwmo=
d_class,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_irqs,
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbtll_fck",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_M=
OD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP343=
0ES2_EN_USBTLL_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D OM=
AP3430ES2_ST_USBTLL_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usb_tll_hs_=
slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap34xx_usb_tll_hs_masters=
,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap34xx_usb_tll_hs_=
masters),
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP34=
30),
> +};
> +
> =A0static __initdata struct omap_hwmod *omap3xxx_hwmods[] =3D {
> =A0 =A0 =A0 =A0&omap3xxx_l3_main_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_l4_core_hwmod,
> @@ -3225,6 +3450,11 @@ static __initdata struct omap_hwmod *omap3xxx_=
hwmods[] =3D {
> =A0 =A0 =A0 =A0&omap3xxx_uart2_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_uart3_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_uart4_hwmod,
> +
> + =A0 =A0 =A0 /* usb host class */
> + =A0 =A0 =A0 &omap34xx_usb_host_hs_hwmod,
> + =A0 =A0 =A0 &omap34xx_usb_tll_hs_hwmod,
> +
> =A0 =A0 =A0 =A0/* dss class */
> =A0 =A0 =A0 =A0&omap3430es1_dss_core_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_dss_core_hwmod,
> --
> 1.6.0.4
>


This is actually v14; Due to mail box errors; Version is not getting
popped out properly from the patch.


regards
keshava
