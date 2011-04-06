From: Barry Song <21cnbao@gmail.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Tue, 5 Apr 2011 23:11:15 -0700
Message-ID: <BANLkTimkHZ01LfRoOha79QPyRaaDKo7T-Q@mail.gmail.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
 <8ya39m2mv65.fsf@huya.qualcomm.com> <20110401074519.GC7594@elte.hu> <201104011554.07924.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54353 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1DFGLh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 02:11:37 -0400
In-Reply-To: <201104011554.07924.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@elte.hu>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org

2011/4/1 Arnd Bergmann <arnd@arndb.de>:
> On Friday 01 April 2011, Ingo Molnar wrote:
>> IMO the right answer is what Linus and Thomas outlined:
>>
>> =C2=A0 =C2=A01) provide a small number of clean examples and clean a=
bstractions
>> =C2=A0 =C2=A02) to not pull new crap from that point on
>> =C2=A0 =C2=A03) do this gradually but consistently
>>
>> I.e. make all your requirements technical and actionable - avoid swe=
eping,
>> impossible to meet requirements. Do not require people to clean up a=
ll of the
>> existing mess straight away (they cannot realistically do it), do no=
t summarily
>> block the flow of patches, but be firm about drawing a line in the s=
and and be
>> firm about not introducing new mess in a gradually growing list of w=
ell-chosen
>> areas of focus.
>>
>> Rinse, repeat.
>
> I believe getting to point 1 is the hard part here. There are a lot o=
f things
> that are wrong with the mach-* (and also plat-*) implementations, and=
 I don't
> think we have one today that can really serve as an example. Most dec=
isions
> made in there made a lot of sense when they were introduced, and decl=
aring
> code that was perfectly acceptable yesterday to be unacceptable crap =
today
> is not going to be met with much understanding by the someone who jus=
t
> wants to add support for one more board to 100 already existing ones =
in the
> same SoC family.
>
> I would actually suggest a different much more radical start: Fork th=
e way
> that platforms are managed today, and start an alternative way of set=
ting
> up boards and devices together with the proven ARM core kernel infras=
tructure,
> based on these observations (please correct me if some of them they d=
on't make
> sense):
>
> 1. The core arch code is not a problem (Russell does a great job here=
)
> 2. The platform specific code contains a lot of crap that doesn't bel=
ong there
> =C2=A0 (not enough reviewers to push back on crap)
> 3. The amount of crap in platform specfic files is growing exponentia=
lly,
> =C2=A0 despite the best efforts of a handful of people to clean it up=
=2E
> 4. Having one source file per board does not scale any more.
> 5. Discoverable hardware would solve this, but is not going to happen
> =C2=A0 in practice.
> 6. Board firmware would not solve this and is usually not present.
> 7. Boot loaders can not be trusted to pass valid information
> 8. Device tree blobs can solve a lot of the problems, and nobody has
> =C2=A0 come up with a better solution.

ARM BSP is still blasting! we are planning to merge our new ARM
cortex-a9 SoC into kernel. So I am just wondering whether traditional
ARM BSP way can still be accepted, or we must move to use device tree?
but i have't seen any arm device tree codes enter mainline yet. but we
can get those patches from linaro 2.6.38. So what's the plan for
merging arm device tree?

What i have seen is that the BSP architecture of different ARM SoC
companies is even different.

samsung has three levels:
plat-samsung
            plat-s3c24xx
                     mach-s3c2410
                     mach-s3c2440
            plat-s5p
                     mach-s5pv210
                     mach-s5pv310

TI has two levels:
plat-omap
            mach-omap1
            mach-omap2

Nvidia has one level:
mach-tegra

I didn't find any rule about what codes should be placed in what
directories. Different companies have different ways. It looks like
the only agreement is board files are in mach-xxx. Any suggestions for
that?

BTW, we don't want to "dick around", which Linus has been very angry.
we want to fix more issues this email pointed out before we send
patches.

> 9. All interesting work is going into a handful of platforms, all of =
which
> =C2=A0 are ARMv7 based.
> 10. We do not want to discontinue support for old boards that work fi=
ne.
> 11. Massive changes to existing platforms would cause massive breakag=
e.
> 12. Supporting many different boards with a single kernel binary is a
> =C2=A0 =C2=A0useful goal.
> 13. Infrastructure code should be cross-platform, not duplicated acro=
ss
> =C2=A0 =C2=A0platforms.
> 14. 32 bit ARM is hitting the wall in the next years (Cortex-A15 is
> =C2=A0 =C2=A0actually adding PAE support, which has failed to solve t=
his on
> =C2=A0 =C2=A0other architectures).
> 15. We need to solve the platform problem before 64 bit support comes
> =C2=A0 =C2=A0and adds another dimension to the complexity.
>
> Based on these assumptions, my preferred strategy would be to a new
> mach-nocrap directory with a documented set of rules (to be adapted w=
hen
> necessary):
>
> * Strictly no crap
> =C2=A0* No board files
> =C2=A0* No hardcoded memory maps
> =C2=A0* No lists of interrupts and GPIOs
> * All infrastructure added must be portable to all ARMv7 based SoCs.
> =C2=A0(ARMv6 can be added later)
> * 64 bit safe code only.
> * SMP safe code only.
> * All board specific information must come from a device tree and
> =C2=A0be run-time detected.
> * Must use the same device drivers as existing platforms
> * Should share platform drivers (interrupt controller, gpio, timer, .=
=2E.)
> =C2=A0with existing platforms where appropriate.
> * Code quality takes priority over stability in mach-nocrap, but must=
 not
> =C2=A0break other platforms.
>
> Until we have something working there, I think we should still genera=
lly
> allow new code to the existing platforms, and even new platforms to b=
e
> added, while trying to keep the quality as high as possible but witho=
ut
> changing the rules for them or doing any major treewide reworks.
>
> Once the mach-nocrap approach has turned into something usable, we ca=
n
> proceed on three fronts:
> 1. delete actively maintained boards from the other platforms once th=
ey
> =C2=A0 are no longer needed there
> 2. generalize concepts from mach-nocrap by applying them to all board=
s,
> =C2=A0 similar to the cleanup work that people have always been doing=
=2E
> 3. gradually make the rules for adding new code in other platforms st=
ricter,
> =C2=A0 up to the point where they are bugfix only.
>
>> If companies do not 'bother to push upstream', then management will =
eventually
>> notice negative economic consequences:
>>
>> ...
>
> Good points, I fully agree with these. I also think that the SoC comp=
anies
> are actually understanding this nowadays, and that is exactly the rea=
son
> why we see so much code getting pushed in.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
