From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 v8] arm: omap: usb: ehci and ohci hwmod structures for omap4
Date: Tue, 20 Sep 2011 20:20:53 +0530
Message-ID: <CAP05o4+=XPr26b6RY6f5BC3x31vCFdsfT90Da=vqo7HkbzTb2A@mail.gmail.com>
References: <1314255697-15411-1-git-send-email-keshava_mgowda@ti.com>
	<1314255697-15411-2-git-send-email-keshava_mgowda@ti.com>
	<4E70DB58.9070901@ti.com>
	<CAP05o4KG36-Aa_KeyYe34Rr7E4nYK6w3WB57GzTw24M6PKFsuw@mail.gmail.com>
	<CAP05o4LbG4xinrkdztJWdO3bMj0WQtEBsOLp7oJ9W0SYGE1fmg@mail.gmail.com>
	<4E77A717.8020504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E77A717.8020504-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org" <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org" <johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, "Sripathy, Vishwanath" <vishwanath.bs-l0cyMroinI0@public.gmane.org>, "Quadros, Roger" <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 20, 2011 at 2:03 AM, Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org> wro=
te:
> OK, it looks like the second half of the answer was in a second email=
=2E..
> that makes sense:-)
>
> On 9/15/2011 9:22 AM, Munegowda, Keshava wrote:
>>
>> On Thu, Sep 15, 2011 at 11:25 AM, Munegowda, Keshava
>> <keshava_mgowda-l0cyMroinI0@public.gmane.org> =A0wrote:
>>>
>>> On Wed, Sep 14, 2011 at 10:20 PM, Cousson, Benoit<b-cousson-l0cyMroinI0@public.gmane.org>
>>> =A0wrote:
>>>>
>>>> Hi Keshava,
>>>>
>>>> On 8/25/2011 9:01 AM, Munegowda, Keshava wrote:
>>>>>
>>>>> From: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
>>>>>
>>>>> Following 4 hwmod structures are added:
>>>>> UHH hwmod of usbhs with uhh base address and functional clock,
>>>>> EHCI hwmod with irq and base address,
>>>>> OHCI hwmod with irq and base address,
>>>>> TLL hwmod of usbhs with the TLL base address and irq.
>>>>>
>>>>> Signed-off-by: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
>>>>
>>>> That version is really different compared to my original patch, so=
 you
>>>> should highlight the diff you introduced.
>>
>> Since there are too many changes are done compare to your original
>> patch; i prefer keep a single patch,rather
>> keeping your original patch and my changes are another patch.
>
> This is not really what I was asking for. You changed at least 30% of=
 the
> original patch without mentioning anything in the changelog.
> You should at least add a history to clarify what part you edited / a=
dded
> compared to the original.
>
>>>>> Signed-off-by: Keshava Munegowda<keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>>>> ---
>>>>> =A0 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0247
>>>>> ++++++++++++++++++++++++++++
>>>>> =A0 1 files changed, 247 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>> index 6201422..0bc01dd 100644
>>>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>> @@ -68,6 +68,10 @@ static struct omap_hwmod omap44xx_mmc2_hwmod;
>>>>> =A0 static struct omap_hwmod omap44xx_mpu_hwmod;
>>>>> =A0 static struct omap_hwmod omap44xx_mpu_private_hwmod;
>>>>> =A0 static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
>>>>> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod;
>>>>> +static struct omap_hwmod omap44xx_usbhs_ohci_hwmod;
>>>>> +static struct omap_hwmod omap44xx_usbhs_ehci_hwmod;
>>>>> +static struct omap_hwmod omap44xx_usb_tll_hs_hwmod;
>>>>
>>>> None of the 3 last entries are master, and thus should not need an=
y
>>>> backward declaration.
>>
>> yes, I will make this change.
>
> But you didn't...

If I remove these backward declaration It is causing compilation error;
This is because omap44xx_l4_cfg__usbhs_ohci structures includes
omap44xx_usbhs_ohci_hwmod structure and then this structure
omap44xx_usbhs_ohci_hwmod
is defined; you need backward declaration;
please let me know if i am missing anything here.


