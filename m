From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] pinctrl: Add generic pinctrl-simple driver that supports
 omap2+ padconf
Date: Fri, 11 May 2012 15:04:39 -0600
Message-ID: <4FAD7EE7.2070704@wwwdotorg.org>
References: <20120504150342.GI5140@atomide.com> <20120504153251.GE7788@game.jcrosoft.org> <20120504163420.GA5613@atomide.com> <4FA42631.6060304@wwwdotorg.org> <20120504220809.GW5613@atomide.com> <4FAAD141.3090306@wwwdotorg.org> <20120509204925.GV5088@atomide.com> <4FABF553.20601@wwwdotorg.org> <20120510172722.GE21851@atomide.com> <4FAD65D8.30109@wwwdotorg.org> <20120511195147.GW21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41067 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903Ab2EKVEn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 17:04:43 -0400
In-Reply-To: <20120511195147.GW21851@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/11/2012 01:51 PM, Tony Lindgren wrote:
> * Stephen Warren <swarren@wwwdotorg.org> [120511 12:21]:
>>
>> The mapping of GPIO to pinctrl pins would presumably be driven solely by
>> the HW design of the pin controller and GPIO, and not by the mux
>> selection in the pin controller (otherwise, I'd argue this isn't a
>> simple case that should be handled by pinctrl-simple).
>>
>> As such, I'd expect some properties/table at the top-level of the pin
>> controller object to describe the GPIO mapping. In turn, that implies
>> that the individual per-pin mux-selection/configuration nodes don't need
>> to describe any GPIO-related information.
> 
> Yes good point. I agree it's a HW design issue, and could be in the properties
> for the pin controller object.
> 
> Just to summarize, the things to consider with the GPIO to mux mapping are:
> 
> 1. Having this table as static data in the driver is is not a nice
>    solution as it seems that we'd currently need six mapping tables for
>    omap2+ alone.
> 
> 2. This table is not needed for most of the (hundreds of) pins, it's
>    only needed for a few selected pins, let's say ten or so on an average
>    device. So there's no need to stuff the kernel with information about
>    the unused GPIO pins.
> 
> It seems that the conclusion here is that we don't need to worry about
> GPIOs in the pinctrl-simple binding for now, and it can be added later
> without having to change the basic binding.

The one thing I wanted to resolve here wasn't so much the binding for
GPIO interaction here, but the following comment:

You wrote:
> I wrote:
>> From a binding perspective, I don't see why you'd want to allow two cases:
>>
>> 1) One node with multiple entries in pinctrl-simple,cells
>> 2) Multiple nodes each with a single entry in pinctrl-simple,cells
>>
>> Why not only allow (1)?
>
> Because we need to specify GPIO for some pins. There may be additional flags
> too, we do have external DMA request lines for few pins available.. I'm not
> saying pinctrl fwk should know about that, but it's a similar mapping of pins
> to GPIO lines.

I'm asserting that since any GPIO mapping information would be at the
top-level of the pinctrl-simple binding, we can in fact only allow
option (1) above for the individual pin configuration nodes.
