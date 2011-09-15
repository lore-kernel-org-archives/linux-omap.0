From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 v8] arm: omap: usb: ehci and ohci hwmod structures for omap4
Date: Thu, 15 Sep 2011 11:25:58 +0530
Message-ID: <CAP05o4KG36-Aa_KeyYe34Rr7E4nYK6w3WB57GzTw24M6PKFsuw@mail.gmail.com>
References: <1314255697-15411-1-git-send-email-keshava_mgowda@ti.com>
	<1314255697-15411-2-git-send-email-keshava_mgowda@ti.com>
	<4E70DB58.9070901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E70DB58.9070901-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org" <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org" <johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, "Sripathy, Vishwanath" <vishwanath.bs-l0cyMroinI0@public.gmane.org>, "Quadros, Roger" <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 14, 2011 at 10:20 PM, Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org> wr=
ote:
> Hi Keshava,
>
> On 8/25/2011 9:01 AM, Munegowda, Keshava wrote:
>> From: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
>>
>> Following 4 hwmod structures are added:
>> UHH hwmod of usbhs with uhh base address and functional clock,
>> EHCI hwmod with irq and base address,
>> OHCI hwmod with irq and base address,
>> TLL hwmod of usbhs with the TLL base address and irq.
>>
>> Signed-off-by: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
>
> That version is really different compared to my original patch, so yo=
u should highlight the diff you introduced.
>
>> Signed-off-by: Keshava Munegowda<keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> ---
>> =A0 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0247 ++++++++++++=
++++++++++++++++
>> =A0 1 files changed, 247 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index 6201422..0bc01dd 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -68,6 +68,10 @@ static struct omap_hwmod omap44xx_mmc2_hwmod;
>> =A0 static struct omap_hwmod omap44xx_mpu_hwmod;
>> =A0 static struct omap_hwmod omap44xx_mpu_private_hwmod;
>> =A0 static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
>> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod;
>> +static struct omap_hwmod omap44xx_usbhs_ohci_hwmod;
>> +static struct omap_hwmod omap44xx_usbhs_ehci_hwmod;
>> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod;
>
> None of the 3 last entries are master, and thus should not need any b=
ackward declaration.
>
>> =A0 /*
>> =A0 =A0* Interconnects omap_hwmod structures
>> @@ -5336,6 +5340,245 @@ static struct omap_hwmod omap44xx_wd_timer3_=
hwmod =3D {
>> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP443=
0),
>> =A0 };
>>
>> +/*
>> + * 'usb_host_hs' class
>> + * high-speed multi-port usb host controller
>> + */
>> +static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 =3D=
 {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_usb_host_hs_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_l3_main_2_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_class_sysconfig omap44xx_usb_host_hs_sysc =
=3D {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SID=
LEMODE),
>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SIDLE_SMAR=
T_WKUP | MSTANDBY_FORCE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSTANDBY_N=
O | MSTANDBY_SMART |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSTANDBY_S=
MART_WKUP),
>
> Minor, but it should be:
> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SIDLE_SMART_WKUP=
 | MSTANDBY_FORCE | MSTANDBY_NO |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_SMART |=
 MSTANDBY_SMART_WKUP),
