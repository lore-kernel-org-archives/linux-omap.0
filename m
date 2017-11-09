From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] Kernel debugging: omap: print warning if CONFIG_DEBUG_LL is enabled
Date: Thu, 9 Nov 2017 19:12:54 +0100
Message-ID: <ECA76857-CF1A-4419-9301-1F3AB4730FA5@goldelico.com>
References: <b80b85cd6f26d02d698463b3dd5e9783081aa780.1510176592.git.hns@goldelico.com> <20171108222755.GW28152@atomide.com> <20171108223604.GG28231@n2100.armlinux.org.uk> <20171108223810.GH28231@n2100.armlinux.org.uk> <E542DC13-D6C4-4C84-8521-8CE468BD0AFE@goldelico.com> <20171109165840.GI28231@n2100.armlinux.org.uk> <450E9318-EB71-4635-A137-82DF78206D24@goldelico.com> <20171109173533.GJ28231@n2100.armlinux.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109173533.GJ28231@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Russell,

> Am 09.11.2017 um 18:35 schrieb Russell King - ARM Linux =
<linux@armlinux.org.uk>:
>=20
> Hi Nikkylos,
>=20
> On Thu, Nov 09, 2017 at 06:16:29PM +0100, H. Nikolaus Schaller wrote:
>> Hi Russel,
>>=20
>>> Am 09.11.2017 um 17:58 schrieb Russell King - ARM Linux =
<linux@armlinux.org.uk>:
>>>=20
>>> On Thu, Nov 09, 2017 at 06:44:49AM +0100, H. Nikolaus Schaller =
wrote:
>>>> Hi Russel,
>>>=20
>>> Nikolus,
>>>=20
>>>>> Am 08.11.2017 um 23:38 schrieb Russell King - ARM Linux =
<linux@armlinux.org.uk>:
>>>>>=20
>>>>> On Wed, Nov 08, 2017 at 10:36:04PM +0000, Russell King - ARM Linux =
wrote:
>>>>>> We don't need a compiler warning there, we probably need better =
help
>>>>>> text against DEBUG_LL and against EARLY_PRINTK.
>>>>>=20
>>>>> Actually, this is already clearly stated against DEBUG_LL:
>>>>>=20
>>>>>        Note that selecting this option will limit the kernel to a =
single
>>>>>        UART definition, as specified below. Attempting to boot the =
kernel
>>>>>        image on a different platform *will not work*, so this =
option should
>>>>>        not be enabled for kernels that are intended to be =
portable.
>>>>>=20
>>>>> and since EARLY_PRINTK depends on DEBUG_LL... I guess people don't
>>>>> read help texts anymore.
>>>>=20
>>>> Yes, we read, but we face a situation where it doesn't help that it =
is a
>>>> well known problem *for you* or anyone else and that it is =
described in
>>>> the help.
>>>=20
>>> Personally, I'd like early_printk not to be re-using this, but =
others
>>> disagree.  It's all about knowledge and compromise.
>>=20
>> Sure, we have to make a lot of compromises...
>>=20
>>>=20
>>> What we don't want is more warnings in the kernel - it's already
>>> hard enough for people to spot the "bad" warnings that they need to
>>> fix to have a working system (such as wrong printf specifiers) that
>>> (a) they're not going to spot this #warning and (b) it's just going
>>> to be more noise for those who do try to spot the warnings.
>>=20
>>>=20
>>>> Do you expect anybody to remember after 3 years of *not* changing =
DEBUG_LL
>>>> what was written in a help message? Or to understand that DEBUG_LL =
has
>>>> anything to do with the mysteriously appearing boot problem? Which =
can't
>>>> easily be debugged since there are no messages despite playing with
>>>> EARLY_PRINTK/EARLYCON?
>>>=20
>>> Do you expect people to read the build log of their kernel and spot
>>> the additional warning?
>>=20
>> I am doing it and I rarely see warnings by the compiler. Maybe =
sometimes
>> during the -rc phase but not in stable.
>=20
> The warnings you see are compiler specific, and I hardly ever see =
builds
> that are fully clean.

I can just contribute my experience that mine are usually.

