From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 v8] arm: omap: usb: ehci and ohci hwmod structures for omap4
Date: Thu, 15 Sep 2011 12:52:59 +0530
Message-ID: <CAP05o4LbG4xinrkdztJWdO3bMj0WQtEBsOLp7oJ9W0SYGE1fmg@mail.gmail.com>
References: <1314255697-15411-1-git-send-email-keshava_mgowda@ti.com>
	<1314255697-15411-2-git-send-email-keshava_mgowda@ti.com>
	<4E70DB58.9070901@ti.com>
	<CAP05o4KG36-Aa_KeyYe34Rr7E4nYK6w3WB57GzTw24M6PKFsuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP05o4KG36-Aa_KeyYe34Rr7E4nYK6w3WB57GzTw24M6PKFsuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "parthab@india.ti.com" <parthab@india.ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Quadros, Roger" <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 15, 2011 at 11:25 AM, Munegowda, Keshava
<keshava_mgowda@ti.com> wrote:
> On Wed, Sep 14, 2011 at 10:20 PM, Cousson, Benoit <b-cousson@ti.com> =
wrote:
>> Hi Keshava,
>>
>> On 8/25/2011 9:01 AM, Munegowda, Keshava wrote:
>>> From: Benoit Cousson<b-cousson@ti.com>
>>>
>>> Following 4 hwmod structures are added:
>>> UHH hwmod of usbhs with uhh base address and functional clock,
>>> EHCI hwmod with irq and base address,
>>> OHCI hwmod with irq and base address,
>>> TLL hwmod of usbhs with the TLL base address and irq.
>>>
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>
>> That version is really different compared to my original patch, so y=
ou should highlight the diff you introduced.

Since there are too many changes are done compare to your original
patch; i prefer keep a single patch,rather
keeping your original patch and my changes are another patch.


>>> Signed-off-by: Keshava Munegowda<keshava_mgowda@ti.com>
>>> ---
>>> =A0 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0247 +++++++++++=
+++++++++++++++++
>>> =A0 1 files changed, 247 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/=
mach-omap2/omap_hwmod_44xx_data.c
>>> index 6201422..0bc01dd 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> @@ -68,6 +68,10 @@ static struct omap_hwmod omap44xx_mmc2_hwmod;
>>> =A0 static struct omap_hwmod omap44xx_mpu_hwmod;
>>> =A0 static struct omap_hwmod omap44xx_mpu_private_hwmod;
>>> =A0 static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
>>> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod;
>>> +static struct omap_hwmod omap44xx_usbhs_ohci_hwmod;
>>> +static struct omap_hwmod omap44xx_usbhs_ehci_hwmod;
>>> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod;
>>
>> None of the 3 last entries are master, and thus should not need any =
backward declaration.

yes, I will make this change.



