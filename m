From: "Palande, Ameya" <ameya.palande@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: fix mult and div mask for USB_DPLL
Date: Wed, 25 Jan 2012 14:45:27 -0800
Message-ID: <CAHFNHeXm=fGbJcEbR4-7+HeANe1tVOVwqB2tPFrC3xFfPn91mA@mail.gmail.com>
References: <1326929954-3912-1-git-send-email-ameya.palande@ti.com>
	<4F1E7F8A.4010805@ti.com>
	<CAJOA=zPtxTxfjg+f2nuq5gGS3KdwU-PiSdgdu4=8FTY2Ywyj2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59196 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750772Ab2AYWp2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 17:45:28 -0500
Received: by mail-tul01m020-f176.google.com with SMTP id wp18so9157062obc.21
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 14:45:27 -0800 (PST)
In-Reply-To: <CAJOA=zPtxTxfjg+f2nuq5gGS3KdwU-PiSdgdu4=8FTY2Ywyj2w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, "Nayak, Rajendra" <rnayak@ti.com>

Hi Mike,

On Wed, Jan 25, 2012 at 10:10 AM, Turquette, Mike <mturquette@ti.com> w=
rote:
> On Tue, Jan 24, 2012 at 1:53 AM, Cousson, Benoit <b-cousson@ti.com> w=
rote:
>> + Mike
>>
>> On 1/19/2012 12:39 AM, Ameya Palande wrote:
>>>
>>> Signed-off-by: Ameya Palande<ameya.palande@ti.com>
>>
>>
>> Assuming that you will re-send with Kevin's comment taken into accou=
nt, the
>> fix is indeed very valid.
>>
>> Acked-by: Benoit Cousson <b-cousson@ti.com>
>>
>>> ---
>>> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 =A04 ++--
>>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c
>>> b/arch/arm/mach-omap2/clock44xx_data.c
>>> index 08e86d7..053cc15 100644
>>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>>> @@ -953,8 +953,8 @@ static struct dpll_data dpll_usb_dd =3D {
>>> =A0 =A0 =A0 =A0.modes =A0 =A0 =A0 =A0 =A0=3D (1<< =A0DPLL_LOW_POWER=
_BYPASS) | (1<<
>>> =A0DPLL_LOCKED),
>>> =A0 =A0 =A0 =A0.autoidle_reg =A0 =3D OMAP4430_CM_AUTOIDLE_DPLL_USB,
>>> =A0 =A0 =A0 =A0.idlest_reg =A0 =A0 =3D OMAP4430_CM_IDLEST_DPLL_USB,
>>> - =A0 =A0 =A0 .mult_mask =A0 =A0 =A0=3D OMAP4430_DPLL_MULT_MASK,
>>> - =A0 =A0 =A0 .div1_mask =A0 =A0 =A0=3D OMAP4430_DPLL_DIV_MASK,
>>> + =A0 =A0 =A0 .mult_mask =A0 =A0 =A0=3D OMAP4430_DPLL_MULT_USB_MASK=
,
>>> + =A0 =A0 =A0 .div1_mask =A0 =A0 =A0=3D OMAP4430_DPLL_DIV_0_7_MASK,
>>
>>
>> We were wrongly assuming that all DPLLs were using the same mask, wh=
ich
>> cannot be the case for the USB DPLL since that one has a higher max
>> multiplier and max divider than the other ones (4095/256 instead of
>> 2047/128).
>>
>> For Mike and Paul,
>>
>> It is indeed a bug in the clock generator script.
>
> This DPLL does have some quirks. =A0Rajendra recently solved a bug wh=
ere
> .clkdm was not set for this DPLL since it is in the L3INIT clkdm, not
> an always-on clkdm, so that must also be taken into account in the
> data generation.

I already submitted that patch for review:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg61444.html

Cheers,
Ameya.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
