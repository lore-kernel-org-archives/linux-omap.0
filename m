From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap1 changes for v3.3 merge window
Date: Sun, 11 Dec 2011 18:10:25 -0800
Message-ID: <CAOesGMg5SP2tJN6KkgYYUqY-QuUtXuZD0VAaxqnA+mThS9f8aA@mail.gmail.com>
References: <20111209212804.GA31337@atomide.com>
	<20111209213727.GC31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55726 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab1LLCK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Dec 2011 21:10:27 -0500
Received: by yenm11 with SMTP id m11so3353624yen.19
        for <linux-omap@vger.kernel.org>; Sun, 11 Dec 2011 18:10:26 -0800 (PST)
In-Reply-To: <20111209213727.GC31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Dec 9, 2011 at 1:37 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [111209 12:56]:
>> Hi And & Olof,
>>
>> Please pull omap1 changes from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1
>>
>> These changes are necessary to always reprogram the core clock
>> based on the SoC type so we can boot at the fastest supported rate.
>
> Sorry forgot to mention that this has a dependency to the fixes that
> you pulled in yesterday.

Thanks for the heads up. Pulled into next/devel.


-Olof
