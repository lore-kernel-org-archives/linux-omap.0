From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Fri, 7 Oct 2011 14:51:52 +0530
Message-ID: <CAP05o4J39MotDTOv-O2ahvWfxL-7jC-L3FGsNXbmDy8HNg=W3g@mail.gmail.com>
References: <1317901099-2519-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1110070305040.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1110070305040.4611@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 7, 2011 at 2:36 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Thu, 6 Oct 2011, Keshava Munegowda wrote:
>
>> From: Benoit Cousson <b-cousson@ti.com>
>>
>> Following 2 hwmod structures are added
>> 1. usb_host_hs
>> =A0 =A0 =A0The hwmod of usbhs with uhh, ehci and ohci base addresses
>> =A0 =A0 =A0functional clock and ehci, ohci irqs
>>
>> 2. usb_tll_hs
>> =A0 =A0 =A0 hwmod of usbhs with the TLL base address and irq.
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>>
>> - rebased to kernel version 3.0
>> - Workarounds for hardware issues
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> Reviewed-by: Partha Basak <parthab@india.ti.com>
>
> A few minor issues in this patch have been fixed. =A0Please be carefu=
l with
> whitespace and with multi-line comment style - see
> Documentation/CodingStyle for more information.

Thanks Paul;
yes, I can your changes in the patches.
so, you don't need v14 from me right? please confirm.
I am preparing/validating next version patches with  OCPIF_SWSUP_IDLE r=
emoved.
Thanks for guiding me and helping on the finalizing the hwmod configura=
tions.


regards
keshava

>
>
> - Paul
>
> From fdf7c66244af5ca5ba4cdc820f7644efb9f6c1bf Mon Sep 17 00:00:00 200=
1
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Fri, 7 Oct 2011 02:40:51 -0600
> Subject: [PATCH] arm: omap: usb: ehci and ohci hwmod structures for o=
map4
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
>
> - rebased to kernel version 3.0
> - Workarounds for hardware issues
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak <parthab@india.ti.com>
> [paul@pwsan.com: fixed whitespace, fixed multi-line comment style]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0206 ++++++++++++++=
+++++++++++++-
> =A01 files changed, 205 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index caaf409..6149407 100644
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
> @@ -5254,6 +5256,205 @@ static struct omap_hwmod omap44xx_wd_timer3_h=
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
> +/*
> + * =A0 =A0 Errata: USBHOST Configured In Smart-Idle Can Lead To a De=
adlock
> + * =A0 =A0 id: i660
> + *
> + * =A0 =A0 Description:
> + * =A0 =A0 In the following configuration :
> + * =A0 =A0 - USBHOST module is set to smart-idle mode
> + * =A0 =A0 - PRCM asserts idle_req to the USBHOST module ( This typi=
cally happens
> + * =A0 =A0 =A0 when the system is going to a low power mode : all po=
rts have been
> + * =A0 =A0 =A0 suspended, the master part of the USBHOST module has =
entered the
> + * =A0 =A0 =A0 standby state, and SW has cut the functional clocks.)
> + * =A0 =A0 - an USBHOST interrupt occurs before the module is able t=
o answer
> + * =A0 =A0 =A0 idle_ack, typically a remote wakeup IRQ.
> + * =A0 =A0 Then the USB HOST module will enter a deadlock situation =
where it is no
> + * =A0 =A0 more accessible nor functional.
> + *
> + * =A0 =A0 Workaround:
> + * =A0 =A0 Don't use smart idle; use only force idle, hence HWMOD_SW=
SUP_SIDLE
> + */
> +
> +/*
> + * =A0 =A0 Errata: USB host EHCI may stall when entering smart-stand=
by mode
> + * =A0 =A0 Id: i571
> + *
> + * =A0 =A0 Description:
> + * =A0 =A0 When the USBHOST module is set to smart-standby mode, and=
 when it is
> + * =A0 =A0 ready to enter the standby state (i.e. all ports are susp=
ended and
> + * =A0 =A0 all attached devices are in suspend mode), then it can wr=
ongly assert
> + * =A0 =A0 the Mstandby signal too early while there are still some =
residual OCP
> + * =A0 =A0 transactions ongoing. If this condition occurs, the inter=
nal state
> + * =A0 =A0 machine may go to an undefined state and the USB link may=
 be stuck
> + * =A0 =A0 upon the next resume.
> + *
> + * =A0 =A0 Workaround:
> + * =A0 =A0 Don't use smart standby; use only force standby,
> + * =A0 =A0 hence HWMOD_SWSUP_MSTANDBY
> + */
> +
> +/*
> + * =A0 =A0 During system boot; If the hwmod framework resets the mod=
ule
> + * =A0 =A0 the module will have smart idle settings; which can lead =
to deadlock
> + * =A0 =A0 (above Errata Id:i660); so, dont reset the module during =
boot;
> + * =A0 =A0 Use HWMOD_INIT_NO_RESET.
> + */
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
> @@ -5393,13 +5594,16 @@ static __initdata struct omap_hwmod *omap44xx=
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
> 1.7.6.3
>
>
