From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: dts: Protect pinctrl headers against multiple inclusions
Date: Wed, 12 Jun 2013 18:18:47 +0200
Message-ID: <51B89F67.9020302@ti.com>
References: <1370962250-9745-1-git-send-email-florian.vaussard@epfl.ch> <20130611215756.9B0CA3E0D8D@localhost> <51B81863.10403@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38598 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290Ab3FLQS5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jun 2013 12:18:57 -0400
In-Reply-To: <51B81863.10403@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

Hi Florian,

On 6/12/2013 8:42 AM, Florian Vaussard wrote:
> Hello Grant,
>
> On 06/11/2013 11:57 PM, Grant Likely wrote:
>> On Tue, 11 Jun 2013 16:50:50 +0200, Florian Vaussard
>> <florian.vaussard@epfl.ch> wrote:
>>> Pinctrl headers were not protected with #ifndef.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>
>> Obviously this needs to go in via whatever tree added the modified
>> header files.
>>
>
> I authored these files, sorry for this stupid omission. Benoit, can you
> take this patch?

Yes, sure, I'll take it with Grant's ack.

Benoit

>
> Regards,
>
> Florian
>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>>> ---
>>>   include/dt-bindings/pinctrl/am33xx.h |    5 +++++
>>>   include/dt-bindings/pinctrl/omap.h   |    5 +++++
>>>   2 files changed, 10 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/include/dt-bindings/pinctrl/am33xx.h
>>> b/include/dt-bindings/pinctrl/am33xx.h
>>> index a3fddd4..469e032 100644
>>> --- a/include/dt-bindings/pinctrl/am33xx.h
>>> +++ b/include/dt-bindings/pinctrl/am33xx.h
>>> @@ -2,6 +2,9 @@
>>>    * This header provides constants specific to AM33XX pinctrl bindings.
>>>    */
>>>
>>> +#ifndef _DT_BINDINGS_PINCTRL_AM33XX_H
>>> +#define _DT_BINDINGS_PINCTRL_AM33XX_H
>>> +
>>>   #include <include/dt-bindings/pinctrl/omap.h>
>>>
>>>   /* am33xx specific mux bit defines */
>>> @@ -35,3 +38,5 @@
>>>   #undef PIN_OFF_INPUT_PULLDOWN
>>>   #undef PIN_OFF_WAKEUPENABLE
>>>
>>> +#endif
>>> +
>>> diff --git a/include/dt-bindings/pinctrl/omap.h
>>> b/include/dt-bindings/pinctrl/omap.h
>>> index 370df3f..edbd250 100644
>>> --- a/include/dt-bindings/pinctrl/omap.h
>>> +++ b/include/dt-bindings/pinctrl/omap.h
>>> @@ -5,6 +5,9 @@
>>>    * Copyright (C) 2009-2010 Texas Instruments
>>>    */
>>>
>>> +#ifndef _DT_BINDINGS_PINCTRL_OMAP_H
>>> +#define _DT_BINDINGS_PINCTRL_OMAP_H
>>> +
>>>   /* 34xx mux mode options for each pin. See TRM for options */
>>>   #define MUX_MODE0    0
>>>   #define MUX_MODE1    1
>>> @@ -48,3 +51,5 @@
>>>   #define PIN_OFF_INPUT_PULLDOWN    (OFF_EN | OFF_PULL_EN)
>>>   #define PIN_OFF_WAKEUPENABLE    WAKEUP_EN
>>>
>>> +#endif
>>> +
>>> --
>>> 1.7.5.4
>>>
>>> _______________________________________________
>>> devicetree-discuss mailing list
>>> devicetree-discuss@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/devicetree-discuss
>>
>

