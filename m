From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Problem with DSS clocks & accessing registers
Date: Mon, 7 Mar 2011 14:51:17 +0100
Message-ID: <4D74E2D5.2000705@ti.com>
References: <1299486149.2281.77.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43805 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1CGNvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 08:51:21 -0500
In-Reply-To: <1299486149.2281.77.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Taneja, Archit" <archit@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>

+ Rajendra

Hi Tomi,

On 3/7/2011 9:22 AM, Valkeinen, Tomi wrote:
> Hi Kevin, Paul,
>
> We currently have a small problem with OMAP4 DSS. When we enable the DSS
> clocks, it seems that the DSS registers are not always accessible right
> after the clock enable.

What clocks are you talking about? As you know, the DSS has a bunch of 
functional clocks available depending of the use case.

> I understood that on OMAP4 the clock framework doesn't guarantee that
> the registers are accessible after enabling clocks, and pm_runtime will
> handle this. Is this correct?

The point is that there is no status at clock level but only one status 
at module level. That's why this check does not have anything to do at 
clock level.
So hwmod with handle that status (OMAP4430_CM_DSS_DSS_CLKCTRL) during 
the hwmod_enable that is indirectly called by pm_runtime, through 
omap_device API.

> I have made a small hack fix for this. I added udelay(10) in the DSS
> code which enables the clocks and this seem to remove the problem. The
> delay is only called when DSS thinks the clocks have been off, so in
> practice the delay shouldn't be visible. Is this fix acceptable for now,
> until we get pm_runtime support to DSS?

Cannot you use omap_device for the moment? Relying on a udelay is not a 
very safe method, even temporally.
Or you might hack the main clock node to check for the module status. I 
think it was done like that at the beginning of OMAP4.
It was removed, but I do not remember if it was done at fmwk level or at 
clock nodes level.

Rajendra should know the full story.

Regards,
Benoit
