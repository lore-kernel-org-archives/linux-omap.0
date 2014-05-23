From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] arm/omap4: add twd clock to DT
Date: Fri, 23 May 2014 13:57:40 +0300
Message-ID: <537F29A4.7030109@ti.com>
References: <1396901139-17268-1-git-send-email-gilles.chanteperdrix@xenomai.org> <20140418223948.GK21823@atomide.com> <5353F44F.5080400@xenomai.org> <535662F0.4080300@ti.com> <CAGhQ9Vw-QaB+OnLa3yNVvD6a=XOutSZ1ejbsuUXvEcyrxEsRcQ@mail.gmail.com> <20140519161319.GD4849@atomide.com> <CAGhQ9Vy-mvaXZ_=E_mmqYqxF5EiJSdN1rJayussm+AgKf94a+g@mail.gmail.com> <20140519162741.GG4849@atomide.com> <537B19F1.5040907@ti.com> <20140520144928.GB27830@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34982 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbaEWK5R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 May 2014 06:57:17 -0400
In-Reply-To: <20140520144928.GB27830@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

On 05/20/2014 05:49 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140520 02:01]:
>> On 05/19/2014 07:27 PM, Tony Lindgren wrote:
>>> * Joachim Eastwood <manabian@gmail.com> [140519 09:24]:
>>>> On 19 May 2014 18:13, Tony Lindgren <tony@atomide.com> wrote:
>>>>> * Joachim Eastwood <manabian@gmail.com> [140518 05:08]:
>>>>>> On 22 April 2014 14:39, Tero Kristo <t-kristo@ti.com> wrote:
>>>>>>> On 04/20/2014 07:22 PM, Gilles Chanteperdrix wrote:
>>>>>>>>
>>>>>>>> Le 19/04/2014 00:39, Tony Lindgren a =C3=A9crit :
>>>>>>>>>
>>>>>>>>> * Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> [14=
0407 13:09]:
>>>>>>>>>>
>>>>>>>>>> Booting Linux 3.14 on Pandaboard currently gets the followin=
g
>>>>>>>>>> message displayed:
>>>>>>>>>>
>>>>>>>>>> smp_twd: clock not found -2
>>>>>>>>>>
>>>>>>>>>> Define "mpu_periphclk" as the twd clock in omap4 dts to avoi=
d this.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Tero, care to ack?
>>>>>>>>
>>>>>>>>
>>>>>>>> Sorry if I did not mail the right people, get_maintainer.pl ga=
ve me a
>>>>>>>> long list, and I did not feel like spamming all these people f=
or such a
>>>>>>>> small patch. I do not believe Tero was in this list.
>>>>>>>>
>>>>>>>> Regards.
>>>>>>>
>>>>>>>
>>>>>>> Yea I don't think this is my expertise area, however the patch =
looks good to
>>>>>>> me, so if you really need it:
>>>>>>>
>>>>>>> Acked-by: Tero Kristo <t-kristo@ti.com>
>>>>>>
>>>>>> Tony, care to add this to your omap 3.16 dt branch?
>>>>>>
>>>>>> I am still getting:
>>>>>> [ 0.000152] smp_twd: clock not found -2
>>>>>>
>>>>>> So this fix from Gilles would be nice to have.
>>>>>
>>>>> Best that Tero picks this one up along with the other dt clock ch=
anges
>>>>> he's queueing.
>>>>
>>>> I kinda assumed you would take it since you asked Tero to ack it. =
But
>>>> either way is fine :)
>>>
>>> Yes that was before Tero started collecting the dt clock patches :)
>>
>> I wouldn't say this to be a clock patch as such, this touches the dr=
iver
>> behavior, i.e. registers the correct clock for the driver. That bein=
g said,
>> I can still queue this up with the clock patches if that is what you=
 want.
>
> Yes please go ahead and take this one.
>
> Thanks,
>
> Tony
>

Ok, thanks, queued for 3.16.

-Tero

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
