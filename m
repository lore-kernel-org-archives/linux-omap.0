From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v14] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Fri, 14 Oct 2011 15:23:08 +0530
Message-ID: <CAP05o4JMnhd+59ocTw+z9a7ukSmDn1deL5T4D9q5ZeKw_tEg0w@mail.gmail.com>
References: <1318319355-20168-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1110131227270.24155@utopia.booyaka.com>
	<alpine.DEB.2.00.1110131857350.24155@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:51865 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756208Ab1JNJxK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Oct 2011 05:53:10 -0400
In-Reply-To: <alpine.DEB.2.00.1110131857350.24155@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com

On Fri, Oct 14, 2011 at 6:33 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi
>
> I probably shouldn't have, but I've gone ahead and fixed a bunch of i=
ssues
> with this patch locally. =A0Modified patch below. =A0Please give it a=
 test and
> ensure that it works for you.
>
>
> - Paul
>
> From: Keshava Munegowda <keshava_mgowda@ti.com>
> Date: Thu, 13 Oct 2011 17:27:28 -0600
> Subject: [PATCH] ARM: OMAP: USB: EHCI and OHCI hwmod structures for O=
MAP3
>
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
> [paul@pwsan.com: fixed whitespace; removed nonexistent TLL->L4 CORE i=
nterface;
> =A0added master & slave for L4 CORE->TLL interface; skip registration=
 on
> =A03430ES1; fixed multiline comment style; updated to apply on Tony's=
 cleanup
> =A0branch]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0221 ++++++++++++++=
++++++++++++++
> =A01 files changed, 221 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_3xxx_data.c
> index ab35acb..060543e 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -84,6 +84,8 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod;
> =A0static struct omap_hwmod omap3xxx_mcbsp5_hwmod;
> =A0static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod;
> =A0static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod;
> +static struct omap_hwmod omap3xxx_usb_host_hs_hwmod;
> +static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod;
>
> =A0/* L3 -> L4_CORE interface */
> =A0static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core =3D {
> @@ -3123,6 +3125,218 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod =
=3D {
> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_mmc_class,
> =A0};
>
> +/*
> + * 'usb_host_hs' class
> + * high-speed multi-port usb host controller
> + */
> +static struct omap_hwmod_ocp_if omap3xxx_usb_host_hs__l3_main_2 =3D =
{
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_usb_host_hs_hwmod=
,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_l3_main_hwmod,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "core_l3_ick",
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap3xxx_usb_host_hs_sysc =3D=
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
> +static struct omap_hwmod_class omap3xxx_usb_host_hs_hwmod_class =3D =
{
> + =A0 =A0 =A0 .name =3D "usb_host_hs",
> + =A0 =A0 =A0 .sysc =3D &omap3xxx_usb_host_hs_sysc,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_usb_host_hs_masters[] =3D =
{
> + =A0 =A0 =A0 &omap3xxx_usb_host_hs__l3_main_2,
> +};
> +
> +static struct omap_hwmod_addr_space omap3xxx_usb_host_hs_addrs[] =3D=
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
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__usb_host_hs =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_usb_host_hs_hwm=
od,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_ick",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap3xxx_usb_host_hs_addr=
s,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_usb_host_hs_slaves[] =3D {
> + =A0 =A0 =A0 &omap3xxx_l4_core__usb_host_hs,
> +};
> +
> +static struct omap_hwmod_opt_clk omap3xxx_usb_host_hs_opt_clks[] =3D=
 {
> + =A0 =A0 =A0 =A0 { .role =3D "ehci_logic_fck", .clk =3D "usbhost_120=
m_fck", },
> +};
> +
> +static struct omap_hwmod_irq_info omap3xxx_usb_host_hs_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 },
> + =A0 =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 },
> + =A0 =A0 =A0 { .irq =3D -1 }
> +};
> +
> +static struct omap_hwmod omap3xxx_usb_host_hs_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_host_hs",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_usb_host_hs_hwm=
od_class,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap3xxx_usb_host_hs_irqs,
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
> + =A0 =A0 =A0 .opt_clks =A0 =A0 =A0 =3D omap3xxx_usb_host_hs_opt_clks=
,
> + =A0 =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(omap3xxx_usb_host_hs_o=
pt_clks),
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3xxx_usb_host_hs_slaves=
,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3xxx_usb_host_hs=
_slaves),
> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap3xxx_usb_host_hs_master=
s,
> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap3xxx_usb_host_hs=
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
> +static struct omap_hwmod_class_sysconfig omap3xxx_usb_tll_hs_sysc =3D=
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
> +static struct omap_hwmod_class omap3xxx_usb_tll_hs_hwmod_class =3D {
> + =A0 =A0 =A0 .name =3D "usb_tll_hs",
> + =A0 =A0 =A0 .sysc =3D &omap3xxx_usb_tll_hs_sysc,
> +};
> +
> +static struct omap_hwmod_irq_info omap3xxx_usb_tll_hs_irqs[] =3D {
> + =A0 =A0 =A0 { .name =3D "tll-irq", .irq =3D 78 },
> + =A0 =A0 =A0 { .irq =3D -1 }
> +};
> +
> +static struct omap_hwmod_addr_space omap3xxx_usb_tll_hs_addrs[] =3D =
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
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__usb_tll_hs =3D {
> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_usb_tll_hs_hwmo=
d,
> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbtll_ick",
> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap3xxx_usb_tll_hs_addrs=
,
> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_usb_tll_hs_slaves[] =3D {
> + =A0 =A0 =A0 &omap3xxx_l4_core__usb_tll_hs,
> +};
> +
> +static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_tll_hs",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_usb_tll_hs_hwmo=
d_class,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap3xxx_usb_tll_hs_irqs,
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
> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3xxx_usb_tll_hs_slaves,
> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3xxx_usb_tll_hs_=
slaves),
> +};
> +
> =A0static __initdata struct omap_hwmod *omap3xxx_hwmods[] =3D {
> =A0 =A0 =A0 =A0&omap3xxx_l3_main_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_l4_core_hwmod,
> @@ -3151,6 +3365,7 @@ static __initdata struct omap_hwmod *omap3xxx_h=
wmods[] =3D {
> =A0 =A0 =A0 =A0&omap3xxx_uart1_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_uart2_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_uart3_hwmod,
> +
> =A0 =A0 =A0 =A0/* dss class */
> =A0 =A0 =A0 =A0&omap3xxx_dss_dispc_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_dss_dsi1_hwmod,
> @@ -3206,6 +3421,8 @@ static __initdata struct omap_hwmod *omap3430es=
1_hwmods[] =3D {
> =A0static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] =3D =
{
> =A0 =A0 =A0 =A0&omap3xxx_dss_core_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_usbhsotg_hwmod,
> + =A0 =A0 =A0 &omap3xxx_usb_host_hs_hwmod,
> + =A0 =A0 =A0 &omap3xxx_usb_tll_hs_hwmod,
> =A0 =A0 =A0 =A0NULL
> =A0};
>
> @@ -3223,12 +3440,16 @@ static __initdata struct omap_hwmod *omap36xx=
_hwmods[] =3D {
> =A0 =A0 =A0 =A0&omap36xx_sr1_hwmod,
> =A0 =A0 =A0 =A0&omap36xx_sr2_hwmod,
> =A0 =A0 =A0 =A0&omap3xxx_usbhsotg_hwmod,
> + =A0 =A0 =A0 &omap3xxx_usb_host_hs_hwmod,
> + =A0 =A0 =A0 &omap3xxx_usb_tll_hs_hwmod,
> =A0 =A0 =A0 =A0NULL
> =A0};
>
> =A0static __initdata struct omap_hwmod *am35xx_hwmods[] =3D {
> =A0 =A0 =A0 =A0&omap3xxx_dss_core_hwmod, /* XXX ??? */
> =A0 =A0 =A0 =A0&am35xx_usbhsotg_hwmod,
> + =A0 =A0 =A0 &omap3xxx_usb_host_hs_hwmod,
> + =A0 =A0 =A0 &omap3xxx_usb_tll_hs_hwmod,
> =A0 =A0 =A0 =A0NULL
> =A0};
>
> --
> 1.7.7
>

This updated patch is working perfectly on 3430 sdp.


regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