>>>>> =A0 /*
>>>>> =A0 =A0* Interconnects omap_hwmod structures
>>>>> @@ -5336,6 +5340,245 @@ static struct omap_hwmod
>>>>> omap44xx_wd_timer3_hwmod =3D {
>>>>> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
>>>>> =A0 };
>>>>>
>>>>> +/*
>>>>> + * 'usb_host_hs' class
>>>>> + * high-speed multi-port usb host controller
>>>>> + */
>>>>> +static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 =
=3D {
>>>>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_usb_host_hs_hwmod,
>>>>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_l3_main_2_hwmod,
>>>>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l3_div_ck",
>>>>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod_class_sysconfig omap44xx_usb_host_hs_sy=
sc =3D {
>>>>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>>>>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>>>>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>>>>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_=
SIDLEMODE),
>>>>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SID=
LE_SMART |
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SIDLE_S=
MART_WKUP | MSTANDBY_FORCE |
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSTANDB=
Y_NO | MSTANDBY_SMART |
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSTANDB=
Y_SMART_WKUP),
>>>>
>>>> Minor, but it should be:
>>>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | =
SIDLE_SMART |
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SIDLE_SMART_W=
KUP | MSTANDBY_FORCE |
>>>> MSTANDBY_NO |
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_SMAR=
T | MSTANDBY_SMART_WKUP),
>>>>
>>>>> + =A0 =A0 .sysc_fields =A0 =A0=3D&omap_hwmod_sysc_type2,
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod_class omap44xx_usb_host_hs_hwmod_class =
=3D {
>>>>> + =A0 =A0 .name =3D "usbhs_uhh",
>>>>> + =A0 =A0 .sysc =3D&omap44xx_usb_host_hs_sysc,
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_masters[] =
=3D {
>>>>> +&omap44xx_usb_host_hs__l3_main_2,
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[]=
 =3D {
>>>>> + =A0 =A0 {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
>>>>
>>>> In general, there is no name for unique entry. And if you need a n=
ame,
>>>> you should find something relevant considering this is local to th=
e hwmod.
>
> No answer and no change on that one.

The usbhs driver internally uses platform_get_resource_byname , hence
it is useful.


>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a064000,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a0647ff,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE=
_RT
>>>>> + =A0 =A0 },
>>>>> + =A0 =A0 {} /* Terminating Entry */
>>>>
>>>> That comment is useless. Paul added one space inside the terminato=
r as
>>>> well.
>>>>
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_hs =3D=
 {
>>>>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l4_cfg_hwmod,
>>>>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_host_hs_hwmo=
d,
>>>>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>>>>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_addr=
s,
>>>>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_S=
DMA,
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_slaves[] =3D=
 {
>>>>> +&omap44xx_l4_cfg__usb_host_hs,
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod omap44xx_usb_host_hs_hwmod =3D {
>>>>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbhs_uhh",
>>>>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_usb_host_hs_hwmo=
d_class,
>>>>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
>>>>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usb_host_hs_fck",
>>>>> + =A0 =A0 .prcm =3D {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D
>>>>> OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D
>>>>> OMAP4_RM_L3INIT_USB_HOST_CONTEXT_OFFSET,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MOD=
ULEMODE_SWCTRL,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>>>>> + =A0 =A0 },
>>>>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_usb_host_hs_slaves=
,
>>>>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_usb_host_hs=
_slaves),
>>>>> + =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap44xx_usb_host_hs_master=
s,
>>>>> + =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_usb_host_hs=
_masters),
>>>>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD=
_SWSUP_MSTANDBY,
>>>>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44=
30),
>>>>> +};
>>>>> +
>>>>> +/* 'usbhs_ohci' class */
>>>>> +static struct omap_hwmod_class omap44xx_usbhs_ohci_hwmod_class =3D=
 {
>>>>> + =A0 =A0 .name =3D "usbhs_ohci",
>>>>
>>>> In the context of devicetree and considering what Felipe did for t=
he
>>>> USB3, I'm wondering if you should define hwmods for ohci and ehci.
>>>> I'm not 100% sure it will apply here, but cannot you add the regis=
ter
>>>> entries inside the usb_host_hs hwmod and create the devices using =
that?
>>>>
>>>> There is no PRCM entry for them so they do not need to be omap_dev=
ice.
>>
>>
>> you need , ehci and ohci as a different hwmods, because later we can
>> add the mux to ehc and ochi independently.
>
> So what? Why do you need 2 hwmods for that? cannot you have regular
> platform_device for that purpose?
>
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod_irq_info omap44xx_usbhs_ohci_irqs[] =3D=
 {
>>>>> + =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 + OMAP44XX_IRQ_GIC_=
START },
>>>>
>>>> Same comment that before about address space name.
>>>>
>>>>> + =A0 =A0 { .irq =3D -1 } /* Terminating IRQ */
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod_addr_space omap44xx_usbhs_ohci_addrs[] =
=3D {
>>>>> + =A0 =A0 {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
>>>>
>>>> Same comment than before.
>>>>
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4A064800,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4A064BFF,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_MAP_=
ON_INIT
>>>>
>>>> Why do you need that flag?
>>
>> This address space does not has sysconfig; so hwmod need not to map =
to
>> this address.
>> driver will to ioremap.
>
> I do agree for the first part, but that does not explain why you did =
add
> that flag? Have you check the behavior of that flag?
> No using the ADDR_TYPE_RT does not mean you have to add that flag.

In hwmod code, I am seeing that ioremap is done if ADDR_TYPE_RT is set.
But, for ehci and ohci address space , the usbhs driver does it
ioremap indirectly
by child drivers ehci and ohci; hence I feel ADDR_MAP_ON_INIT sufficien=
t.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
