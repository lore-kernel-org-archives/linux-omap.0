From: Nishanth Menon <nm@ti.com>
Subject: Re: Fwd: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
Date: Wed, 17 Dec 2014 09:28:57 -0600
Message-ID: <20141217152857.GA838@kahuna>
References: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>
 <CAMAWPa98kyaUJpt=GLw4cH7fkg+8BkrA0kds=H-2-4fWXy_tqw@mail.gmail.com>
 <54909E30.4040300@ti.com>
 <CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 09:37-20141217, Viresh Kumar wrote:
> On 17 December 2014 at 02:33, Nishanth Menon <nm@ti.com> wrote:
> > http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-multi_v7_defconfig/lab-khilman/boot-omap5-uevm.html
> > [    2.071996] ------------[ cut here ]------------
> > [    2.076831] kernel BUG at ../drivers/cpufreq/cpufreq.c:1258!
> > [    2.082753] Internal error: Oops - BUG: 0 [#1] SMP ARM
> 
> This is what we have hit:
> 
>         if ((cpufreq_driver->flags & CPUFREQ_NEED_INITIAL_FREQ_CHECK)
>             && has_target()) {
>                 /* Are we running at unknown frequency ? */
>                 ret = cpufreq_frequency_table_get_index(policy, policy->cur);
>                 if (ret == -EINVAL) {
>                         /* Warn user and fix it */
>                         pr_warn("%s: CPU%d: Running at unlisted freq: %u KHz\n",
>                                 __func__, policy->cpu, policy->cur);
>                         ret = __cpufreq_driver_target(policy, policy->cur - 1,
>                                 CPUFREQ_RELATION_L);
> 
>                         /*
>                          * Reaching here after boot in a few seconds may not
>                          * mean that system will remain stable at "unknown"
>                          * frequency for longer duration. Hence, a BUG_ON().
>                          */
>                         BUG_ON(ret);        /********* We have hit
> this one *******/
>                         pr_warn("%s: CPU%d: Unlisted initial frequency
> changed to: %u KHz\n",
>                                 __func__, policy->cpu, policy->cur);
>                 }
>         }
> 
> 
> So the SoC was running on unlisted frequency and when we tried to
> change to some other valid (listed) frequency, we failed.
> 
> The comment over it describes why it is a BUG.. Its some SoC issue
> and need to be resolved by somebody with a board.
> 
> So, in short __cpufreq_driver_target() failed to change freq..

I still do not see the need to crash the entire system - OK, fine
cpufreq is broke, but the remaining part of the system can easily
function. That BUG does look like a ugly point and lack of proper
cleanup logic - cpufreq should be expected to report and gracefully
shut itself down, not screw up my platform boot.

For that matter we have had cpufreq working on TI platforms for years
now. I will eventually find time to track the issue down if no one else
beats me to it, but it kinda indicates that things are probably starting
to bitrot...

-- 
Regards,
Nishanth Menon
