From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] ARM: ensure all sched_clock() implementations are notrace marked
Date: Thu, 16 Dec 2010 21:52:56 +0530
Message-ID: <AANLkTikLoU-L4YF_FtG4Q8Qh+66zToun5p2LhgYyiyrv@mail.gmail.com>
References: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk>
	<AANLkTimGHSqO=QwESp98UBK28yawdiq+kURU=nwau27G@mail.gmail.com>
	<20101216155750.GA28126@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:47239 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0LPQW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 11:22:57 -0500
In-Reply-To: <20101216155750.GA28126@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>, Lennert Buytenhek <kernel@wantstofly.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Thu, Dec 16, 2010 at 9:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 16, 2010 at 08:42:23PM +0530, Rabin Vincent wrote:
>> On Thu, Dec 16, 2010 at 1:48 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > ftrace requires sched_clock() to be notrace. =A0Ensure that all
>> > implementations are so marked.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> It does seem better to have all of them explicity annotated anyway, =
even
>> if it not required in most of the cases because they include
>> <linux/sched.h> and the annotation in the declaration takes effect.
>
> Firstly, we shouldn't be relying upon that, and secondly, everywhere =
which
> defines sched_clock() should already be including linux/sched.h to av=
oid
> the sparse error. =A0It sounds like there's also an exercise to make =
sure
> that is the case.

Yes.  I believe I identified all the ones which weren't including the
header in the last notrace series I sent out (versatile, plat-iop, omap=
,
and u300 IIRC), but there's been some changes in various platforms'
sched_clocks() and of course new platforms since then.

>
>> Note that in order for this to be fully effective, all functions cal=
led
>> from sched_clock() need to be notrace too. =A0OMAP and u300 miss thi=
s.
>
> Yes, OMAP still suffers from this.
>
> However, I assume you haven't looked at the u300 sched_clock conversi=
on
> patch which is part of a follow-on series on lakml? =A0It sorts u300 =
out
> in that regard.

Yes, I now see U300 no longer needs the notrace addition.  It still
could do with the #include <linux/sched.h> addition though, which was
also being done as part of that patch.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
