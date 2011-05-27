From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 0/6 V3] Cleanups for cpufreq
Date: Fri, 27 May 2011 10:36:49 +0530
Message-ID: <4DDF3169.9070503@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <87ipsxcoz0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59956 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869Ab1E0FGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 01:06:55 -0400
Received: by ywg8 with SMTP id 8so655917ywg.6
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 22:06:54 -0700 (PDT)
In-Reply-To: <87ipsxcoz0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 5/26/2011 11:40 PM, Kevin Hilman wrote:
> So here's a dumb question, being rather ignorant of CPUfreq on SMP.
>
> Should we be running a CPUfreq instance on both CPUs when they cannot be
> scaled independently?
>
> What is being scaled here is actually the cluster (the MPU SS via
> dpll_mpu_ck), not an individual CPU.  So to me, it only makes sense to
> have a an instance of the driver per scalable device, which in this case
> is a single MPU SS.
>
We are running only one instance and for the exact same reason as above.
You are completely right and that's the whole intention of those
CPUMASK two lines in the initialization code.


> What am I missing?
>
Not at all.

Regards
Santosh
