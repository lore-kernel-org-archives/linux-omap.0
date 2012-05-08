From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP3: cleanup AM35xx SoC detection
Date: Tue, 08 May 2012 14:17:31 -0700
Message-ID: <8762c6mkyc.fsf@ti.com>
References: <1335829030-19431-1-git-send-email-khilman@ti.com>
	<87zk9j5216.fsf@ti.com> <20120508205822.GF5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44707 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752567Ab2EHVRU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 17:17:20 -0400
Received: by pbbrq8 with SMTP id rq8so11335654pbb.35
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 14:17:19 -0700 (PDT)
In-Reply-To: <20120508205822.GF5088@atomide.com> (Tony Lindgren's message of
	"Tue, 8 May 2012 13:58:22 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [120507 10:37]:
>> Tony,
>> 
>> Kevin Hilman <khilman@ti.com> writes:
>> 
>> > The detection of AM35xx SoCs is confusing and has redundancies.  Clean
>> > this up so that SoC detection is only based on SoC family: AM35xx.
>> 
>> Since these aren't PM related, can you queue these with other cleanups
>> for v3.5.  This is now independent from the similar changes made to the
>> clock fwk which Paul is queuing.
>
> OK applied now to cleanup branch and just pushed out. Had to update them
> a bit for the hwmod changes done by Paul.

OK, thanks.

>> Once both series are merged, I'll have one final patch that removes all
>> users of cpu_is_omap35*.
>
> OK can you please do that one against the current cleanup branch at
> commit a75bf667d6535af66d34f8d7be0a36aa2a96c56e?

This last "removal" patch depends on the am35x clock changes that are in
devel-prcm too.  So in order to apply it, I'd need a stable base with
your cleanup and devel-prcm branches.

It's not a big deal though, it can wait until v3.5 as well.

Kevin

