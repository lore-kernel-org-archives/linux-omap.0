From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] arm: omap1/2/3/4: convert clocksource to a
 platform_driver
Date: Tue, 6 Apr 2010 18:26:12 +0300
Message-ID: <20100406152612.GC23062@nokia.com>
References: <20100324065442.GB7534@nokia.com>
 <1269588117-17024-1-git-send-email-felipe.balbi@nokia.com>
 <87aathse2b.fsf@deeprootsystems.com>
 <20100406063828.GP16297@nokia.com>
 <87hbnor68n.fsf@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49311 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab0DFP1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 11:27:04 -0400
Content-Disposition: inline
In-Reply-To: <87hbnor68n.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Tue, Apr 06, 2010 at 04:43:52PM +0200, ext Kevin Hilman wrote:
>> so I achieved my goal, which was to convert *32k-sync timer* into a
>> platform_driver.
>
>OK, then I misunderstood your goal.  Based on $SUBJECT, I thought
>you were trying to create a generic clocksource driver.

ok, so it was my bad on the subject choice, maybe something like "arm: 
omap1/2/3/4: convert 32k-sync timer driver into a platform_driver" 
would've been better.

>Sorry for the confusion,

np. Sorry for the bad $SUBJECT

-- 
balbi
