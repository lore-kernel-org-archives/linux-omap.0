From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH ] cpufreq: ti-cpufreq: kfree opp_data when failure
Date: Thu, 28 Sep 2017 13:00:42 +0800
Message-ID: <7a2171a3-d594-7fd7-2ccf-75ef7110dd98@windriver.com>
References: <1506496097-30852-1-git-send-email-zumeng.chen@windriver.com>
 <20170927174026.GB12211@ubuntu>
 <7b7315f0-c2e4-a09e-8769-2d15a167fa73@windriver.com>
 <20170928041933.GG12211@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170928041933.GG12211@ubuntu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: d-gerlach@ti.com, tony@atomide.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/28/2017 12:19 PM, Viresh Kumar wrote:
> On 28-09-17, 07:49, Zumeng Chen wrote:
>> On 09/28/2017 01:40 AM, Viresh Kumar wrote:
>>> On 27-09-17, 15:08, Zumeng Chen wrote:
>>>> From: Zumeng Chen <zumeng.chen@gmail.com>
>>>>
>>>> memory leakage was found by kmemleak. opp_data needs to be freed
>>>> when failure, including fail_put_node.
>>>>
>>>> unreferenced object 0xccdd4c40 (size 64):
>>>>    comm "swapper", pid 1, jiffies 4294938465 (age 888.520s)
>>>>    hex dump (first 32 bytes):
>>>>      00 7c 00 c1 98 69 d8 ce 00 24 03 ce 00 24 03 ce  .|...i...$...$..
>>>>      20 35 23 c1 00 00 00 00 00 00 00 00 00 00 00 00   5#.............
>>>>    backtrace:
>>>>      [<c028fb64>] kmem_cache_alloc_trace+0x2c4/0x3cc
>>>>      [<c076d5f0>] ti_cpufreq_probe+0x6c/0x334
>>>>      [<c068d6e4>] platform_drv_probe+0x60/0xc0
>>>>      [<c068b384>] driver_probe_device+0x218/0x2c4
>>>>      [<c068b5a4>] __device_attach_driver+0xa8/0xdc
>>>>      [<c0689340>] bus_for_each_drv+0x70/0xa4
>>>>      [<c068b020>] __device_attach+0xc0/0x124
>>>>      [<c068b634>] device_initial_probe+0x1c/0x20
>>>>      [<c068a3b8>] bus_probe_device+0x94/0x9c
>>>>      [<c0688300>] device_add+0x404/0x590
>>>>      [<c068d408>] platform_device_add+0x11c/0x230
>>>>      [<c068df40>] platform_device_register_full+0x10c/0x128
>>>>      [<c076d578>] ti_cpufreq_init+0x44/0x50
>>>>      [<c01017c4>] do_one_initcall+0x54/0x180
>>>>      [<c0e00fe0>] kernel_init_freeable+0x270/0x33c
>>>>      [<c093f2bc>] kernel_init+0x18/0x124
>>>>
>>>> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
>>>> ---
>>>>   drivers/cpufreq/ti-cpufreq.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
>>>> index 4bf47de..ffcddcd 100644
>>>> --- a/drivers/cpufreq/ti-cpufreq.c
>>>> +++ b/drivers/cpufreq/ti-cpufreq.c
>>>> @@ -217,7 +217,8 @@ static int ti_cpufreq_init(void)
>>>>   	opp_data->cpu_dev = get_cpu_device(0);
>>>>   	if (!opp_data->cpu_dev) {
>>>>   		pr_err("%s: Failed to get device for CPU0\n", __func__);
>>>> -		return -ENODEV;
>>>> +		ret = ENODEV;
>>>> +		goto free_opp_data;
>>>>   	}
>>>>   	opp_data->opp_node = dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
>>>> @@ -262,6 +263,8 @@ static int ti_cpufreq_init(void)
>>>>   fail_put_node:
>>>>   	of_node_put(opp_data->opp_node);
>>>> +free_opp_data:
>>>> +	kfree(opp_data);
>>>>   	return ret;
>>>>   }
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>
>>> I also see that you are missing an of_node_put(np) in the driver. Maybe you
>>> want to fix that as well (in a separate patch) ?
>> Ha, thanks, I'm not sure if I follow your meanings.
>>
>> opp_data->opp_node will be set after goto free_opp_data, so are we safe
>> here?
>>
>>          opp_data->cpu_dev = get_cpu_device(0);
>>          if (!opp_data->cpu_dev) {
>>                  pr_err("%s: Failed to get device for CPU0\n", __func__);
>>                  ret = ENODEV;
>>                  goto free_opp_data;
>>          }
>>
>>          opp_data->opp_node =
>> dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
> I was talking about this one.
>
>          np = of_find_node_by_path("/");
>
> There is no counterpart of this one.

Yes, you are right, it seems of_node_put(np) that you mentioned were
ignored by both paths. If you don't mind I can deliver a separate patch
to fix this based on some testing later.

Cheers,
Zumeng
>
