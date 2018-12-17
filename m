From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] tps65218.c: fix IRQ resource leak in tps65218_probe()
Date: Mon, 17 Dec 2018 11:31:50 +0530
Message-ID: <f584aab6-374c-5a53-51c5-61098f8bb792@ti.com>
References: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181214122559.GV4497@dell> <20181214122619.GW4497@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214122619.GW4497@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 12/14/2018 5:56 PM, Lee Jones wrote:
> On Fri, 14 Dec 2018, Lee Jones wrote:
> 
>> On Thu, 06 Dec 2018, Christian Hohnstaedt wrote:
>>
>>> Free allocated IRQ if reading the device ID fails.
>>
>> The patch is fine.  However, in future please submit patches using the
>> format set (by precedent) by the subsystem.  I will fix the subject
>> for you this time.
>>
>> To check the format, you can do:
>>
>>    `git log --oneline -- <subsystem>`
> 
> Patch applied, by the way.

This would no longer be needed as the bigger clean up is here:

https://lkml.org/lkml/2018/12/9/86

As both are applied it results in a compilation issue.

Lee Jones,

Do you want me to submit a fix patch? Or you can revert this patch?
Anything fine by me.

Let me know.

Thanks,
Keerthy
> 
