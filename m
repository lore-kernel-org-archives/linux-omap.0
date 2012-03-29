From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes for merge window
Date: Thu, 29 Mar 2012 12:27:21 -0700
Message-ID: <CAOesGMjNJZTFo_t+-O97kuB_Ob-V+1skCPzJvncN3b6R5b1ptg@mail.gmail.com>
References: <20120321180536.GK9859@atomide.com>
	<CAOesGMiKc5Tc2e5X9=gSiFS87JtMWGmmtOLSStWJcO7ayoE6Rg@mail.gmail.com>
	<20120329144151.GS9859@atomide.com>
	<20120329185626.GY9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48434 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2C2T1W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 15:27:22 -0400
Received: by wgbdr13 with SMTP id dr13so1866514wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 29 Mar 2012 12:27:21 -0700 (PDT)
In-Reply-To: <20120329185626.GY9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

On Thu, Mar 29, 2012 at 11:56 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Tony Lindgren <tony@atomide.com> [120329 07:44]:
>> * Olof Johansson <olof@lixom.net> [120328 22:04]:
>> > Hi Tony,
>> >
>> > On Wed, Mar 21, 2012 at 11:05 AM, Tony Lindgren <tony@atomide.com>=
 wrote:
>> > > Hi Arnd & Olof,
>> > >
>> > > Here's a set of fixes that would be nice to get merged during
>> > > the merge window before the GPIO changes get merged to avoid
>> > > boot issues on many omap boards.
>> > >
>> > > The changes queued in the GPIO tree require getting rid of
>> > > OMAP_GPIO_IRQ and use gpio_to_irq() instead. This is needed for
>> > > dynamically allocated GPIO interrupt ranges.
>> >
>> > Sorry for the slow response on this, we've been focused on getting=
 the
>> > main pulls going in. I'm about to start a fixes branch now and loo=
ked
>> > at this pull request.
>> >
>> > I replied to one of the original patches in this branch, they need=
 to
>> > be fixed before they can go in:
>> >
>> > http://marc.info/?l=3Dlinux-omap&m=3D133299716528617&w=3D2
>>
>> Thanks, that's a good catch.
>>
>> > Also, that way we can get a clean branch based on current mainline
>> > without merge conflicts.
>>
>> Yes will do.
>
> Olof, here's an updated pull request for your fixes staging branch.
>
> This contains the updated gpio_to_irq patches from Tarun, and a trivi=
al
> build fix from Govindraj to #include <asm/system_misc.h> in pm.c.
> The DSI mux patch is the same.
>
> Note that the branch name is now just fixes as the necessary commits
> are now all in the mainline tree.
>
> Regards,
>
> Tony
>
>
> The following changes since commit 0195c00244dc2e9f522475868fa278c473=
ba7339:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Merge tag 'split-asm_system_h-for-linus-20120328' of g=
it://git.kernel.org/.../dhowells/linux-asm_system
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fi=
xe

Thanks, pulled.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
