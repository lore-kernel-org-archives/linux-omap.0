From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Tue, 01 Jul 2014 14:40:17 -0700
Message-ID: <20140701214017.32686.37324@quantum>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com>
 <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com>
 <20140515060834.3084.5199@quantum> <5374B241.9010201@ti.com>
 <20140531000207.10062.55946@quantum>
 <alpine.DEB.2.02.1406031907210.14238@utopia.booyaka.com>
 <538EBBF1.7040804@ti.com>
 <alpine.DEB.2.02.1406131924571.340@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59040 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaGAVkb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 17:40:31 -0400
Received: by mail-pd0-f173.google.com with SMTP id r10so10756429pdi.32
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2014 14:40:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1406131924571.340@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org

Quoting Paul Walmsley (2014-06-13 12:53:06)
> Furthermore, as a general interface principle, allowing clk_set_rate() to 
> silently round rates could lead to unexpected behavior, since the set of 
> rates that clk_set_rate() can round to may change between the call to 
> clk_round_rate() and the call to clk_set_rate().

Rounding the rate will always happen in a call to clk_set_rate. We need
to know what rate that clock node can actually support. The real
question is what do we do with that rounded rate. There are two options:

1) abort and return an error code if the rounded rate does not exactly
match the requested rate

2) use the rounded rate even if it does not match the requested rate

#2 has some variations worth considering:

a) allow a rounded rate within a specified tolerance (e.g. 10% of the
requested rate)
b) allow a rounded rate so long as it is rounded down from the requested
rate
c) same as #b, but rounded up, etc.

> 
> So again I think that the right way to deal with this is to:
> 
> 1. avoid silently rounding rates in clk_set_rate() and to return an error 
> if calling clk_set_rate() would result in a rate other than the one 
> desired; and to

Let's get consensus on my above question before we solidify the API.
It's worth noting that the current behavior of rounding the rate within
clk_set_rate is actually what Russell had in mind back in 2010. See this
thread[1] for details.

Also note that this opens up a can of worms regarding *intended rates*.
For example, if you always abort clk_set_rate if the rounded rate does
not match the requested rate, then what does that mean for a child clock
that will be changed by some parent clock higher up the tree? If that
child gets put to a rate that would never be returned by clk_round_rate
then is the framework responsible for walking down the tree, checking
every child and aborting when the first one is off by a few hertz?
That's going to be messy.

> 
> 2. modify clk_round_rate() such that it returns the closest 
> lowest-or-equal rate match to the target rate requested.

I agree that the behavior of clk_round_rate needs to be defined once and
for all. I also think that clk_round_ceil, clk_round_floor and
clk_round_exact aren't terrible ideas either.

I'll kick off a thread on this topic shortly, and we can hopefully gain
some consensus.

Regards,
Mike

[1] https://lkml.org/lkml/2010/7/14/330

> 
> 
> - Paul
