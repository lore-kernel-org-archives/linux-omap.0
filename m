From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/8] OMAP3+: PM: VP: generalize PRM interrupt helpers
Date: Fri, 09 Sep 2011 11:41:11 -0700
Message-ID: <8762l1woc8.fsf@ti.com>
References: <1309393560-8874-1-git-send-email-mturquette@ti.com>
	<1309393560-8874-3-git-send-email-mturquette@ti.com>
	<CAORVsuXzyfWHNyM1u=bXwnhM=yLfF_Q2SS3wjv9n-13mvHcYgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:38720 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759438Ab1IISlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 14:41:22 -0400
Received: by gwb17 with SMTP id 17so1708048gwb.1
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 11:41:21 -0700 (PDT)
In-Reply-To: <CAORVsuXzyfWHNyM1u=bXwnhM=yLfF_Q2SS3wjv9n-13mvHcYgw@mail.gmail.com>
	(Jean Pihet's message of "Wed, 7 Sep 2011 21:27:07 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Mike Turquette <mturquette@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Mike, Kevin,
>
> On Thu, Jun 30, 2011 at 2:25 AM, Mike Turquette <mturquette@ti.com> wrote:
>> From: Nishanth Menon <nm@ti.com>
>>
>> We have multiple interrupt status hidden in the PRM interrupt status
>> reg. Make this handling generic to allow us to pull out LDO status such
>> as those for ABB from it using the same data structure and indexing. We
>> hence rename accordingly.
> I am not sure that the rename is needed.
>
> Kevin, Nishant, what is your opinion?

Rename is mostly fine.

I think the patch is correct, since the interrupts are technically for
the the whole PRM, not just the VP.

However, I don't like  the s/vp_id/irq_id/ in the APIs, because the APIs
are intended to be VP specific.

I'll likely pull/fold the parts I agree with into the original patch in
my VP cleanup series

Kevin

