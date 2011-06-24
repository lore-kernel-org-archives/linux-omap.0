From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 0/7] Fix module-mode enable sequence on OMAP4
Date: Fri, 24 Jun 2011 15:31:08 +0200
Message-ID: <4E04919C.80607@ti.com>
References: <1308917193-16912-1-git-send-email-b-cousson@ti.com> <4E048FD9.6060501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41190 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237Ab1FXNbN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 09:31:13 -0400
In-Reply-To: <4E048FD9.6060501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 6/24/2011 3:23 PM, Nayak, Rajendra wrote:
> On 6/24/2011 5:06 AM, Benoit Cousson wrote:
>> Hi Paul&   Rajendra,
>>
>> Here is an updated version of the series started by Rajendra.
>> I had to update it because this series is mandatory for the hwmod
>> modulemodule control series.
>> I rebased it on top of the various fixes done on hwmod framework
>> and to take advantage of the new clkdm attribute in omap_hwmod.
>> I thus added 2 new APIs to handle clockdomain from hwmod instead
>> of using the clockdomain done for clock.
>>
>> I drop the clockdomain control for optional clocks that is not
>> mandatory.
>
> There were also some locking issues with this series pointed out
> by Todd, for which I did a RFC patch to add a per-clkdm lock.
> Any thoughts on that? We might need that or something similar to
> prevent concurrent clkdm states being programmed, now that they
> are done from hwmod (with a per-hwmod lock held) instead of being
> earlier done from clk framework with a global lock held.

Oops, good point I forgot that one.
I'm fine with it, but I think Paul was wondering if one global lock for 
clockdomain will not be enough. For the moment, it is maybe safer to 
keep one lock per domain.
I'll add it for the next revision.

Thanks,
Benoit
