From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] arm: omap1/2/3/4: convert clocksource to a platform_driver
Date: Tue, 06 Apr 2010 07:43:52 -0700
Message-ID: <87hbnor68n.fsf@deeprootsystems.com>
References: <20100324065442.GB7534@nokia.com>
	<1269588117-17024-1-git-send-email-felipe.balbi@nokia.com>
	<87aathse2b.fsf@deeprootsystems.com>
	<20100406063828.GP16297@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:34636 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab0DFOn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 10:43:56 -0400
Received: by pzk31 with SMTP id 31so1593321pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 07:43:56 -0700 (PDT)
In-Reply-To: <20100406063828.GP16297@nokia.com> (Felipe Balbi's message of "Tue\, 6 Apr 2010 09\:38\:28 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Felipe Balbi <felipe.balbi@nokia.com> writes:

> Hi,
>
> On Tue, Apr 06, 2010 at 12:57:16AM +0200, ext Kevin Hilman wrote:
>>What' you've created is not a generic clocksource driver but one that
>>can only work with the 32k sync timer.
>
> so I achieved my goal, which was to convert *32k-sync timer* into a
> platform_driver.

OK, then I misunderstood your goal.  Based on $SUBJECT, I thought
you were trying to create a generic clocksource driver.

Sorry for the confusion,

Kevin

