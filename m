From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: Protect FIFO1 from
 concurrent access
Date: Wed, 17 Aug 2016 16:43:43 +0530
Message-ID: <a3b53c07-39b9-31db-0a40-4018f74dc9c6@ti.com>
References: <20160808110501.29586-1-vigneshr@ti.com>
 <20160808110501.29586-2-vigneshr@ti.com>
 <1731ca3d-56f1-1183-b049-360b155ced28@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1731ca3d-56f1-1183-b049-360b155ced28@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, "Davis, Andrew" <afd@ti.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Monday 15 August 2016 09:15 PM, Jonathan Cameron wrote:
> On 08/08/16 12:05, Vignesh R wrote:
>> It is possible that two or more ADC channels can be simultaneously
>> requested for raw samples, in which case there can be race in access to
>> FIFO data resulting in loss of samples.
>> If am335x_tsc_se_set_once() is called again from tiadc_read_raw(), when
>> ADC is still acquired to sample one of the channels, the second process
>> might be put into uninterruptible sleep state. Fix these issues, by
>> protecting FIFO access and channel configurations with a mutex. Since
>> tiadc_read_raw() might take anywhere between few microseconds to few
>> milliseconds to finish execution (depending on averaging and delay
>> values supplied via DT), its better to use mutex instead of spinlock.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Hi,
> 
> Thanks for the patch.
> 
> As this is clearly a fix for a long standing issue, I'd like to send
> it for stable inclusion.  Would you mind doing a bit of detective work
> to added a Fixes tag to say which original patch introduced the issue?
> 

Looks to be due to the commit 7ca6740cd1cd4 ("mfd: input: iio:
ti_amm335x: Rework TSC/ADC synchronization")
Will send v2 with fixes tag. Thanks!

-- 
Regards
Vignesh
