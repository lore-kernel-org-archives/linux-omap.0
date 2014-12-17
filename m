From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Fwd: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
Date: Wed, 17 Dec 2014 21:57:36 +0530
Message-ID: <CAKohponn9Ubk7ze5XVsJ4Gdkosx4YY3e0fNHLwjUYurkOYFqsg@mail.gmail.com>
References: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>
	<CAMAWPa98kyaUJpt=GLw4cH7fkg+8BkrA0kds=H-2-4fWXy_tqw@mail.gmail.com>
	<54909E30.4040300@ti.com>
	<CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>
	<20141217152857.GA838@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20141217152857.GA838@kahuna>
Sender: linux-pm-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 17 December 2014 at 20:58, Nishanth Menon <nm@ti.com> wrote:
> I still do not see the need to crash the entire system - OK, fine
> cpufreq is broke, but the remaining part of the system can easily
> function. That BUG does look like a ugly point and lack of proper
> cleanup logic - cpufreq should be expected to report and gracefully
> shut itself down, not screw up my platform boot.

http://lists.linaro.org/pipermail/linaro-kernel/2013-November/009128.html

We came to this conclusion because you insisted that its not safe
for the system to continue on a unsupported frequency from kernel's
freq table. It may run well, but we don't know what will happen in
longer run..

And surely it deserves a bug-on then.
