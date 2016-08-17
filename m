From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_adc: Increase timeout value
 waiting for ADC sample
Date: Wed, 17 Aug 2016 16:41:41 +0530
Message-ID: <2696e440-af5f-e6b0-aac4-e26789eaa56d@ti.com>
References: <20160808110501.29586-1-vigneshr@ti.com>
 <20160808110501.29586-3-vigneshr@ti.com>
 <6e5c9bea-7b0f-0fdb-976a-29b7a0bccc5e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6e5c9bea-7b0f-0fdb-976a-29b7a0bccc5e@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, "Davis, Andrew" <afd@ti.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Monday 15 August 2016 09:17 PM, Jonathan Cameron wrote:
> On 08/08/16 12:05, Vignesh R wrote:
>> Now that open delay and sample delay for each channel is configurable
>> via DT, the default IDLE_TIMEOUT value is not enough as this is
>> calculated based on hardcoded macros. This results in driver returning
>> EBUSY sometimes. Fix this by increasing the timeout
>> value based on maximum value possible to open delay and sample delays
>> for each channel.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> As with patch 1 could you provide a fixes tag as well highlighting the
> patch that introduced the issue. I'm thinking you are referring to:
> 
> iio: adc: ti_am335x_adc: make sample delay, open delay, averaging DT parameters
> 5dc11e810676ec4a5acb4423ccd33314bf74f4e54

Yes, will send v2 with fixes tag pointing to above commit. Thanks!

-- 
Regards
Vignesh
