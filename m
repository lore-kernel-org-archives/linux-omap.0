From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 v14] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Fri, 14 Oct 2011 15:24:32 +0530
Message-ID: <CAP05o4LsJ46EdyYb=iCVF5FHc29YBHCbuRqPmqaMgDC-VxBS7Q@mail.gmail.com>
References: <1318319323-20146-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1110140143380.16865@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1110140143380.16865@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 14, 2011 at 1:15 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> so I've fixed some issues with this patch also; modified patch below.
> Please test.
>
>
> - Paul
>
>
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Tue, 11 Oct 2011 13:18:43 +0530
> Subject: [PATCH] ARM: OMAP: USB: EHCI and OHCI hwmod structures for O=
MAP4
>
> Following 2 hwmod structures are added
> 1. usb_host_hs
> =A0 =A0 The hwmod of usbhs with uhh, ehci and ohci base addresses
> =A0 =A0 functional clock and ehci, ohci irqs
>
> 2. usb_tll_hs
> =A0 =A0 =A0hwmod of usbhs with the TLL base address and irq.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> [keshava_mgowda@ti.com: rebased to kernel version 3.0, added workarou=
nds for
> =A0hardware issues]
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak <parthab@india.ti.com>
> [paul@pwsan.com: fixed multi-line comments, fixed whitespace, fixed S=
-o-b
> =A0notes, removed spurious TLL->L3 interface]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0208 ++++++++++++++=
+++++++++++++-
> =A01 files changed, 207 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index caaf409..194253a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -68,6 +68,8 @@ static struct omap_hwmod omap44xx_mmc2_hwmod;
> =A0static struct omap_hwmod omap44xx_mpu_hwmod;
> =A0static struct omap_hwmod omap44xx_mpu_private_hwmod;
> =A0static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod;
> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod;
>
> =A0/*
> =A0* Interconnects omap_hwmod structures
> @@ -5254,6 +5256,207 @@ static struct omap_hwmod omap44xx_wd_timer3_h=
wmod =3D {
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_wd_timer3_=
slaves),
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
SIDLEMODE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSC_HAS_SOFTRES=
ET),
> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SIDLE_SMART_WKUP=
 | MSTANDBY_FORCE | MSTANDBY_NO |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_SMART |=
 MSTANDBY_SMART_WKUP),
> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type2,
> +};
> +
> +static struct omap_hwmod_class omap44xx_usb_host_hs_hwmod_class =3D =
{
> + =A0 =A0 =A0 .name =3D "usb_host_hs",
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
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a064800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a064bff,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a064c00,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a064fff,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {}
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_usb_host_hs_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 + OMAP44XX_IRQ_GIC_=
START },
> + =A0 =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 + OMAP44XX_IRQ_GIC_=
START },
> + =A0 =A0 =A0 { .irq =3D -1 }
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
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_host_hs",
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
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usb_host_hs_irqs,
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_slaves=
,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_host_hs=
_slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usb_host_hs_master=
s,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usb_host_hs=
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
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Errata: USB host EHCI may stall when entering smar=
t-standby mode
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
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* During system boot; If the hwmod framework resets =
the module
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
> +static struct omap_hwmod_class omap44xx_usb_tll_hs_hwmod_class =3D {
> + =A0 =A0 =A0 .name =3D "usb_tll_hs",
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
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_tll_hs",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_usb_tll_hs_hwmo=
d_class,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
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
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_irqs,
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_tll_hs_=
slaves),
> +};
> +
> =A0static __initdata struct omap_hwmod *omap44xx_hwmods[] =3D {
>
> =A0 =A0 =A0 =A0/* dmm class */
> @@ -5393,13 +5596,16 @@ static __initdata struct omap_hwmod *omap44xx=
_hwmods[] =3D {
> =A0 =A0 =A0 =A0&omap44xx_uart3_hwmod,
> =A0 =A0 =A0 =A0&omap44xx_uart4_hwmod,
>
> + =A0 =A0 =A0 /* usb host class */
> + =A0 =A0 =A0 &omap44xx_usb_host_hs_hwmod,
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
> 1.7.7

Hi Paul

This updated patch is working perfectly on 4430 sdp.

I apologies on not understanding your last comments on omap3 hwmod.
Thanks a lot for helping me to make it.


Thanks and Regards
keshava
