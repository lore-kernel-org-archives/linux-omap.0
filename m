From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 0/5] PM / clock_ops: provide default runtime ops and cleanup
 users
Date: Fri, 24 Apr 2015 08:34:33 -0700
Message-ID: <553A6289.4040001@oracle.com>
References: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org> <2234398.3O5UMXvvlN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2234398.3O5UMXvvlN@vostro.rjw.lan>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rajendra Nayak <rnayak@codeaurora.org>
Cc: ssantosh@kernel.org, tony@atomide.com, khilman@kernel.org, nsekhar@ti.com, magnus.damm@gmail.com, geert@linux-m68k.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 4/24/2015 7:41 AM, Rafael J. Wysocki wrote:
> On Thursday, April 23, 2015 02:03:08 PM Rajendra Nayak wrote:
>> Most users of PM clocks do the exact same thing in runtime callbacks.
>> Provide default callbacks and cleanup the existing users (keystone/davinci
>> /omap1/sh)
>>
>> Rajendra Nayak (5):
>>    PM / clock_ops: Provide default runtime ops to users
>>    arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>>    arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>>    arm: davinci: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>>    drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>>
>>   arch/arm/mach-davinci/pm_domain.c  | 32 +-------------------------
>>   arch/arm/mach-keystone/pm_domain.c | 33 +-------------------------
>>   arch/arm/mach-omap1/pm_bus.c       | 37 ++----------------------------
>>   drivers/base/power/clock_ops.c     | 38 ++++++++++++++++++++++++++++++
>>   drivers/sh/pm_runtime.c            | 47 ++------------------------------------
>>   include/linux/pm_clock.h           | 10 ++++++++
>>   6 files changed, 54 insertions(+), 143 deletions(-)
>
> It is not particularly clear to me who is supposed to apply this series, but
> I can do that if people don't have problems with that.
>
>
I am fine by that given dependency with first patch.
Another way is, you pick up the first patch and give us an
immutable branch.

Either way is fine by me.


Regards,
Santosh
