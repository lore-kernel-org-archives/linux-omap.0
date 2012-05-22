From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 6/9] ARM: OMAP2+: Fix external clock support for dmtimers
Date: Tue, 22 May 2012 17:55:53 +0200
Message-ID: <4FBBB709.7020104@ti.com>
References: <1337124956-20133-1-git-send-email-jon-hunter@ti.com> <4FBA742D.6020800@ti.com> <4FBBAAF7.3030007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42940 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759792Ab2EVPz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 11:55:56 -0400
In-Reply-To: <4FBBAAF7.3030007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 5/22/2012 5:04 PM, Jon Hunter wrote:

...

>> In fact, if the alt clock is there the "alt_clk" alias will be there and
>> thus you can use the clk_get(dev, "alt_clk") to figure out if the clock
>> is there or not.
>
> Ok, I can do this and did think about it, but then wondered why it had
> been done this way in the first place?

Yeah, I don't know but I guess this is probably some OMAP1 legacy stuff...

Benoit
