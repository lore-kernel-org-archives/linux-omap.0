From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] i2c: omap: Trigger bus recovery in lockup case
Date: Thu, 5 Oct 2017 07:30:43 -0500
Message-ID: <fe0ccc55-06c1-bedd-60f4-a2d10d2434b0@ti.com>
References: <1507110225-3050-1-git-send-email-claudio.foellmi@ergon.ch>
 <4aa7db09-f9b5-3140-24e7-179e8933e832@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <4aa7db09-f9b5-3140-24e7-179e8933e832@ti.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Tony Lindgren <tony@atomide.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/05/2017 01:01 AM, Vignesh R wrote:
> Hi,
> 
> On Wednesday 04 October 2017 03:13 PM, Claudio Foellmi wrote:
>> A very conservative check for bus activity (to prevent interference
>> in multimaster setups) prevented the bus recovery methods from being
>> triggered in the case that SDA or SCL was stuck low.
>> This defeats the purpose of the recovery mechanism, which was introduced
>> for exactly this situation (a slave device keeping SDA pulled down).
>>
>> Also added a check to make sure SDA is low before attempting recovery.
>> If SDA is not stuck low, recovery will not help, so we can skip it.
>>
>> Note that bus lockups can persist across reboots. The only other options
>> are to reset or power cycle the offending slave device, and many i2c
>> slaves do not even have a reset pin.
>>
>> If we see that one of the lines is low for the entire timeout duration,
>> we can actually be sure that there is no other master driving the bus.
>> It is therefore save for us to attempt a bus recovery.
>>
>> Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
>> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
>> Cc: Vignesh R <vigneshr@ti.com>
>> ---
>> Changes since v1:
>> Added a check before all bus recoveries, to make sure SDA actually is
>> low. This should prevent most unnecessary attempts, which are not
>> without risk.
>>
> 
> Thanks for the patch! This fixes my case. I no longer see recovery
> attempt or IRQ flood:
> Tested-by: Vignesh R <vigneshr@ti.com>

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
