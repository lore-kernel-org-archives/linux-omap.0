From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: dspbridge sync proposal for 0.1
Date: Thu, 10 Dec 2009 21:03:34 +0200
Message-ID: <94a0d4530912101103y1211612bm8f4b570902e7f0b0@mail.gmail.com>
References: <27F9C60D11D683428E133F85D2BB4A5304271DACDE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:64939 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761552AbZLJTD2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 14:03:28 -0500
Received: by iwn1 with SMTP id 1so65947iwn.33
        for <linux-omap@vger.kernel.org>; Thu, 10 Dec 2009 11:03:34 -0800 (PST)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5304271DACDE@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Artem Bityutskiy <artem.bityutskiy@nokia.com>, "Shah, Bhavin" <bshah@ti.com>, Tony Lindgren <tony@atomide.com>

Hello Omar,

On Thu, Dec 10, 2009 at 7:47 PM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> On Sat, Dec 5, 2009 at 7:39 AM, Felipe Contreras
> <felipe.contreras@nokia.com> wrote:
>> There is a proposal to get the dspbridge branch into a decent state =
for
>> the 0.1 release, so I've been trying to synchronize the internal mae=
mo
>> branch with the upstream one.
>>
>> Unfortunately, there are severe issues:
>> =C2=A0* TI modified the patches sent by Nokia
>
> At the moment the proper comments were made and since authors didn't
> submit any response the patches were modified (I'm thankful that I
> kept the authorship).

=46irst, I see that the _recent_ patches (part of TI's synchronization
efforts), have been handled more properly, but I'm not including those
in my 0.1 proposal. On this proposal I concentrated on old patches,
some of which were properly commented on l-o, but not all. Moreover,
the Maemo tree was never updated with the final version, so it was
never tested in our side (unfortunately), and that worries me.

I haven't had enough time to properly analyze each and every of those
changes, but I can do that and come back to you.

[...]

>> =C2=A0* Many patches have never been sent to l-o for review
>
> When the request came for a new bridge branch for L-O, that is what I
> precisely thought a *new* baseline, not bounded for any freezing poin=
t
> or company requirement and that was going to be updated constantly.
> The existing one was rotting away so no use to take that one, not eve=
n
> thinking about taking other versions.

Here I'm putting my community hat and not speaking on behalf of any
company; whatever baseline we choose must work on *at least* on N900,
and beagleboard, and I'm willing to invest as much time is needed in
order to achieve that goal (hence this proposal).

