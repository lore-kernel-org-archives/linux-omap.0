From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [RESEND][PATCH 0/5] arm: omap: usb: Runtime PM support for EHCI
 and OHCI drivers
Date: Mon, 16 May 2011 14:43:00 +0530
Message-ID: <BANLkTimk-EorruFdqKkoWFSxzeFW+-7tUw@mail.gmail.com>
References: <1305536697-20147-1-git-send-email-keshava_mgowda@ti.com>
	<1305536697-20147-2-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305536697-20147-2-git-send-email-keshava_mgowda@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com
List-Id: linux-omap@vger.kernel.org

Sorry ! Tis patch was 1/5 has different subjct;

Some problem with my email setup , I will send the series.

On Mon, May 16, 2011 at 2:34 PM, Keshava Munegowda
<keshava_mgowda@ti.com> wrote:
> Following 2 hwmod strcuture are added:
> UHH hwmod of usbhs with uhh base address and
> EHCI , OHCI irq and base addresses.
> TLL hwmod of usbhs with the TLL base address and irq.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0184 ++++++++++++++=
++++++++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0153 ++++++++++++++=
+++++++++
> =A02 files changed, 337 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_3xxx_data.c
> index 909a84d..fe9a176 100644
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
> @@ -3574,6 +3576,185 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod =
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
SIDLEMODE),
> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORCE |=
 MSTANDBY_NO | MSTANDBY_SMART),
> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap34xx_usb_host_hs_hwmod_class =3D =
{
> + =A0 =A0 =A0 .name =3D "usbhs_uhh",
> + =A0 =A0 =A0 .sysc =3D &omap34xx_usb_host_hs_sysc,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_masters[] =3D =
{
> + =A0 =A0 =A0 &omap34xx_usb_host_hs__l3_main_2,
> +};
> +
> +static struct omap_hwmod_irq_info omap34xx_usb_host_hs_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 },
> + =A0 =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 },
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480647FF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_=
ON_INIT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48064CFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_=
ON_INIT
> + =A0 =A0 =A0 }
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_host_hs =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwm=
od,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_addr=
s,
> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap34xx_usb_host_=
hs_addrs),
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_f128m_cfg__usb_host_hs =3D =
{
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_120m_fck",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_f48m_cfg__usb_host_hs =3D {
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_48m_fck",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_slaves[] =3D {
> + =A0 =A0 =A0 &omap34xx_l4_cfg__usb_host_hs,
> + =A0 =A0 =A0 &omap34xx_f128m_cfg__usb_host_hs,
> + =A0 =A0 =A0 &omap34xx_f48m_cfg__usb_host_hs,
> +};
> +
> +static struct omap_hwmod omap34xx_usb_host_hs_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_uhh",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwm=
od_class,
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usb_host_hs_irqs,
> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap34xx_usb_host_hs_i=
rqs),
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbhost_ick",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D OMAP34=
30ES2_USBHOST_MOD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_stdby_bit =3D 0=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_slaves=
,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usb_host_hs=
_slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap34xx_usb_host_hs_master=
s,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap34xx_usb_host_hs=
_masters),
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD=
_SWSUP_MSTANDBY,
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
> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_S=
IDLEMODE),
> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART),
> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap34xx_usb_tll_hs_hwmod_class =3D {
> + =A0 =A0 =A0 .name =3D "usbhs_tll",
> + =A0 =A0 =A0 .sysc =3D &omap34xx_usb_tll_hs_sysc,
> +};
> +
> +static struct omap_hwmod_irq_info omap34xx_usb_tll_hs_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "tll-irq", .irq =3D 78 },
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
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_f_cfg__usb_tll_hs =3D {
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbtll_fck",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_tll_hs =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_tll_hs_hwmo=
d,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_addrs=
,
> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap34xx_usb_tll_h=
s_addrs),
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usb_tll_hs_slaves[] =3D {
> + =A0 =A0 =A0 &omap34xx_l4_cfg__usb_tll_hs,
> + =A0 =A0 =A0 &omap34xx_f_cfg__usb_tll_hs,
> +};
> +
> +static struct omap_hwmod omap34xx_usb_tll_hs_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_tll",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_tll_hs_hwmo=
d_class,
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_irqs,
> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap34xx_usb_tll_hs_ir=
qs),
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbtll_ick",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_M=
OD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usb_tll_hs_=
slaves),
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD=
_SWSUP_MSTANDBY,
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP34=
30),
> +};
> +
> =A0static __initdata struct omap_hwmod *omap3xxx_hwmods[] =3D {
> =A0 =A0 =A0 =A0&omap3xxx_l3_main_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_l4_core_hwmod,
> @@ -3656,6 +3837,9 @@ static __initdata struct omap_hwmod *omap3xxx_h=
wmods[] =3D {
> =A0 =A0 =A0 =A0/* usbotg for am35x */
> =A0 =A0 =A0 =A0&am35xx_usbhsotg_hwmod,
>
> + =A0 =A0 =A0 &omap34xx_usb_host_hs_hwmod,
> + =A0 =A0 =A0 &omap34xx_usb_tll_hs_hwmod,
> +
> =A0 =A0 =A0 =A0NULL,
> =A0};
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index abc548a..d7112b0 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -66,6 +66,8 @@ static struct omap_hwmod omap44xx_mmc2_hwmod;
> =A0static struct omap_hwmod omap44xx_mpu_hwmod;
> =A0static struct omap_hwmod omap44xx_mpu_private_hwmod;
> =A0static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod;
> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod;
>
> =A0/*
> =A0* Interconnects omap_hwmod structures
> @@ -5027,6 +5029,155 @@ static struct omap_hwmod omap44xx_wd_timer3_h=
wmod =3D {
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4=
430),
> =A0};
>
> +/*
> + * 'usb_host_hs' class
> + * high-speed multi-port usb host controller
> + */
> +static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 =3D =
{
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_usb_host_hs_hwmod=
,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_l3_main_2_hwmod=
,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_usb_host_hs_sysc =3D=
 {
> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_=
SIDLEMODE),
> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORCE |=
 MSTANDBY_NO | MSTANDBY_SMART),
> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type2,
> +};
> +
> +static struct omap_hwmod_class omap44xx_usb_host_hs_hwmod_class =3D =
{
> + =A0 =A0 =A0 .name =3D "usbhs_uhh",
> + =A0 =A0 =A0 .sysc =3D &omap44xx_usb_host_hs_sysc,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_masters[] =3D =
{
> + =A0 =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_usb_host_hs_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 + OMAP44XX_IRQ_GIC_=
START },
> + =A0 =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 + OMAP44XX_IRQ_GIC_=
START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] =3D=
 {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a064000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a0647ff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE=
_RT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064BFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_=
ON_INIT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064C00,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064FFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_=
ON_INIT
> + =A0 =A0 =A0 }
> +};
> +
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_hs =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_cfg_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usb_host_hs_hwm=
od,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_addr=
s,
> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_host_=
hs_addrs),
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_slaves[] =3D {
> + =A0 =A0 =A0 &omap44xx_l4_cfg__usb_host_hs,
> +};
> +
> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_uhh",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usb_host_hs_hwm=
od_class,
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usb_host_hs_irqs,
> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_usb_host_hs_i=
rqs),
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_host_hs_fck",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP44=
30_CM_L3INIT_USB_HOST_CLKCTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_slaves=
,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_host_hs=
_slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usb_host_hs_master=
s,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usb_host_hs=
_masters),
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD=
_SWSUP_MSTANDBY,
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44=
30),
> +};
> +
> +/*
> + * 'usb_tll_hs' class
> + * usb_tll_hs module is the adapter on the usb_host_hs ports
> + */
> +static struct omap_hwmod_class_sysconfig omap44xx_usb_tll_hs_sysc =3D=
 {
> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_S=
IDLEMODE),
> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART),
> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_usb_tll_hs_hwmod_class =3D {
> + =A0 =A0 =A0 .name =3D "usbhs_tll",
> + =A0 =A0 =A0 .sysc =3D &omap44xx_usb_tll_hs_sysc,
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_usb_tll_hs_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "tll-irq", .irq =3D 78 + OMAP44XX_IRQ_GIC_S=
TART },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_usb_tll_hs_addrs[] =3D =
{
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "tll",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a062000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a063fff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE=
_RT
> + =A0 =A0 =A0 },
> +};
> +
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_tll_hs =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_cfg_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usb_tll_hs_hwmo=
d,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_addrs=
,
> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_tll_h=
s_addrs),
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap44xx_usb_tll_hs_slaves[] =3D {
> + =A0 =A0 =A0 &omap44xx_l4_cfg__usb_tll_hs,
> +};
> +
> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_tll",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usb_tll_hs_hwmo=
d_class,
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_irqs,
> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_usb_tll_hs_ir=
qs),
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_tll_hs_ick",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP44=
30_CM_L3INIT_USB_TLL_CLKCTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_tll_hs_=
slaves),
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD=
_SWSUP_MSTANDBY,
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44=
30),
> +};
> +
> =A0static __initdata struct omap_hwmod *omap44xx_hwmods[] =3D {
>
> =A0 =A0 =A0 =A0/* dmm class */
> @@ -5173,6 +5324,8 @@ static __initdata struct omap_hwmod *omap44xx_h=
wmods[] =3D {
> =A0 =A0 =A0 =A0&omap44xx_wd_timer2_hwmod,
> =A0 =A0 =A0 =A0&omap44xx_wd_timer3_hwmod,
>
> + =A0 =A0 =A0 &omap44xx_usb_host_hs_hwmod,
> + =A0 =A0 =A0 &omap44xx_usb_tll_hs_hwmod,
> =A0 =A0 =A0 =A0NULL,
> =A0};
>
> --
> 1.6.0.4
>
>
