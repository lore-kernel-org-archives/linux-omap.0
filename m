From: Kevin Hilman <khilman@ti.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Wed, 01 Feb 2012 07:30:49 -0800
Message-ID: <87wr86fu52.fsf@ti.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	<87obtkpyna.fsf@ti.com>
	<alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
	<CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
	<alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com>
	<CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
	<CANOLnOMzkNSr5hFbASCWaT6PkBSYQhqMxXmjBfU0tm0GTv=yYA@mail.gmail.com>
	<alpine.DEB.2.00.1201312254150.10061@utopia.booyaka.com>
	<alpine.DEB.2.00.1201312305190.10061@utopia.booyaka.com>
	<CANOLnOMmcztNH+fUzrQxjK5nVVEaAtLi=7ww+dPm0AXEv09qUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55272 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754627Ab2BAPau (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 10:30:50 -0500
Received: by pbds6 with SMTP id s6so1343876pbd.2
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 07:30:47 -0800 (PST)
In-Reply-To: <CANOLnOMmcztNH+fUzrQxjK5nVVEaAtLi=7ww+dPm0AXEv09qUA@mail.gmail.com>
	(Grazvydas Ignotas's message of "Wed, 1 Feb 2012 13:46:46 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Wed, Feb 1, 2012 at 8:06 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> On Tue, 31 Jan 2012, Paul Walmsley wrote:
>>
>>> Well, whether it's in or out of idle, I'll bet the DEBOUNCENABLE
>>> bits are still set to 1 while the debounce clock is off :-(
>>
>> Along these lines, you might try patching omap2_gpio_prepare_for_idle() to
>> turn off the DEBOUNCENABLE bits?
>
> Yes that helps. I guess I'll carry this in pandora tree, at least
> we'll have debounce while more demanding programs/games are running.

Care to share the patch?  It might be worth merging until we have a full
solution.

> Don't know how it's all working for Kevin though..

Now I'm not so sure either...

At first I thought it was because I was getting IO ring wakeups, but
using vanilla 3.2, MPU, CORE & PER are staying on due to the (broken)
UART constraint, so I'm getting module-level wakeups, but haven't dug
into why.

Kevin





