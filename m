From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Wed, 17 Jul 2013 12:40:39 +0530
Message-ID: <51E6436F.5010301@ti.com>
References: <20130705115959.GQ5523@atomide.com> <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com> <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com> <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com> <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com> <20130708133512.GD31221@arwen.pp.htv.fi> <87mwpuakod.fsf@linaro.org> <20130710142633.GV5523@atomide.com> <20130710160704.GH18966@arwen.pp.htv.fi> <51DE780C.2070701@ti.com> <51E51FF6.60608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57649 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727Ab3GQHLQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 03:11:16 -0400
In-Reply-To: <51E51FF6.60608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tuesday 16 July 2013 03:57 PM, Grygorii Strashko wrote:
> Hi Rajendra,
> 
> On 07/11/2013 12:17 PM, Rajendra Nayak wrote:
>> On Wednesday 10 July 2013 09:37 PM, Felipe Balbi wrote:
>>> how about something like below ? It makes omap_device/hwmod and
>>> pm_runtime agree on the initial state of the device and will prevent
>>> ->runtime_resume() from being called on first pm_runtime_get*() done
>>> during probe.
>>>
>>> This is similar to what PCI bus does (if you look at pci_pm_init()).
>>
>> I tried something similar [1] but what I found is that the serial
>> runtime resume was called despite it being marked as active using
>> pm_runtime_set_active().
>>
>> That seems to be because of the pm_runtime_set_autosuspend_delay()
>> because we have the autosuspend_delay = -1
>>
>> -----
>> static void update_autosuspend(struct device *dev, int old_delay, int old_use)
>> {
>>          int delay = dev->power.autosuspend_delay;
>>
>>          /* Should runtime suspend be prevented now? */
>>          if (dev->power.use_autosuspend && delay < 0) {
>>
>>                  /* If it used to be allowed then prevent it. */
>>                  if (!old_use || old_delay >= 0) {
>>                          atomic_inc(&dev->power.usage_count);
>>                          rpm_resume(dev, 0); <------------------------------- calls serial runtime resume.
>>                  }
>>          }
>> -----
>>
>> So we end up with the same issue with serial resume being called before set_termios()
>>
>> [1]
>>
>> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
>> index 5cc9287..c71d47d 100644
>> --- a/arch/arm/mach-omap2/omap_device.c
>> +++ b/arch/arm/mach-omap2/omap_device.c
>> @@ -129,6 +129,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>>          struct device_node *node = pdev->dev.of_node;
>>          const char *oh_name;
>>          int oh_cnt, i, ret = 0;
>> +       bool device_active = false;
>>
>>          oh_cnt = of_property_count_strings(node, "ti,hwmods");
>>          if (oh_cnt <= 0) {
>> @@ -152,6 +153,9 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>>                          goto odbfd_exit1;
>>                  }
>>                  hwmods[i] = oh;
>> +               if (oh->flags & HWMOD_INIT_NO_IDLE)
>> +                       device_active = true;
>> +
>>          }
>>
>>          od = omap_device_alloc(pdev, hwmods, oh_cnt);
>> @@ -172,6 +176,11 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>>
>>          pdev->dev.pm_domain = &omap_device_pm_domain;
>>
>> +       if (device_active) {
>> +               omap_device_enable(pdev);
>> +               pm_runtime_set_active(&pdev->dev);
>> +       }
>> +
>>   odbfd_exit1:
>>          kfree(hwmods);
>>   odbfd_exit:
> 
> This solution works good for me in combination with
> "serial: omap: enable PM runtime only when its fully configured"
> http://www.spinics.net/lists/linux-serial/msg10317.html
> (earlyprintk use case)
> 
> And I think the best way would be to move forward with yours solution.
> - it will affect only on needed IPs drivers - not on all, so no issues with iommu and etc.

Ok, good to know that this solution works. Anyone has any other thoughts on whats the best
way to fix this for the -rcs? (Note that we have bootup broken on all OMAPs with DEBUG_LL
for now, atleast for all DT only platforms)

The other option of course is to use the patch posted by Felipe [1], thought that had issues
handling processor IPs as pointed out by Grygorii and Suman [2], the fix I posted [3] to make
omap_device aware of hwmod bypassing these IPs might fix some of those, but this solution in
general would need more testing as it affects all modules on the bus.

[1] http://www.spinics.net/lists/arm-kernel/msg258062.html
[2] http://www.spinics.net/lists/arm-kernel/msg258061.html
[3] http://www.spinics.net/lists/arm-kernel/msg258465.html

> 
> But issue with *non console" UARTs will still be here and, I think,
> there are no way ti solve it from OMAP device/hwmod frameworks side,
> because only driver can know when his context is ready.
> To test do: #echo 0xDEAD > dev/ttyO3
> 
> Regards,
> -grygorii

