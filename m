From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC/PATCHv2 2/4] arm: omap: gpio: implement set_debounce method
Date: Thu, 1 Apr 2010 14:20:29 +0300
Message-ID: <x2x6ed0b2681004010420q54802b33kee5802b2a36b648e@mail.gmail.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
	 <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com>
	 <y2o6ed0b2681004010229r367aa72fv33746375541cd9da@mail.gmail.com>
	 <20100401093239.GH16297@nokia.com>
	 <i2i6ed0b2681004010237pf44f0f2ak992411ccae6f1b6d@mail.gmail.com>
	 <20100401101043.GI16297@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44469 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab0DALUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 07:20:31 -0400
Received: by fxm27 with SMTP id 27so401263fxm.28
        for <linux-omap@vger.kernel.org>; Thu, 01 Apr 2010 04:20:29 -0700 (PDT)
In-Reply-To: <20100401101043.GI16297@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Apr 1, 2010 at 1:10 PM, Felipe Balbi <felipe.balbi@nokia.com> w=
rote:
> On Thu, Apr 01, 2010 at 11:37:16AM +0200, ext Grazvydas Ignotas wrote=
:
>>
>> On Thu, Apr 1, 2010 at 12:32 PM, Felipe Balbi <felipe.balbi@nokia.co=
m>
>> wrote:
>>>
>>> On Thu, Apr 01, 2010 at 11:29:16AM +0200, ext Grazvydas Ignotas wro=
te:
>>>>
>>>> Hmh, dbck is shared by the whole GPIO bank, so what happens if som=
eone
>>>> calls _set_gpio_debounce(bank, 1, 310) and then
>>>> _set_gpio_debounce(bank, 2, 0)? This should leave debounce enabled=
 for
>>>> GPIO1, but you'll disable dbck on second call. GPIOs 0-31 share th=
e
>>>> same bank.
>>>
>>> but why would you call _set_gpio_debounce(bank, 2 0); without setti=
ng a
>>> real
>>> debounce value before ?
>>
>> ok then you could call
>> =A0_set_gpio_debounce(bank, 1, 310);
>> =A0_set_gpio_debounce(bank, 2, 310);
>> =A0_set_gpio_debounce(bank, 2, 0);
>>
>> The problem here is that debounce is still active for GPIO1, but you
>> disable dbck for the whole bank.
>
> but then you enabled the clock twice. There's refcounting for the clo=
ck.

Oh, it's fine then, forgot about clock refcounting.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
