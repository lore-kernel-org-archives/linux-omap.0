From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 2/5] OMAP: GPIO: use pwrdmn name to find wkup dmn GPIO
Date: Sat, 5 Mar 2011 09:51:12 +0430
Message-ID: <AANLkTikziwQBwPVOMxbQaTj5Oa-UAc38Eb87jq_QAHSD@mail.gmail.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
 <1298890670-5481-3-git-send-email-charu@ti.com> <8762ryftbs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47485 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852Ab1CEFVy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Mar 2011 00:21:54 -0500
Received: by fxm20 with SMTP id 20so2971949fxm.12
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 21:21:52 -0800 (PST)
In-Reply-To: <8762ryftbs.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com

On Sat, Mar 5, 2011 at 02:21, Kevin Hilman <khilman@ti.com> wrote:
> Charulatha V <charu@ti.com> writes:
>
>> In omap3, save/restore context is implemented for GPIO
>> banks 2-6 as GPIO bank1 is in wakeup domain. Instead
>> of identifying bank's power domain by bank id, make use
>> of powerdomain name itself.
>>
>> For this, omap_hwmod_get_pwrdm() is used. omap_device_get_pwrdm()
>> could not be used as the pwrdm information needs to be filled
>> in pdata. But omap_device_get_pwrdm() can be used only after
>> omap_device_build() call.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>>
>> Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> (2430-SDP testing)
>
> I like the idea of this change, but not the implementation...
>
> [...]
>
>> @@ -1865,16 +1867,15 @@ static int workaround_enabled;
>> =A0void omap2_gpio_prepare_for_idle(int off_mode)
>> =A0{
>> =A0 =A0 =A0 int i, c =3D 0;
>> - =A0 =A0 int min =3D 0;
>>
>> - =A0 =A0 if (cpu_is_omap34xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 min =3D 1;
>> -
>> - =A0 =A0 for (i =3D min; i < gpio_bank_count; i++) {
>> + =A0 =A0 for (i =3D 0; i < gpio_bank_count; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_bank *bank =3D &gpio_bank[i]=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 l1 =3D 0, l2 =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"=
))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>
> This adds a string compare for every bank during every idle
> transistion (and every resume.) =A0That's a lot of unneeded overhead.
>
> I'd rather see a per-bank flag 'looses_context' or something that can=
 be
> checked more efficiently in this fast path. =A0This flag can be set b=
ased
> on the powerdomain name in the device init code.

This looks better. Will do the needful.
One question, can "looses_context" be made as part of dev_attr?

>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
