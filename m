From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] arm/omap4: add twd clock to DT
Date: Tue, 20 May 2014 12:01:37 +0300
Message-ID: <537B19F1.5040907@ti.com>
References: <1396901139-17268-1-git-send-email-gilles.chanteperdrix@xenomai.org> <20140418223948.GK21823@atomide.com> <5353F44F.5080400@xenomai.org> <535662F0.4080300@ti.com> <CAGhQ9Vw-QaB+OnLa3yNVvD6a=XOutSZ1ejbsuUXvEcyrxEsRcQ@mail.gmail.com> <20140519161319.GD4849@atomide.com> <CAGhQ9Vy-mvaXZ_=E_mmqYqxF5EiJSdN1rJayussm+AgKf94a+g@mail.gmail.com> <20140519162741.GG4849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59261 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbaETJBU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 05:01:20 -0400
In-Reply-To: <20140519162741.GG4849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Joachim Eastwood <manabian@gmail.com>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

On 05/19/2014 07:27 PM, Tony Lindgren wrote:
> * Joachim Eastwood <manabian@gmail.com> [140519 09:24]:
>> On 19 May 2014 18:13, Tony Lindgren <tony@atomide.com> wrote:
>>> * Joachim Eastwood <manabian@gmail.com> [140518 05:08]:
>>>> On 22 April 2014 14:39, Tero Kristo <t-kristo@ti.com> wrote:
>>>>> On 04/20/2014 07:22 PM, Gilles Chanteperdrix wrote:
>>>>>>
>>>>>> Le 19/04/2014 00:39, Tony Lindgren a =C3=A9crit :
>>>>>>>
>>>>>>> * Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> [1404=
07 13:09]:
>>>>>>>>
>>>>>>>> Booting Linux 3.14 on Pandaboard currently gets the following
>>>>>>>> message displayed:
>>>>>>>>
>>>>>>>> smp_twd: clock not found -2
>>>>>>>>
>>>>>>>> Define "mpu_periphclk" as the twd clock in omap4 dts to avoid =
this.
>>>>>>>
>>>>>>>
>>>>>>> Tero, care to ack?
>>>>>>
>>>>>>
>>>>>> Sorry if I did not mail the right people, get_maintainer.pl gave=
 me a
>>>>>> long list, and I did not feel like spamming all these people for=
 such a
>>>>>> small patch. I do not believe Tero was in this list.
>>>>>>
>>>>>> Regards.
>>>>>
>>>>>
>>>>> Yea I don't think this is my expertise area, however the patch lo=
oks good to
>>>>> me, so if you really need it:
>>>>>
>>>>> Acked-by: Tero Kristo <t-kristo@ti.com>
>>>>
>>>> Tony, care to add this to your omap 3.16 dt branch?
>>>>
>>>> I am still getting:
>>>> [ 0.000152] smp_twd: clock not found -2
>>>>
>>>> So this fix from Gilles would be nice to have.
>>>
>>> Best that Tero picks this one up along with the other dt clock chan=
ges
>>> he's queueing.
>>
>> I kinda assumed you would take it since you asked Tero to ack it. Bu=
t
>> either way is fine :)
>
> Yes that was before Tero started collecting the dt clock patches :)

I wouldn't say this to be a clock patch as such, this touches the drive=
r=20
behavior, i.e. registers the correct clock for the driver. That being=20
said, I can still queue this up with the clock patches if that is what=20
you want.

-Tero

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
