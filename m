From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/9] mfd: Remove redundant i2c_device_id
Date: Tue, 6 Jun 2017 13:00:49 +0530
Message-ID: <9017b16c-e9f3-ea05-4e71-d7920841ce57@ti.com>
References: <1496567924-4278-1-git-send-email-j-keerthy@ti.com>
 <20170605103740.g4t3veigzpdzfkxi@dell>
 <e8cbe8fb-50fd-76ef-a5e3-59a7913622c5@ti.com>
 <20170606071703.o6dnzu4vjeywpoxn@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606071703.o6dnzu4vjeywpoxn@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: tony@atomide.com, milo.kim@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 06 June 2017 12:47 PM, Lee Jones wrote:
> On Mon, 05 Jun 2017, Keerthy wrote:
> 
>>
>>
>> On Monday 05 June 2017 04:07 PM, Lee Jones wrote:
>>> On Sun, 04 Jun 2017, Keerthy wrote:
>>>
>>>> With the introduction of probe_new function the i2c_device_id
>>>> is no longer needed. Hence the remove the same and use probe_new
>>>> instead of probe. 
>>>>
>>>> Keerthy (9):
>>>>   mfd: tps65217: Remove redundant i2c_device_id
>>>>   mfd: tps65218: Remove redundant i2c_device_id
>>>>   mfd: palmas: Remove redundant i2c_device_id
>>>>   mfd: lp873x: Remove redundant i2c_device_id
>>>>   mfd: lp8788: Remove redundant i2c_device_id
>>>>   mfd: lp3943: Remove redundant i2c_device_id
>>>>   mfd: tps65086: Remove redundant i2c_device_id
>>>>   mfd: tps65090: Remove redundant i2c_device_id
>>>>   mfd: tps6586x: Remove redundant i2c_device_id
>>>>
>>>>  drivers/mfd/lp3943.c   | 11 ++---------
>>>>  drivers/mfd/lp873x.c   | 12 ++----------
>>>>  drivers/mfd/lp8788.c   | 11 ++---------
>>>>  drivers/mfd/palmas.c   | 15 ++-------------
>>>>  drivers/mfd/tps65086.c | 12 ++----------
>>>>  drivers/mfd/tps65090.c | 12 ++----------
>>>>  drivers/mfd/tps65217.c | 14 +++-----------
>>>>  drivers/mfd/tps65218.c |  9 +++++----
>>>>  drivers/mfd/tps6586x.c | 12 ++----------
>>>
>>> Are all of these drivers DT only?
>>
>> At least i did not find any platform code calling on to these drivers.
>> No dependency on OF as such. Hence sent these 9.
> 
> I can't accept these changes on any drivers which does not depend on
> OF as a hard requirement.

Okay. So that is a per-requisite. At least palmas, tps65218, lp873x,
tps65217 imho can have the OF dependency. I will post patches for that
and then will resurrect this series.

Thanks for your feedback.


> 
