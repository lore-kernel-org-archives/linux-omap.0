From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 07/14] cpufreq: cpu0: OPPs can be populated at runtime
Date: Thu, 10 Jul 2014 09:31:30 -0400
Message-ID: <53BE95B2.50606@ti.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org>	<1ba7771e910084cd0820c19ca5994fe1b3d6451d.1404231535.git.viresh.kumar@linaro.org>	<53BD5564.2060704@ti.com>	<CAKohpo=KUktq8XJv7Ayis1Q3ik+Wh3wb8wN6VpRAtOsbbv9XCw@mail.gmail.com> <CAGo_u6rBMGO9t87w1e4KCTA+ckF8aeFr+jMw00fks-=y+9JGdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAGo_u6rBMGO9t87w1e4KCTA+ckF8aeFr+jMw00fks-=y+9JGdA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas P Abraham <thomas.ab@samsung.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Sachin Kamat <spk.linux@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 10 July 2014 08:39 AM, Nishanth Menon wrote:
> On Thu, Jul 10, 2014 at 6:19 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 9 July 2014 20:14, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>>> Assuming you are updating bidnings as suggested by Stephen,
>>> patch looks good to me.
>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> Why do you still have a separate cpufreq driver for omap?
>> Would this patch help getting that out?
>>
>> I see this for omap:
>>
>> static inline void omap_init_cpufreq(void)
>> {
>>         struct platform_device_info devinfo = { };
>>
>>         if (!of_have_populated_dt())
>>                 devinfo.name = "omap-cpufreq";
>>         else
>>                 devinfo.name = "cpufreq-generic";
>>         platform_device_register_full(&devinfo);
>> }
>>
>> and it makes me believe that you were just waiting for this patch?
> 
> Sorry, am away on vacation and slow on emails. The plan was to kill
> omap cpufreq once all platforms convert to device tree only boot. Only
> platform left is OMAP3 based platforms - though the date for removing
> non-dt support has changed a couple of kernel revisions - but we
> should be able to remove that entire file with this change.
> 
> We will need this support to go with the solution recommended for opp
> modifier series[1] - where platform code will populate or add OPPs
> based on "speed grade" sample detection.
>
Yep. Last time I blocked the series because all the DT conversions
were not done. Considering now the cpufreq-generic can work on non
DT platforms, I am ok to remove the omap-cpufreq.

Regards,
Santosh

 
