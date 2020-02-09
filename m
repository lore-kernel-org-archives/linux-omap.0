From: "Arthur D." <spinal.by@gmail.com>
Subject: Re: N900: Remove mmc1 "safety feature"? (was: Re: mmc0 on Nokia N900
 on Linux 5.4.18)
Date: Sun, 09 Feb 2020 06:48:47 +0300
Message-ID: <op.0fpbjlbwhxa7s4@supervisor.net28>
References: <5362c659-120f-5247-aaa5-7916229300bc@wizzup.org>
 <20200208190448.GA12984@amd> <270f27c9-afd6-171d-7dce-fe1d71dd8f9a@wizzup.org>
 <1eac0db3-17ce-8ebd-4997-8b1c282126e4@wizzup.org> <20200208220621.GA18161@amd>
 <d2d6d6ac-c964-ac48-1616-6f1826219385@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36139 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgBIDsv (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 8 Feb 2020 22:48:51 -0500
Received: by mail-wr1-f44.google.com with SMTP id z3so3459732wru.3
        for <linux-omap@vger.kernel.org>; Sat, 08 Feb 2020 19:48:50 -0800 (PST)
In-Reply-To: <d2d6d6ac-c964-ac48-1616-6f1826219385@wizzup.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

I suppose the real life scenario would be:

0. The OS runs on eMMC.
1. The user opens his phone back cover and inserts MicroSD card.
2. Kernel doesn't try to access the card until the cover is closed.

It seems wise to me: we don't want to damage user's data or hardware.
Accessing data on unstable medium can't be considered safe.
While the cover is open and user just inserted the microsd card everything
can happen - the phone can be dropped, may be unstable contact to microsd
while the user interacting it, etc.

It seems to be inconvenient for us, while we run OS mostly from microsd.
But removing such behaviour from the kernel completely doesn't seem to
be a good idea generally. Vanilla kernel shouldn't be dedicated for
debugging purposes or edge cases (like running only from external MMC).
Running from embedded MMC should be common for most users in perspective.

If I remember correctly, if the microsd is already mounted and the back
cover is open, nothing bad happens. It continues to work. You can unmount
the card and remove it safely. But you are not going to see the new card
insertion detected until you close the cover.

I'm not sure about the last paragraph. Please correct me if I'm wrong about
how it actually works.


>> It is very bad for debugging, agreed.
>>
>> It makes sense for regular usage: when user removes back cover, system
>> unmounts the u-SD card, so that it is ready for user to remove
>> it. Note that we do _not_ have "remove the card safely" button in the
>> UI; back cover serves that purpose.
>>
>> That said... for Leste just keep the patch. And maybe apply that one
>> to shutdown system when battery is low :-).
>
> So how does this currently happen, the unmounting? Does the mmc1 card
> just disappear from /dev/ without any safe unmount? I don't understand
> how the current setup can work from a userspace point of view.
>
> Userspace could react on kernel events that tell it the cover is open,
> but I assume the kernel doesn't just decide to nuke the node from /dev/,
> so in that case the current DTS setup still doesn't make sense, right?
>
> What am I missing? Could you describe how this would work in a 'real
> life' scenario?
