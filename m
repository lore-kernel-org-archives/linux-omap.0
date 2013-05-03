From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] mailbox driver framework for v3.10 merge window
Date: Fri, 03 May 2013 15:25:23 +0200
Message-ID: <1407180.uGFidLMFHk@wuerfel>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com> <CAJe_Zhf5QwQQU5aVtNhbDT3EK9Dof-ZK_boP9WaNghqO8xY7iA@mail.gmail.com> <5182E403.1030808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58177 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762198Ab3ECNZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 May 2013 09:25:25 -0400
In-Reply-To: <5182E403.1030808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Suman Anna <s-anna@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, "Russell King - ARM Linux (linux@arm.linux.org.uk)" <linux@arm.linux.org.uk>, "Loic PALLARDY (loic.pallardy@st.com)" <loic.pallardy@st.com>, "Tony Lindgren (tony@atomide.com)" <tony@atomide.com>, "Linus Walleij (linus.walleij@linaro.org)" <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>, "Omar Ramirez Luna (omar.ramirez@copitl.com)" <omar.ramirez@copitl.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 02 May 2013 17:09:07 Suman Anna wrote:
> On 04/28/2013 11:07 PM, Jassi Brar wrote:
> > Now, we could either call it (effectively the TI's framework with
> > quirks for STE) as the "Common API" and then dismantle and convert it
> > patch by patch (authors and I seem to agree many things need to be
> > changed and implemented).
> >   OR we do it reasonably right the first time even if that means yet
> > another release. IMHO we should go for slow but steady thing.
> 
> I think it is your call here, either of the above approaches would
> definitely involve some rework on the framework as well as both the OMAP
> & ST mailboxes. Atleast for OMAP, the code exists in kernel but disabled
> currently due to the multi-platform support. It is pending on the move
> to drivers/mailbox folder, and can be enabled just with the first 3
> patches (and another one for renaming generic mailbox.c/.h back to
> omap_mailbox.c/.h files if we go the RFC approach) in the series
> (irrespective of the framework). TI DSP/Bridge would remain broken
> because of the omap dmtimer api dependencies on multi-platform.
> 
> I do not know how much of an impact it is for the ST driver as the
> series adds the driver, and would have to wait until the RFC is sorted
> out otherwise.

I think I'd prefer to drop the branch from the 3.10 queue then
and let you all work out a common approach for 3.11. Olof, any
other input?

	Arnd
