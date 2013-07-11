From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 1/4] MFD: Add TPS659038 documentation under Palmas
Date: Thu, 11 Jul 2013 16:14:17 +0530
Message-ID: <51DE8C81.9090009@ti.com>
References: <1371726289-10042-1-git-send-email-j-keerthy@ti.com> <20130711104327.GE25601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130711104327.GE25601@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: J Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, broonie@kernel.org, ldewangan@nvidia.com, sameo@linux.intel.com, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Thursday 11 July 2013 04:13 PM, Lee Jones wrote:
> On Thu, 20 Jun 2013, J Keerthy wrote:
>
>> Add TPS659038 documentation under Palmas.
>>
>> Signed-off-by: J Keerthy <j-keerthy@ti.com>
>> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/palmas.txt |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Documentation/devicetree/bindings/mfd/palmas.txt
>> index 7bcd59c..89cb773 100644
>> --- a/Documentation/devicetree/bindings/mfd/palmas.txt
>> +++ b/Documentation/devicetree/bindings/mfd/palmas.txt
>> @@ -5,6 +5,7 @@ twl6035 (palmas)
>>   twl6037 (palmas)
>>   tps65913 (palmas)
>>   tps65914 (palmas)
>> +tps659038
>>   
>>   Required properties:
>>   - compatible : Should be from the list
>> @@ -14,6 +15,7 @@ Required properties:
>>     ti,tps65913
>>     ti,tps65914
>>     ti,tps80036
>> +  ti,tps659038
>>   and also the generic series names
>>     ti,palmas
>>   - interrupt-controller : palmas has its own internal IRQs
> Applied.

Thanks Lee Jones.

>