>> And more importantly; I couldn't get it to work, neither on the N900=
,
>> nor the beagleboard (I didn't try very hard, though). So I decided t=
o
>> compare the branches patch by patch.
>
> Impressed since it is working for SDP, zoom2 and zoom3

Being accustomed to TI environments; I'm not. Maybe the module is
being loaded with certain magic parameters, or it only works with
certain DSP firmware, or requires certain PM patches, or certain
user-space software, or only works when compiled with debugging
enabled... Who knows?

I'm fairly certain that if I take a clean environment it wouldn't work
on a zoom2 either. Unfortunately I don't have one, but I would gladly
guide anybody interested in performing such test, although I think
it's rather pointless.

>> First, I found the last synchronization point is:
>> 6cc7482 DSPBRIDGE: Buffer size warning fixes
>>
>> It's not exactly synchronized, as it's missing some patches from Nok=
ia,
>> but it's as good as it gets.
>>
>> Then I marked each patch as "ok" if they are in both branches, "need=
s
>> sync" if it was modified, "!l-m" if it was not in the maemo branch, =
and
>> "unrev" if it was never sent for review.
>>
>> Next I tried to come up with something that could resemble the curre=
nt
>> maemo branch,
>
> what is this? where?

You already received this code for the "TI synchronization" efforts,
but in any case, here it goes again:
http://gitorious.org/tidspbridge/mainline

I only checked 'bridge-pm-2.6.31' but it's essentially the same we use
internally (plus some compilation fixes).

>> but I found no easy way. So, what I did is to pick each
>> patch that was somehow present on both branches (I used the Nokia
>> version for the patches that came from Nokia)
>
> wrong... after a quick look on your proposal some patches seem not to
> be the same as the ones sent to LO, I'm not talking about merge issue=
s
> but would have helped to see a "merge issue" comment on history

It would be nice to know which commits you are talking about.

>>, then, pick all the
>> patches that were only in the upstream branch, but have been sent fo=
r
>> review, and finally, apply any other necessary patches. Needless to =
say;
>> this was not straightforward; I had to resolve many conflcts, and dr=
op
>> many patches.
>>
>> The end result is my proposal for 0.1 which is something that resemb=
les
>> the maemo branch, works both on the N900 (based on 2.6.28)
>
> so, we need to go back 4 kernel versions because you want?

=46irst, nobody is forcing anybody to test on 2.6.28, but since the
dspbridge is not upstream, being able to use it on multiple kernel
versions is a Good Thing. Some people need it on 2.6.28, some on
2.6.30, some on 2.6.32. If we have code that works on all of them, I
don't see why we should use code that doesn't.

That being said, if you have a clean environment along with a 2.6.32
kernel that works on the N900 and test this code, I'm sure it would
work too.

> ...and still confused about maemo bridge thing, what is this? where?

It's the one we use for the N900 and is in Ameya's repository which I
just pointed out.

>>, and the
>> beagleboard (using 2.6.32 without DVFS).
>
> your proposal doesn't fully work for 2.6.32:
> - It lacks a modification on the ioctl numbers, bridge ioctl 1 and 2
> directly conflict with kernel numbers

2.6.32 mainline, or 2.6.32 linux-omap? Where can I see such ioctl1 and =
2 change?

In any case, my video decoding test works.

> - If you take any commit from your proposal other than HEAD
> compilation will break

Of course it would, on >=3D2.6.31 kernels, that's why I named the commi=
t
"fix build for 2.6.31"... if you want some random point in time to
compile on 2.6.32, you should cherry pick this commit. Same applies to
all the commits in your branch before you made such fix.

Moreover, that's precisely the reason why we should be using
ioremap(), which is mentioned in the patch too.

> - how do you acquire mcbsp clocks?

Huh? I don't see any change we did in order to do that. All the
patches in the 0.1 proposal are also present in your current branch.

>> There are still many patches
>> missing, both from the upstream and maemo branches, but I think thos=
e
>> should be tackled in 0.2.
>>
>> The only change needed from 2.6.28 to 2.6.32 seems to be IO_ADDRESS =
->
>> OMAP2_IO_ADDRESS,
>
> wrong, see above

If you are referring to the ioctls patch; it's clearly not *needed*,
although it might be nice to have it. But it's a complete ABI
breakage, such big changes need to be shouted loudly.

[...]

>> All the branches are in:
>> http://gitorious.org/~felipec/linux-omap/felipec
>>
>> =C2=A0* dspbridge-0.1:: 0.1 proposal
>> =C2=A0* dspbridge-0.1-base:: last synchronization point
>> =C2=A0* dspbridge-0.1-step1:: first step: patches on both branches
>> =C2=A0* dspbridge-0.1-step2:: second step: patches only on upstream
>> =C2=A0* dspbridge-0.2-maemo:: maemo patches for 0.2
>
> please don't send this if you are actually complaining of not sending
> patches and modifying patches from other people, or at least mention
> the changes like I did on git log (btw i just checked 0.1 proposal).

This is a *proposal*, I'm not saying "this is now the official branch
we will all be using"; all the patches from -base to -step2 are
present in your dspbridge branch, except that I used the Maemo
original version from the patches that came from Nokia, and the
patches that I modified were trivial conflict fixes.

The rest of the patches (from -step2 to the final proposal), are
patches *needed* to compile, and it would be pointless to send patches
to the mailing list that apply to a ghost branch. If we end up using
this as the baseline, then I would gladly send them for review.

>> For more detail in my analysis of the current dspbridge branch check=
:
>> http://people.freedesktop.org/~felipec/dspbridge-0.1-sync.html
>>
>> Comments?
>
> Overall, I do agree with the part about resending the patches, I
> reverted all of them yesterday (not a pain took like 1 hour or so),
> but history looks like crap... so, I'm planning to drop them on
> upcoming rebase, then resend the missing patches and wait a reasonabl=
e
> time for people to look at them.

Why not just rebase your patches on top of my 0.1 proposal? Just like
I did with with 'dspbridge-0.2-maemo'?

If you decide to come up with a new baseline with the non-reviewed
patches removed; it still needs to be usable, at least on N900 and
beagleboard, just like dspbridge-0.1-base.

> Since all the approved patches were sent long ago I will post the lin=
k
> were I took the patch, so no confusions are made between mixing TI or
> else versions.

No need for that. I'll check the Maemo version, compare it to the
posted version, and TI's version, analyze the results, and come back
to you.

> But my 0.1 idea still remains =3D all LO approved patches + patches t=
hat
> need review, after that all the cleaning up can be done and be part o=
f
> 0.x; anyway, this is a minor thing IMHO.

Sorry, I didn't get that.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
