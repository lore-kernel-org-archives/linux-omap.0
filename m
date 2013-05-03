From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [GIT PULL] mailbox driver framework for v3.10 merge window
Date: Fri, 3 May 2013 08:07:54 +0530
Message-ID: <CAJe_ZhfA=eqihefgtYGmLt03sNV6arme9t1YgzTFoC8nB6SNkQ@mail.gmail.com>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
	<201304091255.03020.arnd@arndb.de>
	<CAJe_Zhf5QwQQU5aVtNhbDT3EK9Dof-ZK_boP9WaNghqO8xY7iA@mail.gmail.com>
	<5182E403.1030808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52912 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827Ab3ECChz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 May 2013 22:37:55 -0400
Received: by mail-ob0-f174.google.com with SMTP id dn14so1066059obc.19
        for <linux-omap@vger.kernel.org>; Thu, 02 May 2013 19:37:54 -0700 (PDT)
In-Reply-To: <5182E403.1030808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Russell King - ARM Linux (linux@arm.linux.org.uk)" <linux@arm.linux.org.uk>, "Loic PALLARDY (loic.pallardy@st.com)" <loic.pallardy@st.com>, "Tony Lindgren (tony@atomide.com)" <tony@atomide.com>, "Linus Walleij (linus.walleij@linaro.org)" <linus.walleij@linaro.org>, "Omar Ramirez Luna (omar.ramirez@copitl.com)" <omar.ramirez@copitl.com>, Olof Johansson <olof@lixom.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 3 May 2013 03:39, Suman Anna <s-anna@ti.com> wrote:
> Hi Arnd,
>
> On 04/28/2013 11:07 PM, Jassi Brar wrote:
>>
>> Not to mean only talk and no do, I prepared another proposal that
>> addressed all the concerns shared so far in the RFC
>> http://www.spinics.net/lists/kernel/msg1523873.html (its not ready for
>> primetime yet)  And also converted the PL320 driver to the new API,
>> unlike the pulled patchset which leaves that out in the cold.
>> http://www.spinics.net/lists/kernel/msg1523874.html
>
> Yes, the current code is mainly interrupt-driven and supports only
> non-atomic context. We have a need to support atomic contexts and ipc
> controllers that do not have interrupt-based triggering.
>
Supporting poll and client driven TX and atomic context is going to
need big chunks of changes which we can avoid by doing them already.
Plus a bottleneck with PL320, as Mark pointed out they can't afford
any bigger latency, which will come from RX via notifier path.

> As Jassi
> pointed out, the RFC is not ready yet and there are still some
> contention points that needs to be sorted out (especially to maintain
> OMAP mailbox functionality).
>
Apart from a few checkpatch fixes, a missing timer delete call and
some testing with dummy client and controller drivers for various
usecases, it's ready from my side. It worked at least as good as your
API in our internal testing.

Please do let me know which OMAP functionality are you worried about,
I believe it could all still be done above this api.

>>
>> Now, we could either call it (effectively the TI's framework with
>> quirks for STE) as the "Common API" and then dismantle and convert it
>> patch by patch (authors and I seem to agree many things need to be
>> changed and implemented).
>>   OR we do it reasonably right the first time even if that means yet
>> another release. IMHO we should go for slow but steady thing.
>
> I think it is your call here, either of the above approaches would
> definitely involve some rework on the framework as well as both the OMAP
> & ST mailboxes.

I am interested to know what changes do you anticipate in my proposed
API. Not to mean it's perfect, but I thought I provided for all
practical use-cases.

Yes, TI and STE would need re-work, but then as of now they are their
own APIs upstream. And even with your proposal they would still need
to be changed if we are to implement the desired features. What about
PL320?

Thanks.
