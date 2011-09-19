From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 v9] arm: omap: usb: ehci and ohci hwmod structures for omap4
Date: Mon, 19 Sep 2011 16:28:03 +0530
Message-ID: <CAP05o4+O2_bT6OEQ=Ss3JqMUAyxirGjY9X9go74iCkYXvOiNgg@mail.gmail.com>
References: <1316092970-2440-1-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-2-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316092970-2440-2-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-cousson-l0cyMroinI0@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 15, 2011 at 6:52 PM, Keshava Munegowda
<keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
> From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>
> Following 4 hwmod structures are added:
> UHH hwmod of usbhs with uhh base address and functional clock,
> EHCI hwmod with irq and base address,
> OHCI hwmod with irq and base address,
> TLL hwmod of usbhs with the TLL base address and irq.
>
> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0249 ++++++++++++++=
+++++++++++++-
> =A01 files changed, 248 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index 6201422..f06efa6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -68,6 +68,10 @@ static struct omap_hwmod omap44xx_mmc2_hwmod;
> =A0static struct omap_hwmod omap44xx_mpu_hwmod;
> =A0static struct omap_hwmod omap44xx_mpu_private_hwmod;
> =A0static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod;
> +static struct omap_hwmod omap44xx_usbhs_ohci_hwmod;
> +static struct omap_hwmod omap44xx_usbhs_ehci_hwmod;
> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod;
>
> =A0/*
> =A0* Interconnects omap_hwmod structures
> @@ -5336,6 +5340,244 @@ static struct omap_hwmod omap44xx_wd_timer3_h=
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SIDLE_SMART_WKUP | MSTA=
NDBY_FORCE | MSTANDBY_NO |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSTANDBY_SMART | MSTAND=
BY_SMART_WKUP),
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
> +static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] =3D=
 {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a064000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a0647ff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE=
_RT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {}
> +};
> +
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_hs =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_cfg_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usb_host_hs_hwm=
od,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_addr=
s,
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
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_host_hs_fck",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4=
_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4=
_RM_L3INIT_USB_HOST_CONTEXT_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MOD=
ULEMODE_SWCTRL,
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
> +/* 'usbhs_ohci' class */
> +static struct omap_hwmod_class omap44xx_usbhs_ohci_hwmod_class =3D {
> + =A0 =A0 =A0 .name =3D "usbhs_ohci",
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_usbhs_ohci_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 + OMAP44XX_IRQ_GIC_=
START },
> + =A0 =A0 =A0 { .irq =3D -1 }
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_usbhs_ohci_addrs[] =3D =
{
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064BFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_=
ON_INIT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {}
> +};
> +
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usbhs_ohci =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_cfg_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usbhs_ohci_hwmo=
d,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_addrs=
,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ohci_slaves[] =3D {
> + =A0 =A0 =A0 &omap44xx_l4_cfg__usbhs_ohci,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ohci_masters[] =3D {
> + =A0 =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
> +};
> +
> +static struct omap_hwmod omap44xx_usbhs_ohci_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_ohci",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usbhs_ohci_hwmo=
d_class,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_irqs,
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usbhs_ohci_=
slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usbhs_ohci_masters=
,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usbhs_ohci_=
masters),
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44=
30),
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWM=
OD_NO_IDLEST,
> +};
> +
> +/* 'usbhs_ehci' class */
> +static struct omap_hwmod_class omap44xx_usbhs_ehci_hwmod_class =3D {
> + =A0 =A0 =A0 .name =3D "usbhs_ehci",
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_usbhs_ehci_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 + OMAP44XX_IRQ_GIC_=
START },
> + =A0 =A0 =A0 { .irq =3D -1 }
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_usbhs_ehci_addrs[] =3D =
{
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064C00,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064FFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_=
ON_INIT
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {}
> +};
> +
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usbhs_ehci =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_cfg_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usbhs_ehci_hwmo=
d,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ehci_addrs=
,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ehci_slaves[] =3D {
> + =A0 =A0 =A0 &omap44xx_l4_cfg__usbhs_ehci,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ehci_masters[] =3D {
> + =A0 =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
> +};
> +
> +
> +static struct omap_hwmod omap44xx_usbhs_ehci_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_ehci",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usbhs_ehci_hwmo=
d_class,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usbhs_ehci_irqs,
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ehci_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usbhs_ehci_=
slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usbhs_ehci_masters=
,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usbhs_ehci_=
masters),
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44=
30),
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWM=
OD_NO_IDLEST,
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
IDLEMODE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_SOFTRESET | SY=
SC_HAS_ENAWAKEUP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_CLOCKACTIVITY)=
,
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
> + =A0 =A0 =A0 { .irq =3D -1 }
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
> + =A0 =A0 =A0 {}
> +};
> +
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_tll_hs =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_cfg_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usb_tll_hs_hwmo=
d,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_addrs=
,
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
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_irqs,
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_tll_hs_ick",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4=
_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4=
_RM_L3INIT_USB_TLL_CONTEXT_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MOD=
ULEMODE_HWCTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_tll_hs_=
slaves),
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE,
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44=
30),
> +};
> +
> =A0static __initdata struct omap_hwmod *omap44xx_hwmods[] =3D {
>
> =A0 =A0 =A0 =A0/* dmm class */
> @@ -5475,13 +5717,18 @@ static __initdata struct omap_hwmod *omap44xx=
_hwmods[] =3D {
> =A0 =A0 =A0 =A0&omap44xx_uart3_hwmod,
> =A0 =A0 =A0 =A0&omap44xx_uart4_hwmod,
>
> + =A0 =A0 =A0 /* usb host class */
> + =A0 =A0 =A0 &omap44xx_usb_host_hs_hwmod,
> + =A0 =A0 =A0 &omap44xx_usbhs_ohci_hwmod,
> + =A0 =A0 =A0 &omap44xx_usbhs_ehci_hwmod,
> + =A0 =A0 =A0 &omap44xx_usb_tll_hs_hwmod,
> +
> =A0 =A0 =A0 =A0/* usb_otg_hs class */
> =A0 =A0 =A0 =A0&omap44xx_usb_otg_hs_hwmod,
>
> =A0 =A0 =A0 =A0/* wd_timer class */
> =A0 =A0 =A0 =A0&omap44xx_wd_timer2_hwmod,
> =A0 =A0 =A0 =A0&omap44xx_wd_timer3_hwmod,
> -
> =A0 =A0 =A0 =A0NULL,
> =A0};
>
> --
> 1.6.0.4
>
>

Hi Benoit Cousson
        please provide your review comments on this; if the patch is
ok, please do ack;
so that I will push these patches for this merge window.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
