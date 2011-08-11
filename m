From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5 v4] arm: omap: usb: ehci and ohci hwmod structures for omap3
Date: Thu, 11 Aug 2011 23:23:48 +0800
Message-ID: <CACVXFVMqwzSOSvkq4q6GnR2gso8NuQD4DRumAVesQB=P_8yDaQ@mail.gmail.com>
References: <1312899309-24067-1-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-2-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-3-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312899309-24067-3-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Aug 9, 2011 at 10:15 PM, Keshava Munegowda
<keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
> Following 4 hwmod strcuture are added:
> UHH hwmod of usbhs with uhh base address and functional clock,
> EHCI hwmod with irq and base address,
> OHCI hwmod with irq and base address,
> TLL hwmod of usbhs with the TLL base address and irq.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0279 ++++++++++++++=
++++++++++++++
> =A01 files changed, 279 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_3xxx_data.c
> index 59fdb9f..d7316b3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -84,6 +84,10 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod;
> =A0static struct omap_hwmod omap3xxx_mcbsp5_hwmod;
> =A0static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod;
> =A0static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod;
> +static struct omap_hwmod omap34xx_usb_host_hs_hwmod;
> +static struct omap_hwmod omap34xx_usbhs_ohci_hwmod;
> +static struct omap_hwmod omap34xx_usbhs_ehci_hwmod;
> +static struct omap_hwmod omap34xx_usb_tll_hs_hwmod;
>
> =A0/* L3 -> L4_CORE interface */
> =A0static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core =3D {
> @@ -3196,6 +3200,276 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod =
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

SYSC_HAS_ENAWAKEUP is missed or not needed?

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
> +static struct omap_hwmod_addr_space omap34xx_usb_host_hs_addrs[] =3D=
 {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480643ff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE=
_RT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {} /* Terminating Entry */
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_host_hs =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwm=
od,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_addr=
s,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};

Even USBHOST_L4_ICLK is used only by USBHOST_SICLK, it is better to
define a "usbhost_siclk" clk for consistence with TRM.

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
> +/* 'usbhs_ohci' class =A0*/
> +static struct omap_hwmod_ocp_if omap34xx_usbhs_ohci__l3_main_2 =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap34xx_usbhs_ohci_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_l3_main_hwmod,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "core_l3_ick",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_class omap34xx_usbhs_ohci_hwmod_class =3D {
> + =A0 =A0 =A0 .name =3D "usbhs_ohci",
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usbhs_ohci_masters[] =3D {
> + =A0 =A0 =A0 &omap34xx_usbhs_ohci__l3_main_2,
> +};
> +
> +static struct omap_hwmod_irq_info omap34xx_usbhs_ohci_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 },
> + =A0 =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
> +};
> +
> +static struct omap_hwmod_addr_space omap34xx_usbhs_ohci_addrs[] =3D =
{
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064400,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480647FF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_=
ON_INIT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {} /* Terminating Entry */
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usbhs_ohci =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usbhs_ohci_hwmo=
d,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usbhs_ohci_addrs=
,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usbhs_ohci_slaves[] =3D {
> + =A0 =A0 =A0 &omap34xx_l4_cfg__usbhs_ohci,
> +};
> +
> +static struct omap_hwmod omap34xx_usbhs_ohci_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_ohci",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usbhs_ohci_hwmo=
d_class,
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usbhs_ohci_irqs,
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usbhs_ohci_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usbhs_ohci_=
slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap34xx_usbhs_ohci_masters=
,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap34xx_usbhs_ohci_=
masters),
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWM=
OD_NO_IDLEST,
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP34=
30),
> +};
> +
> +/* 'usbhs_ehci' class =A0*/
> +static struct omap_hwmod_ocp_if omap34xx_usbhs_ehci__l3_main_2 =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap34xx_usbhs_ehci_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_l3_main_hwmod,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "core_l3_ick",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_class omap34xx_usbhs_ehci_hwmod_class =3D {
> + =A0 =A0 =A0 .name =3D "usbhs_ehci",
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usbhs_ehci_masters[] =3D {
> + =A0 =A0 =A0 &omap34xx_usbhs_ehci__l3_main_2,
> +};
> +
> +static struct omap_hwmod_irq_info omap34xx_usbhs_ehci_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 },
> + =A0 =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
> +};
> +
> +static struct omap_hwmod_addr_space omap34xx_usbhs_ehci_addrs[] =3D =
{
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48064CFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_=
ON_INIT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {} /* Terminating Entry */
> +};
> +
> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usbhs_ehci =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usbhs_ehci_hwmo=
d,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usbhs_ehci_addrs=
,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap34xx_usbhs_ehci_slaves[] =3D {
> + =A0 =A0 =A0 &omap34xx_l4_cfg__usbhs_ehci,
> +};
> +
> +static struct omap_hwmod omap34xx_usbhs_ehci_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_ehci",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usbhs_ehci_hwmo=
d_class,
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usbhs_ehci_irqs,
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usbhs_ehci_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usbhs_ehci_=
slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap34xx_usbhs_ehci_masters=
,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap34xx_usbhs_ehci_=
masters),
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWM=
OD_NO_IDLEST,
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
> + =A0 =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
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
> + =A0 =A0 =A0 {} /* Terminating Entry */
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
> @@ -3278,6 +3552,11 @@ static __initdata struct omap_hwmod *omap3xxx_=
hwmods[] =3D {
> =A0 =A0 =A0 =A0/* usbotg for am35x */
> =A0 =A0 =A0 =A0&am35xx_usbhsotg_hwmod,
>
> + =A0 =A0 =A0 &omap34xx_usb_host_hs_hwmod,
> + =A0 =A0 =A0 &omap34xx_usbhs_ohci_hwmod,
> + =A0 =A0 =A0 &omap34xx_usbhs_ehci_hwmod,
> + =A0 =A0 =A0 &omap34xx_usb_tll_hs_hwmod,
> +
> =A0 =A0 =A0 =A0NULL,
> =A0};
>
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