>>
>>> =A0 /*
>>> =A0 =A0* Interconnects omap_hwmod structures
>>> @@ -5336,6 +5340,245 @@ static struct omap_hwmod omap44xx_wd_timer3=
_hwmod =3D {
>>> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44=
30),
>>> =A0 };
>>>
>>> +/*
>>> + * 'usb_host_hs' class
>>> + * high-speed multi-port usb host controller
>>> + */
>>> +static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 =3D=
 {
>>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_usb_host_hs_hwmod,
>>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_l3_main_2_hwmod,
>>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDM=
A,
>>> +};
>>> +
>>> +static struct omap_hwmod_class_sysconfig omap44xx_usb_host_hs_sysc=
 =3D {
>>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SI=
DLEMODE),
>>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE=
_SMART |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SIDLE_SMA=
RT_WKUP | MSTANDBY_FORCE |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSTANDBY_=
NO | MSTANDBY_SMART |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSTANDBY_=
SMART_WKUP),
>>
>> Minor, but it should be:
>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SI=
DLE_SMART |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SIDLE_SMART_WKU=
P | MSTANDBY_FORCE | MSTANDBY_NO |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_SMART =
| MSTANDBY_SMART_WKUP),
>>
>>> + =A0 =A0 .sysc_fields =A0 =A0=3D&omap_hwmod_sysc_type2,
>>> +};
>>> +
>>> +static struct omap_hwmod_class omap44xx_usb_host_hs_hwmod_class =3D=
 {
>>> + =A0 =A0 .name =3D "usbhs_uhh",
>>> + =A0 =A0 .sysc =3D&omap44xx_usb_host_hs_sysc,
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_masters[] =3D=
 {
>>> + =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
>>> +};
>>> +
>>> +static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] =3D=
 {
>>> + =A0 =A0 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
>>
>> In general, there is no name for unique entry. And if you need a nam=
e, you should find something relevant considering this is local to the =
hwmod.
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a064000,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a0647ff,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_R=
T
>>> + =A0 =A0 },
>>> + =A0 =A0 {} /* Terminating Entry */
>>
>> That comment is useless. Paul added one space inside the terminator =
as well.
>>
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_hs =3D {
>>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_host_hs_hwmod,
>>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_addrs,
>>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDM=
A,
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_slaves[] =3D=
 {
>>> + =A0 =A0 &omap44xx_l4_cfg__usb_host_hs,
>>> +};
>>> +
>>> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod =3D {
>>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_uhh",
>>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_host_hs_hwmod_=
class,
>>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_host_hs_fck",
>>> + =A0 =A0 .prcm =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_C=
M_L3INIT_USB_HOST_CLKCTRL_OFFSET,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4_R=
M_L3INIT_USB_HOST_CONTEXT_OFFSET,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MODUL=
EMODE_SWCTRL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>>> + =A0 =A0 },
>>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_slaves,
>>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_host_hs_s=
laves),
>>> + =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usb_host_hs_masters,
>>> + =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usb_host_hs_m=
asters),
>>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD_S=
WSUP_MSTANDBY,
>>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430=
),
>>> +};
>>> +
>>> +/* 'usbhs_ohci' class */
>>> +static struct omap_hwmod_class omap44xx_usbhs_ohci_hwmod_class =3D=
 {
>>> + =A0 =A0 .name =3D "usbhs_ohci",
>>
>> In the context of devicetree and considering what Felipe did for the=
 USB3, I'm wondering if you should define hwmods for ohci and ehci.
>> I'm not 100% sure it will apply here, but cannot you add the registe=
r entries inside the usb_host_hs hwmod and create the devices using tha=
t?
>>
>> There is no PRCM entry for them so they do not need to be omap_devic=
e.


you need , ehci and ohci as a different hwmods, because later we can
add the mux to ehc and ochi independently.



>>> +};
>>> +
>>> +static struct omap_hwmod_irq_info omap44xx_usbhs_ohci_irqs[] =3D {
>>> + =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 + OMAP44XX_IRQ_GIC_ST=
ART },
>>
>> Same comment that before about address space name.
>>
>>> + =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
>>> +};
>>> +
>>> +static struct omap_hwmod_addr_space omap44xx_usbhs_ohci_addrs[] =3D=
 {
>>> + =A0 =A0 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
>>
>> Same comment than before.
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064800,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064BFF,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_ON=
_INIT
>>
>> Why do you need that flag?

This address space does not has sysconfig; so hwmod need not to map to
this address.
driver will to ioremap.



>>> + =A0 =A0 },
>>> + =A0 =A0 {}
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usbhs_ohci =3D {
>>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ohci_hwmod,
>>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_addrs,
>>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDM=
A,
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ohci_slaves[] =3D =
{
>>> + =A0 =A0 &omap44xx_l4_cfg__usbhs_ohci,
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ohci_masters[] =3D=
 {
>>> + =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
>>> +};
>>> +
>>> +static struct omap_hwmod omap44xx_usbhs_ohci_hwmod =3D {
>>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_ohci",
>>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ohci_hwmod_c=
lass,
>>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_irqs,
>>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ohci_slaves,
>>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usbhs_ohci_sl=
aves),
>>> + =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usbhs_ohci_masters,
>>> + =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usbhs_ohci_ma=
sters),
>>
>> Assuming you need hwmod entries for that, these master entries are u=
seless and probably wrong.
>> The TRM just documents 2 ports for usb_host_hs and 1 port for usb_tl=
l_hs.

ports are not specific to usbhs or tll,  port 1 and port2  can be used
in phy or tll modes.



>> You will still need the slave for the address space.
>>
>>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430=
),
>>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWMOD=
_NO_IDLEST,
>>> +};
>>> +
>>> +/* 'usbhs_ehci' class */
>>> +static struct omap_hwmod_class omap44xx_usbhs_ehci_hwmod_class =3D=
 {
>>> + =A0 =A0 .name =3D "usbhs_ehci",
>>> +};
>>> +
>>> +static struct omap_hwmod_irq_info omap44xx_usbhs_ehci_irqs[] =3D {
>>> + =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 + OMAP44XX_IRQ_GIC_ST=
ART },
>>> + =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
>>> +};
>>> +
>>> +static struct omap_hwmod_addr_space omap44xx_usbhs_ehci_addrs[] =3D=
 {
>>> + =A0 =A0 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064C00,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064FFF,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_ON=
_INIT
>>> + =A0 =A0 },
>>> + =A0 =A0 {} /* Terminating Entry */
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usbhs_ehci =3D {
>>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ehci_hwmod,
>>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ehci_addrs,
>>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDM=
A,
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ehci_slaves[] =3D =
{
>>> + =A0 =A0 &omap44xx_l4_cfg__usbhs_ehci,
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if *omap44xx_usbhs_ehci_masters[] =3D=
 {
>>> + =A0 =A0 &omap44xx_usb_host_hs__l3_main_2,
>>> +};
>>> +
>>> +
>>> +static struct omap_hwmod omap44xx_usbhs_ehci_hwmod =3D {
>>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_ehci",
>>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usbhs_ehci_hwmod_c=
lass,
>>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usbhs_ehci_irqs,
>>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usbhs_ehci_slaves,
>>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usbhs_ehci_sl=
aves),
>>> + =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usbhs_ehci_masters,
>>> + =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usbhs_ehci_ma=
sters),
>>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430=
),
>>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWMOD=
_NO_IDLEST,
>>> +};
>>> +
>>> +/*
>>> + * 'usb_tll_hs' class
>>> + * usb_tll_hs module is the adapter on the usb_host_hs ports
>>> + */
>>> +static struct omap_hwmod_class_sysconfig omap44xx_usb_tll_hs_sysc =
=3D {
>>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_SID=
LEMODE |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_=
SOFTRESET | SYSC_HAS_ENAWAKEUP |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_=
CLOCKACTIVITY),
>>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE=
_SMART),
>>> + =A0 =A0 .sysc_fields =A0 =A0=3D&omap_hwmod_sysc_type1,
>>> +};
>>> +
>>> +static struct omap_hwmod_class omap44xx_usb_tll_hs_hwmod_class =3D=
 {
>>> + =A0 =A0 .name =3D "usbhs_tll",
>>> + =A0 =A0 .sysc =3D&omap44xx_usb_tll_hs_sysc,
>>> +};
>>> +
>>> +static struct omap_hwmod_irq_info omap44xx_usb_tll_hs_irqs[] =3D {
>>> + =A0 =A0 { .name =3D "tll-irq", .irq =3D 78 + OMAP44XX_IRQ_GIC_STA=
RT },
>>> + =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
>>> +};
>>> +
>>> +static struct omap_hwmod_addr_space omap44xx_usb_tll_hs_addrs[] =3D=
 {
>>> + =A0 =A0 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "tll",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a062000,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a063fff,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_R=
T
>>> + =A0 =A0 },
>>> + =A0 =A0 {} /* Terminating Entry */
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_tll_hs =3D {
>>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_tll_hs_hwmod,
>>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_addrs,
>>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDM=
A,
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if *omap44xx_usb_tll_hs_slaves[] =3D =
{
>>> + =A0 =A0 &omap44xx_l4_cfg__usb_tll_hs,
>>> +};
>>> +
>>> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod =3D {
>>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_tll",
>>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_tll_hs_hwmod_c=
lass,
>>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_irqs,
>>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_tll_hs_ick",
>>> + =A0 =A0 .prcm =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_C=
M_L3INIT_USB_TLL_CLKCTRL_OFFSET,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4_R=
M_L3INIT_USB_TLL_CONTEXT_OFFSET,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MODUL=
EMODE_HWCTRL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>>> + =A0 =A0 },
>>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_tll_hs_slaves,
>>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_tll_hs_sl=
aves),
>>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE,
>>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430=
),
>>> +};
>>> +
>>> =A0 static __initdata struct omap_hwmod *omap44xx_hwmods[] =3D {
>>>
>>> =A0 =A0 =A0 /* dmm class */
>>> @@ -5482,6 +5725,10 @@ static __initdata struct omap_hwmod *omap44x=
x_hwmods[] =3D {
>>> =A0 =A0 =A0 &omap44xx_wd_timer2_hwmod,
>>> =A0 =A0 =A0 &omap44xx_wd_timer3_hwmod,
>>>
>>> + =A0 =A0 &omap44xx_usb_host_hs_hwmod,
>>> + =A0 =A0 &omap44xx_usbhs_ohci_hwmod,
>>> + =A0 =A0 &omap44xx_usbhs_ehci_hwmod,
>>> + =A0 =A0 &omap44xx_usb_tll_hs_hwmod,
>>
>> This list is ordered, so it should be something like that:

yes, i will do this.


>>
>> =A0 =A0 =A0 =A0&omap44xx_uart3_hwmod,
>> =A0 =A0 =A0 =A0&omap44xx_uart4_hwmod,
>>
>> + =A0 =A0 =A0 /* usb_host_hs class */
>> + =A0 =A0 =A0 &omap44xx_usb_host_hs_hwmod,
>> +
>> =A0 =A0 =A0 =A0/* usb_otg_hs class */
>> =A0 =A0 =A0 =A0&omap44xx_usb_otg_hs_hwmod,
>>
>> + =A0 =A0 =A0 /* usb_tll_hs class */
>> + =A0 =A0 =A0 &omap44xx_usb_tll_hs_hwmod,
>> +
>> =A0 =A0 =A0 =A0/* wd_timer class */
>> =A0 =A0 =A0 =A0&omap44xx_wd_timer2_hwmod,
>> =A0 =A0 =A0 =A0&omap44xx_wd_timer3_hwmod,
>>
>> Regards,
>> Benoit
>
>
> Thanks benoit,
> I make the changes as per your comments ! I will send the new set of
> patches today only.
>
>
> regards
> keshava
>
