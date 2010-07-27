From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH:v4 00/13] OMAP: GPIO: Implement GPIO in HWMOD way
Date: Tue, 27 Jul 2010 13:47:13 +0200
Message-ID: <4C4EC741.5040202@ti.com>
References: <1277218916-15213-1-git-send-email-charu@ti.com> <20100706131741.GR3192@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47843 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040Ab0G0LrW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jul 2010 07:47:22 -0400
In-Reply-To: <20100706131741.GR3192@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Hi Tony

On 7/6/2010 3:17 PM, Tony Lindgren wrote:
> * Charulatha V<charu@ti.com>  [100622 17:55]:
>> This patch series makes OMAP2PLUS specific GPIO implemented in HWMOD
>> FW way. This is done by implementing GPIO module in platform device model.
>>
>> This patch series is generated on "origin/pm-wip/hwmods-omap4".
>
> Do we still have a dependency on this series to pm-wip?

Yep, I think we still need the runtime PM support and the OMAP4 hwmod 
data that are located only in pm-wip for the moment.

Regards,
Benoit

> Can you please try to rebase this on top of linux-omap for-next
> branch?
>
> Let's see if we can merge this into linux-omap master
> branch for some testing before we merge it.
>
> Regards,
>
> Tony

