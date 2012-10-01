From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 0/8] ARM: OMAP4: Add PMU Support
Date: Mon, 1 Oct 2012 10:03:20 -0500
Message-ID: <5069B0B8.8080503@ti.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1209201714260.12583@utopia.booyaka.com> <20120920210932.GB22307@mudshark.cambridge.arm.com> <5060D462.4040209@ti.com> <20121001094517.GC20812@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52036 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab2JAPDd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Oct 2012 11:03:33 -0400
In-Reply-To: <20121001094517.GC20812@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>


On 10/01/2012 04:45 AM, Will Deacon wrote:
> On Mon, Sep 24, 2012 at 10:45:06PM +0100, Jon Hunter wrote:
>> On 09/20/2012 04:09 PM, Will Deacon wrote:
>>> On Thu, Sep 20, 2012 at 06:17:02PM +0100, Paul Walmsley wrote:
>>>> Have queued most of these for 3.7 with the exception of the OMAP4430 
>>>> CTI-related patches (which look to me like 3.8 material) and the PM 
>>>> runtime suspend/resume patch (which looks to me like 3.7-rc material) -- 
>>>> assuming this series makes it in for 3.7 ... 
>>>
>>> Ok, thanks for queueing what you did.
>>>
>>> Jon -- could you pick the pieces up from what's left please and shout if
>>> you need anything from me?
>>
>> Yes will do.
> 
> Great, thanks! Do you want me to do anything with my perf/omap4 branch? Now
> that we have 3.6, I can try rebasing it but I don't know if it's worth the
> effort if some of the patches are being reworked. Of course, I'm happy to
> pick newer versions if they're available.

I think that we are ok for the minute. I was going to wait until
everything gets merged for 3.7 and then rebase my branch [1] and start
re-working omap4430 support. So I would not worry right now.

Cheers
Jon

[1] https://github.com/jonhunter/linux/tree/dev-pmu
