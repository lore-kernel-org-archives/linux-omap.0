From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT support
Date: Fri, 2 Sep 2011 11:34:32 +0200
Message-ID: <4E60A328.3010202@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com> <1314897912-18178-7-git-send-email-b-cousson@ti.com> <20110902080944.GP3548@atomide.com> <4E609800.9090402@ti.com> <20110902090824.GA30263@n2100.arm.linux.org.uk> <4E609E1F.4050607@ti.com> <20110902092153.GB30263@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38705 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756025Ab1IBJeu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 05:34:50 -0400
In-Reply-To: <20110902092153.GB30263@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 9/2/2011 11:21 AM, Russell King - ARM Linux wrote:
> On Fri, Sep 02, 2011 at 11:13:03AM +0200, Cousson, Benoit wrote:
>> On 9/2/2011 11:08 AM, Russell King - ARM Linux wrote:
>>> On Fri, Sep 02, 2011 at 10:46:56AM +0200, Cousson, Benoit wrote:
>>>> Now, that kernel.org is back, I'll pull you branches :-).
>>>
>>> Umm.  Are you sure?  What are you checking - that some kernel.org
>>> servers are reachable or that master.kernel.org is reachable (it
>>> isn't.)
>>
>> I was not about to fetch
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>> yesterday, but it works today.
>
> git.kernel.org != master.kernel.org.
>
> git.kernel.org is an alias for a set of servers which are selected
> depending on your geographical location, whereas master.kernel.org
> a single machine to which we upload our trees and which has been down
> since Wednesday.  I don't believe master.kernel.org is part of the
> public serving infrastructure (it certainly never used to be.)

Interesting, thanks for the explanations.

> So, I suspect your non-reachability of git.kernel.org yesterday was
> due to some other problem.

OK, maybe. The good point is that now it works :-)

The bad point is that Kevin cannot push his updated branches, so I still 
do not have the latest :-(

Thanks,
Benoit


