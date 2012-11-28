From: Archit Taneja <archit@ti.com>
Subject: Re: OMAP4430 produces boot warnings
Date: Wed, 28 Nov 2012 16:14:58 +0530
Message-ID: <50B5EB2A.3040204@ti.com>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>  <50AE1DC0.3030002@ti.com>  <50AE2BB6.8080406@ti.com>  <1353594842.786.45.camel@sokoban>  <50AE3A5B.5040603@ti.com>  <1353663278.25248.4.camel@sokoban> <50B310D3.9050202@ti.com>  <50B35D0E.6000509@ti.com> <50B4A2B7.9080806@ti.com>  <50B4AA74.1090300@ti.com>  <50B4B045.7090603@ti.com> <1354019506.3250.10.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47490 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab2K1Kpk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 05:45:40 -0500
In-Reply-To: <1354019506.3250.10.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: t-kristo@ti.com, Rajendra Nayak <rnayak@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Tuesday 27 November 2012 06:01 PM, Tero Kristo wrote:
> On Tue, 2012-11-27 at 14:21 +0200, Tomi Valkeinen wrote:
>> On 2012-11-27 13:56, Archit Taneja wrote:
>>> On Tuesday 27 November 2012 04:53 PM, Tomi Valkeinen wrote:
>>
>>>> Hmm, well this feels like a hack. DISPC driver doesn't know how the DSS
>>>> modules are arranged, which module belongs to which power domain, etc.
>>>>
>>>> If it cannot be fixed in the arch code, I guess we could just have
>>>> dss_get_ctx_loss_count(void) function which always returns the
>>>> dss_core's ctx loss count, and define that on all the platforms omapdss
>>>> is used, the dss_core's ctx loss count is the same as ctx loss count for
>>>> all the dss submodules.

Well the context lost count we are interested in isn't the "omapdss" 
platform device in core.c, it's the "omapdss_dss" platform device in dss.c

I was considering moving the dss_get_ctx_lost_count() to dss.c, as it 
needs the "omapdss_dss" platform_device. It looks better in core.c, but 
we would need a dirty way to give it the "omapdss_dss". What do you think?

Archit

>>>>
>>>> I think the above is true for all OMAPs. But it feels like a hack too,
>>>> but not as bad as the above patch.
>>>
>>> Yes, a function taking in no platform device in dss's core.c would be
>>> less hacky. I guess we would need this for now, because a solution in
>>> omap_hwmod would be more complex and it may not be ready by the merge
>>> window.
>>
>> Ok. Can you cook up a patch and test it?
>>
>> PM guys, does the above sound like an acceptable work-around?
>
> This sounds like a good approach to me at least.
>
> -Tero
>
>
>
>

