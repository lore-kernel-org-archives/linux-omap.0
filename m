From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 1 Apr 2011 22:51:19 +0100
Message-ID: <AANLkTin46Hu7BRNrTYYxHwaE10emUM7VNPWwg9w4r9n6@mail.gmail.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104011659.40443.arnd@arndb.de>
	<87vcyxllub.fsf@ti.com>
	<201104012332.24319.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201104012332.24319.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, "david@lang.hm" <david@lang.hm>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Brown <davidb@codeaurora.org>, Detlef Vollmann <dv@vollmann.ch>
List-Id: linux-omap@vger.kernel.org

On Friday, 1 April 2011, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 01 April 2011 23:10:04 Kevin Hilman wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>> > On Friday 01 April 2011, Detlef Vollmann wrote:
>> >> On 04/01/11 15:54, Arnd Bergmann wrote:
>> >
>> >> > 9. All interesting work is going into a handful of platforms, a=
ll of which
>> >> > =C2=A0 =C2=A0 are ARMv7 based.
>> >> Define interesting.
>> >
>> > The ones that are causing the churn that we're talking about.
>> > Platforms that have been working forever and only need to get
>> > the occasional bug fix are boring, i.e. not the problem.
>>
>> I'm not sure I follow the ARMv7-only thinking either.
>>
>> Picking ARMv7 only would be a good way to avoid part of the problem,=
 but
>> IMO, it doesn't really address the root causes. =C2=A0Part of the ug=
liness of
>> the platform-specific hackery (and the "churn" to clean some of it u=
p)
>> is precisely due to support for multiple ARM architecture versions, =
and
>> the various SoCs in a family that use them. =C2=A0For example, linux=
-omap
>> supports OMAP1 (ARMv5), OMAP2 (ARMv6), OMAP3 (ARMv7) and OMAP4 (ARMv=
7
>> SMP), and OMAP2/3/4 in a single binary.
>>
>> Also, since we've only very recently got to the point of being able =
to
>> support ARMv6 + ARMv7 UP & SMP in the same kernel, making a decision=
 now
>> that only ARMv7 is important seems like a step backwards. =C2=A0If t=
he
>> ultimate goal is getting to a point where we have infrastrucure that=
 can
>> be cross-SoC, surely this same infrastrucure should support multiple=
 ARM
>> architecture revisions.
>
> Yes, forget about the ARMv7 part of my proposal, that was not a main =
point.
>
> If we decide to have a new clean platform variant the way I suggested=
,
> it would be nice to support all machines in a single kernel binary,
> and at least v6+v7 is a solved problem.
>
> Supporting a second kernel binary up to v5 with the same source is al=
so
> simple, as would be big-endian/little-endian variants, or thumb2/arm =
variants.
> We might not want to do all combinations from the start though, and I=
 would
> choose ARMv6/v7-thumb2-le simply because that's what Linaro is focusi=
ng
> on. The idea is to start with a clearly defined set, but write the co=
de
> in a way that makes it possible to extend in other directions.

Thumb-2 is ARMv7 only. If you want a v6+v7 binary it would need to be
compiled to ARM.


--=20
Catalin
