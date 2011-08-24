From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 v5] arm: omap: usb: ehci and ohci hwmod structures for omap4
Date: Wed, 24 Aug 2011 16:30:22 +0530
Message-ID: <CAP05o4K1XZi1S9APgTYWSoO487BZS8dCSLtknqCtThSrX1ahZw@mail.gmail.com>
References: <1313581439-4279-1-git-send-email-keshava_mgowda@ti.com>
	<1313581439-4279-2-git-send-email-keshava_mgowda@ti.com>
	<4E54A0EA.1080102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E54A0EA.1080102-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: b-cousson-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, toddpoynor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 24, 2011 at 12:27 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On 08/17/2011 02:43 PM, Keshava Munegowda wrote:
>> From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>>
>> Following 4 hwmod strcuture are added:
>> UHH hwmod of usbhs with uhh base address and functional clock,
>> EHCI hwmod with irq and base address,
>> OHCI hwmod with irq and base address,
>> TLL hwmod of usbhs with the TLL base address and irq.
>>
>> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0244 +++++++++++++=
+++++++++++++++
>> =A01 files changed, 244 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index 6201422..d8f08fa 100644
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
>> @@ -5336,6 +5340,242 @@ static struct omap_hwmod omap44xx_wd_timer3_=
hwmod =3D {
>> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP443=
0),
>> =A0};
>>
>> +/*
>> + * 'usb_host_hs' class
>> + * high-speed multi-port usb host controller
>> + */
>> +static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 =3D=
 {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_usb_host_hs_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_l3_main_2_hwmod,
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
>
> what about SYSC_HAS_SOFTRESET?

Yes, I will add this for omap3 , for omap4 this flag is causing
enumeration issue.
for now , I will not add this for 4430.


>
>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART |
>
> Did you intentionally miss out SIDLE_SMART_WKUP ?

it is not there for omap3 but I will add this for omap4.


>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORCE | MS=
TANDBY_NO | MSTANDBY_SMART |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MSTANDBY_S=
MART_WKUP),
>> + =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type2,
>> +};
>> +
>
> ...
> <snip>
> ...
>
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
EMODE),
>
> what about SYSC_HAS_SOFTRESET, SYSC_HAS_ENAWAKEUP and
> SYSC_HAS_CLOCKACTIVITY?

yes, I will add these flags ;


I will send the v7 soon.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
