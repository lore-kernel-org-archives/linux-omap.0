From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 20:05:23 +0530
Message-ID: <4E04A0AB.40608@ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:47104 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754128Ab1FXOf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 10:35:27 -0400
Received: by mail-yx0-f169.google.com with SMTP id 22so1529556yxn.0
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 07:35:26 -0700 (PDT)
In-Reply-To: <1308923618-5333-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 6/24/2011 7:23 PM, Sanjeev Premi wrote:
> Currently, loops_per_jiffy is being calculated twice for
> non-SMP processors.
>   - Before calling cpufreq_notify_transition()
>   - From within cpufreq_notify_transition()
>
> Double adjustment leads to incorrect value being assigned to
> loops_per_jiffy. This manifests as incorrect BogoMIPS in
> "cat /proc/cpuinfo".
>
> The value of loops_per_jiffy needs to be calculated only
> when CONFIG_SMP is true. It is the core change included
> in this patch.
>
> The patch also leverages the definition of for_each_cpu()
> with and without CONFIG_SMP to consolidate the mechanism
> to call cpufreq_notify_transition().
>
> Signed-off-by: Sanjeev Premi<premi@ti.com>

NAK. This patch again doesn't make sense considering your issue.
Also jiffies should not be undated before changing the freq.
If the set_rate failed for some reason then you will have wrong
jiffies value.

I understand your issue now. The code for global lpj updation
should have been checking smp_on_up() instead of is_smp().
That one line change is enough. I will post a patch on
the same once I reach to office.

Regards
Santosh
