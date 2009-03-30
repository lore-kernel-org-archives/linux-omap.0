From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Mon, 30 Mar 2009 11:43:55 -0700
Message-ID: <873acu26ms.fsf@deeprootsystems.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
	<1237914611.23022.124.camel@blackhole>
	<87zlfaztcd.fsf@deeprootsystems.com>
	<1237925484.23022.133.camel@blackhole>
	<49C940CA.9070805@deeprootsystems.com>
	<f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
	<f9d2a5e10903301044u775edfdo7ac540b3e1bdc597@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:23475 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbZC3SoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 14:44:04 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2719896wff.4
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2009 11:44:03 -0700 (PDT)
In-Reply-To: <f9d2a5e10903301044u775edfdo7ac540b3e1bdc597@mail.gmail.com> (Russ Dill's message of "Mon\, 30 Mar 2009 10\:44\:19 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russ Dill <russ.dill@gmail.com> writes:

> On Mon, Mar 30, 2009 at 3:08 AM, Premi, Sanjeev <premi@ti.com> wrote:
[...]
>>
>> I had found that two drivers that could prevent clocks_off are
>> USB and DSS because of the way they use clk_enable().
>>
>> Can you try building without theses drivers just for verification?
>>
>
> Building without dss makes things worse:
>
> Powerdomain (dss_pwrdm) didn't enter target state 0
>
> Maybe by looking at what the dss driver is doing I can get core and
> per to turn off.

Russ,

Can you try with the latest HEAD of PM branch.  After suspend/resume,
do

# cat /debug/pm_debug/registers/1

and post results to list.  We can then see the exact state of PM
registers before going into WFI.

Also, post dump of

# cat /debug/pm_debug/count

Thanks,

Kevin



