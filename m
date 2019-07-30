From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
Date: Tue, 30 Jul 2019 10:28:10 -0500
Message-ID: <58ef00df-4d99-f4f2-0eda-01db2afe5502@lechnology.com>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com>
 <20190730123523.cjtmr3tpttn6r3pt@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730123523.cjtmr3tpttn6r3pt@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 7/30/19 7:35 AM, Uwe Kleine-König wrote:
> On Mon, Jul 22, 2019 at 10:45:36AM -0500, David Lechner wrote:
>> This adds a new counter driver for the Texas Instruments Enhanced
>> Quadrature Encoder Pulse (eQEP) module.
>>
>> Only very basic functionality is currently implemented - only enough to
>> be able to read the position. The actual device has many more features
>> which can be added to the driver on an as-needed basis.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   MAINTAINERS               |   6 +
>>   drivers/counter/Kconfig   |  12 ++
>>   drivers/counter/Makefile  |   1 +
>>   drivers/counter/ti-eqep.c | 381 ++++++++++++++++++++++++++++++++++++++
>>   drivers/pwm/Kconfig       |   2 +-
> 
> It's not obvious why the change to drivers/pwm/Kconfig is needed. Can
> you please motivate that in the change log?

Will do. The short version is that it is needed for power management.

> 
> Best regards
> Uwe
> 
