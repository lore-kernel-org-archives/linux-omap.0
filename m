From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v14] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Fri, 14 Oct 2011 15:22:02 +0530
Message-ID: <CAP05o4J60+xD_vtfqyqUM3CJPK8LOzWPMUJcJj08RnVnejXD8w@mail.gmail.com>
References: <1318319355-20168-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1110131227270.24155@utopia.booyaka.com>
	<alpine.DEB.2.00.1110131857350.24155@utopia.booyaka.com>
	<CAP05o4JAuCtj_i=Nye2afV8vv23i=qC0zO4a7sYP+hcn3QqHnA@mail.gmail.com>
	<alpine.DEB.2.00.1110140205460.16865@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1110140205460.16865@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 14, 2011 at 1:41 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Fri, 14 Oct 2011, Munegowda, Keshava wrote:
>
>> On Fri, Oct 14, 2011 at 6:33 AM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>
>> > =A0static __initdata struct omap_hwmod *omap3xxx_hwmods[] =3D {
>> > =A0 =A0 =A0 =A0&omap3xxx_l3_main_hwmod,
>> > =A0 =A0 =A0 =A0&omap3xxx_l4_core_hwmod,
>> > @@ -3151,6 +3365,7 @@ static __initdata struct omap_hwmod *omap3xx=
x_hwmods[] =3D {
>> > =A0 =A0 =A0 =A0&omap3xxx_uart1_hwmod,
>> > =A0 =A0 =A0 =A0&omap3xxx_uart2_hwmod,
>> > =A0 =A0 =A0 =A0&omap3xxx_uart3_hwmod,
>> > +
>>
>> why you have removed =A0&omap3xxx_usb_host_hs_hwmod,
>> and =A0 =A0 =A0 &omap3xxx_usb_tll_hs_hwmod.?
>
> I have removed them because, according to the OMAP3430 ES1.0 Revision=
 A
> TRM (SWPU100A), the HS USBHOST subsystem is not present on OMAP3430 E=
S1.0.
> Therefore the HS USBHOST modules must not be marked as being common t=
o all
> OMAP3xxx chips in the hwmod data.
>
> If you have information that indicates that it's present on OMAP3430
> ES1.0, please let me know ASAP.


Thanks , I got your point

regards
keshava





>>
>>
>> > =A0 =A0 =A0 =A0/* dss class */
>> > =A0 =A0 =A0 =A0&omap3xxx_dss_dispc_hwmod,
>> > =A0 =A0 =A0 =A0&omap3xxx_dss_dsi1_hwmod,
>> > @@ -3206,6 +3421,8 @@ static __initdata struct omap_hwmod *omap343=
0es1_hwmods[] =3D {
>> > =A0static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] =3D=
 {
>> > =A0 =A0 =A0 =A0&omap3xxx_dss_core_hwmod,
>> > =A0 =A0 =A0 =A0&omap3xxx_usbhsotg_hwmod,
>> > + =A0 =A0 =A0 &omap3xxx_usb_host_hs_hwmod,
>> > + =A0 =A0 =A0 &omap3xxx_usb_tll_hs_hwmod,
>> > =A0 =A0 =A0 =A0NULL
>> > =A0};
>> >
>> > @@ -3223,12 +3440,16 @@ static __initdata struct omap_hwmod *omap3=
6xx_hwmods[] =3D {
>> > =A0 =A0 =A0 =A0&omap36xx_sr1_hwmod,
>> > =A0 =A0 =A0 =A0&omap36xx_sr2_hwmod,
>> > =A0 =A0 =A0 =A0&omap3xxx_usbhsotg_hwmod,
>> > + =A0 =A0 =A0 &omap3xxx_usb_host_hs_hwmod,
>> > + =A0 =A0 =A0 &omap3xxx_usb_tll_hs_hwmod,
>> > =A0 =A0 =A0 =A0NULL
>> > =A0};
>> >
>> > =A0static __initdata struct omap_hwmod *am35xx_hwmods[] =3D {
>> > =A0 =A0 =A0 =A0&omap3xxx_dss_core_hwmod, /* XXX ??? */
>> > =A0 =A0 =A0 =A0&am35xx_usbhsotg_hwmod,
>> > + =A0 =A0 =A0 &omap3xxx_usb_host_hs_hwmod,
>> > + =A0 =A0 =A0 &omap3xxx_usb_tll_hs_hwmod,
>> > =A0 =A0 =A0 =A0NULL
>> > =A0};
>> >
>> > --
>> > 1.7.7
>> >
>> >
>>
>
>
> - Paul
