From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/6 v2] omap: musb: Adding hwmod data for ti81xx
Date: Thu, 8 Sep 2011 14:17:39 +0530
Message-ID: <CAP05o4+WjKJZDH1k1Rzrzju2yQEHQ7Z96qhU5qY0oD5NRoddJg@mail.gmail.com>
References: <1315414945-19829-1-git-send-email-ajay.gupta@ti.com>
	<1315414945-19829-2-git-send-email-ajay.gupta@ti.com>
	<CAP05o4Lfas96izGGVQN0qkTRX_kwUncPWVX2d6+izh4YMuQ6dA@mail.gmail.com>
	<20110908080004.GD7707@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110908080004.GD7707-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 8, 2011 at 1:30 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Thu, Sep 08, 2011 at 11:56:25AM +0530, Munegowda, Keshava wrote:
>> On Wed, Sep 7, 2011 at 10:32 PM, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org=
> wrote:
>> > From: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
>> >
>> > The usb subsystem (usbss) in ti81xx has two musb interfaces. There=
 are three
>> > irqs and three address spaces for usbss, musb0 and musb1 respectiv=
ely. Created
>> > one hwmod with three irq and memory resources.
>> >
>> > Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>> > Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>> > Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
>> > ---
>> > =A0arch/arm/mach-omap2/omap_hwmod_81xx_data.c | =A0 74 +++++++++++=
+++++++++++++++++
>> > =A01 files changed, 74 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm=
/mach-omap2/omap_hwmod_81xx_data.c
>> > index e73a4c6..e960d70 100644
>> > --- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>> > +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>> > @@ -194,6 +194,7 @@ static struct omap_hwmod ti81xx_timer4_hwmod;
>> > =A0static struct omap_hwmod ti81xx_timer5_hwmod;
>> > =A0static struct omap_hwmod ti81xx_timer6_hwmod;
>> > =A0static struct omap_hwmod ti81xx_timer7_hwmod;
>> > +static struct omap_hwmod ti81xx_usbss_hwmod;
>> >
>> > =A0/* L4 SLOW -> TIMER1 interface */
>> > =A0static struct omap_hwmod_addr_space ti81xx_timer1_addr_space[] =
=3D {
>> > @@ -650,6 +651,78 @@ static struct omap_hwmod ti81xx_timer7_hwmod =
=3D {
>> > =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_TI=
816X | CHIP_IS_TI814X)
>> > =A0};
>> >
>> > +/* L3 SLOW -> USBSS interface */
>> > +static struct omap_hwmod_addr_space ti81xx_usbss_addr_space[] =3D=
 {
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usbss=
",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x47400000=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x474000=
00 + SZ_4K - 1,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_T=
YPE_RT
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "musb0=
",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x47401000=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x474010=
00 + SZ_2K - 1,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_T=
YPE_RT
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "musb1=
",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x47401800=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x474018=
00 + SZ_2K - 1,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_T=
YPE_RT
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 },
>> > +};
>> > +
>> > +static struct omap_hwmod_class_sysconfig ti81xx_usbhsotg_sysc =3D=
 {
>> > + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0,
>> > + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x10,
>> > + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_SIDLEMODE | SYSC_H=
AS_SOFTRESET),
>> > + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | =
SIDLE_SMART),
>> > + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type2,
>> > +};
>> > +
>> > +static struct omap_hwmod_class ti81xx_usbotg_class =3D {
>> > + =A0 =A0 =A0 .name =3D "usbotg",
>> > + =A0 =A0 =A0 .sysc =3D &ti81xx_usbhsotg_sysc,
>> > +};
>> > +
>> > +static struct omap_hwmod_irq_info ti81xx_usbss_mpu_irqs[] =3D {
>> > + =A0 =A0 =A0 { .name =3D "usbss-irq", .irq =3D 17, },
>> > + =A0 =A0 =A0 { .name =3D "musb0-irq", .irq =3D 18, },
>> > + =A0 =A0 =A0 { .name =3D "musb1-irq", .irq =3D 19, },
>> > + =A0 =A0 =A0 { .irq =3D -1, },
>> > +};
>> > +
>> > +static struct omap_hwmod_ocp_if ti81xx_l3_slow__usbss =3D {
>> > + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &ti81xx_l3_slow_hwmod,
>> > + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &ti81xx_usbss_hwmod,
>> > + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbotg_ick",
>> > + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D ti81xx_usbss_addr_spac=
e,
>> > + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> > + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>> > +};
>> > +
>> > +static struct omap_hwmod_ocp_if *ti81xx_usbss_slaves[] =3D {
>> > + =A0 =A0 =A0 &ti81xx_l3_slow__usbss,
>> > +};
>> > +
>> > +static struct omap_hwmod ti81xx_usbss_hwmod =3D {
>> > + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_otg_hs",
>> > + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D ti81xx_usbss_mpu_irqs,
>> > + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbotg_ick",
>> > + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "default_usb_clkdm",
>> > + =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D TI=
816X_CM_DEFAULT_USB_CLKCTRL_OFFSET,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D ti81xx_usbss_slaves,
>> > + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(ti81xx_usbss_slav=
es),
>> > + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &ti81xx_usbotg_class,
>> > + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_TI8=
16X | CHIP_IS_TI814X)
>> > +};
>> >
>> > =A0static __initdata struct omap_hwmod *ti81xx_hwmods[] =3D {
>> > =A0 =A0 =A0 =A0&ti81xx_l3_fast_hwmod,
>> > @@ -668,6 +741,7 @@ static __initdata struct omap_hwmod *ti81xx_hw=
mods[] =3D {
>> > =A0 =A0 =A0 =A0&ti81xx_timer5_hwmod,
>> > =A0 =A0 =A0 =A0&ti81xx_timer6_hwmod,
>> > =A0 =A0 =A0 =A0&ti81xx_timer7_hwmod,
>> > + =A0 =A0 =A0 &ti81xx_usbss_hwmod,
>> > =A0 =A0 =A0 =A0NULL,
>> > =A0};
>> >
>> > --
>> > 1.6.2.4
>>
>> looks good to me.
>
> how about you reply with your Acked-by then ?
>
> --
> balbi

yes balbi,
     here it is

Acked-By: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
