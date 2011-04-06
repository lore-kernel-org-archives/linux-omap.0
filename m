From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Wed, 6 Apr 2011 15:31:59 +0800
Message-ID: <BANLkTimJJt7dhVBHp22t+QbmDp42hZL1bQ@mail.gmail.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
 <8ya39m2mv65.fsf@huya.qualcomm.com> <20110401074519.GC7594@elte.hu>
 <201104011554.07924.arnd@arndb.de> <BANLkTimkHZ01LfRoOha79QPyRaaDKo7T-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTimkHZ01LfRoOha79QPyRaaDKo7T-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@elte.hu>, david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 6, 2011 at 2:11 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2011/4/1 Arnd Bergmann <arnd@arndb.de>:
>> On Friday 01 April 2011, Ingo Molnar wrote:
>>> IMO the right answer is what Linus and Thomas outlined:
>>>
>>> =A0 =A01) provide a small number of clean examples and clean abstra=
ctions
>>> =A0 =A02) to not pull new crap from that point on
>>> =A0 =A03) do this gradually but consistently
>>>
>>> I.e. make all your requirements technical and actionable - avoid sw=
eeping,
>>> impossible to meet requirements. Do not require people to clean up =
all of the
>>> existing mess straight away (they cannot realistically do it), do n=
ot summarily
>>> block the flow of patches, but be firm about drawing a line in the =
sand and be
>>> firm about not introducing new mess in a gradually growing list of =
well-chosen
>>> areas of focus.
>>>
>>> Rinse, repeat.
>>
>> I believe getting to point 1 is the hard part here. There are a lot =
of things
>> that are wrong with the mach-* (and also plat-*) implementations, an=
d I don't
>> think we have one today that can really serve as an example. Most de=
cisions
>> made in there made a lot of sense when they were introduced, and dec=
laring
>> code that was perfectly acceptable yesterday to be unacceptable crap=
 today
>> is not going to be met with much understanding by the someone who ju=
st
>> wants to add support for one more board to 100 already existing ones=
 in the
>> same SoC family.
>>
>> I would actually suggest a different much more radical start: Fork t=
he way
>> that platforms are managed today, and start an alternative way of se=
tting
>> up boards and devices together with the proven ARM core kernel infra=
structure,
>> based on these observations (please correct me if some of them they =
don't make
>> sense):
>>
>> 1. The core arch code is not a problem (Russell does a great job her=
e)
>> 2. The platform specific code contains a lot of crap that doesn't be=
long there
>> =A0 (not enough reviewers to push back on crap)
>> 3. The amount of crap in platform specfic files is growing exponenti=
ally,
>> =A0 despite the best efforts of a handful of people to clean it up.
>> 4. Having one source file per board does not scale any more.
>> 5. Discoverable hardware would solve this, but is not going to happe=
n
>> =A0 in practice.
>> 6. Board firmware would not solve this and is usually not present.
>> 7. Boot loaders can not be trusted to pass valid information
>> 8. Device tree blobs can solve a lot of the problems, and nobody has
>> =A0 come up with a better solution.
>
> ARM BSP is still blasting! we are planning to merge our new ARM
> cortex-a9 SoC into kernel.

As far as I know, Barry is working on a new SoC family based on
Cortex-A9. He asked me/Eric personally before about this issue, it is
quite confused for new comers. On one hand, they wanna follow the
mainline style to join our upstream family, on the other hand if they
duplicate some crap from other SoC families, they will bring us
trouble or more crap.

> So I am just wondering whether traditional
> ARM BSP way can still be accepted, or we must move to use device tree=
?
> but i have't seen any arm device tree codes enter mainline yet. but w=
e
> can get those patches from linaro 2.6.38. So what's the plan for
> merging arm device tree?
>

I suggest you need a dedicated guy who will work on DT supporting for
your SoC. As I can tell from this thread, DT will be heavily supported
by other SoC soon.

