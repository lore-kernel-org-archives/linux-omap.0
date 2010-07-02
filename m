From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
Date: Fri, 02 Jul 2010 12:42:39 +0300 (EEST)
Message-ID: <20100702.124239.260109498.Hiroshi.DOYU@nokia.com>
References: <20100629.075744.104054771.Hiroshi.DOYU@nokia.com>
	<20100702.093534.115912504.Hiroshi.DOYU@nokia.com>
	<20100702090411.GH6632@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35874 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab0GBJnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 05:43:14 -0400
In-Reply-To: <20100702090411.GH6632@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

From: ext Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
Date: Fri, 2 Jul 2010 11:04:11 +0200

> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [100702 09:29]:
>> 
>> Do you have any plan for pulling for-next patches?
>> 
>> I have some "omap iommu" and "omap mailbox" patches for for-next. Now
>> the merge window seems so small and I don't want to miss it.
> 
> Pulled now into omap-for-linus for the next merge window. Sorry
> for the delay.
> 
> BTW, I did not add that Makefile fix into omap-fixes-for-linus,
> I figured we should first make sure to get the pending fixes
> in, and then maybe do another set of fixes.
> 
> But looks like that's in your for-next, so we might as well
> keep it there. If there's urgent need to get that in as a fix,
> let me know ASAP, I can still rebuild omap-for-linus as that's
> the only set merged there.

Ok, Thanks. I'll send another pull request for omap mailbox for-next.
