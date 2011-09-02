From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT
	support
Date: Fri, 2 Sep 2011 10:21:53 +0100
Message-ID: <20110902092153.GB30263@n2100.arm.linux.org.uk>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com> <1314897912-18178-7-git-send-email-b-cousson@ti.com> <20110902080944.GP3548@atomide.com> <4E609800.9090402@ti.com> <20110902090824.GA30263@n2100.arm.linux.org.uk> <4E609E1F.4050607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44882 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab1IBJWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 05:22:13 -0400
Content-Disposition: inline
In-Reply-To: <4E609E1F.4050607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 02, 2011 at 11:13:03AM +0200, Cousson, Benoit wrote:
> On 9/2/2011 11:08 AM, Russell King - ARM Linux wrote:
>> On Fri, Sep 02, 2011 at 10:46:56AM +0200, Cousson, Benoit wrote:
>>> Now, that kernel.org is back, I'll pull you branches :-).
>>
>> Umm.  Are you sure?  What are you checking - that some kernel.org
>> servers are reachable or that master.kernel.org is reachable (it
>> isn't.)
>
> I was not about to fetch  
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git  
> yesterday, but it works today.

git.kernel.org != master.kernel.org.

git.kernel.org is an alias for a set of servers which are selected
depending on your geographical location, whereas master.kernel.org
a single machine to which we upload our trees and which has been down
since Wednesday.  I don't believe master.kernel.org is part of the
public serving infrastructure (it certainly never used to be.)

So, I suspect your non-reachability of git.kernel.org yesterday was
due to some other problem.
