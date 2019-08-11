From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 3/5] counter: new TI eQEP driver
Date: Sun, 11 Aug 2019 14:15:14 -0500
Message-ID: <aa307094-c205-4e68-b21f-73d27f9ee257@lechnology.com>
References: <20190807194023.15318-1-david@lechnology.com>
 <20190807194023.15318-4-david@lechnology.com>
 <20190811102345.1af5c23c@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190811102345.1af5c23c@archlinux>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, linux-omap@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 8/11/19 4:23 AM, Jonathan Cameron wrote:
> On Wed,  7 Aug 2019 14:40:21 -0500
> David Lechner <david@lechnology.com> wrote:
>> +
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_get(dev);
> I'm a little confused on the flow here.
> 
> pm_runtime_enable turns on runtime pm in general.
> 
> pm_runtime_get basically calls runtime_resume to ensrue the
> device has power.
> 
>> +
>> +	return devm_counter_register(dev, &priv->counter);
> 
> This registers the userspace interfaces and exposes the device.
> 
>> +}
>> +
>> +static int ti_eqep_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +
>> +	pm_runtime_put(dev),
>> +	pm_runtime_disable(dev);
> 
> pm_runtime_put notifies the system that the device is idle
> (and hence potentially turns it off).
> 
> Not good if the counter is still registered.
> 
> I'm assuming the presence of runtime pm at all is to interact
> with a parent driver and hence stop that turning off if this
> driver is probed?  That's probably fine, but add a few comments
> to make it clear that this driver itself doesn't really do
> runtime pm at all.
> 

To be honest, despite reading the runtime PM docs more than once,
I still don't feel like I have a good grasp on how it is supposed
to work. I just know that we get a crash if it is omitted because
the IP block is not powered on.

I will fix the ordering in _remove() and add a comment in v3.
