From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/9] ARM: dts: Various OMAP2+ device-tree updates
Date: Thu, 14 Mar 2013 10:59:00 -0500
Message-ID: <5141F3C4.8000508@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com> <5141E55E.9040801@ti.com> <5141F0A8.6040009@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44054 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932394Ab3CNP7M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 11:59:12 -0400
In-Reply-To: <5141F0A8.6040009@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 03/14/2013 10:45 AM, Florian Vaussard wrote:
> Hi Benoit,
> 
> On 03/14/2013 03:57 PM, Benoit Cousson wrote:
>> Salut Jon,
>>
>> On 03/08/2013 06:27 PM, Jon Hunter wrote:
>>> Various OMAP device-tree updates for PMU, DMA, GPIO, GPMC and boards.
>>>
>>> The DMA, PMU and OMAP3430 SDP board changes have been sent before
>>> individually but re-sending here as a complete series for v3.10.
>>>
>>> This is based upon v3.9-rc1 and the OMAP3 GPMC binding from Florian
>>> Vaussard [1] and OMAP5 DT SPI patch from Felipe Balbi [2].
>>>
>>> [1] https://patchwork.kernel.org/patch/2057111/
>>
>> I've tried to follow the series review, and it seems that Florian was
>> considering sending some other patches. It is not clear if this is a new
>> version of the series or some additional patches.

A bit of both. Sorry for the confusion :-)

> Concerning patch [1], it can be merged to add the GPMC binding for OMAP3.
> But please discard the rest of my original series, I will repost something
> later.

Benoit, if you pick up Florian's patch, I will re-post my remaining
patches for you to pick up.

By the way, I see that you have picked up the PMU bindings, however,
ideally we should merge the "pmu prepare" patch first. We agreed with
Tony for you to take this with his ack [1].

Let me know if you just want me to re-post that one on top of your branch.

Cheers
Jon

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/91036



