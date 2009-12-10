From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: dspbridge sync proposal for 0.1
Date: Thu, 10 Dec 2009 11:47:36 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304271DACDE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36125 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760871AbZLJRrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 12:47:35 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Artem Bityutskiy <artem.bityutskiy@nokia.com>, "Shah, Bhavin" <bshah@ti.com>, Tony Lindgren <tony@atomide.com>

Hi,

On Sat, Dec 5, 2009 at 7:39 AM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> Hi,
>
> There is a proposal to get the dspbridge branch into a decent state for
> the 0.1 release, so I've been trying to synchronize the internal maemo
> branch with the upstream one.
>
> Unfortunately, there are severe issues:
>  * TI modified the patches sent by Nokia

At the moment the proper comments were made and since authors didn't
submit any response the patches were modified (I'm thankful that I
kept the authorship).

To name a few...
[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15653.html
[2] http://markmail.org/message/vfigmwc2q2gqc4r4

>  * Many patches have never been sent to l-o for review

When the request came for a new bridge branch for L-O, that is what I
precisely thought a *new* baseline, not bounded for any freezing point
or company requirement and that was going to be updated constantly.
The existing one was rotting away so no use to take that one, not even
thinking about taking other versions.

>
> And more importantly; I couldn't get it to work, neither on the N900,
> nor the beagleboard (I didn't try very hard, though). So I decided to
> compare the branches patch by patch.

Impressed since it is working for SDP, zoom2 and zoom3

>
> First, I found the last synchronization point is:
> 6cc7482 DSPBRIDGE: Buffer size warning fixes
>
> It's not exactly synchronized, as it's missing some patches from Nokia,
> but it's as good as it gets.
>
> Then I marked each patch as "ok" if they are in both branches, "needs
> sync" if it was modified, "!l-m" if it was not in the maemo branch, and
> "unrev" if it was never sent for review.
>
> Next I tried to come up with something that could resemble the current
> maemo branch,

what is this? where?

> but I found no easy way. So, what I did is to pick each
> patch that was somehow present on both branches (I used the Nokia
> version for the patches that came from Nokia)

wrong... after a quick look on your proposal some patches seem not to
be the same as the ones sent to LO, I'm not talking about merge issues
but would have helped to see a "merge issue" comment on history

>, then, pick all the
> patches that were only in the upstream branch, but have been sent for
> review, and finally, apply any other necessary patches. Needless to say;
> this was not straightforward; I had to resolve many conflcts, and drop
> many patches.
>
> The end result is my proposal for 0.1 which is something that resembles
> the maemo branch, works both on the N900 (based on 2.6.28)

so, we need to go back 4 kernel versions because you want?

...and still confused about maemo bridge thing, what is this? where?

>, and the
> beagleboard (using 2.6.32 without DVFS).

your proposal doesn't fully work for 2.6.32:
- It lacks a modification on the ioctl numbers, bridge ioctl 1 and 2
directly conflict with kernel numbers
- If you take any commit from your proposal other than HEAD
compilation will break
- how do you acquire mcbsp clocks?

> There are still many patches
> missing, both from the upstream and maemo branches, but I think those
> should be tackled in 0.2.
>
> The only change needed from 2.6.28 to 2.6.32 seems to be IO_ADDRESS ->
> OMAP2_IO_ADDRESS,

wrong, see above

> but I guess it would be much better to use ioremap
> instead, so the same code works everywhere. Any volunteers? :)

agree

>
> All the branches are in:
> http://gitorious.org/~felipec/linux-omap/felipec
>
>  * dspbridge-0.1:: 0.1 proposal
>  * dspbridge-0.1-base:: last synchronization point
>  * dspbridge-0.1-step1:: first step: patches on both branches
>  * dspbridge-0.1-step2:: second step: patches only on upstream
>  * dspbridge-0.2-maemo:: maemo patches for 0.2
>

please don't send this if you are actually complaining of not sending
patches and modifying patches from other people, or at least mention
the changes like I did on git log (btw i just checked 0.1 proposal).

> For more detail in my analysis of the current dspbridge branch check:
> http://people.freedesktop.org/~felipec/dspbridge-0.1-sync.html
>
> Comments?

Overall, I do agree with the part about resending the patches, I
reverted all of them yesterday (not a pain took like 1 hour or so),
but history looks like crap... so, I'm planning to drop them on
upcoming rebase, then resend the missing patches and wait a reasonable
time for people to look at them.

Since all the approved patches were sent long ago I will post the link
were I took the patch, so no confusions are made between mixing TI or
else versions.

But my 0.1 idea still remains = all LO approved patches + patches that
need review, after that all the cleaning up can be done and be part of
0.x; anyway, this is a minor thing IMHO.

- omar
