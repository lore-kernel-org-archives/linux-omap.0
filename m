From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to
 include interconnect barriers.
Date: Thu, 15 Sep 2011 23:52:21 +0530
Message-ID: <CAMQu2gzfU0K0Q1Pta4vX=dNBBYQ6wNg_Kf5EeMTCV_WHTs3Y=w@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
 <20110913202701.GF24252@atomide.com> <4E7080F8.9020302@ti.com>
 <87obyl7mj8.fsf@ti.com> <CAMQu2gy6yVA7zWAPUsnzCtixHkjzkn6UnbapR0mpoJ+AwNMAcQ@mail.gmail.com>
 <20110915175354.GW24252@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:36559 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934271Ab1IOSWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 14:22:42 -0400
Received: by mail-yx0-f171.google.com with SMTP id 3so3363748yxt.30
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 11:22:41 -0700 (PDT)
In-Reply-To: <20110915175354.GW24252@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, Richard Woodruff <r-woodruff2@ti.com>

On Thu, Sep 15, 2011 at 11:23 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [110915 09:51]:
>> On Thu, Sep 15, 2011 at 10:47 PM, Kevin Hilman <khilman@ti.com> wrot=
e:
>> > Santosh <santosh.shilimkar@ti.com> writes:
>> >
>> >> On Wednesday 14 September 2011 01:57 AM, Tony Lindgren wrote:
>> >>> * Santosh Shilimkar<santosh.shilimkar@ti.com> =A0[110904 06:22]:
>> >>>> On OMAP4 SOC intecronnects has many write buffers in the async =
bridges
>> >>>> and they can be drained only with stongly ordered accesses.
>> >>>
>> >>> This is not correct, strongly ordered access does not guarantee
>> >>> anything here. If it fixes issues, it's because it makes the wri=
tes
>> >>> to reach the device faster. Strongly ordered does not affect any=
thing
>> >>> outside ARM, so the bus access won't change.
>> >>>
>> >> What I said is the aync bridges WB and what is said is correct
>> >> from MPU accesses point of view.
>> >>
>> >> It's not about faster or slower. With device memory the, writes
>> >> can get stuck into write buffers where as with SO, the write buff=
ers
>> >> will be bypassed.
>> >>
>> >> The behaviours is limited to the MPU side async bridge boundary w=
hich
>> >> is the problem. The statement is not for l3 and l4 interconnect w=
hich
>> >> probably you mean.
>> >>
>> >> There is always a hardware signal to communicate CPU at async bri=
dges
>> >> to ensure that data is not stuck in these bridges before CPU
>> >> clock/voltage is cut. Unfortunately we have a BUG on OMAP44XX dev=
ices
>> >> and the dual channel makes it even worst since both pipes have th=
e
>> >> same BUG. So what we are doing is issuing SO write/read accesses
>> >> on these pipes so that there is nothing stuck there before MPU
>> >> hits low power states and also avoids any race conditions when
>> >> both channels are used together by some initiators. The behaviour
>> >> is validated at RTL level and there is no ambiguity about it.
>> >>
>> >> May be you have mistaken the L3 and L4 as the interconnect levels
>> >> in this case.
>> >
>> > Sounds to me like the changelog needs to be a bit more verbose.
>> >
>> > Remember, we're all probably going to forget the gory details of t=
his in
>> > a few months and want to be able to go back to the code w/changelo=
g to
>> > refresh our memories.
>> >
>> Change log was accurate but I agree it needs more description to mak=
e it
>> clear. I plan to update it.
>
> Please also include the errata in the description and set it up with
> a Kconfig entry with something like ARM_ERRATA_XXXXXX or TI_ERRATA_XX=
XXXX.
>
Sure.
It's a  TI ERRATA.

> Also it would be best to apply this fix at the end of the PM series s=
o
> it is easier to verify the bug and potentially remove the hack if
> a better fix is ever available.
>
As such order doesn't matter much because it can be removed either way
even if it is in the beginning of the series with KCONFIG entry.

But I can change the order if you prefer that way.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
