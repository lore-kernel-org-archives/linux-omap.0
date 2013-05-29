From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v1 1/3] PM / AVS: SmartReflex: disable errgen before vpbound disable
Date: Wed, 29 May 2013 09:32:50 -0700
Message-ID: <87ehcp926l.fsf@linaro.org>
References: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com>
	<1369652846-14412-2-git-send-email-andrii.tseglytskyi@ti.com>
	<87sj17aqq2.fsf@linaro.org> <51A5D148.8050203@ti.com>
	<51A60F86.4090900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:37851 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821Ab3E2Qcx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 12:32:53 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so9331118pbb.6
        for <linux-omap@vger.kernel.org>; Wed, 29 May 2013 09:32:53 -0700 (PDT)
In-Reply-To: <51A60F86.4090900@ti.com> (Andrii Tseglytskyi's message of "Wed,
	29 May 2013 17:24:06 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: J Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:

> On 05/29/2013 12:58 PM, Andrii Tseglytskyi wrote:
>> Hi Kevin,
>>
>> Thanks a lot for your comments.
>>
>> On 05/28/2013 09:45 PM, Kevin Hilman wrote:
>>> Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:
>>>
>>>> From: Nishanth Menon <nm@ti.com>
>>>>
>>>> vpboundsintr_en is available inside the IP block as an re-sycned
>>>> version and one which is not. Due to this, there is an 1 sysclk
>>>> cycle window where interruptz could be asserted low for 1 cycle.
>>>                               ^^^
>>>
>>> Is that the way the cool kidz are spelling interrupts these days?  ;)
>>
>> Oh! Shame on me. Thank you for catching this :)
>
> Shame on me again (((. Name "interruptz" is more less OK. This is the
> name of signal between Voltage Processor and SmartReflex.
> In documentation it is referenced as "SR_SInterruptz". Anyway commit
> message should be updated to make this more clear.

Ah, OK.  Makes sense now.  

Yes, the changlog should be more clear that this is referring to a
signal name, e.g. 

       ...there is an 1 sysclk cycle window where the SR_SInterruptz
       signal could be asserted low.

(also note that I think the  "for once cycle" that ends that phrase in
the original changelog is redundant, since it already says a "1 sysclk
cycle window".

Kevin

