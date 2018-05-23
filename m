From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 01/14] memory: ti-emif-sram: Add resume function to recopy
 sram code
Date: Wed, 23 May 2018 09:42:54 -0700
Message-ID: <443e8bb5-91d8-8bd9-ed6a-cf78377eeef4@oracle.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-2-git-send-email-j-keerthy@ti.com>
 <31688cf4-b6ca-e7ce-3407-46262006b38f@oracle.com>
 <d52373eb-1707-17ff-fabb-9f7200cf54c0@ti.com>
 <739d9bbf-2acc-9c90-db43-cf78f5b184e3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <739d9bbf-2acc-9c90-db43-cf78f5b184e3@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org


On 5/23/2018 1:47 AM, Keerthy wrote:
> 
> 
> On Monday 16 April 2018 03:59 PM, Keerthy wrote:
>>
[..]

>>> Instead of this indirect method , why can't just check the previous
>>> deep sleep mode and based on that do copy or not. EMIF power status
>>> register should have something like that ?
>>
>> I will check if we have a register that tells the previous state of sram.
> 
> Unfortunately i do not see any such register for knowing SRAM previous
> state in am43 TRM and hence this indirect way of knowing.
> 
OK.

> 
>>
>>>
>>> Another minor point is even though there is nothing to do in suspend,
>>> might be good to have a callback with comment that nothing to do with
>>> some explanation why not. Don't have strong preference but may for
>>> better readability.
> 
> I can add a blank suspend call with comment
> 
> "The contents are already present in DDR hence no need to explicitly save"
> 
> The comment in resume function pretty much explains the above. So let me
> know if i need to add the suspend callback.
> Please add the empty suspend callback with comment.

Regards,
Santosh
