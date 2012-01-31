From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Tue, 31 Jan 2012 02:56:57 +0200
Message-ID: <CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	<87obtkpyna.fsf@ti.com>
	<alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53614 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753107Ab2AaA47 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 19:56:59 -0500
Received: by lagu2 with SMTP id u2so2558137lag.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 16:56:57 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Tue, Jan 31, 2012 at 1:34 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 30 Jan 2012, Kevin Hilman wrote:
>
>> Grazvydas Ignotas <notasas@gmail.com> writes:
>>
>> > Hmm but it doesn't work here (OMAP3530 ES2.1), /proc/interrupts
>> > doesn't increase when I hit buttons unless something else is happe=
ning
>> > at the same time. I wonder if I'm missing something here, does it =
all
>> > work for you with debounce on?
>>
>> Yes.
>>
>> Specifically, I tested on a n900 which has several GPIOs in the boar=
d
>> file (board-rx51.c) with debounce enabled.

Thanks for testing. Which kernel was that on, and what .config?

>> When I push the button (or slide the switch in this case), I see
>> /proc/interrupts incrementing on an idle system with CPUidle enabled=
=2E
>>
>> The same GPIOs can also bring the system out of suspend (debounce cl=
ocks
>> are disabled on suspend also.)
>
> That's probably I/O ring/pad wakeups happening there, not GPIO wakeup=
s.
> Gra=C5=BEvydas, you are referring to the case where the CORE powerdom=
ain is on,
> but the GPIO IP block is idle?

I think so, it's just after boot with cpuidle enabled.
/debug/pm_debug/count seems to confirm it.

> Supposedly when the GPIO blocks enter idle with the debounce clock of=
f,
> they enter a state that basically links the input pad to the GPIO blo=
ck's
> SWAKEUP line. =C2=A0Pure combinational logic, no clocks. =C2=A0The TR=
M references,
> in the 34xx TRM Rev. ZT [SWPU223T], are Figure 25-7 "Asynchronous Pat=
h",
> Figure 25-9 "Wake-Up Request Generation", and Section 25.4.1.2
> "Asynchronous Path: Wake-Up Request Generation".

ok..

> So apparently, looking at these references, the following registers s=
hould
> be configured:
>
> 1. at least one of GPIO_LEVELDETECT{0,1} or GPIO_{RISING,FALLING}DETE=
CT
>
> 2. GPIO_WAKEUPENABLE
>
> 3. GPIO_IRQENABLE1

According to some /dev/mem hacking, all these have corresponding bits
set.. And as soon as I clear corresponding bit in GPIO_DEBOUNCENABLE
(using the same /dev/mem hacking method), it starts working. When it's
set, even GPIO_DATAIN
isn't updating in realtime.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
