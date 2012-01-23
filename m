From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: fix mult and div mask for USB_DPLL
Date: Mon, 23 Jan 2012 15:34:51 -0800
Message-ID: <87vco2j8mc.fsf@ti.com>
References: <1326929954-3912-1-git-send-email-ameya.palande@ti.com>
	<CAHFNHeXZKDnHUwjeahsNLk_2QDDuNJ12p2iZnEgCMSCRD99V4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37225 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752075Ab2AWXe4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 18:34:56 -0500
Received: by ghrr17 with SMTP id r17so1592721ghr.36
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 15:34:55 -0800 (PST)
In-Reply-To: <CAHFNHeXZKDnHUwjeahsNLk_2QDDuNJ12p2iZnEgCMSCRD99V4g@mail.gmail.com>
	(Ameya Palande's message of "Fri, 20 Jan 2012 11:52:17 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Palande, Ameya" <ameya.palande@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

"Palande, Ameya" <ameya.palande@ti.com> writes:

> Any update on this?

A descriptive changelog would be helpful here, ideally with a TRM
reference to the correct values such that a reviewer could verify this
quickly.

Also, please Cc linux-arm-kernel@lists.infradead.org for upstream
patches.

Thanks,

Kevin

> On Wed, Jan 18, 2012 at 3:39 PM, Ameya Palande <ameya.palande@ti.com>=
 wrote:
>>
>> Signed-off-by: Ameya Palande <ameya.palande@ti.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/clock44xx_data.c | =C2=A0 =C2=A04 ++--
>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-om=
ap2/clock44xx_data.c
>> index 08e86d7..053cc15 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -953,8 +953,8 @@ static struct dpll_data dpll_usb_dd =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.modes =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.autoidle_reg =C2=A0 =3D OMAP4430_CM_AUTO=
IDLE_DPLL_USB,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.idlest_reg =C2=A0 =C2=A0 =3D OMAP4430_CM=
_IDLEST_DPLL_USB,
>> - =C2=A0 =C2=A0 =C2=A0 .mult_mask =C2=A0 =C2=A0 =C2=A0=3D OMAP4430_D=
PLL_MULT_MASK,
>> - =C2=A0 =C2=A0 =C2=A0 .div1_mask =C2=A0 =C2=A0 =C2=A0=3D OMAP4430_D=
PLL_DIV_MASK,
>> + =C2=A0 =C2=A0 =C2=A0 .mult_mask =C2=A0 =C2=A0 =C2=A0=3D OMAP4430_D=
PLL_MULT_USB_MASK,
>> + =C2=A0 =C2=A0 =C2=A0 .div1_mask =C2=A0 =C2=A0 =C2=A0=3D OMAP4430_D=
PLL_DIV_0_7_MASK,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.enable_mask =C2=A0 =C2=A0=3D OMAP4430_DP=
LL_EN_MASK,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.autoidle_mask =C2=A0=3D OMAP4430_AUTO_DP=
LL_MODE_MASK,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.idlest_mask =C2=A0 =C2=A0=3D OMAP4430_ST=
_DPLL_CLK_MASK,
>> --
>> 1.7.4.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
