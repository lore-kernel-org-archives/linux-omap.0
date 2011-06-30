From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] arm: platsmp: Allow secondary cpu hotplug with	maxcpus=1
Date: Thu, 30 Jun 2011 09:36:20 -0700
Message-ID: <4E0CA604.5080802@codeaurora.org>
References: <1309372300-28911-1-git-send-email-sboyd@codeaurora.org> <20110630131154.GJ23312@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110630131154.GJ23312@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, David Brown <davidb@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-omap@vger.kernel.org

On 6/30/2011 6:11 AM, Russell King - ARM Linux wrote:
> On Wed, Jun 29, 2011 at 11:31:39AM -0700, Stephen Boyd wrote:
>>  void __init platform_smp_prepare_cpus(unsigned int max_cpus)
>>  {
>> -	int i;
>> -
>>  	/*
>>  	 * Initialise the present map, which describes the set of CPUs
>>  	 * actually populated at the present time.
>>  	 */
>> -	for (i = 0; i < max_cpus; i++)
>> -		set_cpu_present(i, true);
>> +	init_cpu_present(&cpu_possible_map);
> Ok, if we're now doing this in every platform, it might as well go into
> arch/arm/kernel/smp.c - platforms can re-initialize the present map
> in this callback if they need to do something different.

That sounds better. V2 coming soon.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
