From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to include interconnect barriers.
Date: Thu, 15 Sep 2011 10:17:31 -0700
Message-ID: <87obyl7mj8.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
	<20110913202701.GF24252@atomide.com> <4E7080F8.9020302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36785 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756445Ab1IORRk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 13:17:40 -0400
Received: by yie13 with SMTP id 13so4254945yie.25
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 10:17:39 -0700 (PDT)
In-Reply-To: <4E7080F8.9020302@ti.com> (Santosh's message of "Wed, 14 Sep 2011
	15:54:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, Richard Woodruff <r-woodruff2@ti.com>

Santosh <santosh.shilimkar@ti.com> writes:

> On Wednesday 14 September 2011 01:57 AM, Tony Lindgren wrote:
>> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [110904 06:22]:
>>> On OMAP4 SOC intecronnects has many write buffers in the async bridges
>>> and they can be drained only with stongly ordered accesses.
>>
>> This is not correct, strongly ordered access does not guarantee
>> anything here. If it fixes issues, it's because it makes the writes
>> to reach the device faster. Strongly ordered does not affect anything
>> outside ARM, so the bus access won't change.
>>
> What I said is the aync bridges WB and what is said is correct
> from MPU accesses point of view.
>
> It's not about faster or slower. With device memory the, writes
> can get stuck into write buffers where as with SO, the write buffers
> will be bypassed.
>
> The behaviours is limited to the MPU side async bridge boundary which
> is the problem. The statement is not for l3 and l4 interconnect which
> probably you mean.
>
> There is always a hardware signal to communicate CPU at async bridges
> to ensure that data is not stuck in these bridges before CPU
> clock/voltage is cut. Unfortunately we have a BUG on OMAP44XX devices
> and the dual channel makes it even worst since both pipes have the
> same BUG. So what we are doing is issuing SO write/read accesses
> on these pipes so that there is nothing stuck there before MPU
> hits low power states and also avoids any race conditions when
> both channels are used together by some initiators. The behaviour
> is validated at RTL level and there is no ambiguity about it.
>
> May be you have mistaken the L3 and L4 as the interconnect levels
> in this case.

Sounds to me like the changelog needs to be a bit more verbose.

Remember, we're all probably going to forget the gory details of this in
a few months and want to be able to go back to the code w/changelog to
refresh our memories.

Thanks,

Kevin
