From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/10] cpufreq: OMAP: cleanup for multi-SoC support,move into drivers/cpufreq
Date: Fri, 23 Sep 2011 07:02:17 -0700
Message-ID: <87d3erl5li.fsf@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
	<1316725648-26710-2-git-send-email-khilman@ti.com>
	<9bc8649a2e151bec117424b678bb09f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53131 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753633Ab1IWOCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 10:02:23 -0400
In-Reply-To: <9bc8649a2e151bec117424b678bb09f8@mail.gmail.com> (Vishwanath
	Sripathy's message of "Fri, 23 Sep 2011 14:51:51 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

[...]

>> +#ifdef CONFIG_CPU_FREQ_DEBUG
>> +	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old,
>> freqs.new);
>> +#endif
>> +
>> +	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>
> Do you plan to post follow up patches to scale voltage along with Clock?

Yes.

This series is just a move of existing code + minor cleanups.

The next step is to finalize/merge Tero's regulator driver and use
that to scale voltage along with frequency here.

Now that the voltage domain cleanups are merged, I hope to have
regulator series + voltage scaling changes in this driver ready next week.

Kevin
