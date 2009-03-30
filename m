From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Mon, 30 Mar 2009 10:57:54 -0700
Message-ID: <878wmm3nbx.fsf@deeprootsystems.com>
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
Received: from qw-out-2122.google.com ([74.125.92.26]:58299 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbZC3R57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 13:57:59 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2635414qwh.37
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2009 10:57:57 -0700 (PDT)
In-Reply-To: <f9d2a5e10903301044u775edfdo7ac540b3e1bdc597@mail.gmail.com> (Russ Dill's message of "Mon\, 30 Mar 2009 10\:44\:19 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russ Dill <russ.dill@gmail.com> writes:

> On Mon, Mar 30, 2009 at 3:08 AM, Premi, Sanjeev <premi@ti.com> wrote:
[...]

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

Peter,

Have you tried with the debug patch I sent?  If you can test with that
patch, and send the output, I can tell you what is preventing you from
hitting RET.

FWIW, the latest HEAD of the PM branch has that debug patch included.

After doing the suspend/resume, just

# cat /debug/pm_debug/registers/1

and attach the output.

Kevin

