From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: add fail hook for runtime_pm
 when bad data is detected
Date: Thu, 5 Dec 2013 15:06:37 +0530
Message-ID: <52A04925.6020801@ti.com>
References: <1386121153-32351-1-git-send-email-nm@ti.com>
 <529EE305.70001@ti.com> <529F12F4.70304@ti.com> <529F2391.8070202@ti.com>
 <20131204133702.GA7828@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131204133702.GA7828@kahuna>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/04/2013 07:07 PM, Nishanth Menon wrote:
> On 18:14-20131204, Joel Fernandes wrote:
>> On 12/04/2013 05:03 PM, Nishanth Menon wrote:
>>> On 12/04/2013 02:08 AM, Joel Fernandes wrote:
>>>> On 12/04/2013 07:09 AM, Nishanth Menon wrote:
>>>>> Due to the cross dependencies between hwmod for automanaged device
>>>>> information for OMAP and dts node definitions, we can run into scenarios
>>>>> where the dts node is defined, however it's hwmod entry is yet to be
>>>>> added. In these cases:
>>>>> a) omap_device does not register a pm_domain (since it cannot find
>>>>>     hwmod entry).
>>>>> b) driver does not know about (a), does a pm_runtime_get_sync which
>>>>>     never fails
>>>>> c) It then tries to do some operation on the device (such as read the
>>>>>    revision register (as part of probe) without clock or adequate OMAP
>>>>>    generic PM operation performed for enabling the module.
>>>>>
>>>>> This causes a crash such as that reported in:
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=66441
>>>>>
>>>>> When 'ti,hwmod' is provided in dt node, it is expected that the device
>>>>> will not function without the OMAP's power automanagement. Hence, when
>>>>> we hit a fail condition (due to hwmod entries not present or other
>>>>> similar scenario), fail at pm_domain level due to lack of data, provide
>>>>> enough information for it to be fixed, however, it allows for the driver
>>>>> to take appropriate measures to prevent crash.
>>>>>
>>>>> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>>> ---
>>>>>   arch/arm/mach-omap2/omap_device.c |   24 ++++++++++++++++++++++++
>>>>>   arch/arm/mach-omap2/omap_device.h |    1 +
>>>>>   2 files changed, 25 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/omap_device.c
>>>>> b/arch/arm/mach-omap2/omap_device.c
>>>>> index 53f0735..e0a398c 100644
>>>>> --- a/arch/arm/mach-omap2/omap_device.c
>>>>> +++ b/arch/arm/mach-omap2/omap_device.c
>>>>> @@ -183,6 +183,10 @@ static int omap_device_build_from_dt(struct
>>>>> platform_device *pdev)
>>>>>   odbfd_exit1:
>>>>>       kfree(hwmods);
>>>>>   odbfd_exit:
>>>>> +    /* if data/we are at fault.. load up a fail handler */
>>>>> +    if (ret)
>>>>> +        pdev->dev.pm_domain = &omap_device_fail_pm_domain;
>>>>> +
>>>>>       return ret;
>>>>>   }
>>>>>
>>>>
>>>> Just wondering, can't we just print the warning here instead of registering new
>>>> pm_domain callbacks?
>>>>
>>>
>>> I suggest you might want to read the commit message again.. but lets try once
>>> again:
>>
>> I know what your patch does and what the problem you're trying to solve is.. Was
>> just trying to see if there's a better way of doing what you're trying to do..
> Thanks for clarifying.
> 
>>
>>>>> b) driver does not know about (a), does a pm_runtime_get_sync which
>>>>>     never fails"
>>>
>>> A device node stated it will have hwmod to adequately control it, but in
>>> reality, as in this case, it does not. how does printing a warning alone help
>>> the driver which is not aware of these? The driver's attempt at pm_runtime_sync
>>> should fail, as that is what "ti,hwmod" property controls.
>>
>> Why not do the following?
>>
>> Assign pm_domain as omap_device_pm_domain always regardless of error or not.
>>
>> Then in the _od_runtime_resume, check if the od or hwmods exists. If not, print
>> the warning. That way you don't need to register additional special callbacks
>> just to print a warning and will prolly be fewer LoC fwiw.
>>
>> That may be harder to do and may require additional checks in omap_device_enable
>> etc, not sure. In that case, your approach is certainly the next best way. Just
>> thought its worth looking into :)
> 
> fair enough, The moment we use the generic omap_device_pm_domain, the
> remaining code which assumes od will be valid will need checking.. (so,
> we got to do that for all functions where usage is present - fine, that
> can be done too)[1] - and yes, it will take care of the pm_runtime handling
> However, lets look at the side effect, omap_device_pm_domain also
> registers generic suspend_noirq and resume_noirq, and _od_suspend_noirq will
> also fail -> as a result device will fail to even attempt to suspend.
> 
> That IMHO, is a wrong behavior, So, that explains why we'd need a
> omap_device_fail_pm_domain. Keeps the error handling completely
> seperated from regular code.

