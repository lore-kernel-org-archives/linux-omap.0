From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] ARM: OMAP2+: omap_device: maintain sane runtime pm
 status around suspend/resume
Date: Wed, 13 Nov 2013 09:28:07 -0600
Message-ID: <52839A87.3020408@ti.com>
References: <1384297710-29694-1-git-send-email-nm@ti.com> <20131113125149.GB28192@saruman.home> <52839306.7050701@ti.com> <20131113152001.GC29226@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131113152001.GC29226@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, rnayak@ti.com, khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/13/2013 09:20 AM, Felipe Balbi wrote:
> On Wed, Nov 13, 2013 at 08:56:06AM -0600, Nishanth Menon wrote:
>> On 11/13/2013 06:51 AM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Tue, Nov 12, 2013 at 05:08:30PM -0600, Nishanth Menon wrote:
>>>> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
>>>> index b69dd9a..f97b34b 100644
>>>> --- a/arch/arm/mach-omap2/omap_device.c
>>>> +++ b/arch/arm/mach-omap2/omap_device.c
>>>> @@ -621,6 +621,7 @@ static int _od_suspend_noirq(struct device *dev)
>>>>  
>>>>  	if (!ret && !pm_runtime_status_suspended(dev)) {
>>>>  		if (pm_generic_runtime_suspend(dev) == 0) {
>>>> +			pm_runtime_set_suspended(dev);
>>>
>>> don't you have to disable pm_runtime around status changes ? Or is
>>> pm_runtime already disabled by the time we get here ?
>>
>> pm_runtime is already disabled by the time no_irq suspend is invoked.
>>
>>>
>>>> @@ -634,10 +635,10 @@ static int _od_resume_noirq(struct device *dev)
>>>>  	struct platform_device *pdev = to_platform_device(dev);
>>>>  	struct omap_device *od = to_omap_device(pdev);
>>>>  
>>>> -	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
>>>> -	    !pm_runtime_status_suspended(dev)) {
>>>> +	if (od->flags & OMAP_DEVICE_SUSPENDED) {
>>>>  		od->flags &= ~OMAP_DEVICE_SUSPENDED;
>>>>  		omap_device_enable(pdev);
>>>> +		pm_runtime_set_active(dev);
>>>
>>> ditto, also pm_runtime_set_active() may fail.
>>>
>> again, pm_runtime is not yet active here yet - we just restore the pm
>> runtime state with which we went down with -> and that is not expected
>> to fail either - So, how about just adding a WARN if our expectation
>> of balanced operation was somehow broken in the future with changes to
>> runtime framework?
> 
> you mean:
> 
> WARN(pm_runtime_set_active(dev));  ?

yes

> 
> sounds good

Thanks. Will post a v3 tomorrow morning to give a chance for
discussions on further comments if any.

-- 
Regards,
Nishanth Menon
