From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Sat, 5 May 2012 00:17:03 +0300
Message-ID: <CANOLnOML0GkvTYabdoMXC-Z=rENp=W_zEP0BS=emxqyRGZj8UA@mail.gmail.com>
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
	<alpine.DEB.2.00.1202011138400.10541@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59245 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab2EDVRF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 17:17:05 -0400
Received: by yenm10 with SMTP id m10so2721226yen.19
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 14:17:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1202011138400.10541@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Wed, Feb 1, 2012 at 8:41 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 1 Feb 2012, Grazvydas Ignotas wrote:
>
>> On Wed, Feb 1, 2012 at 8:06 AM, Paul Walmsley <paul@pwsan.com> wrote=
:
>> > On Tue, 31 Jan 2012, Paul Walmsley wrote:
>> >
>> >> Well, whether it's in or out of idle, I'll bet the DEBOUNCENABLE
>> >> bits are still set to 1 while the debounce clock is off :-(
>> >
>> > Along these lines, you might try patching omap2_gpio_prepare_for_i=
dle() to
>> > turn off the DEBOUNCENABLE bits?
>>
>> Yes that helps. I guess I'll carry this in pandora tree, at least
>> we'll have debounce while more demanding programs/games are running.
>
> Yep definitely. =C2=A0When only I/O wakeups can occur on those GPIO l=
ines (when
> CORE/PER is in a low-power state), they are intrinsically debounced :=
-)
> So it should be fine. =C2=A0You are re-enabling the DEBOUNCENABLE bit=
s in
> omap2_gpio_resume_after_idle() I assume? =C2=A0If so, that should be =
a good
> workaround for mainline too.

To follow up on this, it appears clearing DEBOUNCENABLE in
omap2_gpio_prepare_for_idle (or omap_gpio_runtime_suspend in 3.4) and
reenabling on resume causes some sort of irq storm, I get ~50 irqs on
key press/release for given GPIO, which causes CPU usage spikes, but
no duplicate input events, curiously. Obviously this is not good for
UIs and games, so I have nothing left but to disable hardware debounce
now :(



--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
