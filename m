From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Date: Sun, 11 Nov 2018 12:45:08 +0100
Message-ID: <dda29b24-035f-eb0b-fd07-dce6680e8912@redhat.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <20181110182622.GA32657@kroah.com>
 <20181110183629.GE10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181110183629.GE10650@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Grant Likely <grant.likely@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 11/10/18 7:36 PM, Andy Shevchenko wrote:
> On Sat, Nov 10, 2018 at 10:26:22AM -0800, Greg Kroah-Hartman wrote:
>> On Sat, Nov 10, 2018 at 08:10:57PM +0200, Andy Shevchenko wrote:
>>> Consider the following scenario.
>>>
>>> There are two independent devices coupled together by functional dependencies:
>>>   - USB OTG (dwc3-pci)
>>>   - extcon (tested with extcon-intel-mrfld, not yet in upstream)
>>>
>>> Each of the driver services a corresponding device is built as a module. In the
>>> Buildroot environment the modules are probed by alphabetical ordering of their
>>> modaliases. The latter comes to the case when USB OTG driver will be probed
>>> first followed by extcon one.
>>>
>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>> we will get deferred probe of USB OTG, because of ordering.
>>>
>>> Now, a cherry on top of the cake, the deferred probing list contains
>>> the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
>>> values in the local_trigger_count and deferred_trigger_count are not the same,
>>> and thus provokes deferred probe triggering again and again.
>>>
>>> ...
>>> [   20.678332] platform dwc3.0.auto: Retrying from deferred list
>>> [   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>> [   20.701254] platform dwc3.0.auto: Added to deferred list
>>> [   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
>>> [   20.713732] platform dwc3.0.auto: Retrying from deferred list
>>> [   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>> [   20.736540] platform dwc3.0.auto: Added to deferred list
>>> [   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
>>> [   20.748991] platform dwc3.0.auto: Retrying from deferred list
>>> [   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>> [   20.771914] platform dwc3.0.auto: Added to deferred list
>>> [   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
>>> ...
>>>
>>> Deeper investigation shows the culprit commit 58b116bce136
>>> ("drivercore: deferral race condition fix") which was dedicated to fix some
>>> other issue while bringing a regression.
>>>
>>> This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
>>> we will have better solution.
>>>
>>> Cc: Grant Likely <grant.likely@linaro.org>
>>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Felipe Balbi <balbi@kernel.org>
>>> Cc: Andrzej Hajda <a.hajda@samsung.com>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>   drivers/base/dd.c | 27 ++-------------------------
>>>   1 file changed, 2 insertions(+), 25 deletions(-)
>>
>> Shouldn't there be a "Fixes:" line and cc: stable here?
> 
> I'm not sure (yet). I would like to hear from people first, especially from
> Grant (I spoke to him already for the matters at ELCE in Edinburg).
> 
> Perhaps, Hans can have a chance to test this and comment on.

I'm currently hitting a regression in 4.20-rc1 which causes it to not
boot on my Cherry Trail test devices (sdhci driver times out so it
cannot find its root filesystem).

I'm currently debugging this (it looks like I need todo a full bisect to
find the cause) once I've that working, if I hit something which look
likes you've described I will give this patch a test. But currently I
cannot reproduce the problem you describe.

As for patches 2-55, they look good to me:

Ackeed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
