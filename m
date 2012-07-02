From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH] OMAP4: Clock: Correct OTG clock to use otg_60m_gfclk.
Date: Mon, 2 Jul 2012 19:29:29 +0300
Message-ID: <CAEa47NpaBfHB_HUvH9CLFUUHR1tNRnPsQMipdFagXWvYpcPuEQ@mail.gmail.com>
References: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com>
	<alpine.DEB.2.00.1206291434190.2338@utopia.booyaka.com>
	<4FF1977B.1080002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:43138 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752478Ab2GBQ3a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 12:29:30 -0400
Received: by vbbfr13 with SMTP id fr13so3957738vbb.34
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 09:29:29 -0700 (PDT)
In-Reply-To: <4FF1977B.1080002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Wenbiao Wang <wwang@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Thanks Benoit for the explanation. It seems you are right.
+ Wenbiao who is the original patch author that may have another point
of view and some additional explanations.

--
Best regards,
Ruslan Bilovol


On Mon, Jul 2, 2012 at 3:43 PM, Benoit Cousson <b-cousson@ti.com> wrote=
:
>
> On 06/29/2012 10:35 PM, Paul Walmsley wrote:
>>
>> + Beno=EEt who is the maintainer of this file
>>
>> + the linux-arm-kernel mailing list, which should be cc'ed on all OM=
AP
>> patches
>>
>> On Fri, 29 Jun 2012, Ruslan Bilovol wrote:
>>
>>> From: Wenbiao Wang <wwang@ti.com>
>>>
>>> OTG clock usb_otg_hs_ick used a incorrect parent l3_div_ck.
>>> Correct it to use the right colck otg_60m_gfclk as its
>>> parent.
>
>
> Mmm, that does not seems to be correct.
>
> otg_60m_gfclk is an optional clock. The interface clock is the main c=
lock
> of that module. That's why this is the parent of the fake MODULEMODE =
clock
> node.
>
> Moreover you are changing as well the utmi_phy_clkout_ck. That's not
> mentioned at all in the changelog.
>
> I know that there are some non standard stuff in this clock scheme.
> The main reason being the utmi_phy_clkout_ck source is generated from=
 the
> usb_phy module. Unfortunately the clock fmwk cannot handle module as =
a clock
> node.
>
> So, as of today, this only way to get the OTG_60M_FCLK clock availabl=
e is
> to ensure that the usb_phy module is enabled before the usb_otg_hs mo=
dule.
>
> Regards,
> Benoit
>
>>>
>>> Signed-off-by: Wenbiao Wang <wwang@ti.com>
>>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/clock44xx_data.c |   15 ++++++++-------
>>>   1 files changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c
>>> b/arch/arm/mach-omap2/clock44xx_data.c
>>> index b825049..fd43214 100644
>>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>>> @@ -199,12 +199,6 @@ static struct clk tie_low_clock_ck =3D {
>>>         .ops            =3D &clkops_null,
>>>   };
>>>
>>> -static struct clk utmi_phy_clkout_ck =3D {
>>> -       .name           =3D "utmi_phy_clkout_ck",
>>> -       .rate           =3D 60000000,
>>> -       .ops            =3D &clkops_null,
>>> -};
>>> -
>>>   static struct clk xclk60mhsp1_ck =3D {
>>>         .name           =3D "xclk60mhsp1_ck",
>>>         .rate           =3D 60000000,
>>> @@ -992,6 +986,13 @@ static struct clk dpll_usb_clkdcoldo_ck =3D {
>>>         .recalc         =3D &followparent_recalc,
>>>   };
>>>
>>> +static struct clk utmi_phy_clkout_ck =3D {
>>> +       .name           =3D "utmi_phy_clkout_ck",
>>> +       .ops            =3D &clkops_null,
>>> +       .parent         =3D &dpll_usb_clkdcoldo_ck,
>>> +       .recalc         =3D &followparent_recalc,
>>> +};
>>> +
>>>   static const struct clksel dpll_usb_m2_div[] =3D {
>>>         { .parent =3D &dpll_usb_ck, .rates =3D div31_1to31_rates },
>>>         { .parent =3D NULL },
>>> @@ -2685,7 +2686,7 @@ static struct clk usb_otg_hs_ick =3D {
>>>         .enable_reg     =3D OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
>>>         .enable_bit     =3D OMAP4430_MODULEMODE_HWCTRL,
>>>         .clkdm_name     =3D "l3_init_clkdm",
>>> -       .parent         =3D &l3_div_ck,
>>> +       .parent         =3D &otg_60m_gfclk,
>>>         .recalc         =3D &followparent_recalc,
>>>   };
>>
>>
>> Beno=EEt should have a look at this one, I think.
>>
>>
>> - Paul
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