>
>> + =A0 =A0 .sysc_fields =A0 =A0=3D&omap_hwmod_sysc_type2,
>> +};
>> +
>> +static struct omap_hwmod_class omap44xx_usb_host_hs_hwmod_class =3D=
 {
>> + =A0 =A0 .name =3D "usbhs_uhh",
>> + =A0 =A0 .sysc =3D&omap44xx_usb_host_hs_sysc,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_masters[] =3D=
 {
>> + =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
>
> In general, there is no name for unique entry. And if you need a name=
, you should find something relevant considering this is local to the h=
wmod.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a064000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a0647ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> + =A0 =A0 {} /* Terminating Entry */
>
> That comment is useless. Paul added one space inside the terminator a=
s well.
>
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_hs =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_host_hs_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_slaves[] =3D =
{
>> + =A0 =A0 &omap44xx_l4_cfg__usb_host_hs,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_uhh",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_host_hs_hwmod_c=
lass,
>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_host_hs_fck",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_CM=
_L3INIT_USB_HOST_CLKCTRL_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4_RM=
_L3INIT_USB_HOST_CONTEXT_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MODULE=
MODE_SWCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_host_hs_sl=
aves),
>> + =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usb_host_hs_masters,
>> + =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usb_host_hs_ma=
sters),
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD_SW=
SUP_MSTANDBY,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> +};
>> +
>> +/* 'usbhs_ohci' class */
>> +static struct omap_hwmod_class omap44xx_usbhs_ohci_hwmod_class =3D =
{
>> + =A0 =A0 .name =3D "usbhs_ohci",
>
> In the context of devicetree and considering what Felipe did for the =
USB3, I'm wondering if you should define hwmods for ohci and ehci.
> I'm not 100% sure it will apply here, but cannot you add the register=
 entries inside the usb_host_hs hwmod and create the devices using that=
?
>
> There is no PRCM entry for them so they do not need to be omap_device=
=2E
>
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap44xx_usbhs_ohci_irqs[] =3D {
>> + =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 + OMAP44XX_IRQ_GIC_STA=
RT },
>
> Same comment that before about address space name.
>
>> + =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_usbhs_ohci_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
>
> Same comment than before.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064800,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064BFF,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_ON_=
INIT
>
> Why do you need that flag?
>
>> + =A0 =A0 },
>> + =A0 =A0 {}
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usbhs_ohci =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ohci_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ohci_slaves[] =3D {
>> + =A0 =A0 &omap44xx_l4_cfg__usbhs_ohci,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ohci_masters[] =3D =
{
>> + =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_usbhs_ohci_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_ohci",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ohci_hwmod_cl=
ass,
>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_irqs,
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usbhs_ohci_sla=
ves),
>> + =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usbhs_ohci_masters,
>> + =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usbhs_ohci_mas=
ters),
>
> Assuming you need hwmod entries for that, these master entries are us=
eless and probably wrong.
> The TRM just documents 2 ports for usb_host_hs and 1 port for usb_tll=
_hs.
>
> You will still need the slave for the address space.
>
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWMOD_=
NO_IDLEST,
>> +};
>> +
>> +/* 'usbhs_ehci' class */
>> +static struct omap_hwmod_class omap44xx_usbhs_ehci_hwmod_class =3D =
{
>> + =A0 =A0 .name =3D "usbhs_ehci",
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap44xx_usbhs_ehci_irqs[] =3D {
>> + =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 + OMAP44XX_IRQ_GIC_STA=
RT },
>> + =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_usbhs_ehci_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064C00,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064FFF,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_ON_=
INIT
>> + =A0 =A0 },
>> + =A0 =A0 {} /* Terminating Entry */
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usbhs_ehci =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ehci_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ehci_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ehci_slaves[] =3D {
>> + =A0 =A0 &omap44xx_l4_cfg__usbhs_ehci,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ehci_masters[] =3D =
{
>> + =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
>> +};
>> +
>> +
>> +static struct omap_hwmod omap44xx_usbhs_ehci_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_ehci",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ehci_hwmod_cl=
ass,
>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usbhs_ehci_irqs,
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ehci_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usbhs_ehci_sla=
ves),
>> + =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usbhs_ehci_masters,
>> + =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usbhs_ehci_mas=
ters),
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWMOD_=
NO_IDLEST,
>> +};
>> +
>> +/*
>> + * 'usb_tll_hs' class
>> + * usb_tll_hs module is the adapter on the usb_host_hs ports
>> + */
>> +static struct omap_hwmod_class_sysconfig omap44xx_usb_tll_hs_sysc =3D=
 {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDL=
EMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_S=
OFTRESET | SYSC_HAS_ENAWAKEUP |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_C=
LOCKACTIVITY),
>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART),
>> + =A0 =A0 .sysc_fields =A0 =A0=3D&omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap44xx_usb_tll_hs_hwmod_class =3D =
{
>> + =A0 =A0 .name =3D "usbhs_tll",
>> + =A0 =A0 .sysc =3D&omap44xx_usb_tll_hs_sysc,
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap44xx_usb_tll_hs_irqs[] =3D {
>> + =A0 =A0 { .name =3D "tll-irq", .irq =3D 78 + OMAP44XX_IRQ_GIC_STAR=
T },
>> + =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_usb_tll_hs_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "tll",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a062000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a063fff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> + =A0 =A0 {} /* Terminating Entry */
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_tll_hs =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_tll_hs_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usb_tll_hs_slaves[] =3D {
>> + =A0 =A0 &omap44xx_l4_cfg__usb_tll_hs,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_tll",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_tll_hs_hwmod_cl=
ass,
>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_irqs,
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_tll_hs_ick",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_CM=
_L3INIT_USB_TLL_CLKCTRL_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4_RM=
_L3INIT_USB_TLL_CONTEXT_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MODULE=
MODE_HWCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_tll_hs_sla=
ves),
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> +};
>> +
>> =A0 static __initdata struct omap_hwmod *omap44xx_hwmods[] =3D {
>>
>> =A0 =A0 =A0 /* dmm class */
>> @@ -5482,6 +5725,10 @@ static __initdata struct omap_hwmod *omap44xx=
_hwmods[] =3D {
>> =A0 =A0 =A0 &omap44xx_wd_timer2_hwmod,
>> =A0 =A0 =A0 &omap44xx_wd_timer3_hwmod,
>>
>> + =A0 =A0 &omap44xx_usb_host_hs_hwmod,
>> + =A0 =A0 &omap44xx_usbhs_ohci_hwmod,
>> + =A0 =A0 &omap44xx_usbhs_ehci_hwmod,
>> + =A0 =A0 &omap44xx_usb_tll_hs_hwmod,
>
> This list is ordered, so it should be something like that:
>
> =A0 =A0 =A0 =A0&omap44xx_uart3_hwmod,
> =A0 =A0 =A0 =A0&omap44xx_uart4_hwmod,
>
> + =A0 =A0 =A0 /* usb_host_hs class */
> + =A0 =A0 =A0 &omap44xx_usb_host_hs_hwmod,
> +
> =A0 =A0 =A0 =A0/* usb_otg_hs class */
> =A0 =A0 =A0 =A0&omap44xx_usb_otg_hs_hwmod,
>
> + =A0 =A0 =A0 /* usb_tll_hs class */
> + =A0 =A0 =A0 &omap44xx_usb_tll_hs_hwmod,
> +
> =A0 =A0 =A0 =A0/* wd_timer class */
> =A0 =A0 =A0 =A0&omap44xx_wd_timer2_hwmod,
> =A0 =A0 =A0 =A0&omap44xx_wd_timer3_hwmod,
>
> Regards,
> Benoit


Thanks benoit,
I make the changes as per your comments ! I will send the new set of
patches today only.


regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
