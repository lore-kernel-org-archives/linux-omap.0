From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [GIT PULL] mailbox driver framework for v3.10 merge window
Date: Fri, 3 May 2013 15:39:42 +0200
Message-ID: <CACRpkdYSnNeO8F-1WWN9J+pkMi6B_Qydo85QovbgWOEoDDS9Aw@mail.gmail.com>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
	<CAJe_Zhf5QwQQU5aVtNhbDT3EK9Dof-ZK_boP9WaNghqO8xY7iA@mail.gmail.com>
	<5182E403.1030808@ti.com>
	<1407180.uGFidLMFHk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59856 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762352Ab3ECNjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 May 2013 09:39:43 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so1792279ied.5
        for <linux-omap@vger.kernel.org>; Fri, 03 May 2013 06:39:43 -0700 (PDT)
In-Reply-To: <1407180.uGFidLMFHk@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Loic PALLARDY <loic.pallardy@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, "Russell King - ARM Linux (linux@arm.linux.org.uk)" <linux@arm.linux.org.uk>, "Tony Lindgren (tony@atomide.com)" <tony@atomide.com>, Olof Johansson <olof@lixom.net>, "Omar Ramirez Luna (omar.ramirez@copitl.com)" <omar.ramirez@copitl.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, May 3, 2013 at 3:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 02 May 2013 17:09:07 Suman Anna wrote:
>>
>> I do not know how much of an impact it is for the ST driver as the
>> series adds the driver, and would have to wait until the RFC is sorted
>> out otherwise.
>
> I think I'd prefer to drop the branch from the 3.10 queue then
> and let you all work out a common approach for 3.11. Olof, any
> other input?

This will block all refactoring of the PRCMU driver, which Loic
is working on, and also Ulf Hansson's clock driver. It is basically
the key to breaking that driver apart and distributing it out into
the proper subsystems. Loic has a big patch series for that
for next merge window which will then have to be postponed,
or queued on top of the mailbox work when finished.

But maybe it's the right thing to do if the subsystem needs more
work? I have no clear opinion on this, Loic, Ulf?

Yours,
Linus Walleij
