From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Regression with suspicious RCU usage splats with cpu_pm change
Date: Thu, 13 Jul 2017 13:50:26 +0200
Message-ID: <CAJZ5v0j15uWyCRAPep4KwqSiC4UD4ZppAG++SUvN3Ok1wzDwNQ@mail.gmail.com>
References: <20170713070749.GE16509@atomide.com> <c00272dc-cf84-81a2-b2e2-d52cadf7bcc6@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c00272dc-cf84-81a2-b2e2-d52cadf7bcc6@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 13, 2017 at 11:43 AM, Alex Shi <alex.shi@linaro.org> wrote:
>
> On 07/13/2017 03:07 PM, Tony Lindgren wrote:
>> Hi,
>>
>> Looks like next-20170713 gives me a bunch of "suspicious RCU usage"
>> splats with cpuidle_coupled on duovero, see below. I bisected it down
>> to commit 2f027e003d05 ("cpu_pm: replace raw_notifier with
>> atomic_notifier").

OK, so I'm dropping this commit.

Thanks,
Rafael
