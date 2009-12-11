From: Daniel Toussaint <daniel@dmhome.net>
Subject: Re: [PATCH] Initial support for OMAP3 Thunder board
Date: Fri, 11 Dec 2009 13:18:30 +0100
Message-ID: <6cb69d4a0912110418x2d06acem1408e4b9d2e0a5fd@mail.gmail.com>
References: <4B21593C.9060409@dmhome.net> <20091210204821.GV24013@atomide.com>
	 <6cb69d4a0912101430l2555db33y8c56f7f75a1f9dd@mail.gmail.com>
	 <20091210224556.GW24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45957 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbZLKMS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 07:18:26 -0500
Received: by bwz27 with SMTP id 27so547008bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 04:18:32 -0800 (PST)
In-Reply-To: <20091210224556.GW24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 10, 2009 at 11:45 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Daniel Toussaint <daniel@dmhome.net> [091210 14:29]:
>> >
>> > Cool. Can you please split the the patches into following
>> > separate patches:
>> >
>> > 1. Add minimal board support
>> > 2. Add defconfig
>> > 3. Add ASoC support
>> > 4. Add DSS2 support
>>
>> Ok, so can the DSS2 related stuff be ifdef-ed in the board file ,or
>> does it have to be completely seperated ?
>
> Please leave it out for now as the DSS2 code is not merged yet.
>
> That can be patched in later on, it's best to leave out all the
> dependencies from patches when possible.
>
> Also, your patches need to be against current Linus' mainline
> tree, not against linux-omap master branch as we already have
> DSS2 merged in for testing.
Mainline ? ok. I noticed mainline is still using <mach/xxxx> instead
of <plat/xxxx> and there no support for the ehci reset with GPIO's.
Or am I looking at the wrong tree ?



> Regards,
>
> Tony
>
