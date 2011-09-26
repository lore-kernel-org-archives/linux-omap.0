From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v11] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Mon, 26 Sep 2011 19:51:40 +0530
Message-ID: <CAP05o4+uwuFL8XNFG-wmUW8voYQ4kywyU9Qn-Mng7kv=TzZm9w@mail.gmail.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com>
	<1316691479-1849-2-git-send-email-keshava_mgowda@ti.com>
	<1316691479-1849-3-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109221115320.10719@utopia.booyaka.com>
	<CAP05o4+Zc2z6sBOX_rQeoDQ9PneypcLRCyBbaaB2m+ZjeXZnaw@mail.gmail.com>
	<alpine.DEB.2.00.1109240101120.22872@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:32823 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169Ab1IZO2P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 10:28:15 -0400
In-Reply-To: <alpine.DEB.2.00.1109240101120.22872@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: parthab@india.ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b-cousson@ti.com, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, tony@atomide.com, khilman@ti.com, johnstul@us.ibm.com, vishwanath.bs@ti.com

On Sat, Sep 24, 2011 at 12:45 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Fri, 23 Sep 2011, Munegowda, Keshava wrote:
>
>> On Thu, Sep 22, 2011 at 11:31 PM, Paul Walmsley <paul@pwsan.com> wro=
te:
>> >
>> > On Thu, 22 Sep 2011, Keshava Munegowda wrote:
>> >> 4. usb_tll_hs hwmod of usbhs with the TLL base address and irq.
>> >>
>> >> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> >> Reviewed-by: Partha Basak <parthab@india.ti.com>
>> >> ---
>> >> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0271 ++++++++++=
++++++++++++++++++
>> >> =A01 files changed, 271 insertions(+), 0 deletions(-)
>> >>
>> >> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/ar=
m/mach-omap2/omap_hwmod_3xxx_data.c
>> >> index 59fdb9f..d79f728 100644
>> >> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> >> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>
>> >> +static struct omap_hwmod_ocp_if omap34xx_f128m_cfg__usb_host_hs =
=3D {
>> >> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_120m_fck",
>> >
>> > This doesn't look right. =A0This is an interface structure record,=
 so it
>> > should be associated with an interface clock. =A0Is the hardware r=
eally
>> > using the functional clock as the interface clock? =A0Or, as seems=
 more
>> > likely...
>>
>>
>> Agreed, how about:
>>
>> main clock: usbhost_120m_fck
>> optional f clock: usbhost_48m_fck
>
> Assuming the interface clock is enabled, which one of these clocks is
> needed for UHH register accesses to complete successfully?


it is usbhost_48m_fck ;
so,
main clock: usbhost_48m_fck
optional clock : usbhost_120m_fck

do you agree?

>
>> interface clock: usbhost_ick.
>>
>>
>>
>> >> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> >> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>> >
>> > ... is this just a hack? =A0OCPIF_SWSUP_IDLE is intended to work a=
round
>> > hardware autoidle bugs only. =A0Are you sure this shouldn't be def=
ined as an
>> > optional clock instead?
>>
>> yes ! it was causeing resets, hence you this flag.
>
> usbhost_120m_fck is not an interface clock. =A0That is probably what =
was
> causing the problem you describe.

yes , you are right ! its not an interface clock.


>
>> >> +static struct omap_hwmod omap34xx_usb_host_hs_hwmod =3D {
>> >> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_host_hs",
>> >> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwm=
od_class,
>> >> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbhost_ick",
>> >
>> > Is this really the main clock? =A0The main clock is the clock that=
 drives
>> > the register logic in the IP block. =A0Looks to me, based on the i=
ntegration
>> > document in the 34xx TRM vZR, that this module has a functional cl=
ock. =A0In
>> > general, the only time that the main_clk should be an interface cl=
ock is
>> > when the clock is a combined interface and functional clock. =A0Th=
e mailbox
>> > IP block is a classic example.
>>
>> As I mentioned above; =A0I can make
>>
>> main clock: usbhost_120m_fck
>> optional f clock: usbhost_48m_fck
>> interface clock: usbhost_ick.
>>
>> do you agree?
>
> The interface clock should definitely be usbhost_ick, no doubt about =
it.
>
> But, as I mentioned above, to determine which functional clock should=
 be
> the main clock, you first need to know which of those two clocks need=
 to
> be enabled for register accesses to that module to succeed.
>
> I did this work a few years ago, by trial and error since it was larg=
ely
> undocumented. =A0It was needed since the OMAP3 clk_enable() code wait=
s for
> the PRCM to request that the IP block exit idle before returning.
> You might want to take a look at arch/arm/mach-omap2/clock3xxx_data.c=
=2E
>
>> >> +static struct omap_hwmod omap34xx_usb_tll_hs_hwmod =3D {
>> >> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_tll_hs",
>> >> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_tll_hs_hwmo=
d_class,
>> >> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_irqs,
>> >> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbtll_ick",
>> >
>> > Is this really the main clock? =A0The main clock is the clock that=
 drives
>> > the register logic in the IP block. =A0Looks to me, based on the i=
ntegration
>> > document in the 34xx TRM vZR, that this module has a functional cl=
ock.
>>
>> I can make
>>
>> main clock: usbtll_fck
>> interface clock: usbtll_ick.
>>
>> do you agree?
>
> Doesn't that make more sense?

yes, I will do this change.


keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
