From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/8] OMAP3+: PM: VP: generalize PRM interrupt helpers
Date: Fri, 09 Sep 2011 14:36:43 -0700
Message-ID: <87ipp1tn2s.fsf@ti.com>
References: <1309393560-8874-1-git-send-email-mturquette@ti.com>
	<1309393560-8874-3-git-send-email-mturquette@ti.com>
	<CAORVsuXzyfWHNyM1u=bXwnhM=yLfF_Q2SS3wjv9n-13mvHcYgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40546 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933939Ab1IIVgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 17:36:46 -0400
Received: by mail-pz0-f46.google.com with SMTP id 32so3405501pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 14:36:45 -0700 (PDT)
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

On second thought, I don't like the rename.

The goal of the VP stuff in prmXXXX.c is to provide high-level functions
for VP code where the register access stuff is contained in the PRM
layer (since all registers for VP are in the PRM.)

While it's currently only used for VP-related IRQs, this might be
extended for other VP register accesses, if there are register
differences between SoC revisions.

So, in the end, I agree w/Jean.  I don't think the rename is right.

I will however pick up the sparse warning fix, and fold it into the
original patch in my part A series where the problem was introduced:
OMAP2+: add PRM VP functions for checking/clearing VP TX done status

Thanks,

Kevin