> What i have seen is that the BSP architecture of different ARM SoC
> companies is even different.
>
> samsung has three levels:
> plat-samsung
> =A0 =A0 =A0 =A0 =A0 =A0plat-s3c24xx
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mach-s3c2410
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mach-s3c2440
> =A0 =A0 =A0 =A0 =A0 =A0plat-s5p
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mach-s5pv210
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mach-s5pv310
>
> TI has two levels:
> plat-omap
> =A0 =A0 =A0 =A0 =A0 =A0mach-omap1
> =A0 =A0 =A0 =A0 =A0 =A0mach-omap2
>
> Nvidia has one level:
> mach-tegra
>
> I didn't find any rule about what codes should be placed in what
> directories. Different companies have different ways. It looks like
> the only agreement is board files are in mach-xxx. Any suggestions fo=
r
> that?
>

That's totally frustrated for a new comer, I think. It's that possible
we do more unification firstly and then allow new comers to follow,
like:
plat-common (or just named 'plat')- common plat-common framework for
all ARM based SoC, which might contains IRQ framework, GPIO, Timer,
Clock, PWM or other common things
SoC players just need add one file to enable the platform common
things on their SoC such as plat-omap.c, plat-imx.c, plat-samsung.c
and etc.

mach-'soc' - for machine or board related code, such as mach-omap,
mach-imx .., or maybe we can also introduce mach-common to share other
machine or board layer common code. I guess it will be some machine
related API common functions.

It's just a simple idea, we still need lots of work to make that happen=
=2E

Thanks,
-Bryan

> BTW, we don't want to "dick around", which Linus has been very angry.
> we want to fix more issues this email pointed out before we send
> patches.
>
>> 9. All interesting work is going into a handful of platforms, all of=
 which
>> =A0 are ARMv7 based.
>> 10. We do not want to discontinue support for old boards that work f=
ine.
>> 11. Massive changes to existing platforms would cause massive breaka=
ge.
>> 12. Supporting many different boards with a single kernel binary is =
a
>> =A0 =A0useful goal.
>> 13. Infrastructure code should be cross-platform, not duplicated acr=
oss
>> =A0 =A0platforms.
>> 14. 32 bit ARM is hitting the wall in the next years (Cortex-A15 is
>> =A0 =A0actually adding PAE support, which has failed to solve this o=
n
>> =A0 =A0other architectures).
>> 15. We need to solve the platform problem before 64 bit support come=
s
>> =A0 =A0and adds another dimension to the complexity.
>>
>> Based on these assumptions, my preferred strategy would be to a new
>> mach-nocrap directory with a documented set of rules (to be adapted =
when
>> necessary):
>>
>> * Strictly no crap
>> =A0* No board files
>> =A0* No hardcoded memory maps
>> =A0* No lists of interrupts and GPIOs
>> * All infrastructure added must be portable to all ARMv7 based SoCs.
>> =A0(ARMv6 can be added later)
>> * 64 bit safe code only.
>> * SMP safe code only.
>> * All board specific information must come from a device tree and
>> =A0be run-time detected.
>> * Must use the same device drivers as existing platforms
>> * Should share platform drivers (interrupt controller, gpio, timer, =
=2E..)
>> =A0with existing platforms where appropriate.
>> * Code quality takes priority over stability in mach-nocrap, but mus=
t not
>> =A0break other platforms.
>>
>> Until we have something working there, I think we should still gener=
ally
>> allow new code to the existing platforms, and even new platforms to =
be
>> added, while trying to keep the quality as high as possible but with=
out
>> changing the rules for them or doing any major treewide reworks.
>>
>> Once the mach-nocrap approach has turned into something usable, we c=
an
>> proceed on three fronts:
>> 1. delete actively maintained boards from the other platforms once t=
hey
>> =A0 are no longer needed there
>> 2. generalize concepts from mach-nocrap by applying them to all boar=
ds,
>> =A0 similar to the cleanup work that people have always been doing.
>> 3. gradually make the rules for adding new code in other platforms s=
tricter,
>> =A0 up to the point where they are bugfix only.
>>
>>> If companies do not 'bother to push upstream', then management will=
 eventually
>>> notice negative economic consequences:
>>>
>>> ...
>>
>> Good points, I fully agree with these. I also think that the SoC com=
panies
>> are actually understanding this nowadays, and that is exactly the re=
ason
>> why we see so much code getting pushed in.
>>
>> =A0 =A0 =A0 =A0Arnd
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
