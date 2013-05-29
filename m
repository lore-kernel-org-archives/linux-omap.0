From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: Re: [PATCH v1 1/3] PM / AVS: SmartReflex: disable errgen before vpbound
 disable
Date: Wed, 29 May 2013 17:24:06 +0300
Message-ID: <51A60F86.4090900@ti.com>
References: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com> <1369652846-14412-2-git-send-email-andrii.tseglytskyi@ti.com> <87sj17aqq2.fsf@linaro.org> <51A5D148.8050203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A5D148.8050203@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: J Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/29/2013 12:58 PM, Andrii Tseglytskyi wrote:
> Hi Kevin,
>
> Thanks a lot for your comments.
>
> On 05/28/2013 09:45 PM, Kevin Hilman wrote:
>> Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:
>>
>>> From: Nishanth Menon <nm@ti.com>
>>>
>>> vpboundsintr_en is available inside the IP block as an re-sycned
>>> version and one which is not. Due to this, there is an 1 sysclk
>>> cycle window where interruptz could be asserted low for 1 cycle.
>>                               ^^^
>>
>> Is that the way the cool kidz are spelling interrupts these days?  ;)
>
> Oh! Shame on me. Thank you for catching this :)

Shame on me again (((. Name "interruptz" is more less OK. This is the 
name of signal between Voltage Processor and SmartReflex.
In documentation it is referenced as "SR_SInterruptz". Anyway commit 
message should be updated to make this more clear.


[snip]
>
>

Regards,
Andrii
