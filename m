From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/5] OMAP: GPIO: use pwrdmn name to find wkup dmn GPIO
Date: Mon, 07 Mar 2011 10:56:48 -0800
Message-ID: <87k4ga7o9b.fsf@ti.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
	<1298890670-5481-3-git-send-email-charu@ti.com>
	<8762ryftbs.fsf@ti.com>
	<AANLkTikziwQBwPVOMxbQaTj5Oa-UAc38Eb87jq_QAHSD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41862 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169Ab1CGS4w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 13:56:52 -0500
Received: by mail-yi0-f43.google.com with SMTP id 13so1975144yia.30
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 10:56:51 -0800 (PST)
In-Reply-To: <AANLkTikziwQBwPVOMxbQaTj5Oa-UAc38Eb87jq_QAHSD@mail.gmail.com>
	(Charulatha Varadarajan's message of "Sat, 5 Mar 2011 09:51:12 +0430")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com

"Varadarajan, Charulatha" <charu@ti.com> writes:

> On Sat, Mar 5, 2011 at 02:21, Kevin Hilman <khilman@ti.com> wrote:
>> Charulatha V <charu@ti.com> writes:
>>
>>> In omap3, save/restore context is implemented for GPIO
>>> banks 2-6 as GPIO bank1 is in wakeup domain. Instead
>>> of identifying bank's power domain by bank id, make use
>>> of powerdomain name itself.
>>>
>>> For this, omap_hwmod_get_pwrdm() is used. omap_device_get_pwrdm()
>>> could not be used as the pwrdm information needs to be filled
>>> in pdata. But omap_device_get_pwrdm() can be used only after
>>> omap_device_build() call.
>>>
>>> Signed-off-by: Charulatha V <charu@ti.com>
>>>
>>> Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>> (2430-SDP testing)
>>
>> I like the idea of this change, but not the implementation...
>>
>> [...]
>>
>>> @@ -1865,16 +1867,15 @@ static int workaround_enabled;
>>> =C2=A0void omap2_gpio_prepare_for_idle(int off_mode)
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 int i, c =3D 0;
>>> - =C2=A0 =C2=A0 int min =3D 0;
>>>
>>> - =C2=A0 =C2=A0 if (cpu_is_omap34xx())
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 min =3D 1;
>>> -
>>> - =C2=A0 =C2=A0 for (i =3D min; i < gpio_bank_count; i++) {
>>> + =C2=A0 =C2=A0 for (i =3D 0; i < gpio_bank_count; i++) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gpio_bank *=
bank =3D &gpio_bank[i];
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 l1 =3D 0, l2 =3D=
 0;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int j;
>>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(bank->pwrdm=
_name, "wkup_pwrdm"))
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>>> +
>>
>> This adds a string compare for every bank during every idle
>> transistion (and every resume.) =C2=A0That's a lot of unneeded overh=
ead.
>>
>> I'd rather see a per-bank flag 'looses_context' or something that ca=
n be
>> checked more efficiently in this fast path. =C2=A0This flag can be s=
et based
>> on the powerdomain name in the device init code.
>
> This looks better. Will do the needful.
> One question, can "looses_context" be made as part of dev_attr?

I guess that's up to Beno=C3=AEt.

But, I don't think that's necessary. It should be easy to set at runtim=
e
just doing a strcmp on the powerdomain during the device init,
omap_device_build phase.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
