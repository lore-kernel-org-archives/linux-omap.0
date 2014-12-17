From: Nishanth Menon <nm@ti.com>
Subject: Re: Fwd: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
Date: Wed, 17 Dec 2014 10:43:56 -0600
Message-ID: <CAGo_u6qeNBSHYtq84QZH76bR_8xztbi2+Q6mXwH-_orTSg1jtQ@mail.gmail.com>
References: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>
	<CAMAWPa98kyaUJpt=GLw4cH7fkg+8BkrA0kds=H-2-4fWXy_tqw@mail.gmail.com>
	<54909E30.4040300@ti.com>
	<CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>
	<20141217152857.GA838@kahuna>
	<CAKohponn9Ubk7ze5XVsJ4Gdkosx4YY3e0fNHLwjUYurkOYFqsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:54873 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbaLQQn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2014 11:43:56 -0500
In-Reply-To: <CAKohponn9Ubk7ze5XVsJ4Gdkosx4YY3e0fNHLwjUYurkOYFqsg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Dec 17, 2014 at 10:27 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17 December 2014 at 20:58, Nishanth Menon <nm@ti.com> wrote:
>> I still do not see the need to crash the entire system - OK, fine
>> cpufreq is broke, but the remaining part of the system can easily
>> function. That BUG does look like a ugly point and lack of proper
>> cleanup logic - cpufreq should be expected to report and gracefully
>> shut itself down, not screw up my platform boot.
>
> http://lists.linaro.org/pipermail/linaro-kernel/2013-November/009128.html
>
> We came to this conclusion because you insisted that its not safe
> for the system to continue on a unsupported frequency from kernel's
> freq table. It may run well, but we don't know what will happen in
> longer run..
>
I do realize that i did have different opinion given bootloader screw
ups. Given that we have discovered a potentially bad configuration (in
this case for some reason almost ALL TI platforms "have bad
configuration" - could be due to recent clock code changes or what
ever), just killing boot does not make sense to me as purely
bootloader being the cause may not always be the case for that path to
go wrong.

---
Regards,
Nishanth Menon