Sorry for the late reply due to travel. Ok, in that case then your patch is OK
method to fix it.

If required for FWIW,
Acked-by: Joel Fernandes <joelf@ti.com>


regards,

-Joel


> 
> 
> [1]
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 53f0735..029f076 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -173,7 +173,6 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>  			r->name = dev_name(&pdev->dev);
>  	}
>  
> -	pdev->dev.pm_domain = &omap_device_pm_domain;
>  
>  	if (device_active) {
>  		omap_device_enable(pdev);
> @@ -183,6 +182,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>  odbfd_exit1:
>  	kfree(hwmods);
>  odbfd_exit:
> +	pdev->dev.pm_domain = &omap_device_pm_domain;
>  	return ret;
>  }
>  
> @@ -267,6 +267,10 @@ int omap_device_get_context_loss_count(struct platform_device *pdev)
>  	u32 ret = 0;
>  
>  	od = to_omap_device(pdev);
> +	if (!od) {
> +		dev_err(&pdev->dev, "%s: Missing od data\n", __func__);
> +		return -ENODEV;
> +	}
>  
>  	if (od->hwmods_cnt)
>  		ret = omap_hwmod_get_context_loss_count(od->hwmods[0]);
> @@ -587,6 +591,12 @@ static int _od_runtime_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	int ret;
> +	struct omap_device *od = to_omap_device(pdev);
> +
> +	if (!od) {
> +		dev_err(dev, "%s: Missing od data\n", __func__);
> +		return -ENODEV;
> +	}
>  
>  	ret = pm_generic_runtime_suspend(dev);
>  
> @@ -599,6 +609,12 @@ static int _od_runtime_suspend(struct device *dev)
>  static int _od_runtime_resume(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct omap_device *od = to_omap_device(pdev);
> +
> +	if (!od) {
> +		dev_err(dev, "%s: Missing od data\n", __func__);
> +		return -ENODEV;
> +	}
>  
>  	omap_device_enable(pdev);
>  
> @@ -613,6 +629,11 @@ static int _od_suspend_noirq(struct device *dev)
>  	struct omap_device *od = to_omap_device(pdev);
>  	int ret;
>  
> +	if (!od) {
> +		dev_err(dev, "%s: Missing od data\n", __func__);
> +		return -ENODEV;
> +	}
> +
>  	/* Don't attempt late suspend on a driver that is not bound */
>  	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
>  		return 0;
> @@ -635,6 +656,11 @@ static int _od_resume_noirq(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct omap_device *od = to_omap_device(pdev);
>  
> +	if (!od) {
> +		dev_err(dev, "%s: Missing od data\n", __func__);
> +		return -ENODEV;
> +	}
> +
>  	if (od->flags & OMAP_DEVICE_SUSPENDED) {
>  		od->flags &= ~OMAP_DEVICE_SUSPENDED;
>  		omap_device_enable(pdev);
> @@ -704,6 +730,10 @@ int omap_device_enable(struct platform_device *pdev)
>  	struct omap_device *od;
>  
>  	od = to_omap_device(pdev);
> +	if (!od) {
> +		dev_err(&pdev->dev, "%s: Missing od data\n", __func__);
> +		return -ENODEV;
> +	}
>  
>  	if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
>  		dev_warn(&pdev->dev,
> @@ -734,6 +764,10 @@ int omap_device_idle(struct platform_device *pdev)
>  	struct omap_device *od;
>  
>  	od = to_omap_device(pdev);
> +	if (!od) {
> +		dev_err(&pdev->dev, "%s: Missing od data\n", __func__);
> +		return -ENODEV;
> +	}
>  
>  	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
>  		dev_warn(&pdev->dev,
> @@ -767,6 +801,11 @@ int omap_device_assert_hardreset(struct platform_device *pdev, const char *name)
>  	int ret = 0;
>  	int i;
>  
> +	if (!od) {
> +		dev_err(&pdev->dev, "%s: Missing od data\n", __func__);
> +		return -ENODEV;
> +	}
> +
>  	for (i = 0; i < od->hwmods_cnt; i++) {
>  		ret = omap_hwmod_assert_hardreset(od->hwmods[i], name);
>  		if (ret)
> @@ -795,6 +834,11 @@ int omap_device_deassert_hardreset(struct platform_device *pdev,
>  	int ret = 0;
>  	int i;
>  
> +	if (!od) {
> +		dev_err(&pdev->dev, "%s: Missing od data\n", __func__);
> +		return -ENODEV;
> +	}
> +
>  	for (i = 0; i < od->hwmods_cnt; i++) {
>  		ret = omap_hwmod_deassert_hardreset(od->hwmods[i], name);
>  		if (ret)
> 
