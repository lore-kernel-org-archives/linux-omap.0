From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Tue, 29 Sep 2009 20:24:51 +0300
Message-ID: <94a0d4530909291024kcac6b20m727b2908b2a76b88@mail.gmail.com>
References: <20090928190404.GE18957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:44912 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbZI2RYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 13:24:48 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1135602fge.1
        for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2009 10:24:51 -0700 (PDT)
In-Reply-To: <20090928190404.GE18957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Mon, Sep 28, 2009 at 10:04 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> I've updated our linux-omap tree to v2.6.32-rc1. I've also
> added a branch omap-2.6.31 for the old code.
>
> This time I also nuked the remaining omap legacy code we
> still had lurking around :) The commits at the end of this
> mail describe what I did first as commits, then I merged
> everything to be the same as the mainline v2.6.32-rc1.
>
> So currently the linux-omap master branch is:
>
> v2.6.32-rc1 + omap-fixes + ehci + cbus
>
> The new model is that I'll be resetting the linux-omap master
> branch to mainline at each -rc, then merge in our various
> upstream queues back in again.

Excellent! I was wondering why this wasn't being done. I certainly
hope linus' 2.6.32 will work on omap right away.

Anyway, I haven't been able to make 2.6.31 boot on beagleboard, and
other people report similar issues:
http://www.spinics.net/lists/linux-omap/msg17968.html

Have you got 2.6.32-rc1 (+fixes) to boot?

Cheers.

-- 
Felipe Contreras
