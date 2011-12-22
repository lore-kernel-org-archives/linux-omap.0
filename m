From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] Borderline fixes for v3.2-rc6
Date: Thu, 22 Dec 2011 09:14:47 -0800
Message-ID: <CAOesGMihx_1Ay6qEfynXw8Xqmu9xzgLeEj0UjkfY8g7e9jUaDw@mail.gmail.com>
References: <20111219194249.GO6464@atomide.com>
	<CAOesGMj-OyDu9pcOZ20o6G0W3-kkxyHF7o5DqDRaQkkUDf98CA@mail.gmail.com>
	<20111220171041.GA24444@atomide.com>
	<CAOesGMhXnSB8-eW=NxjFqv_9Br5pD5XOi==wAL_j+bDoj_+gCw@mail.gmail.com>
	<20111222171112.GH24444@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47103 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab1LVROs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 12:14:48 -0500
Received: by yhr47 with SMTP id 47so6062109yhr.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 09:14:47 -0800 (PST)
In-Reply-To: <20111222171112.GH24444@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Dec 22, 2011 at 9:11 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Olof,
>
> * Olof Johansson <olof@lixom.net> [111220 09:29]:
>> On Tue, Dec 20, 2011 at 9:10 AM, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > I've branched it out into fixes-hwmod-regression with just that
>> > same commit in it. The second patch in this series will be pulled in
>> > with fixes-non-critical-part2. Updated pull request below.
>>
>> Thanks, I pulled fixes-hwmod-regression into fixes and fixes-hwmod
>> into next/fixes-non-critical.
>
> Just checking.. Looks like you pulled fixes-hwmod into a new branch
> named fixes-non-critical-part2, but did not pull the same name branch
> fixes-non-critical-part2 that I posted?
>
> That's this pull request:
>
> http://www.spinics.net/lists/linux-omap/msg62050.html

Grmbl, thanks for catching that. I'll sort it out at this end.


-Olof
