From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] DSPBRIDGE: use dm timer framework for gpt timers
Date: Wed, 28 Apr 2010 20:04:18 +0300
Message-ID: <m2v94a0d4531004281004re2e80644q742547e02d755dce@mail.gmail.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-8-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-9-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-10-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-11-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-12-git-send-email-omar.ramirez@ti.com>
	 <t2j94a0d4531004280046g49d9a0f9j60a6147b86a1854f@mail.gmail.com>
	 <4BD8430B.80909@ti.com> <87bpd3h774.fsf@deeprootsystems.com>
	 <4BD863FE.80804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44131 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab0D1RET convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 13:04:19 -0400
Received: by bwz19 with SMTP id 19so14662bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 10:04:18 -0700 (PDT)
In-Reply-To: <4BD863FE.80804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

On Wed, Apr 28, 2010 at 7:36 PM, Nishanth Menon <nm@ti.com> wrote:
> Kevin Hilman had written, on 04/28/2010 11:29 AM, the following:
>>
>> Omar Ramirez Luna <omar.ramirez@ti.com> writes:
>>
>>> On 4/28/2010 2:46 AM, Felipe Contreras wrote:
>>>>
>>>> On Wed, Apr 28, 2010 at 4:29 AM, Omar Ramirez Luna<omar.ramirez@ti=
=2Ecom>
>>>> =C2=A0wrote:
>>>>>
>>>>> This patch switches to use DM timer framework instead of
>>>>> a custom one for GPT timers, currently dsp can make use of
>>>>> gpt 5, 6, 7 or 8.
>>>>
>>>> I heard someone that was using gpt 8 for something else. Is it
>>>> possible to configure dsp-bridge to not use it?
>>>>
>>> There are two scenarios:
>>>
>>> 1. The request comes from the DSP side (afaik for video use case), =
the
>>> change should be in the DSP side binaries to request some other gpt
>>> instead. I don't know how possible is to get this changed.
>>>
>>> 2. bridge driver also requests gpt8 whenever a mmu fault is trigger=
ed,
>>> this to set a timer to interrupt the dsp after the mmu fault dump h=
as
>>> been finished, I think this can be easily replaced in bridge to use
>>> some other gpt, but "1" is still there. (besides a new patch is nee=
ded
>>> to remove direct access to dm timer inside ue_deh and make it to go
>>> through dsp-clock)
>>
>> Why does Bridge care at all which specific timers it requests? =C2=A0=
They
>> are all the same, with the exception of GPT1 which is in the WKUP
>> powerdomain and already used as the kernel clocksource.
>>
>> Bridge should just use the generic _request() instead of
>> _request_specific()
>>
> trouble I believe is that DSP BIOS uses a specific timer.

=46TR, this is the conversation... I don't understand what PWM is,
hopefully somebody else does:

<av500> felipec: ping
<felipec> av500: pong
<av500> dspbridge uses GPT8 which is one of the PWM capable ones
<av500> which is not so nice as my hw guy uses that PWM
<av500> otoh, only GPT5-8 can deliver IRQ to DSP
<av500> so I see code that handles 5-8, but somehow only GPT6 and GPT8
seem to be really used
<felipec> av500: you are wondering if it could use GPT7 or something?
<av500> yup
<av500> GPT8 is unfortunately in the DSP and the PWM set
<av500> DSP 5-8, PWM 8-11
<felipec> av500: I've no idea =3D/
<av500> felipec: ok, and who could?
<felipec> that's for the mailing list I guess
<av500> l-o?
<felipec> yup
<av500> k, thx
<felipec> orbarron maybe
<av500> orbarron: ^^^^^^^

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
