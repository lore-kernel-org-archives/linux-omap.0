From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: PMU: fix runtime PM enable
Date: Wed, 24 Oct 2012 10:06:07 -0500
Message-ID: <508803DF.7020902@ti.com>
References: <1351024268-26734-1-git-send-email-jon-hunter@ti.com> <20121024093150.GA23775@mudshark.cambridge.arm.com> <5087F84B.9070705@ti.com> <20121024143204.GF7339@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47415 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934915Ab2JXPGN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 11:06:13 -0400
In-Reply-To: <20121024143204.GF7339@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 10/24/2012 09:32 AM, Will Deacon wrote:
> On Wed, Oct 24, 2012 at 03:16:43PM +0100, Jon Hunter wrote:
>> Hi Will,
>>
>> On 10/24/2012 04:31 AM, Will Deacon wrote:
>>> Can we not just use the presence of the resume/suspend function pointers to
>>> indicate whether we should enable runtime pm or not? i.e. if they're not
>>> NULL, then enable the thing?
>>
>> I wondered if you would ask that :-)
>>
>> Unfortunately, we can't. For example, OMAP3430 and OMAP4460 both require
>> runtime_pm to be enabled to turn on the debug sub-system in OMAP for PMU
>> to work. However, neither of these devices are using the suspend/resume
>> callbacks because the HWMOD framework is doing this for us behind the
>> scenes.
>>
>> So then you ask, why do we need the resume/suspend callbacks, well we
>> will need them for OMAP4430 where in addition to turning on the debug
>> sub-system we need to configure the CTI module. Therefore, I had to add
>> another plat data variable.
> 
> Hmmm, now I start to wonder whether your original idea of having separate
> callbacks for enable/disable irq and resume/suspend doesn't make more sense.
> Then the CTI magic can go in the irq management code and be totally separate
> to the PM stuff.
> 
> What do you reckon?

The resume/suspend calls really replaced the enable/disable irq
callbacks. That still seems like a good approach given that we need
runtime PM for OMAP and PMU.

The problem is going to be with device-tree. When booting with
device-tree we will not call the current OMAP specific code that is
creating the PMU device and calling pm_runtime_enable(). So calling
pm_runtime_enable() needs to be done somewhere in the PERF driver and
that's the real problem here.

>> By the way, I did add a comment in the above changelog about this. See
>> the last paragraph, not sure if this is 100% clear.
> 
> Sorry, I missed that this morning.
> 
>> One alternative I had thought about was always calling
>> pm_runtime_enable() on registering the PMU device and avoid having a
>> use_runtime_pm variable. For ARM platforms that don't use runtime PM the
>> pm_runtime_enable() function does nothing. However, I was more concerned
>> about adding unnecessary overhead for ARM platforms that are using
>> runtime PM but don't need runtime PM for PMU. I don't see any side
>> affects on our OMAP2 platform that does not need runtime PM for PMU.
>> However, was not sure what is best here.
> 
> Nah, we should be able to fix this in the platdata, I'd just rather have
> function pointers instead of state variables in there.

Well, we could pass a pointer to pm_runtime_enable() function in the
platdata.

Cheers
Jon
