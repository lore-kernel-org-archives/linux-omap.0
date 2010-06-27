From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: pm_debug/voltage_off_while_idle has gone?
Date: Sun, 27 Jun 2010 08:21:30 +0300
Message-ID: <4C26DFDA.9050104@compulab.co.il>
References: <4C21FCF1.20600@compulab.co.il> <87d3vhwrp2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52567 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084Ab0F0FW4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Jun 2010 01:22:56 -0400
In-Reply-To: <87d3vhwrp2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

Kevin Hilman wrote:
> Mike Rapoport <mike@compulab.co.il> writes:
> 
>> There used to be 'voltage_off_while_idle' attribute in the PM-enabled
>> kernels that allowed to put PMIC into OFF mode.  In the current tip of
>> the linux-omap-pm tree this attribute seem to be gone Is there
>> possibility to make PMIC enter the OFF mode when suspending to RAM?
> 
> Hi Mike,
> 
> We are currently in the middle of a major rewrite of the SmartReflex and
> voltage layers of the PM branch.
> 
> The previous voltage-related work (like voltage_off_while_idle) are
> still available in the pm-vc branch of my tree, but are not currently
> merged with the new voltage work due to conflicts.
> 
> For this particular feature, I suspect you could just apply the first
> patch in my pm-vc branch to add back this feature.
> 
> Let me know if that works,

I've cherry-picked two commits from your pm-vc and it failed to compile :)
After fixing it, I did several small tests, but is seems that PMIC does not 
execute the power scripts... I'll continue to work on it.

> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
