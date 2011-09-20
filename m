From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 v9] arm: omap: usb: ehci and ohci hwmod structures for omap4
Date: Tue, 20 Sep 2011 20:05:44 +0530
Message-ID: <CAP05o4LE+9pWkePa3d3pMaoCi1g2Wo06-GJ5Ve4pKreMCajHNA@mail.gmail.com>
References: <1316092970-2440-1-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-2-git-send-email-keshava_mgowda@ti.com>
	<4E77AA21.3040304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E77AA21.3040304@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "parthab@india.ti.com" <parthab@india.ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 20, 2011 at 2:16 AM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Keshava,
>
> I've just replied to your previous v8 version about the comments you =
didn't
> take into account.
> I just have one minor nit on that one I missed previously, plus a cou=
ple of
> clarifications.
>
> On 9/15/2011 3:22 PM, Munegowda, Keshava wrote:
>>
>> From: Benoit Cousson<b-cousson@ti.com>
>>
>> Following 4 hwmod structures are added:
>> UHH hwmod of usbhs with uhh base address and functional clock,
>> EHCI hwmod with irq and base address,
>> OHCI hwmod with irq and base address,
>> TLL hwmod of usbhs with the TLL base address and irq.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Keshava Munegowda<keshava_mgowda@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0249
>> +++++++++++++++++++++++++++-
>> =A01 files changed, 248 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 6201422..f06efa6 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -68,6 +68,10 @@ static struct omap_hwmod omap44xx_mmc2_hwmod;
>> =A0static struct omap_hwmod omap44xx_mpu_hwmod;
>> =A0static struct omap_hwmod omap44xx_mpu_private_hwmod;
>> =A0static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
>> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod;
>> +static struct omap_hwmod omap44xx_usbhs_ohci_hwmod;
>> +static struct omap_hwmod omap44xx_usbhs_ehci_hwmod;
>> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod;
>>
>> =A0/*
>> =A0 * Interconnects omap_hwmod structures
>> @@ -5336,6 +5340,244 @@ static struct omap_hwmod omap44xx_wd_timer3_=
hwmod
>> =3D {
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
>> =A0};
>>
>> +/*
>> + * 'usb_host_hs' class
>> + * high-speed multi-port usb host controller
>> + */
>> +static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 =3D=
 {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_usb_host_hs_hwmod=
,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_l3_main_2_hwmod=
,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
>> +};
>> +
>> +static struct omap_hwmod_class_sysconfig omap44xx_usb_host_hs_sysc =
=3D {
>> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS=
_SIDLEMODE),
>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SI=
DLE_SMART |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SIDLE_SMART_WKUP | MST=
ANDBY_FORCE | MSTANDBY_NO |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSTANDBY_SMART | MSTAN=
DBY_SMART_WKUP),
>> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D&omap_hwmod_sysc_type2,
>> +};
>> +
>> +static struct omap_hwmod_class omap44xx_usb_host_hs_hwmod_class =3D=
 {
>> + =A0 =A0 =A0 .name =3D "usbhs_uhh",
>> + =A0 =A0 =A0 .sysc =3D&omap44xx_usb_host_hs_sysc,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_masters[] =3D=
 {
>> + =A0 =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a064000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a0647ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 {}
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_hs =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_host_hs_hwm=
od,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_add=
rs,
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_slaves[] =3D =
{
>> + =A0 =A0 =A0 &omap44xx_l4_cfg__usb_host_hs,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_uhh",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_host_hs_hwm=
od_class,
>> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_host_hs_fck",
>> + =A0 =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D
>> OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D
>> OMAP4_RM_L3INIT_USB_HOST_CONTEXT_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MO=
DULEMODE_SWCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_slave=
s,
>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_host_h=
s_slaves),
>> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usb_host_hs_maste=
rs,
>> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usb_host_h=
s_masters),
>> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMO=
D_SWSUP_MSTANDBY,
>
> Why do you need these flags? These flags are reserved for non-standar=
d
> behavior / HW bugs. I know that this IP is full of various bugs, but =
it will
> be nice to add some explanation in the changelog and a small comment =
here as
> well.
>
>> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4=
430),
>> +};
>> +
>> +/* 'usbhs_ohci' class */
>> +static struct omap_hwmod_class omap44xx_usbhs_ohci_hwmod_class =3D =
{
>> + =A0 =A0 =A0 .name =3D "usbhs_ohci",
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap44xx_usbhs_ohci_irqs[] =3D {
>> + =A0 =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 + OMAP44XX_IRQ_GIC=
_START },
>> + =A0 =A0 =A0 { .irq =3D -1 }
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_usbhs_ohci_addrs[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064800,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064BFF=
,
>
> Nit: Please use lower case for hexa value. This is applicable for the=
 whole
> patch.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP=
_ON_INIT
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 {}
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usbhs_ohci =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ohci_hwmo=
d,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_addr=
s,
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ohci_slaves[] =3D {
>> + =A0 =A0 =A0 &omap44xx_l4_cfg__usbhs_ohci,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ohci_masters[] =3D =
{
>> + =A0 =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
>> +};
>> +
>> +static struct omap_hwmod omap44xx_usbhs_ohci_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_ohci",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ohci_hwmo=
d_class,
>> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_irqs,
>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_slaves=
,
>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usbhs_ohci=
_slaves),
>> + =A0 =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usbhs_ohci_master=
s,
>> + =A0 =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usbhs_ohci=
_masters),
>> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4=
430),
>> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HW=
MOD_NO_IDLEST,
>
> Same question about these flags. Why do you need these? Please add so=
me
> explanation.
>
> That comment is applicable for the remaining flags. These flags are p=
robably
> all needed for that kind of IP, but the least you should do is to add=
 some
> explanation.
>
> Thanks,
> Benoit
>

Hi Benoit
         I have posted v10 covering all your comments which you have
mentioned in this mail

regards
keshava
