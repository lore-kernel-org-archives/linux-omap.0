From: Kevin Hilman <khilman@kernel.org>
Subject: Re: Fwd: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
Date: Wed, 17 Dec 2014 09:16:15 -0800
Message-ID: <CAMAWPa-_OZC3ynKYxbtXK4=z-z720JxXigT23umscMTm8VWAzA@mail.gmail.com>
References: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>
	<CAMAWPa98kyaUJpt=GLw4cH7fkg+8BkrA0kds=H-2-4fWXy_tqw@mail.gmail.com>
	<54909E30.4040300@ti.com>
	<CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

[+ Tero]

On Tue, Dec 16, 2014 at 8:07 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17 December 2014 at 02:33, Nishanth Menon <nm@ti.com> wrote:
>> http://storage.armcloud.us/kernel-ci/next/next-20141216/arm-multi_v7_defconfig/lab-khilman/boot-omap5-uevm.html
>> [    2.071996] ------------[ cut here ]------------
>> [    2.076831] kernel BUG at ../drivers/cpufreq/cpufreq.c:1258!
>> [    2.082753] Internal error: Oops - BUG: 0 [#1] SMP ARM
>

[...]

> So the SoC was running on unlisted frequency and when we tried to
> change to some other valid (listed) frequency, we failed.
>
> The comment over it describes why it is a BUG.. Its some SoC issue
> and need to be resolved by somebody with a board.
>
> So, in short __cpufreq_driver_target() failed to change freq..

So this looks like a bug that has been hiding, but just exposed
because cpufreq-cpu0 (now cpufreq-dt) was not getting built-in since
before v3.18.

On omap4-panda-es, v3.18 with multi_v7_defconfig + CPUFREQ_DT enabled,
I see this:

[    2.062103] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted
freq: 699977 KHz
[    2.070404] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial
frequency changed to: 700000 KHz

No BUG.  But, in next-20141216,

[    2.083953] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted
freq: 699977 KHz
[    2.091949] cpu cpu0: failed to set clock rate: -22
[    2.097045] cpufreq: __target_index: Failed to change cpu frequency: -22

And then the BUG.

So the BUG() itself isn't the problem with this regression.  There's
been a fair amount of changes in the OMAP clk driver (including some
other regressions), so I suspect the culprit to be lying somewhere in
the recent OMAP clock changes.

Kevin
