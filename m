From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: new PM branch available
Date: Wed, 18 Mar 2009 12:01:54 -0700
Message-ID: <87hc1qodst.fsf@deeprootsystems.com>
References: <794F9949-C366-41CE-BC4C-AB9AAA95FFD2@cs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:26658 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbZCRTB7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 15:01:59 -0400
Received: by wf-out-1314.google.com with SMTP id 29so205430wff.4
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 12:01:57 -0700 (PDT)
In-Reply-To: <794F9949-C366-41CE-BC4C-AB9AAA95FFD2@cs.umd.edu> (Nicholas Chen's message of "Wed\, 18 Mar 2009 14\:56\:33 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicholas Chen <nchen@cs.umd.edu>
Cc: linux-omap@vger.kernel.org

Nicholas Chen <nchen@cs.umd.edu> writes:

> I recently checked out the latest PM branch from your git repository
> and put it on the Beagleboard (B5). I have been largely able to
> reproduce the results others have reported on this PM thread, 

...not sure what "this PM thread" you are referring to?

> but I believe my CORE and PER powerdomains are not hitting RET or
> OFF.

> I think this based on the following:
> after I
> echo 1 > enable_off_mode
> echo 1 > sleep_while_idle
> echo mem > state

CORE and PER are still on because UART clocks are not being cut in
idle:

  # echo 1 > /sys/power/clocks_off_when_idle

And see if that works.  Also at least on my Beagle, I am not able
to resume from full-chip OFF, so for starters I suggest just testing
retention: echo 0 > /sys/power/enable_off_mode

> Suspending starts but upon resume I see the following:
> ...
> Powerdomain (core_pwrdm) didn't enter target state 0
> Powerdomain (per_pwrdm) didn't enter target state 0
> Could not enter target state in pm_suspend
>
> looking at debug/pm_debug/count/
> I see that only the core_pwrdm and per_pwrdm have 0's next to OFF: and
> RET:
>
> Based on the thread, the resolution seems  to be to disable USB and
> upgrade u-boot. I think I have done both. My u-boot is 2009.03-rc2
> from Steve Sakoman's tree, and I have disabled USB support in my
> Kernel build. Is there something that I am overlooking? Also, I'm
> curious if the two powerdomains linked (i.e. I need to fix PER before
> CORE will shut off or vice versa).

For your problem, they're linked in that they both contain a UART
block.  UART1,2 are in CORE and UART3 is in PER.

Kevin
