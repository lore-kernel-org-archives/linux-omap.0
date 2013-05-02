From: Suman Anna <s-anna@ti.com>
Subject: Re: [GIT PULL] mailbox driver framework for v3.10 merge window
Date: Thu, 2 May 2013 17:09:07 -0500
Message-ID: <5182E403.1030808@ti.com>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com> <201304091255.03020.arnd@arndb.de> <CAJe_Zhf5QwQQU5aVtNhbDT3EK9Dof-ZK_boP9WaNghqO8xY7iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58022 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758853Ab3EBWOm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 May 2013 18:14:42 -0400
In-Reply-To: <CAJe_Zhf5QwQQU5aVtNhbDT3EK9Dof-ZK_boP9WaNghqO8xY7iA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Russell King - ARM Linux (linux@arm.linux.org.uk)" <linux@arm.linux.org.uk>, "Loic PALLARDY (loic.pallardy@st.com)" <loic.pallardy@st.com>, "Tony Lindgren (tony@atomide.com)" <tony@atomide.com>, "Linus Walleij (linus.walleij@linaro.org)" <linus.walleij@linaro.org>, "Omar Ramirez Luna (omar.ramirez@copitl.com)" <omar.ramirez@copitl.com>, Olof Johansson <olof@lixom.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Arnd,

On 04/28/2013 11:07 PM, Jassi Brar wrote:
> Hello Arnd,
> 
> On 9 April 2013 16:25, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thursday 04 April 2013, Anna, Suman wrote:
>>> OMAP and ST-Ericsson platforms are both using mailbox to communicate with some coprocessors. This series creates a consolidated framework, living under drivers/mailbox.
>>> The changes mainly contain:
>>> - create a mailbox framework independent from OMAP h/w
>>> - creates dbx500 mailbox driver for ST-Ericsson platforms
>>> - move the omap mailbox out of plat-omap/mach-omapX  adapting to the new framework.
>>> - minor bug fixes in mailbox code
>>
>> Pulled into a new next/mailbox branch, to keep it separate from the
>> existing subsystems.
>>
> I am going to be a heavy user of the Mailbox API. And I have reviewed
> this API quite in detail. I pointed out many aspects that might have
> worked for TI's usage but are not going to be work on many platforms
> (including one of mine).  Suman and Loic also acknowledged most (if
> not all) from 'generic' POV.  Here is the thread ...
>    http://www.spinics.net/lists/arm-kernel/msg239433.html
> 
> Not to mean only talk and no do, I prepared another proposal that
> addressed all the concerns shared so far in the RFC
> http://www.spinics.net/lists/kernel/msg1523873.html (its not ready for
> primetime yet)  And also converted the PL320 driver to the new API,
> unlike the pulled patchset which leaves that out in the cold.
> http://www.spinics.net/lists/kernel/msg1523874.html

Yes, the current code is mainly interrupt-driven and supports only
non-atomic context. We have a need to support atomic contexts and ipc
controllers that do not have interrupt-based triggering. As Jassi
pointed out, the RFC is not ready yet and there are still some
contention points that needs to be sorted out (especially to maintain
OMAP mailbox functionality).

> 
> Now, we could either call it (effectively the TI's framework with
> quirks for STE) as the "Common API" and then dismantle and convert it
> patch by patch (authors and I seem to agree many things need to be
> changed and implemented).
>   OR we do it reasonably right the first time even if that means yet
> another release. IMHO we should go for slow but steady thing.

I think it is your call here, either of the above approaches would
definitely involve some rework on the framework as well as both the OMAP
& ST mailboxes. Atleast for OMAP, the code exists in kernel but disabled
currently due to the multi-platform support. It is pending on the move
to drivers/mailbox folder, and can be enabled just with the first 3
patches (and another one for renaming generic mailbox.c/.h back to
omap_mailbox.c/.h files if we go the RFC approach) in the series
(irrespective of the framework). TI DSP/Bridge would remain broken
because of the omap dmtimer api dependencies on multi-platform.

I do not know how much of an impact it is for the ST driver as the
series adds the driver, and would have to wait until the RFC is sorted
out otherwise.

regards
Suman
