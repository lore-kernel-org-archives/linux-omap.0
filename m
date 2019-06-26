From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/3] thermal/drivers/cpu_cooling: Unregister with the
 policy
Date: Wed, 26 Jun 2019 14:52:10 +0200
Message-ID: <81eed47f-9439-abd3-8b73-56ccf5137be3@linaro.org>
References: <20190625113244.18146-1-daniel.lezcano@linaro.org>
 <20190625113244.18146-2-daniel.lezcano@linaro.org>
 <20190626025831.jmyzyypxr6ezpbtu@vireshk-i7>
 <da1d2603-e30a-d877-54c3-1fad218f9d57@linaro.org>
 <20190626063716.cechnzsb75q5lclr@vireshk-i7>
 <CAJZ5v0jFXmJ3ikEPQUp-cLv3+ZSnp1kP8CxdkZVofV1BS3+UwQ@mail.gmail.com>
 <8a9b7bd0-9b21-1ce1-6176-cffff4b8d739@linaro.org>
 <CAJZ5v0h7=BqnQqvULnQr3MuQsS2qwSn7RCZbMo-V+cUi+kbvSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h7=BqnQqvULnQr3MuQsS2qwSn7RCZbMo-V+cUi+kbvSg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Keerthy <j-keerthy@ti.com>, "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list:TI BANDG
List-Id: linux-omap@vger.kernel.org

On 26/06/2019 13:28, Rafael J. Wysocki wrote:
> On Wed, Jun 26, 2019 at 12:19 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 26/06/2019 11:06, Rafael J. Wysocki wrote:
>>> On Wed, Jun 26, 2019 at 8:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>
>>>> On 26-06-19, 08:02, Daniel Lezcano wrote:
>>>>> On 26/06/2019 04:58, Viresh Kumar wrote:
>>>>>> On 25-06-19, 13:32, Daniel Lezcano wrote:
>>>>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>>>>> index aee024e42618..f07454249fbc 100644
>>>>>>> --- a/drivers/cpufreq/cpufreq.c
>>>>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>>>>> @@ -1379,8 +1379,8 @@ static int cpufreq_online(unsigned int cpu)
>>>>>>>            cpufreq_driver->ready(policy);
>>>>>>>
>>>>>>>    if (cpufreq_thermal_control_enabled(cpufreq_driver))
>>>>>>> -          policy->cdev = of_cpufreq_cooling_register(policy);
>>>>>>> -
>>>>>>> +          of_cpufreq_cooling_register(policy);
>>>>>>> +
>>>>>>
>>>>>> We don't need any error checking here anymore ?
>>>>>
>>>>> There was no error checking initially. This comment and the others below
>>>>> are for an additional patch IMO, not a change in this one.
>>>>
>>>> right, but ...
>>>>
>>>>>>> -void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>>>>>>> +void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
>>>>>>>  {
>>>>>>>    struct cpufreq_cooling_device *cpufreq_cdev;
>>>>>>>    bool last;
>>>>>>>
>>>>>>> -  if (!cdev)
>>>>>>> -          return;
>>>>
>>>> we used to return without any errors from here. Now we will have
>>>> problems if regsitering fails for some reason.
>>>
>>> Specifically, the last cpufreq_cdev in the list will be unregistered
>>> AFAICS, and without removing it from the list for that matter, which
>>> isn't what the caller wants.
>>
>> Indeed,
>>
>> What about the resulting code above:
>>
>> void __cpufreq_cooling_unregister(struct cpufreq_cooling_device
>> *cpufreq_cdev, int last)
>> {
>>         /* Unregister the notifier for the last cpufreq cooling device */
>>         if (last)
>>                 cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
>>                                             CPUFREQ_POLICY_NOTIFIER);
>>
> 
> Doesn't the notifier need to be unregistered under cooling_list_lock ?

I don't think so because the element is no longer in the list and we
don't touch the list anymore. Do you see another possible race?

>>         thermal_cooling_device_unregister(cpufreq_cdev->cdev);
>>         ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
>>         kfree(cpufreq_cdev->idle_time);
>>         kfree(cpufreq_cdev);
>> }
>>
>> /**
>>
>>  * cpufreq_cooling_unregister - function to remove cpufreq cooling
>> device.
>>  * @cdev: thermal cooling device pointer.
>>
>>  *
>>
>>  * This interface function unregisters the "thermal-cpufreq-%x" cooling
>> device.
>>  */
>> void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
>> {
>>         struct cpufreq_cooling_device *cpufreq_cdev;
>>         bool last;
>>
>>         mutex_lock(&cooling_list_lock);
>>         list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
>>                 if (cpufreq_cdev->policy == policy) {
>>                         list_del(&cpufreq_cdev->node);
>>                         last = list_empty(&cpufreq_cdev_list);
>>                         break;
>>                 }
>>         }
>>         mutex_unlock(&cooling_list_lock);
>>
>>         if (cpufreq_cdev->policy == policy)
>>                 __cpufreq_cooling_unregister(cpufreq_cdev, last);
>> }
>> EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
>>
>>
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
