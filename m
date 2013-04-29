From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [GIT PULL] mailbox driver framework for v3.10 merge window
Date: Mon, 29 Apr 2013 09:37:30 +0530
Message-ID: <CAJe_Zhf5QwQQU5aVtNhbDT3EK9Dof-ZK_boP9WaNghqO8xY7iA@mail.gmail.com>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
	<201304091255.03020.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:50393 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab3D2EHb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Apr 2013 00:07:31 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so5072776obc.2
        for <linux-omap@vger.kernel.org>; Sun, 28 Apr 2013 21:07:30 -0700 (PDT)
In-Reply-To: <201304091255.03020.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Anna, Suman" <s-anna@ti.com>, "Russell King - ARM Linux (linux@arm.linux.org.uk)" <linux@arm.linux.org.uk>, "Loic PALLARDY (loic.pallardy@st.com)" <loic.pallardy@st.com>, "Tony Lindgren (tony@atomide.com)" <tony@atomide.com>, "Linus Walleij (linus.walleij@linaro.org)" <linus.walleij@linaro.org>, "Omar Ramirez Luna (omar.ramirez@copitl.com)" <omar.ramirez@copitl.com>, Olof Johansson <olof@lixom.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Arnd,

On 9 April 2013 16:25, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 04 April 2013, Anna, Suman wrote:
>> OMAP and ST-Ericsson platforms are both using mailbox to communicate with some coprocessors. This series creates a consolidated framework, living under drivers/mailbox.
>> The changes mainly contain:
>> - create a mailbox framework independent from OMAP h/w
>> - creates dbx500 mailbox driver for ST-Ericsson platforms
>> - move the omap mailbox out of plat-omap/mach-omapX  adapting to the new framework.
>> - minor bug fixes in mailbox code
>
> Pulled into a new next/mailbox branch, to keep it separate from the
> existing subsystems.
>
I am going to be a heavy user of the Mailbox API. And I have reviewed
this API quite in detail. I pointed out many aspects that might have
worked for TI's usage but are not going to be work on many platforms
(including one of mine).  Suman and Loic also acknowledged most (if
not all) from 'generic' POV.  Here is the thread ...
   http://www.spinics.net/lists/arm-kernel/msg239433.html

Not to mean only talk and no do, I prepared another proposal that
addressed all the concerns shared so far in the RFC
http://www.spinics.net/lists/kernel/msg1523873.html (its not ready for
primetime yet)  And also converted the PL320 driver to the new API,
unlike the pulled patchset which leaves that out in the cold.
http://www.spinics.net/lists/kernel/msg1523874.html

Now, we could either call it (effectively the TI's framework with
quirks for STE) as the "Common API" and then dismantle and convert it
patch by patch (authors and I seem to agree many things need to be
changed and implemented).
  OR we do it reasonably right the first time even if that means yet
another release. IMHO we should go for slow but steady thing.

Hi Suman, Hi Loic,
   Please feel free to object to anything you think I might have
misrepresented. I am OK if you are not sure about my implementation
either - we could co-work on a new one.

Regards,
-Jassi
