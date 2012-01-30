From: Kevin Hilman <khilman@ti.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Mon, 30 Jan 2012 15:18:49 -0800
Message-ID: <87obtkpyna.fsf@ti.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52948 "HELO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752493Ab2A3XSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 18:18:52 -0500
Received: by mail-gy0-f173.google.com with SMTP id r20so1637013ghr.18
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 15:18:51 -0800 (PST)
In-Reply-To: <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	(Grazvydas Ignotas's message of "Tue, 31 Jan 2012 00:07:59 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Mon, Jan 30, 2012 at 9:36 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Grazvydas Ignotas <notasas@gmail.com> writes:
>>
>>> Hi,
>>>
>>> On 3.2 (I think some earlier versions too), with CONFIG_CPU_IDLE
>>> enabled GPIO based buttons are not working properly on OMAP3 pandora,
>>> button presses are almost never registered. The buttons are connected
>>> GPIO bank4 and have hardware debounce feature enabled.
>>>
>>> Doing either of the following solves (or hides) the problem:
>>> - disabling CPU_IDLE in kernel config
>>> - disabling debounce for the buttons
>>> - running a program spinning a loop on the CPU
>>>
>>> From what I can see in the code debounce clock is disabled when
>>> entering idle, can those GPIOs work without debounce clock?
>>
>> Yes, the clock is only for the debounce feature, but the GPIOs are
>> capable of wakeups and interrupts with the debounce clock disabled.
>
> Hmm but it doesn't work here (OMAP3530 ES2.1), /proc/interrupts
> doesn't increase when I hit buttons unless something else is happening
> at the same time. I wonder if I'm missing something here, does it all
> work for you with debounce on? 

Yes.  

Specifically, I tested on a n900 which has several GPIOs in the board
file (board-rx51.c) with debounce enabled.

When I push the button (or slide the switch in this case), I see
/proc/interrupts incrementing on an idle system with CPUidle enabled.

The same GPIOs can also bring the system out of suspend (debounce clocks
are disabled on suspend also.)

Kevin


