From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v11] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Wed, 28 Sep 2011 17:38:47 +0530
Message-ID: <CAP05o4KbVkXgnPc7JonrvURmCpQRgjMK2K_dmjQSKzQufQhjkA@mail.gmail.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com>
	<1316691479-1849-2-git-send-email-keshava_mgowda@ti.com>
	<1316691479-1849-3-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109221115320.10719@utopia.booyaka.com>
	<CAP05o4+Zc2z6sBOX_rQeoDQ9PneypcLRCyBbaaB2m+ZjeXZnaw@mail.gmail.com>
	<alpine.DEB.2.00.1109240101120.22872@utopia.booyaka.com>
	<CAP05o4+uwuFL8XNFG-wmUW8voYQ4kywyU9Qn-Mng7kv=TzZm9w@mail.gmail.com>
	<alpine.DEB.2.00.1109260844360.13188@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1109260844360.13188@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>
Cc: parthab@india.ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, tony@atomide.com, khilman@ti.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 26, 2011 at 8:15 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 26 Sep 2011, Munegowda, Keshava wrote:
>
>> On Sat, Sep 24, 2011 at 12:45 PM, Paul Walmsley <paul@pwsan.com> wro=
te:
>> > On Fri, 23 Sep 2011, Munegowda, Keshava wrote:
>> >
>> >> On Thu, Sep 22, 2011 at 11:31 PM, Paul Walmsley <paul@pwsan.com> =
wrote:
>> >> >
>> >> > On Thu, 22 Sep 2011, Keshava Munegowda wrote:
>> >> >> 4. usb_tll_hs hwmod of usbhs with the TLL base address and irq=
=2E
>> >> >>
>> >> >> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> >> >> Reviewed-by: Partha Basak <parthab@india.ti.com>
>> >> >> ---
>> >> >> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0271 +++++++=
+++++++++++++++++++++
>> >> >> =A01 files changed, 271 insertions(+), 0 deletions(-)
>> >> >>
>> >> >> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch=
/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> >> >> index 59fdb9f..d79f728 100644
>> >> >> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> >> >> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> >
>> >> >> +static struct omap_hwmod_ocp_if omap34xx_f128m_cfg__usb_host_=
hs =3D {
>> >> >> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_120m_fck",
>> >> >
>> >> > This doesn't look right. =A0This is an interface structure reco=
rd, so it
>> >> > should be associated with an interface clock. =A0Is the hardwar=
e really
>> >> > using the functional clock as the interface clock? =A0Or, as se=
ems more
>> >> > likely...
>> >>
>> >>
>> >> Agreed, how about:
>> >>
>> >> main clock: usbhost_120m_fck
>> >> optional f clock: usbhost_48m_fck
>> >
>> > Assuming the interface clock is enabled, which one of these clocks=
 is
>> > needed for UHH register accesses to complete successfully?
>>
>> it is usbhost_48m_fck ;
>> so,
>> main clock: usbhost_48m_fck
>> optional clock : usbhost_120m_fck
>>
>> do you agree?
>
> Yes.

Thanks paul,

But In USB Host case, there is a challenge!

I need both usbhost_48m_fck and usbhost_120m_fck to be turned on when
I invoke pm_runtime_get_sync ; so there are couple of options to do thi=
s

1. use clk_get with hard coded  usbhost_120m_fck name in  usbhs driver
       enable this clock after invoking pm_runtime_get_sync

2. add an additional flag in hwmod ; so that pm_runtime_get_sync will e=
nable
           main clock as well as optional clocks

please comment on these two approaches..


regards
keshava
