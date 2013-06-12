From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH] ARM: dts: Protect pinctrl headers against multiple inclusions
Date: Wed, 12 Jun 2013 08:42:43 +0200
Message-ID: <51B81863.10403@epfl.ch>
References: <1370962250-9745-1-git-send-email-florian.vaussard@epfl.ch> <20130611215756.9B0CA3E0D8D@localhost>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:42140 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755215Ab3FLGmr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jun 2013 02:42:47 -0400
In-Reply-To: <20130611215756.9B0CA3E0D8D@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

Hello Grant,

On 06/11/2013 11:57 PM, Grant Likely wrote:
> On Tue, 11 Jun 2013 16:50:50 +0200, Florian Vaussard <florian.vaussard@epfl.ch> wrote:
>> Pinctrl headers were not protected with #ifndef.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>
> Obviously this needs to go in via whatever tree added the modified
> header files.
>

I authored these files, sorry for this stupid omission. Benoit, can you
take this patch?

Regards,

Florian

> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
>> ---
>>   include/dt-bindings/pinctrl/am33xx.h |    5 +++++
>>   include/dt-bindings/pinctrl/omap.h   |    5 +++++
>>   2 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/dt-bindings/pinctrl/am33xx.h b/include/dt-bindings/pinctrl/am33xx.h
>> index a3fddd4..469e032 100644
>> --- a/include/dt-bindings/pinctrl/am33xx.h
>> +++ b/include/dt-bindings/pinctrl/am33xx.h
>> @@ -2,6 +2,9 @@
>>    * This header provides constants specific to AM33XX pinctrl bindings.
>>    */
>>
>> +#ifndef _DT_BINDINGS_PINCTRL_AM33XX_H
>> +#define _DT_BINDINGS_PINCTRL_AM33XX_H
>> +
>>   #include <include/dt-bindings/pinctrl/omap.h>
>>
>>   /* am33xx specific mux bit defines */
>> @@ -35,3 +38,5 @@
>>   #undef PIN_OFF_INPUT_PULLDOWN
>>   #undef PIN_OFF_WAKEUPENABLE
>>
>> +#endif
>> +
>> diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
>> index 370df3f..edbd250 100644
>> --- a/include/dt-bindings/pinctrl/omap.h
>> +++ b/include/dt-bindings/pinctrl/omap.h
>> @@ -5,6 +5,9 @@
>>    * Copyright (C) 2009-2010 Texas Instruments
>>    */
>>
>> +#ifndef _DT_BINDINGS_PINCTRL_OMAP_H
>> +#define _DT_BINDINGS_PINCTRL_OMAP_H
>> +
>>   /* 34xx mux mode options for each pin. See TRM for options */
>>   #define MUX_MODE0	0
>>   #define MUX_MODE1	1
>> @@ -48,3 +51,5 @@
>>   #define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
>>   #define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
>>
>> +#endif
>> +
>> --
>> 1.7.5.4
>>
>> _______________________________________________
>> devicetree-discuss mailing list
>> devicetree-discuss@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/devicetree-discuss
>

-- 
Florian Vaussard
EPFL - STI - IMT - LSRO1
MEB330 - Station 9
1015 Lausanne / Switzerland

tel: +41 21 693 78 39
fax: +41 21 693 78 07
http://lsro.epfl.ch
