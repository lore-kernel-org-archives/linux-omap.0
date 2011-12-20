From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] Borderline fixes for v3.2-rc6
Date: Tue, 20 Dec 2011 10:01:39 -0800
Message-ID: <CAOesGMhXnSB8-eW=NxjFqv_9Br5pD5XOi==wAL_j+bDoj_+gCw@mail.gmail.com>
References: <20111219194249.GO6464@atomide.com>
	<CAOesGMj-OyDu9pcOZ20o6G0W3-kkxyHF7o5DqDRaQkkUDf98CA@mail.gmail.com>
	<20111220171041.GA24444@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39050 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab1LTSBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 13:01:40 -0500
Received: by yenm11 with SMTP id m11so4168898yen.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Dec 2011 10:01:39 -0800 (PST)
In-Reply-To: <20111220171041.GA24444@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Dec 20, 2011 at 9:10 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Olof Johansson <olof@lixom.net> [111219 20:20]:
>> Hi Tony,
>>
>> On Mon, Dec 19, 2011 at 11:42 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > Hi Arnd & Olof,
>> >
>> > Here are two fixes that could potentially go into v3.2 -rc cycle.
>> >
>> > One fixes a harmless but annoying warning that happens on omap 34xx
>> > processors during boot. The other one fixes booting on pretty rare
>> > secure mode development board, but that's fixed in "features that
>> > never worked earlier either" style.
>> >
>> > We can surely wait on these fixes, but if you have something going
>> > upstream anyways, then these might be worth considering too.
>>
>> The hwmod patch is a regression so that one I'll take, the other one
>> is a little less obvious that it should go in now. Also, shouldn't it
>> be cc:d stable in that case?
>
> Yes let's not worry about the second one, it adds new functionality and
> it's for a currently rare case.
>
>> Let me know what you prefer (rebase with a cc: stable) or take out the
>> secure mode patch. I'm collecting a small series of fixes so I'll pull
>> it in tomorrow for that.
>
> I've branched it out into fixes-hwmod-regression with just that
> same commit in it. The second patch in this series will be pulled in
> with fixes-non-critical-part2. Updated pull request below.

Thanks, I pulled fixes-hwmod-regression into fixes and fixes-hwmod
into next/fixes-non-critical.


-Olof
