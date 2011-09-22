From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Thu, 22 Sep 2011 09:15:05 -0700
Message-ID: <87hb44v9iu.fsf@ti.com>
References: <20110917014623.GC2937@atomide.com> <2241590.uiCS2D9jjt@wuerfel>
	<87d3et4zj9.fsf@ti.com> <201109221633.14887.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:60219 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051Ab1IVQPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 12:15:10 -0400
Received: by mail-yx0-f176.google.com with SMTP id 22so2793780yxn.21
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 09:15:09 -0700 (PDT)
In-Reply-To: <201109221633.14887.arnd@arndb.de> (Arnd Bergmann's message of
	"Thu, 22 Sep 2011 16:33:14 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 21 September 2011, Kevin Hilman wrote:
>> Found.  Patch below.
>> 
>> If this one is OK, I'll push to my for_3.2/voltage-cleanup branch (which
>> is already pulled into arm-soc/next/voltage) so just re-pulling will
>> pick up the fix.
>
> Looks good to me, it's always nice when a bug fix is also a cleanup ;-)
>

OK, added it to the branch you've already pulled[1], if you (re)pull,
you'll get the fix too.

Thanks,

Kevin

[1] git://gitorious.org/khilman/linux-omap-pm.git for_3.2/voltage_cleanup
