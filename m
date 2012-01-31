From: Kevin Hilman <khilman@ti.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Mon, 30 Jan 2012 16:22:02 -0800
Message-ID: <871uqgpvpx.fsf@ti.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	<87obtkpyna.fsf@ti.com>
	<alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:58830 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753120Ab2AaAWG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 19:22:06 -0500
Received: by mail-gx0-f182.google.com with SMTP id k5so19901ggn.27
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 16:22:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com> (Paul
	Walmsley's message of "Mon, 30 Jan 2012 16:34:12 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Mon, 30 Jan 2012, Kevin Hilman wrote:
>
>> Grazvydas Ignotas <notasas@gmail.com> writes:
>>=20
>> > On Mon, Jan 30, 2012 at 9:36 PM, Kevin Hilman <khilman@ti.com> wro=
te:
>> >> Grazvydas Ignotas <notasas@gmail.com> writes:
>> >>
>> >>> On 3.2 (I think some earlier versions too), with CONFIG_CPU_IDLE
>> >>> enabled GPIO based buttons are not working properly on OMAP3 pan=
dora,
>> >>> button presses are almost never registered. The buttons are conn=
ected
>> >>> GPIO bank4 and have hardware debounce feature enabled.
>> >>>
>> >>> Doing either of the following solves (or hides) the problem:
>> >>> - disabling CPU_IDLE in kernel config
>> >>> - disabling debounce for the buttons
>> >>> - running a program spinning a loop on the CPU
>> >>>
>> >>> From what I can see in the code debounce clock is disabled when
>> >>> entering idle, can those GPIOs work without debounce clock?
>> >>
>> >> Yes, the clock is only for the debounce feature, but the GPIOs ar=
e
>> >> capable of wakeups and interrupts with the debounce clock disable=
d.
>> >
>> > Hmm but it doesn't work here (OMAP3530 ES2.1), /proc/interrupts
>> > doesn't increase when I hit buttons unless something else is happe=
ning
>> > at the same time. I wonder if I'm missing something here, does it =
all
>> > work for you with debounce on?=20
>>=20
>> Yes. =20
>>=20
>> Specifically, I tested on a n900 which has several GPIOs in the boar=
d
>> file (board-rx51.c) with debounce enabled.
>>=20
>> When I push the button (or slide the switch in this case), I see
>> /proc/interrupts incrementing on an idle system with CPUidle enabled=
=2E
>>=20
>> The same GPIOs can also bring the system out of suspend (debounce cl=
ocks
>> are disabled on suspend also.)
>
> That's probably I/O ring/pad wakeups happening there, not GPIO wakeup=
s. =20
> Gra=C5=BEvydas, you are referring to the case where the CORE powerdom=
ain is on,=20
> but the GPIO IP block is idle?

Right good point.

If CORE is powerdomain is staying on, you might also have a look at the
"GPIO module-level wakeups not always working" item in the "Known
problems" section of the OMAP PM wiki:

          http://elinux.org/OMAP_Power_Management#Known_Problems

It might be the case that haven't done a request_irq() +
enable_irq_wake() for those GPIOs.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