>=20
>>> You might be on the ball enough to do that,
>>> but not everyone does, or is.  Not everyone logs the output of the
>>> kernel build so they can review it later.  I suspect that many just
>>> set the build going in a terminal, walk away and come back sometime
>>> later when they think it's done.
>>=20
>> In this case they would have a good trigger and reason to look into =
the
>> build log: the kernel they just built isn't booting and doesn't tell
>> anything. Then I guess for many of us the next logical step would be =
to
>> look trough the build log (but not through a defconfig that wasn't =
touched
>> for ages).
>>=20
>> Well, I have to admit that if someone doesn't try a clean build, it
>> will not see it again if the initial log wasn't captured somewhere...
>>=20
>> So it should more be an #error than a #warning. Then people must =
notice.
>> But I don't know if there are situations where this would be too =
strict.
>=20
> There are - it's perfectly valid to have your kernel, but with =
DEBUG_LL
> enabled and configured correctly so it outputs to a real UART on your
> platform.  As I've explained already, DEBUG_LL exists as a way of last
> resort to solve the "it doesn't boot" problem, because it gives a
> way for the early assembler to be instrumented and debugged before
> anything else is up, through the kernel boot sequence and into the C
> code.

Indeed - except that DEBUG_LL can be the reason for the "it doesn't =
boot"
which I assume nobody expects. t would be like placing a voltmeter =
somewhere
and you have power outage.

>=20
> That is its primary purpose.  Adding a #error or #warning is going to
> turn people who most need the infrastructure to solve the "it silently
> doesn't boot" away.

This confirms my assumption that a #warning seems more appropriate than
an #error. You can ignore it if you know what you are doing.

>=20
> Unfortunately, DEBUG_LL is one of those things that is platform =
specific,
> it has to be to guarantee output, so situations such as missing DT can
> still produce output.  Unfortunately, it got used for early_printk
> because it was easier to add early_printk rather than telling people
> to add a printascii() call in kernel/printk/printk.c (which is what I
> used to tell people, and what I _still_ do today.)

Yes, I have used printascii() in early days of board bringup (especially
with broken u-boot setup)...

>=20
> DEBUG_LL has always been intended for this purpose, and it's under the
> "debugging" menus, because it's really not meant to be enabled for
> production.  If you have folk who have enabled DEBUG_LL in your
> configurations, and then left it enabled beyond this level of =
debugging,
> I have to question the competence of that.

It is not a matter of competence but experience. Simply assume that =
someone
with only a little experience did enable it (or even copied from some
nowadays unknown source) some years ago for some good reason (in the
view of the team experience back then) and nobody questioned this =
decision
afterwards.

And suddenly the system fails completely.

It is the same mental principle how severe bugs (and security issues) =
stay
for years and are suddenly found to the surprise of everybody.

> DEBUG_LL may be an extreme example of a config option that can land
> your kernel in a non-bootable situation, but there are plenty of other
> configuration options that will severely degrade the performance of
> your kernel.  Should we go around adding #warning's for those as well?

No. If just performance is going down, you can still boot and see =
messages
and debug other (e.g. driver) issues.

And have all debugging tools around. But you can't play around to debug
a non-booting kernel (except through JTAG).

>=20
> I know that the kernel configuration is hard - and it's hard because
> it's large, but it is worth reviewing the options that you have in
> your config from time to time, especially the debug options,

We did that from time to time - but I admit it is not done in a =
systematic
and well documented way. Something to think about and maybe automate...

sed "s/\(.*DEBUG.*\)=3Dy/# \1 is not set/g" <debug_defconfig >defconfig

> and
> question whether the debug options that are enabled are appropriate
> for the phase of development.
>=20
> So, if you're doing new development, you should have all the options
> that add extra checks enabled (such as lockdep, hang checks, etc).
> If you're moving towards the end of the development phase, and you
> care about performance, then you need to start turning these options
> off, because many of them will slow the kernel down.
>=20
> The configuration of debug options is not something that should be
> static.
>=20
> I suspect that you probably have a lot of debug options enabled in =
your
> kernel that affect it's performance... maybe you're due to review them
> as a whole?

It would not solve the problem. Just assume we have two configs - one =
with
debug disabled and one with debug enabled. Now we come to 4.14-rc1 where
the code change happened. We will not immediately notice, but as soon as =
we
build with the debug defconfig (for debugging something else), we can't
even boot.

So instead of fixing an important and urgent issue, we have to make the
debug kernel boot again...

While this might hint at a config problem, we still do not know which =
one.
And we look for and find DEBUG_LL enabled which we think is (still) =
right.

And it wasn't completely wrong before the patches for OMAP were =
integrated.

While my proposed patch would immediately tell - without runtime =
performance
influence. And in the non-debug config nobody would even see the =
#warning
because DEBUG_LL is disabled.

But it is up to you to accept or reject this idea - we for our team have
solved it for us. We simply want to save others from making the same
bad experience again. If this is not welcome, it has to be accepted.

BR and thanks,
Nikolaus
