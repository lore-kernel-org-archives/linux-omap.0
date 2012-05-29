From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Tue, 29 May 2012 17:27:07 -0500
Message-ID: <4FC54D3B.10301@ti.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com> <87wr3uelgp.fsf@ti.com> <4FC548A3.2040906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52769 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861Ab2E2W1S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 18:27:18 -0400
In-Reply-To: <4FC548A3.2040906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Kevin,

On 05/29/2012 05:07 PM, Jon Hunter wrote:
> Hi Kevin,
> 
> On 05/29/2012 04:17 PM, Kevin Hilman wrote:
>> Jon Hunter <jon-hunter@ti.com> writes:
>>
>>> From: Jon Hunter <jon-hunter@ti.com>
>>>
>>> This patch is based upon Ming Lei's patch to add runtime PM support for OMAP4
>>> [1]. In Ming's original patch the CTI interrupts were being enabled during
>>> runtime when the PMU was used but they were only configured once during init.
>>> Therefore move the configuration of the CTI interrupts to the runtime PM
>>> functions.
>>
>> Lovely.  This is exactly the workaround I was hoping to see.   Thanks!
>>
>> Some comments below...
> 
> Thanks! Great timing, I am getting ready to post V2 :-)
> 
>>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074153.html
>>>
>>> Cc: Ming Lei <ming.lei@canonical.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/devices.c |   50 ++++++++++++++++++++++------------------
>>>  1 files changed, 27 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>>> index 636533d..b02aa81 100644
>>> --- a/arch/arm/mach-omap2/devices.c
>>> +++ b/arch/arm/mach-omap2/devices.c
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/of.h>
>>>  #incluhttp://marc.info/?l=linux-arm-kernel&m=132227620816504&w=2de <linux/platform_data/omap4-keypad.h>
>>> +#include <linux/pm_runtime.h>
>>>  
>>>  #include <mach/hardware.h>
>>>  #include <mach/irqs.h>
>>> @@ -434,13 +435,22 @@ static struct omap_device_pm_latency omap_pmu_latency[] = {
>>>  };
>>>  
>>>  static struct cti omap4_cti[2];
>>> +static struct platform_device *pmu_dev;
>>>  
>>>  static void omap4_enable_cti(int irq)
>>>  {
>>> -	if (irq == OMAP44XX_IRQ_CTI0)
>>> +	pm_runtime_get_sync(&pmu_dev->dev);
>>> +	if (irq == OMAP44XX_IRQ_CTI0) {
>>> +		/* configure CTI0 for pmu irq routing */
>>> +		cti_unlock(&omap4_cti[0]);
>>> +		cti_map_trigger(&omap4_cti[0], 1, 6, 2);
>>>  		cti_enablook at thisle(&omap4_cti[0]);
>>> -	else if (irq == OMAP44XX_IRQ_CTI1)
>>> +	} else if (irq == OMAP44XX_IRQ_CTI1) {
>>> +		/* configure CTI1 for pmu irq routing */
>>> +		cti_unlolook at thisck(&omap4_cti[1]);
>>> +		cti_map_trigger(&omap4_cti[1], 1, 6, 2);
>>>  		cti_enable(&omap4_cti[1]);
>>> +	}
>>>  }
>>
>> The cti_* functions really belong in the ->runtime_resume() callback.
>>
>> In the case of multiple users, I don't think the current implementation
>> will do what is intended.  IOW, you only want to (re)init for the first
>> user (when runtime PM usecount goes from zero to one.)   That is when
>> the ->runtime_resume() is called.   For a 2nd user, the
>> ->runtime_resume() callback will not be called, but the cti_* functions
>> will still be called.   I don't think that is what you want.
> 
> Ah, yes that would not work. Ok, let me make that change.

Actually, looking at this some more, the above omap4_enable_cti()
function is getting called from armpmu_reserve_hardware() function in
the pmu driver. In armpmu_reserve_hardware(), it calls reserve_pmu() to
see if the PMU is in-use and if not acquires it. So I believe that this
code should be atomic already. May be Will or Ming can confirm. However,
if this is the case, then do you agree we should be ok?

I can see that ideally, we should use ->runtime_resume/suspend, but the
arm-pmu does not currently have support for these functions and hence
there is no easy way to specify such platform functions. Obviously it
could be done but would be a bigger change.

Let me know your thoughts.

Cheers
Jon
